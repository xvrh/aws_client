// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:typed_data';

import '../../shared/shared.dart' as _s;
import '../../shared/shared.dart'
    show
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

export '../../shared/shared.dart' show AwsClientCredentials;

/// Contains all data plane API operations and data types for the Amazon
/// SageMaker Feature Store. Use this API to put, delete, and retrieve (get)
/// features from a feature store.
///
/// Use the following operations to configure your <code>OnlineStore</code> and
/// <code>OfflineStore</code> features, and to create and manage feature groups:
///
/// <ul>
/// <li>
/// <a
/// href="https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateFeatureGroup.html">CreateFeatureGroup</a>
/// </li>
/// <li>
/// <a
/// href="https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteFeatureGroup.html">DeleteFeatureGroup</a>
/// </li>
/// <li>
/// <a
/// href="https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeFeatureGroup.html">DescribeFeatureGroup</a>
/// </li>
/// <li>
/// <a
/// href="https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListFeatureGroups.html">ListFeatureGroups</a>
/// </li>
/// </ul>
class SageMakerFeatureStoreRuntime {
  final _s.RestJsonProtocol _protocol;
  SageMakerFeatureStoreRuntime({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'featurestore-runtime.sagemaker',
            signingName: 'sagemaker',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  /// Deletes a <code>Record</code> from a <code>FeatureGroup</code>. A new
  /// record will show up in the <code>OfflineStore</code> when the
  /// <code>DeleteRecord</code> API is called. This record will have a value of
  /// <code>True</code> in the <code>is_deleted</code> column.
  ///
  /// May throw [ValidationError].
  /// May throw [InternalFailure].
  /// May throw [ServiceUnavailable].
  /// May throw [AccessForbidden].
  ///
  /// Parameter [eventTime] :
  /// Timestamp indicating when the deletion event occurred.
  /// <code>EventTime</code> can be used to query data at a certain point in
  /// time.
  ///
  /// Parameter [featureGroupName] :
  /// The name of the feature group to delete the record from.
  ///
  /// Parameter [recordIdentifierValueAsString] :
  /// The value for the <code>RecordIdentifier</code> that uniquely identifies
  /// the record, in string format.
  Future<void> deleteRecord({
    required String eventTime,
    required String featureGroupName,
    required String recordIdentifierValueAsString,
  }) async {
    ArgumentError.checkNotNull(eventTime, 'eventTime');
    _s.validateStringLength(
      'eventTime',
      eventTime,
      0,
      358400,
      isRequired: true,
    );
    _s.validateStringPattern(
      'eventTime',
      eventTime,
      r'''.*''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(featureGroupName, 'featureGroupName');
    _s.validateStringLength(
      'featureGroupName',
      featureGroupName,
      1,
      64,
      isRequired: true,
    );
    _s.validateStringPattern(
      'featureGroupName',
      featureGroupName,
      r'''^[a-zA-Z0-9](-*[a-zA-Z0-9])*''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(
        recordIdentifierValueAsString, 'recordIdentifierValueAsString');
    _s.validateStringLength(
      'recordIdentifierValueAsString',
      recordIdentifierValueAsString,
      0,
      358400,
      isRequired: true,
    );
    _s.validateStringPattern(
      'recordIdentifierValueAsString',
      recordIdentifierValueAsString,
      r'''.*''',
      isRequired: true,
    );
    final $query = <String, List<String>>{
      'EventTime': [eventTime],
      'RecordIdentifierValueAsString': [recordIdentifierValueAsString],
    };
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/FeatureGroup/${Uri.encodeComponent(featureGroupName)}',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Use for <code>OnlineStore</code> serving from a <code>FeatureStore</code>.
  /// Only the latest records stored in the <code>OnlineStore</code> can be
  /// retrieved. If no Record with <code>RecordIdentifierValue</code> is found,
  /// then an empty result is returned.
  ///
  /// May throw [ValidationError].
  /// May throw [ResourceNotFound].
  /// May throw [InternalFailure].
  /// May throw [ServiceUnavailable].
  /// May throw [AccessForbidden].
  ///
  /// Parameter [featureGroupName] :
  /// The name of the feature group in which you want to put the records.
  ///
  /// Parameter [recordIdentifierValueAsString] :
  /// The value that corresponds to <code>RecordIdentifier</code> type and
  /// uniquely identifies the record in the <code>FeatureGroup</code>.
  ///
  /// Parameter [featureNames] :
  /// List of names of Features to be retrieved. If not specified, the latest
  /// value for all the Features are returned.
  Future<GetRecordResponse> getRecord({
    required String featureGroupName,
    required String recordIdentifierValueAsString,
    List<String>? featureNames,
  }) async {
    ArgumentError.checkNotNull(featureGroupName, 'featureGroupName');
    _s.validateStringLength(
      'featureGroupName',
      featureGroupName,
      1,
      64,
      isRequired: true,
    );
    _s.validateStringPattern(
      'featureGroupName',
      featureGroupName,
      r'''^[a-zA-Z0-9](-*[a-zA-Z0-9])*''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(
        recordIdentifierValueAsString, 'recordIdentifierValueAsString');
    _s.validateStringLength(
      'recordIdentifierValueAsString',
      recordIdentifierValueAsString,
      0,
      358400,
      isRequired: true,
    );
    _s.validateStringPattern(
      'recordIdentifierValueAsString',
      recordIdentifierValueAsString,
      r'''.*''',
      isRequired: true,
    );
    final $query = <String, List<String>>{
      'RecordIdentifierValueAsString': [recordIdentifierValueAsString],
      if (featureNames != null) 'FeatureName': featureNames,
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/FeatureGroup/${Uri.encodeComponent(featureGroupName)}',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return GetRecordResponse.fromJson(response);
  }

  /// Used for data ingestion into the <code>FeatureStore</code>. The
  /// <code>PutRecord</code> API writes to both the <code>OnlineStore</code> and
  /// <code>OfflineStore</code>. If the record is the latest record for the
  /// <code>recordIdentifier</code>, the record is written to both the
  /// <code>OnlineStore</code> and <code>OfflineStore</code>. If the record is a
  /// historic record, it is written only to the <code>OfflineStore</code>.
  ///
  /// May throw [ValidationError].
  /// May throw [InternalFailure].
  /// May throw [ServiceUnavailable].
  /// May throw [AccessForbidden].
  ///
  /// Parameter [featureGroupName] :
  /// The name of the feature group that you want to insert the record into.
  ///
  /// Parameter [record] :
  /// List of FeatureValues to be inserted. This will be a full over-write. If
  /// you only want to update few of the feature values, do the following:
  ///
  /// <ul>
  /// <li>
  /// Use <code>GetRecord</code> to retrieve the latest record.
  /// </li>
  /// <li>
  /// Update the record returned from <code>GetRecord</code>.
  /// </li>
  /// <li>
  /// Use <code>PutRecord</code> to update feature values.
  /// </li>
  /// </ul>
  Future<void> putRecord({
    required String featureGroupName,
    required List<FeatureValue> record,
  }) async {
    ArgumentError.checkNotNull(featureGroupName, 'featureGroupName');
    _s.validateStringLength(
      'featureGroupName',
      featureGroupName,
      1,
      64,
      isRequired: true,
    );
    _s.validateStringPattern(
      'featureGroupName',
      featureGroupName,
      r'''^[a-zA-Z0-9](-*[a-zA-Z0-9])*''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(record, 'record');
    final $payload = <String, dynamic>{
      'Record': record,
    };
    await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/FeatureGroup/${Uri.encodeComponent(featureGroupName)}',
      exceptionFnMap: _exceptionFns,
    );
  }
}

/// The value associated with a feature.
class FeatureValue {
  /// The name of a feature that a feature value corresponds to.
  final String featureName;

  /// The value associated with a feature, in string format. Note that features
  /// types can be String, Integral, or Fractional. This value represents all
  /// three types as a string.
  final String valueAsString;

  FeatureValue({
    required this.featureName,
    required this.valueAsString,
  });
  factory FeatureValue.fromJson(Map<String, dynamic> json) {
    return FeatureValue(
      featureName: json['FeatureName'] as String,
      valueAsString: json['ValueAsString'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final featureName = this.featureName;
    final valueAsString = this.valueAsString;
    return {
      'FeatureName': featureName,
      'ValueAsString': valueAsString,
    };
  }
}

class GetRecordResponse {
  /// The record you requested. A list of <code>FeatureValues</code>.
  final List<FeatureValue>? record;

  GetRecordResponse({
    this.record,
  });
  factory GetRecordResponse.fromJson(Map<String, dynamic> json) {
    return GetRecordResponse(
      record: (json['Record'] as List?)
          ?.whereNotNull()
          .map((e) => FeatureValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AccessForbidden extends _s.GenericAwsException {
  AccessForbidden({String? type, String? message})
      : super(type: type, code: 'AccessForbidden', message: message);
}

class InternalFailure extends _s.GenericAwsException {
  InternalFailure({String? type, String? message})
      : super(type: type, code: 'InternalFailure', message: message);
}

class ResourceNotFound extends _s.GenericAwsException {
  ResourceNotFound({String? type, String? message})
      : super(type: type, code: 'ResourceNotFound', message: message);
}

class ServiceUnavailable extends _s.GenericAwsException {
  ServiceUnavailable({String? type, String? message})
      : super(type: type, code: 'ServiceUnavailable', message: message);
}

class ValidationError extends _s.GenericAwsException {
  ValidationError({String? type, String? message})
      : super(type: type, code: 'ValidationError', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'AccessForbidden': (type, message) =>
      AccessForbidden(type: type, message: message),
  'InternalFailure': (type, message) =>
      InternalFailure(type: type, message: message),
  'ResourceNotFound': (type, message) =>
      ResourceNotFound(type: type, message: message),
  'ServiceUnavailable': (type, message) =>
      ServiceUnavailable(type: type, message: message),
  'ValidationError': (type, message) =>
      ValidationError(type: type, message: message),
};
