// Validates the typed Smithy transform by comparing apiFromSmithy() against the
// legacy Api.fromJson() on the INTERSECTION of shapes/operations present in
// both. This isolates transform fidelity from model evolution: the frozen
// golden has drifted, so additions are expected, but a value mismatch on a
// shared element is a transform bug. Run from generator/. Defaults to the
// awsJson cohort; pass --all to sweep the awsJson family.
// Exit: 0 = no intersection mismatch, 1 = mismatch, 2 = setup error.

import 'dart:convert';
import 'dart:io';

import 'package:aws_client_generator/model/api.dart';
import 'package:aws_client_generator/model/shape.dart';
import 'package:aws_client_generator/smithy/ast.dart';
import 'package:aws_client_generator/smithy/from_smithy.dart';
import 'package:aws_client_generator/smithy/traits.dart';

const cohort = ['dynamodb-2012-08-10', 'kinesis-2013-12-02'];

void main(List<String> args) {
  final all = args.contains('--all');
  final uids = all ? _supportedUidsWithLegacy() : (args.isEmpty ? cohort : args);
  var anyMismatch = false;
  var total = 0;
  final dirty = <String>[];

  for (final uid in uids) {
    final legacyFile = File('apis/$uid.normal.json');
    final smithyFile = File('smithy_apis/$uid.json');
    if (!legacyFile.existsSync() || !smithyFile.existsSync()) {
      stderr.writeln('Missing inputs for $uid');
      exit(2);
    }

    final _Result r;
    try {
      final legacy = Api.fromJson(
          jsonDecode(legacyFile.readAsStringSync()) as Map<String, dynamic>);
      final smithy = apiFromSmithy(
          SmithyModel.fromJson(
              jsonDecode(smithyFile.readAsStringSync()) as Map<String, dynamic>),
          uid: uid);
      r = _compare(legacy, smithy);
    } catch (e) {
      anyMismatch = true;
      dirty.add(uid);
      stdout.writeln('=== $uid: TRANSFORM ERROR ===\n    $e');
      continue;
    }
    if (r.mismatches.isNotEmpty) {
      anyMismatch = true;
      total += r.mismatches.length;
      dirty.add(uid);
    }
    if (all) {
      if (r.mismatches.isNotEmpty) {
        stdout.writeln('=== $uid: ${r.mismatches.length} mismatches ===');
        for (final m in r.mismatches.take(20)) {
          stdout.writeln('    - $m');
        }
      }
      continue;
    }
    stdout.writeln('=== $uid ===');
    stdout.writeln('  shapes: ${r.legacyShapes} legacy / ${r.smithyShapes} smithy');
    stdout.writeln('  transform mismatches (gate): ${r.mismatches.length}');
    for (final m in r.mismatches.take(40)) {
      stdout.writeln('    - $m');
    }
    stdout.writeln('  evolution (informational): ${r.additions} added shapes, '
        '${r.opAdditions} added ops, ${r.evolution.length} relaxations/removals');
  }

  if (all) {
    stdout.writeln();
    stdout.writeln('Supported-protocol sweep: ${uids.length} services with a '
        'legacy counterpart, $total transform mismatches'
        '${dirty.isEmpty ? '' : ' in ${dirty.join(', ')}'}.');
  }

  exit(anyMismatch ? 1 : 0);
}

class _Result {
  final List<String> mismatches = [];
  final List<String> evolution = [];
  int additions = 0;
  int opAdditions = 0;
  int legacyShapes = 0;
  int smithyShapes = 0;
}

