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

/// AWS IoT Core Device Advisor is a cloud-based, fully managed test capability
/// for validating IoT devices during device software development. Device
/// Advisor provides pre-built tests that you can use to validate IoT devices
/// for reliable and secure connectivity with AWS IoT Core before deploying
/// devices to production. By using Device Advisor, you can confirm that your
/// devices can connect to AWS IoT Core, follow security best practices and, if
/// applicable, receive software updates from IoT Device Management. You can
/// also download signed qualification reports to submit to the AWS Partner
/// Network to get your device qualified for the AWS Partner Device Catalog
/// without the need to send your device in and wait for it to be tested.
class IoTDeviceAdvisor {
  final _s.RestJsonProtocol _protocol;
  IoTDeviceAdvisor({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'api.iotdeviceadvisor',
            signingName: 'iotdeviceadvisor',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  /// Creates a Device Advisor test suite.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [suiteDefinitionConfiguration] :
  /// Creates a Device Advisor test suite with suite definition configuration.
  ///
  /// Parameter [tags] :
  /// The tags to be attached to the suite definition.
  Future<CreateSuiteDefinitionResponse> createSuiteDefinition({
    SuiteDefinitionConfiguration? suiteDefinitionConfiguration,
    Map<String, String>? tags,
  }) async {
    final $payload = <String, dynamic>{
      if (suiteDefinitionConfiguration != null)
        'suiteDefinitionConfiguration': suiteDefinitionConfiguration,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/suiteDefinitions',
      exceptionFnMap: _exceptionFns,
    );
    return CreateSuiteDefinitionResponse.fromJson(response);
  }

  /// Deletes a Device Advisor test suite.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [suiteDefinitionId] :
  /// Deletes a Device Advisor test suite with defined suite Id.
  Future<void> deleteSuiteDefinition({
    required String suiteDefinitionId,
  }) async {
    ArgumentError.checkNotNull(suiteDefinitionId, 'suiteDefinitionId');
    _s.validateStringLength(
      'suiteDefinitionId',
      suiteDefinitionId,
      36,
      36,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/suiteDefinitions/${Uri.encodeComponent(suiteDefinitionId)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Gets information about a Device Advisor test suite.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [suiteDefinitionId] :
  /// Requests suite definition Id with GetSuiteDefinition API call.
  ///
  /// Parameter [suiteDefinitionVersion] :
  /// Requests the suite definition version of a test suite.
  Future<GetSuiteDefinitionResponse> getSuiteDefinition({
    required String suiteDefinitionId,
    String? suiteDefinitionVersion,
  }) async {
    ArgumentError.checkNotNull(suiteDefinitionId, 'suiteDefinitionId');
    _s.validateStringLength(
      'suiteDefinitionId',
      suiteDefinitionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringLength(
      'suiteDefinitionVersion',
      suiteDefinitionVersion,
      2,
      255,
    );
    final $query = <String, List<String>>{
      if (suiteDefinitionVersion != null)
        'suiteDefinitionVersion': [suiteDefinitionVersion],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/suiteDefinitions/${Uri.encodeComponent(suiteDefinitionId)}',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return GetSuiteDefinitionResponse.fromJson(response);
  }

  /// Gets information about a Device Advisor test suite run.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [suiteDefinitionId] :
  /// Requests the information about Device Advisor test suite run based on
  /// suite definition Id.
  ///
  /// Parameter [suiteRunId] :
  /// Requests the information about Device Advisor test suite run based on
  /// suite run Id.
  Future<GetSuiteRunResponse> getSuiteRun({
    required String suiteDefinitionId,
    required String suiteRunId,
  }) async {
    ArgumentError.checkNotNull(suiteDefinitionId, 'suiteDefinitionId');
    _s.validateStringLength(
      'suiteDefinitionId',
      suiteDefinitionId,
      36,
      36,
      isRequired: true,
    );
    ArgumentError.checkNotNull(suiteRunId, 'suiteRunId');
    _s.validateStringLength(
      'suiteRunId',
      suiteRunId,
      36,
      36,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/suiteDefinitions/${Uri.encodeComponent(suiteDefinitionId)}/suiteRuns/${Uri.encodeComponent(suiteRunId)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetSuiteRunResponse.fromJson(response);
  }

  /// Gets a report download link for a successful Device Advisor qualifying
  /// test suite run.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [suiteDefinitionId] :
  /// Device Advisor suite definition Id.
  ///
  /// Parameter [suiteRunId] :
  /// Device Advisor suite run Id.
  Future<GetSuiteRunReportResponse> getSuiteRunReport({
    required String suiteDefinitionId,
    required String suiteRunId,
  }) async {
    ArgumentError.checkNotNull(suiteDefinitionId, 'suiteDefinitionId');
    _s.validateStringLength(
      'suiteDefinitionId',
      suiteDefinitionId,
      36,
      36,
      isRequired: true,
    );
    ArgumentError.checkNotNull(suiteRunId, 'suiteRunId');
    _s.validateStringLength(
      'suiteRunId',
      suiteRunId,
      36,
      36,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/suiteDefinitions/${Uri.encodeComponent(suiteDefinitionId)}/suiteRuns/${Uri.encodeComponent(suiteRunId)}/report',
      exceptionFnMap: _exceptionFns,
    );
    return GetSuiteRunReportResponse.fromJson(response);
  }

  /// Lists the Device Advisor test suites you have created.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [maxResults] :
  /// Request the list of all the Device Advisor test suites.
  ///
  /// Parameter [nextToken] :
  /// Requests the Device Advisor test suites next token.
  Future<ListSuiteDefinitionsResponse> listSuiteDefinitions({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      2000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/suiteDefinitions',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListSuiteDefinitionsResponse.fromJson(response);
  }

  /// Lists the runs of the specified Device Advisor test suite. You can list
  /// all runs of the test suite, or the runs of a specific version of the test
  /// suite.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [maxResults] :
  /// MaxResults for list suite run API request.
  ///
  /// Parameter [nextToken] :
  /// Next pagination token for list suite run request.
  ///
  /// Parameter [suiteDefinitionId] :
  /// Lists the runs of the specified Device Advisor test suite based on suite
  /// definition Id.
  ///
  /// Parameter [suiteDefinitionVersion] :
  /// Lists the runs of the specified Device Advisor test suite based on suite
  /// definition version.
  Future<ListSuiteRunsResponse> listSuiteRuns({
    int? maxResults,
    String? nextToken,
    String? suiteDefinitionId,
    String? suiteDefinitionVersion,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      2000,
    );
    _s.validateStringLength(
      'suiteDefinitionId',
      suiteDefinitionId,
      36,
      36,
    );
    _s.validateStringLength(
      'suiteDefinitionVersion',
      suiteDefinitionVersion,
      2,
      255,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
      if (suiteDefinitionId != null) 'suiteDefinitionId': [suiteDefinitionId],
      if (suiteDefinitionVersion != null)
        'suiteDefinitionVersion': [suiteDefinitionVersion],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/suiteRuns',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListSuiteRunsResponse.fromJson(response);
  }

  /// Lists the tags attached to an IoT Device Advisor resource.
  ///
  /// May throw [InternalServerException].
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [resourceArn] :
  /// The ARN of the IoT Device Advisor resource.
  Future<ListTagsForResourceResponse> listTagsForResource({
    required String resourceArn,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      20,
      2048,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return ListTagsForResourceResponse.fromJson(response);
  }

  /// Lists all the test cases in the test suite.
  ///
  /// May throw [InternalServerException].
  ///
  /// Parameter [intendedForQualification] :
  /// Lists all the qualification test cases in the test suite.
  ///
  /// Parameter [maxResults] :
  /// Requests the test cases max results.
  ///
  /// Parameter [nextToken] :
  /// Requests the test cases next token.
  Future<ListTestCasesResponse> listTestCases({
    bool? intendedForQualification,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      2000,
    );
    final $query = <String, List<String>>{
      if (intendedForQualification != null)
        'intendedForQualification': [intendedForQualification.toString()],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/testCases',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListTestCasesResponse.fromJson(response);
  }

  /// Starts a Device Advisor test suite run.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  /// May throw [ConflictException].
  ///
  /// Parameter [suiteDefinitionId] :
  /// Request to start suite run based on suite definition Id.
  ///
  /// Parameter [suiteDefinitionVersion] :
  /// Request to start suite run based on suite definition version.
  ///
  /// Parameter [suiteRunConfiguration] :
  /// Request to start suite run based on suite configuration.
  ///
  /// Parameter [tags] :
  /// The tags to be attached to the suite run.
  Future<StartSuiteRunResponse> startSuiteRun({
    required String suiteDefinitionId,
    String? suiteDefinitionVersion,
    SuiteRunConfiguration? suiteRunConfiguration,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(suiteDefinitionId, 'suiteDefinitionId');
    _s.validateStringLength(
      'suiteDefinitionId',
      suiteDefinitionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringLength(
      'suiteDefinitionVersion',
      suiteDefinitionVersion,
      2,
      255,
    );
    final $payload = <String, dynamic>{
      if (suiteDefinitionVersion != null)
        'suiteDefinitionVersion': suiteDefinitionVersion,
      if (suiteRunConfiguration != null)
        'suiteRunConfiguration': suiteRunConfiguration,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/suiteDefinitions/${Uri.encodeComponent(suiteDefinitionId)}/suiteRuns',
      exceptionFnMap: _exceptionFns,
    );
    return StartSuiteRunResponse.fromJson(response);
  }

  /// Adds to and modifies existing tags of an IoT Device Advisor resource.
  ///
  /// May throw [InternalServerException].
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [resourceArn] :
  /// The resource ARN of an IoT Device Advisor resource.
  ///
  /// Parameter [tags] :
  /// The tags to be attached to the IoT Device Advisor resource.
  Future<void> tagResource({
    required String resourceArn,
    required Map<String, String> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      20,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(tags, 'tags');
    final $payload = <String, dynamic>{
      'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Removes tags from an IoT Device Advisor resource.
  ///
  /// May throw [InternalServerException].
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [resourceArn] :
  /// The resource ARN of an IoT Device Advisor resource.
  ///
  /// Parameter [tagKeys] :
  /// List of tag keys to remove from the IoT Device Advisor resource.
  Future<void> untagResource({
    required String resourceArn,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      20,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(tagKeys, 'tagKeys');
    final $query = <String, List<String>>{
      'tagKeys': tagKeys,
    };
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Updates a Device Advisor test suite.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [suiteDefinitionId] :
  /// Updates a Device Advisor test suite with suite definition id.
  ///
  /// Parameter [suiteDefinitionConfiguration] :
  /// Updates a Device Advisor test suite with suite definition configuration.
  Future<UpdateSuiteDefinitionResponse> updateSuiteDefinition({
    required String suiteDefinitionId,
    SuiteDefinitionConfiguration? suiteDefinitionConfiguration,
  }) async {
    ArgumentError.checkNotNull(suiteDefinitionId, 'suiteDefinitionId');
    _s.validateStringLength(
      'suiteDefinitionId',
      suiteDefinitionId,
      36,
      36,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      if (suiteDefinitionConfiguration != null)
        'suiteDefinitionConfiguration': suiteDefinitionConfiguration,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PATCH',
      requestUri: '/suiteDefinitions/${Uri.encodeComponent(suiteDefinitionId)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateSuiteDefinitionResponse.fromJson(response);
  }
}

class CreateSuiteDefinitionResponse {
  /// Creates a Device Advisor test suite with TimeStamp of when it was created.
  final DateTime? createdAt;

  /// Creates a Device Advisor test suite with Amazon Resource name.
  final String? suiteDefinitionArn;

  /// Creates a Device Advisor test suite with suite UUID.
  final String? suiteDefinitionId;

  /// Creates a Device Advisor test suite with suite definition name.
  final String? suiteDefinitionName;

  CreateSuiteDefinitionResponse({
    this.createdAt,
    this.suiteDefinitionArn,
    this.suiteDefinitionId,
    this.suiteDefinitionName,
  });
  factory CreateSuiteDefinitionResponse.fromJson(Map<String, dynamic> json) {
    return CreateSuiteDefinitionResponse(
      createdAt: timeStampFromJson(json['createdAt']),
      suiteDefinitionArn: json['suiteDefinitionArn'] as String?,
      suiteDefinitionId: json['suiteDefinitionId'] as String?,
      suiteDefinitionName: json['suiteDefinitionName'] as String?,
    );
  }
}

class DeleteSuiteDefinitionResponse {
  DeleteSuiteDefinitionResponse();
  factory DeleteSuiteDefinitionResponse.fromJson(Map<String, dynamic> _) {
    return DeleteSuiteDefinitionResponse();
  }
}

/// Lists all the devices under test
class DeviceUnderTest {
  /// Lists devices certificate arn
  final String? certificateArn;

  /// Lists devices thing arn
  final String? thingArn;

  DeviceUnderTest({
    this.certificateArn,
    this.thingArn,
  });
  factory DeviceUnderTest.fromJson(Map<String, dynamic> json) {
    return DeviceUnderTest(
      certificateArn: json['certificateArn'] as String?,
      thingArn: json['thingArn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final certificateArn = this.certificateArn;
    final thingArn = this.thingArn;
    return {
      if (certificateArn != null) 'certificateArn': certificateArn,
      if (thingArn != null) 'thingArn': thingArn,
    };
  }
}

class GetSuiteDefinitionResponse {
  /// Gets the timestamp of the time suite was created with GetSuiteDefinition API
  /// call.
  final DateTime? createdAt;

  /// Gets the timestamp of the time suite was modified with GetSuiteDefinition
  /// API call.
  final DateTime? lastModifiedAt;

  /// Gets latest suite definition version with GetSuiteDefinition API call.
  final String? latestVersion;

  /// The ARN of the suite definition.
  final String? suiteDefinitionArn;

  /// Gets the suite configuration with GetSuiteDefinition API call.
  final SuiteDefinitionConfiguration? suiteDefinitionConfiguration;

  /// Gets suite definition Id with GetSuiteDefinition API call.
  final String? suiteDefinitionId;

  /// Gets suite definition version with GetSuiteDefinition API call.
  final String? suiteDefinitionVersion;

  /// Tags attached to the suite definition.
  final Map<String, String>? tags;

  GetSuiteDefinitionResponse({
    this.createdAt,
    this.lastModifiedAt,
    this.latestVersion,
    this.suiteDefinitionArn,
    this.suiteDefinitionConfiguration,
    this.suiteDefinitionId,
    this.suiteDefinitionVersion,
    this.tags,
  });
  factory GetSuiteDefinitionResponse.fromJson(Map<String, dynamic> json) {
    return GetSuiteDefinitionResponse(
      createdAt: timeStampFromJson(json['createdAt']),
      lastModifiedAt: timeStampFromJson(json['lastModifiedAt']),
      latestVersion: json['latestVersion'] as String?,
      suiteDefinitionArn: json['suiteDefinitionArn'] as String?,
      suiteDefinitionConfiguration: json['suiteDefinitionConfiguration'] != null
          ? SuiteDefinitionConfiguration.fromJson(
              json['suiteDefinitionConfiguration'] as Map<String, dynamic>)
          : null,
      suiteDefinitionId: json['suiteDefinitionId'] as String?,
      suiteDefinitionVersion: json['suiteDefinitionVersion'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class GetSuiteRunReportResponse {
  /// Gets the download URL of the qualification report.
  final String? qualificationReportDownloadUrl;

  GetSuiteRunReportResponse({
    this.qualificationReportDownloadUrl,
  });
  factory GetSuiteRunReportResponse.fromJson(Map<String, dynamic> json) {
    return GetSuiteRunReportResponse(
      qualificationReportDownloadUrl:
          json['qualificationReportDownloadUrl'] as String?,
    );
  }
}

class GetSuiteRunResponse {
  /// Gets the information about Device Advisor test suite run based on end time.
  final DateTime? endTime;

  /// Gets the information about Device Advisor test suite run based on error.
  final String? errorReason;

  /// Gets the information about Device Advisor test suite run based on start
  /// time.
  final DateTime? startTime;

  /// Gets the information about Device Advisor test suite run based on its
  /// status.
  final SuiteRunStatus? status;

  /// Gets the information about Device Advisor test suite run based on suite
  /// definition Id.
  final String? suiteDefinitionId;

  /// Gets the information about Device Advisor test suite run based on suite
  /// definition version.
  final String? suiteDefinitionVersion;

  /// The ARN of the suite run.
  final String? suiteRunArn;

  /// Gets the information about Device Advisor test suite run based on suite
  /// configuration.
  final SuiteRunConfiguration? suiteRunConfiguration;

  /// Gets the information about Device Advisor test suite run based on suite run
  /// Id.
  final String? suiteRunId;

  /// The tags attached to the suite run.
  final Map<String, String>? tags;

  /// Gets the information about Device Advisor test suite run based on test case
  /// runs.
  final TestResult? testResult;

  GetSuiteRunResponse({
    this.endTime,
    this.errorReason,
    this.startTime,
    this.status,
    this.suiteDefinitionId,
    this.suiteDefinitionVersion,
    this.suiteRunArn,
    this.suiteRunConfiguration,
    this.suiteRunId,
    this.tags,
    this.testResult,
  });
  factory GetSuiteRunResponse.fromJson(Map<String, dynamic> json) {
    return GetSuiteRunResponse(
      endTime: timeStampFromJson(json['endTime']),
      errorReason: json['errorReason'] as String?,
      startTime: timeStampFromJson(json['startTime']),
      status: (json['status'] as String?)?.toSuiteRunStatus(),
      suiteDefinitionId: json['suiteDefinitionId'] as String?,
      suiteDefinitionVersion: json['suiteDefinitionVersion'] as String?,
      suiteRunArn: json['suiteRunArn'] as String?,
      suiteRunConfiguration: json['suiteRunConfiguration'] != null
          ? SuiteRunConfiguration.fromJson(
              json['suiteRunConfiguration'] as Map<String, dynamic>)
          : null,
      suiteRunId: json['suiteRunId'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      testResult: json['testResult'] != null
          ? TestResult.fromJson(json['testResult'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Show Group Result.
class GroupResult {
  /// Show Group Result Id.
  final String? groupId;

  /// Show Group Result Name.
  final String? groupName;

  /// Show Group Result.
  final List<TestCaseRun>? tests;

  GroupResult({
    this.groupId,
    this.groupName,
    this.tests,
  });
  factory GroupResult.fromJson(Map<String, dynamic> json) {
    return GroupResult(
      groupId: json['groupId'] as String?,
      groupName: json['groupName'] as String?,
      tests: (json['tests'] as List?)
          ?.whereNotNull()
          .map((e) => TestCaseRun.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListSuiteDefinitionsResponse {
  /// Creates a Device Advisor test suite.
  final String? nextToken;

  /// Lists test suite information using List suite definition.
  final List<SuiteDefinitionInformation>? suiteDefinitionInformationList;

  ListSuiteDefinitionsResponse({
    this.nextToken,
    this.suiteDefinitionInformationList,
  });
  factory ListSuiteDefinitionsResponse.fromJson(Map<String, dynamic> json) {
    return ListSuiteDefinitionsResponse(
      nextToken: json['nextToken'] as String?,
      suiteDefinitionInformationList: (json['suiteDefinitionInformationList']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              SuiteDefinitionInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListSuiteRunsResponse {
  /// Next pagination token for list suite run response.
  final String? nextToken;

  /// Lists the runs of the specified Device Advisor test suite.
  final List<SuiteRunInformation>? suiteRunsList;

  ListSuiteRunsResponse({
    this.nextToken,
    this.suiteRunsList,
  });
  factory ListSuiteRunsResponse.fromJson(Map<String, dynamic> json) {
    return ListSuiteRunsResponse(
      nextToken: json['nextToken'] as String?,
      suiteRunsList: (json['suiteRunsList'] as List?)
          ?.whereNotNull()
          .map((e) => SuiteRunInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListTagsForResourceResponse {
  /// The tags attached to the IoT Device Advisor resource.
  final Map<String, String>? tags;

  ListTagsForResourceResponse({
    this.tags,
  });
  factory ListTagsForResourceResponse.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResponse(
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class ListTestCasesResponse {
  /// Gets the category of test case.
  final List<TestCaseCategory>? categories;

  /// Gets the configuration of test group.
  final Map<String, String>? groupConfiguration;

  /// Test cases next token response.
  final String? nextToken;

  /// Gets the configuration of root test group.
  final Map<String, String>? rootGroupConfiguration;

  ListTestCasesResponse({
    this.categories,
    this.groupConfiguration,
    this.nextToken,
    this.rootGroupConfiguration,
  });
  factory ListTestCasesResponse.fromJson(Map<String, dynamic> json) {
    return ListTestCasesResponse(
      categories: (json['categories'] as List?)
          ?.whereNotNull()
          .map((e) => TestCaseCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupConfiguration: (json['groupConfiguration'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      nextToken: json['nextToken'] as String?,
      rootGroupConfiguration:
          (json['rootGroupConfiguration'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class StartSuiteRunResponse {
  /// Starts a Device Advisor test suite run based on suite create time.
  final DateTime? createdAt;

  /// Starts a Device Advisor test suite run based on suite run arn.
  final String? suiteRunArn;

  /// Starts a Device Advisor test suite run based on suite Run Id.
  final String? suiteRunId;

  StartSuiteRunResponse({
    this.createdAt,
    this.suiteRunArn,
    this.suiteRunId,
  });
  factory StartSuiteRunResponse.fromJson(Map<String, dynamic> json) {
    return StartSuiteRunResponse(
      createdAt: timeStampFromJson(json['createdAt']),
      suiteRunArn: json['suiteRunArn'] as String?,
      suiteRunId: json['suiteRunId'] as String?,
    );
  }
}

enum Status {
  pass,
  fail,
  canceled,
  pending,
  running,
  passWithWarnings,
  error,
}

extension on Status {
  String toValue() {
    switch (this) {
      case Status.pass:
        return 'PASS';
      case Status.fail:
        return 'FAIL';
      case Status.canceled:
        return 'CANCELED';
      case Status.pending:
        return 'PENDING';
      case Status.running:
        return 'RUNNING';
      case Status.passWithWarnings:
        return 'PASS_WITH_WARNINGS';
      case Status.error:
        return 'ERROR';
    }
  }
}

extension on String {
  Status toStatus() {
    switch (this) {
      case 'PASS':
        return Status.pass;
      case 'FAIL':
        return Status.fail;
      case 'CANCELED':
        return Status.canceled;
      case 'PENDING':
        return Status.pending;
      case 'RUNNING':
        return Status.running;
      case 'PASS_WITH_WARNINGS':
        return Status.passWithWarnings;
      case 'ERROR':
        return Status.error;
    }
    throw Exception('$this is not known in enum Status');
  }
}

/// Gets Suite Definition Configuration.
class SuiteDefinitionConfiguration {
  /// Gets device permission arn.
  final String? devicePermissionRoleArn;

  /// Gets the devices configured.
  final List<DeviceUnderTest>? devices;

  /// Gets the tests intended for qualification in a suite.
  final bool? intendedForQualification;

  /// Gets test suite root group.
  final String? rootGroup;

  /// Gets Suite Definition Configuration name.
  final String? suiteDefinitionName;

  SuiteDefinitionConfiguration({
    this.devicePermissionRoleArn,
    this.devices,
    this.intendedForQualification,
    this.rootGroup,
    this.suiteDefinitionName,
  });
  factory SuiteDefinitionConfiguration.fromJson(Map<String, dynamic> json) {
    return SuiteDefinitionConfiguration(
      devicePermissionRoleArn: json['devicePermissionRoleArn'] as String?,
      devices: (json['devices'] as List?)
          ?.whereNotNull()
          .map((e) => DeviceUnderTest.fromJson(e as Map<String, dynamic>))
          .toList(),
      intendedForQualification: json['intendedForQualification'] as bool?,
      rootGroup: json['rootGroup'] as String?,
      suiteDefinitionName: json['suiteDefinitionName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final devicePermissionRoleArn = this.devicePermissionRoleArn;
    final devices = this.devices;
    final intendedForQualification = this.intendedForQualification;
    final rootGroup = this.rootGroup;
    final suiteDefinitionName = this.suiteDefinitionName;
    return {
      if (devicePermissionRoleArn != null)
        'devicePermissionRoleArn': devicePermissionRoleArn,
      if (devices != null) 'devices': devices,
      if (intendedForQualification != null)
        'intendedForQualification': intendedForQualification,
      if (rootGroup != null) 'rootGroup': rootGroup,
      if (suiteDefinitionName != null)
        'suiteDefinitionName': suiteDefinitionName,
    };
  }
}

/// Get suite definition information.
class SuiteDefinitionInformation {
  /// Gets the information of when the test suite was created.
  final DateTime? createdAt;

  /// Specifies the devices under test.
  final List<DeviceUnderTest>? defaultDevices;

  /// Gets the test suites which will be used for qualification.
  final bool? intendedForQualification;

  /// Get suite definition Id.
  final String? suiteDefinitionId;

  /// Get test suite name.
  final String? suiteDefinitionName;

  SuiteDefinitionInformation({
    this.createdAt,
    this.defaultDevices,
    this.intendedForQualification,
    this.suiteDefinitionId,
    this.suiteDefinitionName,
  });
  factory SuiteDefinitionInformation.fromJson(Map<String, dynamic> json) {
    return SuiteDefinitionInformation(
      createdAt: timeStampFromJson(json['createdAt']),
      defaultDevices: (json['defaultDevices'] as List?)
          ?.whereNotNull()
          .map((e) => DeviceUnderTest.fromJson(e as Map<String, dynamic>))
          .toList(),
      intendedForQualification: json['intendedForQualification'] as bool?,
      suiteDefinitionId: json['suiteDefinitionId'] as String?,
      suiteDefinitionName: json['suiteDefinitionName'] as String?,
    );
  }
}

/// Gets suite run configuration.
class SuiteRunConfiguration {
  /// Gets the primary device for suite run.
  final DeviceUnderTest? primaryDevice;

  /// Gets the secondary device for suite run.
  final DeviceUnderTest? secondaryDevice;

  /// Gets test case list.
  final List<String>? selectedTestList;

  SuiteRunConfiguration({
    this.primaryDevice,
    this.secondaryDevice,
    this.selectedTestList,
  });
  factory SuiteRunConfiguration.fromJson(Map<String, dynamic> json) {
    return SuiteRunConfiguration(
      primaryDevice: json['primaryDevice'] != null
          ? DeviceUnderTest.fromJson(
              json['primaryDevice'] as Map<String, dynamic>)
          : null,
      secondaryDevice: json['secondaryDevice'] != null
          ? DeviceUnderTest.fromJson(
              json['secondaryDevice'] as Map<String, dynamic>)
          : null,
      selectedTestList: (json['selectedTestList'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final primaryDevice = this.primaryDevice;
    final secondaryDevice = this.secondaryDevice;
    final selectedTestList = this.selectedTestList;
    return {
      if (primaryDevice != null) 'primaryDevice': primaryDevice,
      if (secondaryDevice != null) 'secondaryDevice': secondaryDevice,
      if (selectedTestList != null) 'selectedTestList': selectedTestList,
    };
  }
}

/// Get suite run information.
class SuiteRunInformation {
  /// Get suite run information based on time suite was created.
  final DateTime? createdAt;

  /// Get suite run information based on end time of the run.
  final DateTime? endAt;

  /// Get suite run information based on result of the test suite run.
  final int? failed;

  /// Get suite run information based on result of the test suite run.
  final int? passed;

  /// Get suite run information based on start time of the run.
  final DateTime? startedAt;

  /// Get suite run information based on test run status.
  final SuiteRunStatus? status;

  /// Get suite run information based on suite definition Id.
  final String? suiteDefinitionId;

  /// Get suite run information based on suite definition name.
  final String? suiteDefinitionName;

  /// Get suite run information based on suite definition version.
  final String? suiteDefinitionVersion;

  /// Get suite run information based on suite run Id.
  final String? suiteRunId;

  SuiteRunInformation({
    this.createdAt,
    this.endAt,
    this.failed,
    this.passed,
    this.startedAt,
    this.status,
    this.suiteDefinitionId,
    this.suiteDefinitionName,
    this.suiteDefinitionVersion,
    this.suiteRunId,
  });
  factory SuiteRunInformation.fromJson(Map<String, dynamic> json) {
    return SuiteRunInformation(
      createdAt: timeStampFromJson(json['createdAt']),
      endAt: timeStampFromJson(json['endAt']),
      failed: json['failed'] as int?,
      passed: json['passed'] as int?,
      startedAt: timeStampFromJson(json['startedAt']),
      status: (json['status'] as String?)?.toSuiteRunStatus(),
      suiteDefinitionId: json['suiteDefinitionId'] as String?,
      suiteDefinitionName: json['suiteDefinitionName'] as String?,
      suiteDefinitionVersion: json['suiteDefinitionVersion'] as String?,
      suiteRunId: json['suiteRunId'] as String?,
    );
  }
}

enum SuiteRunStatus {
  pass,
  fail,
  canceled,
  pending,
  running,
  passWithWarnings,
  error,
}

extension on SuiteRunStatus {
  String toValue() {
    switch (this) {
      case SuiteRunStatus.pass:
        return 'PASS';
      case SuiteRunStatus.fail:
        return 'FAIL';
      case SuiteRunStatus.canceled:
        return 'CANCELED';
      case SuiteRunStatus.pending:
        return 'PENDING';
      case SuiteRunStatus.running:
        return 'RUNNING';
      case SuiteRunStatus.passWithWarnings:
        return 'PASS_WITH_WARNINGS';
      case SuiteRunStatus.error:
        return 'ERROR';
    }
  }
}

extension on String {
  SuiteRunStatus toSuiteRunStatus() {
    switch (this) {
      case 'PASS':
        return SuiteRunStatus.pass;
      case 'FAIL':
        return SuiteRunStatus.fail;
      case 'CANCELED':
        return SuiteRunStatus.canceled;
      case 'PENDING':
        return SuiteRunStatus.pending;
      case 'RUNNING':
        return SuiteRunStatus.running;
      case 'PASS_WITH_WARNINGS':
        return SuiteRunStatus.passWithWarnings;
      case 'ERROR':
        return SuiteRunStatus.error;
    }
    throw Exception('$this is not known in enum SuiteRunStatus');
  }
}

class TagResourceResponse {
  TagResourceResponse();
  factory TagResourceResponse.fromJson(Map<String, dynamic> _) {
    return TagResourceResponse();
  }
}

/// Shows tests in a test group.
class TestCase {
  /// Shows test case configuration.
  final Map<String, String>? configuration;

  /// Shows test case name.
  final String? name;

  /// Specifies a test.
  final TestCaseDefinition? test;

  TestCase({
    this.configuration,
    this.name,
    this.test,
  });
  factory TestCase.fromJson(Map<String, dynamic> json) {
    return TestCase(
      configuration: (json['configuration'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      name: json['name'] as String?,
      test: json['test'] != null
          ? TestCaseDefinition.fromJson(json['test'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Gets the test case category.
class TestCaseCategory {
  /// Lists all the tests name in the specified category.
  final String? name;

  /// Lists all the tests in the specified category.
  final List<TestCase>? tests;

  TestCaseCategory({
    this.name,
    this.tests,
  });
  factory TestCaseCategory.fromJson(Map<String, dynamic> json) {
    return TestCaseCategory(
      name: json['name'] as String?,
      tests: (json['tests'] as List?)
          ?.whereNotNull()
          .map((e) => TestCase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Provides test case definition.
class TestCaseDefinition {
  /// Provides test case definition Id.
  final String? id;

  /// Provides test case definition version.
  final String? testCaseVersion;

  TestCaseDefinition({
    this.id,
    this.testCaseVersion,
  });
  factory TestCaseDefinition.fromJson(Map<String, dynamic> json) {
    return TestCaseDefinition(
      id: json['id'] as String?,
      testCaseVersion: json['testCaseVersion'] as String?,
    );
  }
}

/// Provides test case run.
class TestCaseRun {
  /// Provides test case run end time.
  final DateTime? endTime;

  /// Provides test case run failure result.
  final String? failure;

  /// Provides test case run log Url.
  final String? logUrl;

  /// Provides test case run start time.
  final DateTime? startTime;

  /// Provides test case run status.
  final Status? status;

  /// Provides test case run definition Id.
  final String? testCaseDefinitionId;

  /// Provides test case run definition Name.
  final String? testCaseDefinitionName;

  /// Provides test case run Id.
  final String? testCaseRunId;

  /// Provides test case run warnings.
  final String? warnings;

  TestCaseRun({
    this.endTime,
    this.failure,
    this.logUrl,
    this.startTime,
    this.status,
    this.testCaseDefinitionId,
    this.testCaseDefinitionName,
    this.testCaseRunId,
    this.warnings,
  });
  factory TestCaseRun.fromJson(Map<String, dynamic> json) {
    return TestCaseRun(
      endTime: timeStampFromJson(json['endTime']),
      failure: json['failure'] as String?,
      logUrl: json['logUrl'] as String?,
      startTime: timeStampFromJson(json['startTime']),
      status: (json['status'] as String?)?.toStatus(),
      testCaseDefinitionId: json['testCaseDefinitionId'] as String?,
      testCaseDefinitionName: json['testCaseDefinitionName'] as String?,
      testCaseRunId: json['testCaseRunId'] as String?,
      warnings: json['warnings'] as String?,
    );
  }
}

/// Show each group result.
class TestResult {
  /// Show each group of test results.
  final List<GroupResult>? groups;

  TestResult({
    this.groups,
  });
  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      groups: (json['groups'] as List?)
          ?.whereNotNull()
          .map((e) => GroupResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class UntagResourceResponse {
  UntagResourceResponse();
  factory UntagResourceResponse.fromJson(Map<String, dynamic> _) {
    return UntagResourceResponse();
  }
}

class UpdateSuiteDefinitionResponse {
  /// Updates a Device Advisor test suite with TimeStamp of when it was created.
  final DateTime? createdAt;

  /// Updates a Device Advisor test suite with TimeStamp of when it was updated.
  final DateTime? lastUpdatedAt;

  /// Updates a Device Advisor test suite with Amazon Resource name.
  final String? suiteDefinitionArn;

  /// Updates a Device Advisor test suite with suite UUID.
  final String? suiteDefinitionId;

  /// Updates a Device Advisor test suite with suite definition name.
  final String? suiteDefinitionName;

  /// Updates a Device Advisor test suite with suite definition version.
  final String? suiteDefinitionVersion;

  UpdateSuiteDefinitionResponse({
    this.createdAt,
    this.lastUpdatedAt,
    this.suiteDefinitionArn,
    this.suiteDefinitionId,
    this.suiteDefinitionName,
    this.suiteDefinitionVersion,
  });
  factory UpdateSuiteDefinitionResponse.fromJson(Map<String, dynamic> json) {
    return UpdateSuiteDefinitionResponse(
      createdAt: timeStampFromJson(json['createdAt']),
      lastUpdatedAt: timeStampFromJson(json['lastUpdatedAt']),
      suiteDefinitionArn: json['suiteDefinitionArn'] as String?,
      suiteDefinitionId: json['suiteDefinitionId'] as String?,
      suiteDefinitionName: json['suiteDefinitionName'] as String?,
      suiteDefinitionVersion: json['suiteDefinitionVersion'] as String?,
    );
  }
}

class ConflictException extends _s.GenericAwsException {
  ConflictException({String? type, String? message})
      : super(type: type, code: 'ConflictException', message: message);
}

class InternalServerException extends _s.GenericAwsException {
  InternalServerException({String? type, String? message})
      : super(type: type, code: 'InternalServerException', message: message);
}

class ResourceNotFoundException extends _s.GenericAwsException {
  ResourceNotFoundException({String? type, String? message})
      : super(type: type, code: 'ResourceNotFoundException', message: message);
}

class ValidationException extends _s.GenericAwsException {
  ValidationException({String? type, String? message})
      : super(type: type, code: 'ValidationException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'ConflictException': (type, message) =>
      ConflictException(type: type, message: message),
  'InternalServerException': (type, message) =>
      InternalServerException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ValidationException': (type, message) =>
      ValidationException(type: type, message: message),
};