_Result _compare(Api legacy, Api smithy) {
  final r = _Result()
    ..legacyShapes = legacy.shapes.length
    ..smithyShapes = smithy.shapes.length;
  r.additions =
      smithy.shapes.keys.where((k) => !legacy.shapes.containsKey(k)).length;

  legacy.shapes.forEach((name, l) {
    final s = smithy.shapes[name];
    if (s == null) return; // removed shape: evolution, skip
    if (l.type != s.type) {
      r.mismatches.add('$name: type ${l.type} != ${s.type}');
      return;
    }
    switch (l.type) {
      case 'structure':
        _compareStructure(name, l, s, legacy, smithy, r);
      case 'string':
        _compareEnum(name, l, s, r);
      case 'list':
        _compareType(name, 'member', l.member?.shape, s.member?.shape,
            legacy, smithy, r);
      case 'map':
        _compareType(name, 'key', l.key?.shape, s.key?.shape, legacy, smithy, r);
        _compareType(
            name, 'value', l.value?.shape, s.value?.shape, legacy, smithy, r);
    }
  });

  r.opAdditions =
      smithy.operations.keys.where((k) => !legacy.operations.containsKey(k)).length;
  legacy.operations.forEach((name, l) {
    final s = smithy.operations[name];
    if (s == null) {
      // A legacy operation absent from the Smithy build is almost always a
      // collection bug (e.g. resource-bound ops), not a real removal.
      r.mismatches.add('op $name: missing in smithy build');
      return;
    }
    if (l.input?.shape != s.input?.shape) {
      r.mismatches.add('op $name: input ${l.input?.shape} != ${s.input?.shape}');
    }
    if (l.output?.shape != s.output?.shape) {
      r.mismatches
          .add('op $name: output ${l.output?.shape} != ${s.output?.shape}');
    }
    if (l.authtype != s.authtype) {
      r.mismatches.add('op $name: authtype ${l.authtype} != ${s.authtype}');
    }
  });
  return r;
}

void _compareStructure(
    String name, Shape l, Shape s, Api la, Api sa, _Result r) {
  final lmem = l.membersMap ?? const {};
  final smem = s.membersMap ?? const {};
  for (final mn in lmem.keys) {
    final lm = lmem[mn]!;
    final sm = smem[mn];
    if (sm == null) {
      r.evolution.add('$name.$mn: member removed');
      continue;
    }
    _compareType(name, mn, lm.shape, sm.shape, la, sa, r);
    if (lm.location != sm.location) {
      r.mismatches.add('$name.$mn: location ${lm.location} != ${sm.location}');
    }
    if (lm.locationName != sm.locationName) {
      r.mismatches
          .add('$name.$mn: locationName ${lm.locationName} != ${sm.locationName}');
    }
  }
  if (l.payload != s.payload) {
    r.mismatches.add('$name: payload ${l.payload} != ${s.payload}');
  }
  if (l.exception != s.exception) {
    r.mismatches.add('$name: exception ${l.exception} != ${s.exception}');
  }
  final dropped = (l.required ?? const <String>[])
      .toSet()
      .difference((s.required ?? const <String>[]).toSet());
  if (dropped.isNotEmpty) r.evolution.add('$name: required relaxed $dropped');
}

void _compareEnum(String name, Shape l, Shape s, _Result r) {
  final le = l.enumeration?.toSet();
  if (le == null) return;
  final missing = le.difference(s.enumeration?.toSet() ?? const {});
  if (missing.isNotEmpty) r.evolution.add('$name: enum values removed $missing');
}

/// Compares the target's resolved type kind, not its name: AWS routinely renames
/// a target to a constraint-specialized alias of the same kind, which is drift.
void _compareType(
    String name, String slot, String? l, String? s, Api la, Api sa, _Result r) {
  final lt = _typeOf(la, l);
  final st = _typeOf(sa, s);
  if (lt != st) r.mismatches.add('$name.$slot: type $lt != $st');
}

String _typeOf(Api api, String? shapeName) {
  if (shapeName == null) return 'void';
  final s = api.shapes[shapeName];
  if (s != null) return s.type;
  return shapeName.isEmpty
      ? shapeName
      : shapeName[0].toLowerCase() + shapeName.substring(1);
}

/// Services in smithy_apis/ whose protocol the transform supports and that also
/// have a legacy apis/*.normal.json to compare against.
List<String> _supportedUidsWithLegacy() {
  const supported = {
    TraitIds.awsJson1_0,
    TraitIds.awsJson1_1,
    TraitIds.restJson1,
  };
  final uids = <String>[];
  for (final f in Directory('smithy_apis')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))) {
    final uid = f.uri.pathSegments.last.replaceFirst('.json', '');
    if (!File('apis/$uid.normal.json').existsSync()) continue;
    final model = SmithyModel.fromJson(
        jsonDecode(f.readAsStringSync()) as Map<String, dynamic>);
    if (supported.contains(model.service.value.protocolTraitId)) uids.add(uid);
  }
  return uids..sort();
}
