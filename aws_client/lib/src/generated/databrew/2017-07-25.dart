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

/// AWS Glue DataBrew is a visual, cloud-scale data-preparation service.
/// DataBrew simplifies data preparation tasks, targeting data issues that are
/// hard to spot and time-consuming to fix. DataBrew empowers users of all
/// technical levels to visualize the data and perform one-click data
/// transformations, with no coding required.
class GlueDataBrew {
  final _s.RestJsonProtocol _protocol;
  GlueDataBrew({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'databrew',
            signingName: 'databrew',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  /// Deletes one or more versions of a recipe at a time.
  ///
  /// May throw [ConflictException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the recipe to be modified.
  ///
  /// Parameter [recipeVersions] :
  /// An array of version identifiers to be deleted.
  Future<BatchDeleteRecipeVersionResponse> batchDeleteRecipeVersion({
    required String name,
    required List<String> recipeVersions,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(recipeVersions, 'recipeVersions');
    final $payload = <String, dynamic>{
      'RecipeVersions': recipeVersions,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/recipes/${Uri.encodeComponent(name)}/batchDeleteRecipeVersion',
      exceptionFnMap: _exceptionFns,
    );
    return BatchDeleteRecipeVersionResponse.fromJson(response);
  }

  /// Creates a new AWS Glue DataBrew dataset for this AWS account.
  ///
  /// May throw [AccessDeniedException].
  /// May throw [ConflictException].
  /// May throw [ServiceQuotaExceededException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the dataset to be created.
  ///
  /// Parameter [tags] :
  /// Metadata tags to apply to this dataset.
  Future<CreateDatasetResponse> createDataset({
    required Input input,
    required String name,
    FormatOptions? formatOptions,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(input, 'input');
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'Input': input,
      'Name': name,
      if (formatOptions != null) 'FormatOptions': formatOptions,
      if (tags != null) 'Tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/datasets',
      exceptionFnMap: _exceptionFns,
    );
    return CreateDatasetResponse.fromJson(response);
  }

  /// Creates a new job to profile an AWS Glue DataBrew dataset that exists in
  /// the current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [datasetName] :
  /// The name of the dataset that this job is to act upon.
  ///
  /// Parameter [name] :
  /// The name of the job to be created.
  ///
  /// Parameter [roleArn] :
  /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
  /// (IAM) role to be assumed for this request.
  ///
  /// Parameter [encryptionKeyArn] :
  /// The Amazon Resource Name (ARN) of an encryption key that is used to
  /// protect the job.
  ///
  /// Parameter [encryptionMode] :
  /// The encryption mode for the job, which can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>SSE-KMS</code> - para&gt;<code>SSE-KMS</code> - server-side
  /// encryption with AWS KMS-managed keys.
  /// </li>
  /// <li>
  /// <code>SSE-S3</code> - Server-side encryption with keys managed by Amazon
  /// S3.
  /// </li>
  /// </ul>
  ///
  /// Parameter [logSubscription] :
  /// A value that enables or disables Amazon CloudWatch logging for the current
  /// AWS account. If logging is enabled, CloudWatch writes one log stream for
  /// each job run.
  ///
  /// Parameter [maxCapacity] :
  /// The maximum number of nodes that DataBrew can use when the job processes
  /// data.
  ///
  /// Parameter [maxRetries] :
  /// The maximum number of times to retry the job after a job run fails.
  ///
  /// Parameter [tags] :
  /// Metadata tags to apply to this job.
  ///
  /// Parameter [timeout] :
  /// The job's timeout in minutes. A job that attempts to run longer than this
  /// timeout period ends with a status of <code>TIMEOUT</code>.
  Future<CreateProfileJobResponse> createProfileJob({
    required String datasetName,
    required String name,
    required S3Location outputLocation,
    required String roleArn,
    String? encryptionKeyArn,
    EncryptionMode? encryptionMode,
    LogSubscription? logSubscription,
    int? maxCapacity,
    int? maxRetries,
    Map<String, String>? tags,
    int? timeout,
  }) async {
    ArgumentError.checkNotNull(datasetName, 'datasetName');
    _s.validateStringLength(
      'datasetName',
      datasetName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    ArgumentError.checkNotNull(outputLocation, 'outputLocation');
    ArgumentError.checkNotNull(roleArn, 'roleArn');
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
      isRequired: true,
    );
    _s.validateStringLength(
      'encryptionKeyArn',
      encryptionKeyArn,
      20,
      2048,
    );
    _s.validateNumRange(
      'maxRetries',
      maxRetries,
      0,
      1152921504606846976,
    );
    _s.validateNumRange(
      'timeout',
      timeout,
      0,
      1152921504606846976,
    );
    final $payload = <String, dynamic>{
      'DatasetName': datasetName,
      'Name': name,
      'OutputLocation': outputLocation,
      'RoleArn': roleArn,
      if (encryptionKeyArn != null) 'EncryptionKeyArn': encryptionKeyArn,
      if (encryptionMode != null) 'EncryptionMode': encryptionMode.toValue(),
      if (logSubscription != null) 'LogSubscription': logSubscription.toValue(),
      if (maxCapacity != null) 'MaxCapacity': maxCapacity,
      if (maxRetries != null) 'MaxRetries': maxRetries,
      if (tags != null) 'Tags': tags,
      if (timeout != null) 'Timeout': timeout,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/profileJobs',
      exceptionFnMap: _exceptionFns,
    );
    return CreateProfileJobResponse.fromJson(response);
  }

  /// Creates a new AWS Glue DataBrew project in the current AWS account.
  ///
  /// May throw [ConflictException].
  /// May throw [InternalServerException].
  /// May throw [ServiceQuotaExceededException].
  /// May throw [ValidationException].
  ///
  /// Parameter [datasetName] :
  /// The name of the dataset to associate this project with.
  ///
  /// Parameter [name] :
  /// A unique name for the new project.
  ///
  /// Parameter [recipeName] :
  /// The name of an existing recipe to associate with the project.
  ///
  /// Parameter [roleArn] :
  /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
  /// (IAM) role to be assumed for this request.
  ///
  /// Parameter [tags] :
  /// Metadata tags to apply to this project.
  Future<CreateProjectResponse> createProject({
    required String datasetName,
    required String name,
    required String recipeName,
    required String roleArn,
    Sample? sample,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(datasetName, 'datasetName');
    _s.validateStringLength(
      'datasetName',
      datasetName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(recipeName, 'recipeName');
    _s.validateStringLength(
      'recipeName',
      recipeName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(roleArn, 'roleArn');
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'DatasetName': datasetName,
      'Name': name,
      'RecipeName': recipeName,
      'RoleArn': roleArn,
      if (sample != null) 'Sample': sample,
      if (tags != null) 'Tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/projects',
      exceptionFnMap: _exceptionFns,
    );
    return CreateProjectResponse.fromJson(response);
  }

  /// Creates a new AWS Glue DataBrew recipe for the current AWS account.
  ///
  /// May throw [ConflictException].
  /// May throw [ServiceQuotaExceededException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// A unique name for the recipe.
  ///
  /// Parameter [steps] :
  /// An array containing the steps to be performed by the recipe. Each recipe
  /// step consists of one recipe action and (optionally) an array of condition
  /// expressions.
  ///
  /// Parameter [description] :
  /// A description for the recipe.
  ///
  /// Parameter [tags] :
  /// Metadata tags to apply to this recipe.
  Future<CreateRecipeResponse> createRecipe({
    required String name,
    required List<RecipeStep> steps,
    String? description,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(steps, 'steps');
    _s.validateStringLength(
      'description',
      description,
      0,
      1024,
    );
    final $payload = <String, dynamic>{
      'Name': name,
      'Steps': steps,
      if (description != null) 'Description': description,
      if (tags != null) 'Tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/recipes',
      exceptionFnMap: _exceptionFns,
    );
    return CreateRecipeResponse.fromJson(response);
  }

  /// Creates a new job for an existing AWS Glue DataBrew recipe in the current
  /// AWS account. You can create a standalone job using either a project, or a
  /// combination of a recipe and a dataset.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// A unique name for the job.
  ///
  /// Parameter [outputs] :
  /// One or more artifacts that represent the output from running the job.
  ///
  /// Parameter [roleArn] :
  /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
  /// (IAM) role to be assumed for this request.
  ///
  /// Parameter [datasetName] :
  /// The name of the dataset that this job processes.
  ///
  /// Parameter [encryptionKeyArn] :
  /// The Amazon Resource Name (ARN) of an encryption key that is used to
  /// protect the job.
  ///
  /// Parameter [encryptionMode] :
  /// The encryption mode for the job, which can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>SSE-KMS</code> - Server-side encryption with AWS KMS-managed keys.
  /// </li>
  /// <li>
  /// <code>SSE-S3</code> - Server-side encryption with keys managed by Amazon
  /// S3.
  /// </li>
  /// </ul>
  ///
  /// Parameter [logSubscription] :
  /// A value that enables or disables Amazon CloudWatch logging for the current
  /// AWS account. If logging is enabled, CloudWatch writes one log stream for
  /// each job run.
  ///
  /// Parameter [maxCapacity] :
  /// The maximum number of nodes that DataBrew can consume when the job
  /// processes data.
  ///
  /// Parameter [maxRetries] :
  /// The maximum number of times to retry the job after a job run fails.
  ///
  /// Parameter [projectName] :
  /// Either the name of an existing project, or a combination of a recipe and a
  /// dataset to associate with the recipe.
  ///
  /// Parameter [tags] :
  /// Metadata tags to apply to this job dataset.
  ///
  /// Parameter [timeout] :
  /// The job's timeout in minutes. A job that attempts to run longer than this
  /// timeout period ends with a status of <code>TIMEOUT</code>.
  Future<CreateRecipeJobResponse> createRecipeJob({
    required String name,
    required List<Output> outputs,
    required String roleArn,
    String? datasetName,
    String? encryptionKeyArn,
    EncryptionMode? encryptionMode,
    LogSubscription? logSubscription,
    int? maxCapacity,
    int? maxRetries,
    String? projectName,
    RecipeReference? recipeReference,
    Map<String, String>? tags,
    int? timeout,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    ArgumentError.checkNotNull(outputs, 'outputs');
    ArgumentError.checkNotNull(roleArn, 'roleArn');
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
      isRequired: true,
    );
    _s.validateStringLength(
      'datasetName',
      datasetName,
      1,
      255,
    );
    _s.validateStringLength(
      'encryptionKeyArn',
      encryptionKeyArn,
      20,
      2048,
    );
    _s.validateNumRange(
      'maxRetries',
      maxRetries,
      0,
      1152921504606846976,
    );
    _s.validateStringLength(
      'projectName',
      projectName,
      1,
      255,
    );
    _s.validateNumRange(
      'timeout',
      timeout,
      0,
      1152921504606846976,
    );
    final $payload = <String, dynamic>{
      'Name': name,
      'Outputs': outputs,
      'RoleArn': roleArn,
      if (datasetName != null) 'DatasetName': datasetName,
      if (encryptionKeyArn != null) 'EncryptionKeyArn': encryptionKeyArn,
      if (encryptionMode != null) 'EncryptionMode': encryptionMode.toValue(),
      if (logSubscription != null) 'LogSubscription': logSubscription.toValue(),
      if (maxCapacity != null) 'MaxCapacity': maxCapacity,
      if (maxRetries != null) 'MaxRetries': maxRetries,
      if (projectName != null) 'ProjectName': projectName,
      if (recipeReference != null) 'RecipeReference': recipeReference,
      if (tags != null) 'Tags': tags,
      if (timeout != null) 'Timeout': timeout,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/recipeJobs',
      exceptionFnMap: _exceptionFns,
    );
    return CreateRecipeJobResponse.fromJson(response);
  }

  /// Creates a new schedule for one or more AWS Glue DataBrew jobs. Jobs can be
  /// run at a specific date and time, or at regular intervals.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [cronExpression] :
  /// The date or dates and time or times, in <code>cron</code> format, when the
  /// jobs are to be run.
  ///
  /// Parameter [name] :
  /// A unique name for the schedule.
  ///
  /// Parameter [jobNames] :
  /// The name or names of one or more jobs to be run.
  ///
  /// Parameter [tags] :
  /// Metadata tags to apply to this schedule.
  Future<CreateScheduleResponse> createSchedule({
    required String cronExpression,
    required String name,
    List<String>? jobNames,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(cronExpression, 'cronExpression');
    _s.validateStringLength(
      'cronExpression',
      cronExpression,
      1,
      512,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'CronExpression': cronExpression,
      'Name': name,
      if (jobNames != null) 'JobNames': jobNames,
      if (tags != null) 'Tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/schedules',
      exceptionFnMap: _exceptionFns,
    );
    return CreateScheduleResponse.fromJson(response);
  }

  /// Deletes a dataset from AWS Glue DataBrew.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the dataset to be deleted.
  Future<DeleteDatasetResponse> deleteDataset({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/datasets/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DeleteDatasetResponse.fromJson(response);
  }

  /// Deletes the specified AWS Glue DataBrew job from the current AWS account.
  /// The job can be for a recipe or for a profile.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the job to be deleted.
  Future<DeleteJobResponse> deleteJob({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/jobs/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DeleteJobResponse.fromJson(response);
  }

  /// Deletes an existing AWS Glue DataBrew project from the current AWS
  /// account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the project to be deleted.
  Future<DeleteProjectResponse> deleteProject({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/projects/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DeleteProjectResponse.fromJson(response);
  }

  /// Deletes a single version of an AWS Glue DataBrew recipe.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the recipe to be deleted.
  ///
  /// Parameter [recipeVersion] :
  /// The version of the recipe to be deleted.
  Future<DeleteRecipeVersionResponse> deleteRecipeVersion({
    required String name,
    required String recipeVersion,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(recipeVersion, 'recipeVersion');
    _s.validateStringLength(
      'recipeVersion',
      recipeVersion,
      1,
      16,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/recipes/${Uri.encodeComponent(name)}/recipeVersion/${Uri.encodeComponent(recipeVersion)}',
      exceptionFnMap: _exceptionFns,
    );
    return DeleteRecipeVersionResponse.fromJson(response);
  }

  /// Deletes the specified AWS Glue DataBrew schedule from the current AWS
  /// account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the schedule to be deleted.
  Future<DeleteScheduleResponse> deleteSchedule({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/schedules/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DeleteScheduleResponse.fromJson(response);
  }

  /// Returns the definition of a specific AWS Glue DataBrew dataset that is in
  /// the current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the dataset to be described.
  Future<DescribeDatasetResponse> describeDataset({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/datasets/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeDatasetResponse.fromJson(response);
  }

  /// Returns the definition of a specific AWS Glue DataBrew job that is in the
  /// current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the job to be described.
  Future<DescribeJobResponse> describeJob({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/jobs/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeJobResponse.fromJson(response);
  }

  /// Returns the definition of a specific AWS Glue DataBrew project that is in
  /// the current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the project to be described.
  Future<DescribeProjectResponse> describeProject({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/projects/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeProjectResponse.fromJson(response);
  }

  /// Returns the definition of a specific AWS Glue DataBrew recipe that is in
  /// the current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the recipe to be described.
  ///
  /// Parameter [recipeVersion] :
  /// The recipe version identifier. If this parameter isn't specified, then the
  /// latest published version is returned.
  Future<DescribeRecipeResponse> describeRecipe({
    required String name,
    String? recipeVersion,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'recipeVersion',
      recipeVersion,
      1,
      16,
    );
    final $query = <String, List<String>>{
      if (recipeVersion != null) 'recipeVersion': [recipeVersion],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/recipes/${Uri.encodeComponent(name)}',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return DescribeRecipeResponse.fromJson(response);
  }

  /// Returns the definition of a specific AWS Glue DataBrew schedule that is in
  /// the current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the schedule to be described.
  Future<DescribeScheduleResponse> describeSchedule({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/schedules/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeScheduleResponse.fromJson(response);
  }

  /// Lists all of the AWS Glue DataBrew datasets for the current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in this request.
  ///
  /// Parameter [nextToken] :
  /// A token generated by DataBrew that specifies where to continue pagination
  /// if a previous request was truncated. To get the next set of pages, pass in
  /// the NextToken value from the response object of the previous page call.
  Future<ListDatasetsResponse> listDatasets({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/datasets',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListDatasetsResponse.fromJson(response);
  }

  /// Lists all of the previous runs of a particular AWS Glue DataBrew job in
  /// the current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the job.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in this request.
  ///
  /// Parameter [nextToken] :
  /// A token generated by AWS Glue DataBrew that specifies where to continue
  /// pagination if a previous request was truncated. To get the next set of
  /// pages, pass in the NextToken value from the response object of the
  /// previous page call.
  Future<ListJobRunsResponse> listJobRuns({
    required String name,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/jobs/${Uri.encodeComponent(name)}/jobRuns',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListJobRunsResponse.fromJson(response);
  }

  /// Lists the AWS Glue DataBrew jobs in the current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [datasetName] :
  /// The name of a dataset. Using this parameter indicates to return only those
  /// jobs that act on the specified dataset.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in this request.
  ///
  /// Parameter [nextToken] :
  /// A token generated by DataBrew that specifies where to continue pagination
  /// if a previous request was truncated. To get the next set of pages, pass in
  /// the NextToken value from the response object of the previous page call.
  ///
  /// Parameter [projectName] :
  /// The name of a project. Using this parameter indicates to return only those
  /// jobs that are associated with the specified project.
  Future<ListJobsResponse> listJobs({
    String? datasetName,
    int? maxResults,
    String? nextToken,
    String? projectName,
  }) async {
    _s.validateStringLength(
      'datasetName',
      datasetName,
      1,
      255,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    _s.validateStringLength(
      'projectName',
      projectName,
      1,
      255,
    );
    final $query = <String, List<String>>{
      if (datasetName != null) 'datasetName': [datasetName],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
      if (projectName != null) 'projectName': [projectName],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/jobs',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListJobsResponse.fromJson(response);
  }

  /// Lists all of the DataBrew projects in the current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in this request.
  ///
  /// Parameter [nextToken] :
  /// A pagination token that can be used in a subsequent request.
  Future<ListProjectsResponse> listProjects({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/projects',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListProjectsResponse.fromJson(response);
  }

  /// Lists all of the versions of a particular AWS Glue DataBrew recipe in the
  /// current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the recipe for which to return version information.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in this request.
  ///
  /// Parameter [nextToken] :
  /// A pagination token that can be used in a subsequent request.
  Future<ListRecipeVersionsResponse> listRecipeVersions({
    required String name,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    final $query = <String, List<String>>{
      'name': [name],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/recipeVersions',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListRecipeVersionsResponse.fromJson(response);
  }

  /// Lists all of the AWS Glue DataBrew recipes in the current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in this request.
  ///
  /// Parameter [nextToken] :
  /// A pagination token that can be used in a subsequent request.
  ///
  /// Parameter [recipeVersion] :
  /// A version identifier. Using this parameter indicates to return only those
  /// recipes that have this version identifier.
  Future<ListRecipesResponse> listRecipes({
    int? maxResults,
    String? nextToken,
    String? recipeVersion,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    _s.validateStringLength(
      'recipeVersion',
      recipeVersion,
      1,
      16,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
      if (recipeVersion != null) 'recipeVersion': [recipeVersion],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/recipes',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListRecipesResponse.fromJson(response);
  }

  /// Lists the AWS Glue DataBrew schedules in the current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [jobName] :
  /// The name of the job that these schedules apply to.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in this request.
  ///
  /// Parameter [nextToken] :
  /// A pagination token that can be used in a subsequent request.
  Future<ListSchedulesResponse> listSchedules({
    String? jobName,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateStringLength(
      'jobName',
      jobName,
      1,
      240,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    final $query = <String, List<String>>{
      if (jobName != null) 'jobName': [jobName],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/schedules',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListSchedulesResponse.fromJson(response);
  }

  /// Lists all the tags for an AWS Glue DataBrew resource.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) string that uniquely identifies the
  /// DataBrew resource.
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

  /// Publishes a new major version of an AWS Glue DataBrew recipe that exists
  /// in the current AWS account.
  ///
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [name] :
  /// The name of the recipe to be published.
  ///
  /// Parameter [description] :
  /// A description of the recipe to be published, for this version of the
  /// recipe.
  Future<PublishRecipeResponse> publishRecipe({
    required String name,
    String? description,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      1024,
    );
    final $payload = <String, dynamic>{
      if (description != null) 'Description': description,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/recipes/${Uri.encodeComponent(name)}/publishRecipe',
      exceptionFnMap: _exceptionFns,
    );
    return PublishRecipeResponse.fromJson(response);
  }

  /// Performs a recipe step within an interactive AWS Glue DataBrew session
  /// that's currently open.
  ///
  /// May throw [ConflictException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the project to apply the action to.
  ///
  /// Parameter [clientSessionId] :
  /// A unique identifier for an interactive session that's currently open and
  /// ready for work. The action will be performed on this session.
  ///
  /// Parameter [preview] :
  /// Returns the result of the recipe step, without applying it. The result
  /// isn't added to the view frame stack.
  ///
  /// Parameter [stepIndex] :
  /// The index from which to preview a step. This index is used to preview the
  /// result of steps that have already been applied, so that the resulting view
  /// frame is from earlier in the view frame stack.
  Future<SendProjectSessionActionResponse> sendProjectSessionAction({
    required String name,
    String? clientSessionId,
    bool? preview,
    RecipeStep? recipeStep,
    int? stepIndex,
    ViewFrame? viewFrame,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientSessionId',
      clientSessionId,
      1,
      255,
    );
    _s.validateStringPattern(
      'clientSessionId',
      clientSessionId,
      r'''^[a-zA-Z0-9][a-zA-Z0-9-]*$''',
    );
    _s.validateNumRange(
      'stepIndex',
      stepIndex,
      0,
      1152921504606846976,
    );
    final $payload = <String, dynamic>{
      if (clientSessionId != null) 'ClientSessionId': clientSessionId,
      if (preview != null) 'Preview': preview,
      if (recipeStep != null) 'RecipeStep': recipeStep,
      if (stepIndex != null) 'StepIndex': stepIndex,
      if (viewFrame != null) 'ViewFrame': viewFrame,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/projects/${Uri.encodeComponent(name)}/sendProjectSessionAction',
      exceptionFnMap: _exceptionFns,
    );
    return SendProjectSessionActionResponse.fromJson(response);
  }

  /// Runs an AWS Glue DataBrew job that exists in the current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the job to be run.
  Future<StartJobRunResponse> startJobRun({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri: '/jobs/${Uri.encodeComponent(name)}/startJobRun',
      exceptionFnMap: _exceptionFns,
    );
    return StartJobRunResponse.fromJson(response);
  }

  /// Creates an interactive session, enabling you to manipulate an AWS Glue
  /// DataBrew project.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the project to act upon.
  ///
  /// Parameter [assumeControl] :
  /// A value that, if true, enables you to take control of a session, even if a
  /// different client is currently accessing the project.
  Future<StartProjectSessionResponse> startProjectSession({
    required String name,
    bool? assumeControl,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      if (assumeControl != null) 'AssumeControl': assumeControl,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/projects/${Uri.encodeComponent(name)}/startProjectSession',
      exceptionFnMap: _exceptionFns,
    );
    return StartProjectSessionResponse.fromJson(response);
  }

  /// Stops the specified job from running in the current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the job to be stopped.
  ///
  /// Parameter [runId] :
  /// The ID of the job run to be stopped.
  Future<StopJobRunResponse> stopJobRun({
    required String name,
    required String runId,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    ArgumentError.checkNotNull(runId, 'runId');
    _s.validateStringLength(
      'runId',
      runId,
      1,
      255,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri:
          '/jobs/${Uri.encodeComponent(name)}/jobRun/${Uri.encodeComponent(runId)}/stopJobRun',
      exceptionFnMap: _exceptionFns,
    );
    return StopJobRunResponse.fromJson(response);
  }

  /// Adds metadata tags to an AWS Glue DataBrew resource, such as a dataset,
  /// job, project, or recipe.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [resourceArn] :
  /// The DataBrew resource to which tags should be added. The value for this
  /// parameter is an Amazon Resource Name (ARN). For DataBrew, you can tag a
  /// dataset, a job, a project, or a recipe.
  ///
  /// Parameter [tags] :
  /// One or more tags to be assigned to the resource.
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
      'Tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Removes metadata tags from an AWS Glue DataBrew resource.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [resourceArn] :
  /// An DataBrew resource from which you want to remove a tag or tags. The
  /// value for this parameter is an Amazon Resource Name (ARN).
  ///
  /// Parameter [tagKeys] :
  /// The tag keys (names) of one or more tags to be removed.
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

  /// Modifies the definition of an existing AWS Glue DataBrew dataset in the
  /// current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the dataset to be updated.
  Future<UpdateDatasetResponse> updateDataset({
    required Input input,
    required String name,
    FormatOptions? formatOptions,
  }) async {
    ArgumentError.checkNotNull(input, 'input');
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'Input': input,
      if (formatOptions != null) 'FormatOptions': formatOptions,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/datasets/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateDatasetResponse.fromJson(response);
  }

  /// Modifies the definition of an existing AWS Glue DataBrew job in the
  /// current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the job to be updated.
  ///
  /// Parameter [roleArn] :
  /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
  /// (IAM) role to be assumed for this request.
  ///
  /// Parameter [encryptionKeyArn] :
  /// The Amazon Resource Name (ARN) of an encryption key that is used to
  /// protect the job.
  ///
  /// Parameter [encryptionMode] :
  /// The encryption mode for the job, which can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>SSE-KMS</code> - Server-side encryption with AWS KMS-managed keys.
  /// </li>
  /// <li>
  /// <code>SSE-S3</code> - Server-side encryption with keys managed by Amazon
  /// S3.
  /// </li>
  /// </ul>
  ///
  /// Parameter [logSubscription] :
  /// A value that enables or disables Amazon CloudWatch logging for the current
  /// AWS account. If logging is enabled, CloudWatch writes one log stream for
  /// each job run.
  ///
  /// Parameter [maxCapacity] :
  /// The maximum number of nodes that DataBrew can use when the job processes
  /// data.
  ///
  /// Parameter [maxRetries] :
  /// The maximum number of times to retry the job after a job run fails.
  ///
  /// Parameter [timeout] :
  /// The job's timeout in minutes. A job that attempts to run longer than this
  /// timeout period ends with a status of <code>TIMEOUT</code>.
  Future<UpdateProfileJobResponse> updateProfileJob({
    required String name,
    required S3Location outputLocation,
    required String roleArn,
    String? encryptionKeyArn,
    EncryptionMode? encryptionMode,
    LogSubscription? logSubscription,
    int? maxCapacity,
    int? maxRetries,
    int? timeout,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    ArgumentError.checkNotNull(outputLocation, 'outputLocation');
    ArgumentError.checkNotNull(roleArn, 'roleArn');
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
      isRequired: true,
    );
    _s.validateStringLength(
      'encryptionKeyArn',
      encryptionKeyArn,
      20,
      2048,
    );
    _s.validateNumRange(
      'maxRetries',
      maxRetries,
      0,
      1152921504606846976,
    );
    _s.validateNumRange(
      'timeout',
      timeout,
      0,
      1152921504606846976,
    );
    final $payload = <String, dynamic>{
      'OutputLocation': outputLocation,
      'RoleArn': roleArn,
      if (encryptionKeyArn != null) 'EncryptionKeyArn': encryptionKeyArn,
      if (encryptionMode != null) 'EncryptionMode': encryptionMode.toValue(),
      if (logSubscription != null) 'LogSubscription': logSubscription.toValue(),
      if (maxCapacity != null) 'MaxCapacity': maxCapacity,
      if (maxRetries != null) 'MaxRetries': maxRetries,
      if (timeout != null) 'Timeout': timeout,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/profileJobs/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateProfileJobResponse.fromJson(response);
  }

  /// Modifies the definition of an existing AWS Glue DataBrew project in the
  /// current AWS account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the project to be updated.
  ///
  /// Parameter [roleArn] :
  /// The Amazon Resource Name (ARN) of the IAM role to be assumed for this
  /// request.
  Future<UpdateProjectResponse> updateProject({
    required String name,
    required String roleArn,
    Sample? sample,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(roleArn, 'roleArn');
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'RoleArn': roleArn,
      if (sample != null) 'Sample': sample,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/projects/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateProjectResponse.fromJson(response);
  }

  /// Modifies the definition of the latest working version of an AWS Glue
  /// DataBrew recipe in the current AWS account.
  ///
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [name] :
  /// The name of the recipe to be updated.
  ///
  /// Parameter [description] :
  /// A description of the recipe.
  ///
  /// Parameter [steps] :
  /// One or more steps to be performed by the recipe. Each step consists of an
  /// action, and the conditions under which the action should succeed.
  Future<UpdateRecipeResponse> updateRecipe({
    required String name,
    String? description,
    List<RecipeStep>? steps,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      1024,
    );
    final $payload = <String, dynamic>{
      if (description != null) 'Description': description,
      if (steps != null) 'Steps': steps,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/recipes/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateRecipeResponse.fromJson(response);
  }

  /// Modifies the definition of an existing AWS Glue DataBrew recipe job in the
  /// current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [name] :
  /// The name of the job to update.
  ///
  /// Parameter [outputs] :
  /// One or more artifacts that represent the output from running the job.
  ///
  /// Parameter [roleArn] :
  /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
  /// (IAM) role to be assumed for this request.
  ///
  /// Parameter [encryptionKeyArn] :
  /// The Amazon Resource Name (ARN) of an encryption key that is used to
  /// protect the job.
  ///
  /// Parameter [encryptionMode] :
  /// The encryption mode for the job, which can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>SSE-KMS</code> - Server-side encryption with AWS KMS-managed keys.
  /// </li>
  /// <li>
  /// <code>SSE-S3</code> - Server-side encryption with keys managed by Amazon
  /// S3.
  /// </li>
  /// </ul>
  ///
  /// Parameter [logSubscription] :
  /// A value that enables or disables Amazon CloudWatch logging for the current
  /// AWS account. If logging is enabled, CloudWatch writes one log stream for
  /// each job run.
  ///
  /// Parameter [maxCapacity] :
  /// The maximum number of nodes that DataBrew can consume when the job
  /// processes data.
  ///
  /// Parameter [maxRetries] :
  /// The maximum number of times to retry the job after a job run fails.
  ///
  /// Parameter [timeout] :
  /// The job's timeout in minutes. A job that attempts to run longer than this
  /// timeout period ends with a status of <code>TIMEOUT</code>.
  Future<UpdateRecipeJobResponse> updateRecipeJob({
    required String name,
    required List<Output> outputs,
    required String roleArn,
    String? encryptionKeyArn,
    EncryptionMode? encryptionMode,
    LogSubscription? logSubscription,
    int? maxCapacity,
    int? maxRetries,
    int? timeout,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      240,
      isRequired: true,
    );
    ArgumentError.checkNotNull(outputs, 'outputs');
    ArgumentError.checkNotNull(roleArn, 'roleArn');
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
      isRequired: true,
    );
    _s.validateStringLength(
      'encryptionKeyArn',
      encryptionKeyArn,
      20,
      2048,
    );
    _s.validateNumRange(
      'maxRetries',
      maxRetries,
      0,
      1152921504606846976,
    );
    _s.validateNumRange(
      'timeout',
      timeout,
      0,
      1152921504606846976,
    );
    final $payload = <String, dynamic>{
      'Outputs': outputs,
      'RoleArn': roleArn,
      if (encryptionKeyArn != null) 'EncryptionKeyArn': encryptionKeyArn,
      if (encryptionMode != null) 'EncryptionMode': encryptionMode.toValue(),
      if (logSubscription != null) 'LogSubscription': logSubscription.toValue(),
      if (maxCapacity != null) 'MaxCapacity': maxCapacity,
      if (maxRetries != null) 'MaxRetries': maxRetries,
      if (timeout != null) 'Timeout': timeout,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/recipeJobs/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateRecipeJobResponse.fromJson(response);
  }

  /// Modifies the definition of an existing AWS Glue DataBrew schedule in the
  /// current AWS account.
  ///
  /// May throw [ValidationException].
  ///
  /// Parameter [cronExpression] :
  /// The date or dates and time or times, in <code>cron</code> format, when the
  /// jobs are to be run.
  ///
  /// Parameter [name] :
  /// The name of the schedule to update.
  ///
  /// Parameter [jobNames] :
  /// The name or names of one or more jobs to be run for this schedule.
  Future<UpdateScheduleResponse> updateSchedule({
    required String cronExpression,
    required String name,
    List<String>? jobNames,
  }) async {
    ArgumentError.checkNotNull(cronExpression, 'cronExpression');
    _s.validateStringLength(
      'cronExpression',
      cronExpression,
      1,
      512,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      255,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'CronExpression': cronExpression,
      if (jobNames != null) 'JobNames': jobNames,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/schedules/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateScheduleResponse.fromJson(response);
  }
}

class BatchDeleteRecipeVersionResponse {
  /// The name of the recipe that was modified.
  final String name;

  /// Errors, if any, that were encountered when deleting the recipe versions.
  final List<RecipeVersionErrorDetail>? errors;

  BatchDeleteRecipeVersionResponse({
    required this.name,
    this.errors,
  });
  factory BatchDeleteRecipeVersionResponse.fromJson(Map<String, dynamic> json) {
    return BatchDeleteRecipeVersionResponse(
      name: json['Name'] as String,
      errors: (json['Errors'] as List?)
          ?.whereNotNull()
          .map((e) =>
              RecipeVersionErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

enum CompressionFormat {
  gzip,
  lz4,
  snappy,
  bzip2,
  deflate,
  lzo,
  brotli,
  zstd,
  zlib,
}

extension on CompressionFormat {
  String toValue() {
    switch (this) {
      case CompressionFormat.gzip:
        return 'GZIP';
      case CompressionFormat.lz4:
        return 'LZ4';
      case CompressionFormat.snappy:
        return 'SNAPPY';
      case CompressionFormat.bzip2:
        return 'BZIP2';
      case CompressionFormat.deflate:
        return 'DEFLATE';
      case CompressionFormat.lzo:
        return 'LZO';
      case CompressionFormat.brotli:
        return 'BROTLI';
      case CompressionFormat.zstd:
        return 'ZSTD';
      case CompressionFormat.zlib:
        return 'ZLIB';
    }
  }
}

extension on String {
  CompressionFormat toCompressionFormat() {
    switch (this) {
      case 'GZIP':
        return CompressionFormat.gzip;
      case 'LZ4':
        return CompressionFormat.lz4;
      case 'SNAPPY':
        return CompressionFormat.snappy;
      case 'BZIP2':
        return CompressionFormat.bzip2;
      case 'DEFLATE':
        return CompressionFormat.deflate;
      case 'LZO':
        return CompressionFormat.lzo;
      case 'BROTLI':
        return CompressionFormat.brotli;
      case 'ZSTD':
        return CompressionFormat.zstd;
      case 'ZLIB':
        return CompressionFormat.zlib;
    }
    throw Exception('$this is not known in enum CompressionFormat');
  }
}

/// Represents an individual condition that evaluates to true or false.
///
/// Conditions are used with recipe actions: The action is only performed for
/// column values where the condition evaluates to true.
///
/// If a recipe requires more than one condition, then the recipe must specify
/// multiple <code>ConditionExpression</code> elements. Each condition is
/// applied to the rows in a dataset first, before the recipe action is
/// performed.
class ConditionExpression {
  /// A specific condition to apply to a recipe action. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/databrew/latest/dg/recipe-structure.html">Recipe
  /// structure</a> in the <i>AWS Glue DataBrew Developer Guide</i>.
  final String condition;

  /// A column to apply this condition to, within an AWS Glue DataBrew dataset.
  final String targetColumn;

  /// A value that the condition must evaluate to for the condition to succeed.
  final String? value;

  ConditionExpression({
    required this.condition,
    required this.targetColumn,
    this.value,
  });
  factory ConditionExpression.fromJson(Map<String, dynamic> json) {
    return ConditionExpression(
      condition: json['Condition'] as String,
      targetColumn: json['TargetColumn'] as String,
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final condition = this.condition;
    final targetColumn = this.targetColumn;
    final value = this.value;
    return {
      'Condition': condition,
      'TargetColumn': targetColumn,
      if (value != null) 'Value': value,
    };
  }
}

class CreateDatasetResponse {
  /// The name of the dataset that you created.
  final String name;

  CreateDatasetResponse({
    required this.name,
  });
  factory CreateDatasetResponse.fromJson(Map<String, dynamic> json) {
    return CreateDatasetResponse(
      name: json['Name'] as String,
    );
  }
}

class CreateProfileJobResponse {
  /// The name of the job that was created.
  final String name;

  CreateProfileJobResponse({
    required this.name,
  });
  factory CreateProfileJobResponse.fromJson(Map<String, dynamic> json) {
    return CreateProfileJobResponse(
      name: json['Name'] as String,
    );
  }
}

class CreateProjectResponse {
  /// The name of the project that you created.
  final String name;

  CreateProjectResponse({
    required this.name,
  });
  factory CreateProjectResponse.fromJson(Map<String, dynamic> json) {
    return CreateProjectResponse(
      name: json['Name'] as String,
    );
  }
}

class CreateRecipeJobResponse {
  /// The name of the job that you created.
  final String name;

  CreateRecipeJobResponse({
    required this.name,
  });
  factory CreateRecipeJobResponse.fromJson(Map<String, dynamic> json) {
    return CreateRecipeJobResponse(
      name: json['Name'] as String,
    );
  }
}

class CreateRecipeResponse {
  /// The name of the recipe that you created.
  final String name;

  CreateRecipeResponse({
    required this.name,
  });
  factory CreateRecipeResponse.fromJson(Map<String, dynamic> json) {
    return CreateRecipeResponse(
      name: json['Name'] as String,
    );
  }
}

class CreateScheduleResponse {
  /// The name of the schedule that was created.
  final String name;

  CreateScheduleResponse({
    required this.name,
  });
  factory CreateScheduleResponse.fromJson(Map<String, dynamic> json) {
    return CreateScheduleResponse(
      name: json['Name'] as String,
    );
  }
}

/// Represents how metadata stored in the AWS Glue Data Catalog is defined in an
/// AWS Glue DataBrew dataset.
class DataCatalogInputDefinition {
  /// The name of a database in the Data Catalog.
  final String databaseName;

  /// The name of a database table in the Data Catalog. This table corresponds to
  /// a DataBrew dataset.
  final String tableName;

  /// The unique identifier of the AWS account that holds the Data Catalog that
  /// stores the data.
  final String? catalogId;

  /// An Amazon location that AWS Glue Data Catalog can use as a temporary
  /// directory.
  final S3Location? tempDirectory;

  DataCatalogInputDefinition({
    required this.databaseName,
    required this.tableName,
    this.catalogId,
    this.tempDirectory,
  });
  factory DataCatalogInputDefinition.fromJson(Map<String, dynamic> json) {
    return DataCatalogInputDefinition(
      databaseName: json['DatabaseName'] as String,
      tableName: json['TableName'] as String,
      catalogId: json['CatalogId'] as String?,
      tempDirectory: json['TempDirectory'] != null
          ? S3Location.fromJson(json['TempDirectory'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final databaseName = this.databaseName;
    final tableName = this.tableName;
    final catalogId = this.catalogId;
    final tempDirectory = this.tempDirectory;
    return {
      'DatabaseName': databaseName,
      'TableName': tableName,
      if (catalogId != null) 'CatalogId': catalogId,
      if (tempDirectory != null) 'TempDirectory': tempDirectory,
    };
  }
}

/// Represents a dataset that can be processed by AWS Glue DataBrew.
class Dataset {
  /// Information on how DataBrew can find the dataset, in either the AWS Glue
  /// Data Catalog or Amazon S3.
  final Input input;

  /// The unique name of the dataset.
  final String name;

  /// The ID of the AWS account that owns the dataset.
  final String? accountId;

  /// The date and time that the dataset was created.
  final DateTime? createDate;

  /// The identifier (the user name) of the user who created the dataset.
  final String? createdBy;

  /// Options that define how DataBrew interprets the data in the dataset.
  final FormatOptions? formatOptions;

  /// The identifier (the user name) of the user who last modified the dataset.
  final String? lastModifiedBy;

  /// The last modification date and time of the dataset.
  final DateTime? lastModifiedDate;

  /// The unique Amazon Resource Name (ARN) for the dataset.
  final String? resourceArn;

  /// The location of the data for the dataset, either Amazon S3 or the AWS Glue
  /// Data Catalog.
  final Source? source;

  /// Metadata tags that have been applied to the dataset.
  final Map<String, String>? tags;

  Dataset({
    required this.input,
    required this.name,
    this.accountId,
    this.createDate,
    this.createdBy,
    this.formatOptions,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.resourceArn,
    this.source,
    this.tags,
  });
  factory Dataset.fromJson(Map<String, dynamic> json) {
    return Dataset(
      input: Input.fromJson(json['Input'] as Map<String, dynamic>),
      name: json['Name'] as String,
      accountId: json['AccountId'] as String?,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      formatOptions: json['FormatOptions'] != null
          ? FormatOptions.fromJson(
              json['FormatOptions'] as Map<String, dynamic>)
          : null,
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      resourceArn: json['ResourceArn'] as String?,
      source: (json['Source'] as String?)?.toSource(),
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class DeleteDatasetResponse {
  /// The name of the dataset that you deleted.
  final String name;

  DeleteDatasetResponse({
    required this.name,
  });
  factory DeleteDatasetResponse.fromJson(Map<String, dynamic> json) {
    return DeleteDatasetResponse(
      name: json['Name'] as String,
    );
  }
}

class DeleteJobResponse {
  /// The name of the job that you deleted.
  final String name;

  DeleteJobResponse({
    required this.name,
  });
  factory DeleteJobResponse.fromJson(Map<String, dynamic> json) {
    return DeleteJobResponse(
      name: json['Name'] as String,
    );
  }
}

class DeleteProjectResponse {
  /// The name of the project that you deleted.
  final String name;

  DeleteProjectResponse({
    required this.name,
  });
  factory DeleteProjectResponse.fromJson(Map<String, dynamic> json) {
    return DeleteProjectResponse(
      name: json['Name'] as String,
    );
  }
}

class DeleteRecipeVersionResponse {
  /// The name of the recipe that was deleted.
  final String name;

  /// The version of the recipe that was deleted.
  final String recipeVersion;

  DeleteRecipeVersionResponse({
    required this.name,
    required this.recipeVersion,
  });
  factory DeleteRecipeVersionResponse.fromJson(Map<String, dynamic> json) {
    return DeleteRecipeVersionResponse(
      name: json['Name'] as String,
      recipeVersion: json['RecipeVersion'] as String,
    );
  }
}

class DeleteScheduleResponse {
  /// The name of the schedule that was deleted.
  final String name;

  DeleteScheduleResponse({
    required this.name,
  });
  factory DeleteScheduleResponse.fromJson(Map<String, dynamic> json) {
    return DeleteScheduleResponse(
      name: json['Name'] as String,
    );
  }
}

class DescribeDatasetResponse {
  final Input input;

  /// The name of the dataset.
  final String name;

  /// The date and time that the dataset was created.
  final DateTime? createDate;

  /// The identifier (user name) of the user who created the dataset.
  final String? createdBy;
  final FormatOptions? formatOptions;

  /// The identifier (user name) of the user who last modified the dataset.
  final String? lastModifiedBy;

  /// The date and time that the dataset was last modified.
  final DateTime? lastModifiedDate;

  /// The Amazon Resource Name (ARN) of the dataset.
  final String? resourceArn;

  /// The location of the data for this dataset, Amazon S3 or the AWS Glue Data
  /// Catalog.
  final Source? source;

  /// Metadata tags associated with this dataset.
  final Map<String, String>? tags;

  DescribeDatasetResponse({
    required this.input,
    required this.name,
    this.createDate,
    this.createdBy,
    this.formatOptions,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.resourceArn,
    this.source,
    this.tags,
  });
  factory DescribeDatasetResponse.fromJson(Map<String, dynamic> json) {
    return DescribeDatasetResponse(
      input: Input.fromJson(json['Input'] as Map<String, dynamic>),
      name: json['Name'] as String,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      formatOptions: json['FormatOptions'] != null
          ? FormatOptions.fromJson(
              json['FormatOptions'] as Map<String, dynamic>)
          : null,
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      resourceArn: json['ResourceArn'] as String?,
      source: (json['Source'] as String?)?.toSource(),
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class DescribeJobResponse {
  /// The name of the job.
  final String name;

  /// The date and time that the job was created.
  final DateTime? createDate;

  /// The identifier (user name) of the user associated with the creation of the
  /// job.
  final String? createdBy;

  /// The dataset that the job acts upon.
  final String? datasetName;

  /// The Amazon Resource Name (ARN) of an encryption key that is used to protect
  /// the job.
  final String? encryptionKeyArn;

  /// The encryption mode for the job, which can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>SSE-KMS</code> - Server-side encryption with AWS KMS-managed keys.
  /// </li>
  /// <li>
  /// <code>SSE-S3</code> - Server-side encryption with keys managed by Amazon S3.
  /// </li>
  /// </ul>
  final EncryptionMode? encryptionMode;

  /// The identifier (user name) of the user who last modified the job.
  final String? lastModifiedBy;

  /// The date and time that the job was last modified.
  final DateTime? lastModifiedDate;

  /// A value that indicates whether Amazon CloudWatch logging is enabled for this
  /// job.
  final LogSubscription? logSubscription;

  /// The maximum number of nodes that AWS Glue DataBrew can consume when the job
  /// processes data.
  final int? maxCapacity;

  /// The maximum number of times to retry the job after a job run fails.
  final int? maxRetries;

  /// One or more artifacts that represent the output from running the job.
  final List<Output>? outputs;

  /// The DataBrew project associated with this job.
  final String? projectName;
  final RecipeReference? recipeReference;

  /// The Amazon Resource Name (ARN) of the job.
  final String? resourceArn;

  /// The ARN of the AWS Identity and Access Management (IAM) role that was
  /// assumed for this request.
  final String? roleArn;

  /// Metadata tags associated with this job.
  final Map<String, String>? tags;

  /// The job's timeout in minutes. A job that attempts to run longer than this
  /// timeout period ends with a status of <code>TIMEOUT</code>.
  final int? timeout;

  /// The job type, which must be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>PROFILE</code> - The job analyzes the dataset to determine its size,
  /// data types, data distribution, and more.
  /// </li>
  /// <li>
  /// <code>RECIPE</code> - The job applies one or more transformations to a
  /// dataset.
  /// </li>
  /// </ul>
  final JobType? type;

  DescribeJobResponse({
    required this.name,
    this.createDate,
    this.createdBy,
    this.datasetName,
    this.encryptionKeyArn,
    this.encryptionMode,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.logSubscription,
    this.maxCapacity,
    this.maxRetries,
    this.outputs,
    this.projectName,
    this.recipeReference,
    this.resourceArn,
    this.roleArn,
    this.tags,
    this.timeout,
    this.type,
  });
  factory DescribeJobResponse.fromJson(Map<String, dynamic> json) {
    return DescribeJobResponse(
      name: json['Name'] as String,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      datasetName: json['DatasetName'] as String?,
      encryptionKeyArn: json['EncryptionKeyArn'] as String?,
      encryptionMode: (json['EncryptionMode'] as String?)?.toEncryptionMode(),
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      logSubscription:
          (json['LogSubscription'] as String?)?.toLogSubscription(),
      maxCapacity: json['MaxCapacity'] as int?,
      maxRetries: json['MaxRetries'] as int?,
      outputs: (json['Outputs'] as List?)
          ?.whereNotNull()
          .map((e) => Output.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectName: json['ProjectName'] as String?,
      recipeReference: json['RecipeReference'] != null
          ? RecipeReference.fromJson(
              json['RecipeReference'] as Map<String, dynamic>)
          : null,
      resourceArn: json['ResourceArn'] as String?,
      roleArn: json['RoleArn'] as String?,
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      timeout: json['Timeout'] as int?,
      type: (json['Type'] as String?)?.toJobType(),
    );
  }
}

class DescribeProjectResponse {
  /// The name of the project.
  final String name;

  /// The date and time that the project was created.
  final DateTime? createDate;

  /// The identifier (user name) of the user who created the project.
  final String? createdBy;

  /// The dataset associated with the project.
  final String? datasetName;

  /// The identifier (user name) of the user who last modified the project.
  final String? lastModifiedBy;

  /// The date and time that the project was last modified.
  final DateTime? lastModifiedDate;

  /// The date and time when the project was opened.
  final DateTime? openDate;

  /// The identifier (user name) of the user that opened the project for use.
  final String? openedBy;

  /// The recipe associated with this job.
  final String? recipeName;

  /// The Amazon Resource Name (ARN) of the project.
  final String? resourceArn;

  /// The ARN of the AWS Identity and Access Management (IAM) role that was
  /// assumed for this request.
  final String? roleArn;
  final Sample? sample;

  /// Describes the current state of the session:
  ///
  /// <ul>
  /// <li>
  /// <code>PROVISIONING</code> - allocating resources for the session.
  /// </li>
  /// <li>
  /// <code>INITIALIZING</code> - getting the session ready for first use.
  /// </li>
  /// <li>
  /// <code>ASSIGNED</code> - the session is ready for use.
  /// </li>
  /// </ul>
  final SessionStatus? sessionStatus;

  /// Metadata tags associated with this project.
  final Map<String, String>? tags;

  DescribeProjectResponse({
    required this.name,
    this.createDate,
    this.createdBy,
    this.datasetName,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.openDate,
    this.openedBy,
    this.recipeName,
    this.resourceArn,
    this.roleArn,
    this.sample,
    this.sessionStatus,
    this.tags,
  });
  factory DescribeProjectResponse.fromJson(Map<String, dynamic> json) {
    return DescribeProjectResponse(
      name: json['Name'] as String,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      datasetName: json['DatasetName'] as String?,
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      openDate: timeStampFromJson(json['OpenDate']),
      openedBy: json['OpenedBy'] as String?,
      recipeName: json['RecipeName'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      roleArn: json['RoleArn'] as String?,
      sample: json['Sample'] != null
          ? Sample.fromJson(json['Sample'] as Map<String, dynamic>)
          : null,
      sessionStatus: (json['SessionStatus'] as String?)?.toSessionStatus(),
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class DescribeRecipeResponse {
  /// The name of the recipe.
  final String name;

  /// The date and time that the recipe was created.
  final DateTime? createDate;

  /// The identifier (user name) of the user who created the recipe.
  final String? createdBy;

  /// The description of the recipe.
  final String? description;

  /// The identifier (user name) of the user who last modified the recipe.
  final String? lastModifiedBy;

  /// The date and time that the recipe was last modified.
  final DateTime? lastModifiedDate;

  /// The name of the project associated with this recipe.
  final String? projectName;

  /// The identifier (user name) of the user who last published the recipe.
  final String? publishedBy;

  /// The date and time when the recipe was last published.
  final DateTime? publishedDate;

  /// The recipe version identifier.
  final String? recipeVersion;

  /// The ARN of the recipe.
  final String? resourceArn;

  /// One or more steps to be performed by the recipe. Each step consists of an
  /// action, and the conditions under which the action should succeed.
  final List<RecipeStep>? steps;

  /// Metadata tags associated with this project.
  final Map<String, String>? tags;

  DescribeRecipeResponse({
    required this.name,
    this.createDate,
    this.createdBy,
    this.description,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.projectName,
    this.publishedBy,
    this.publishedDate,
    this.recipeVersion,
    this.resourceArn,
    this.steps,
    this.tags,
  });
  factory DescribeRecipeResponse.fromJson(Map<String, dynamic> json) {
    return DescribeRecipeResponse(
      name: json['Name'] as String,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      description: json['Description'] as String?,
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      projectName: json['ProjectName'] as String?,
      publishedBy: json['PublishedBy'] as String?,
      publishedDate: timeStampFromJson(json['PublishedDate']),
      recipeVersion: json['RecipeVersion'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      steps: (json['Steps'] as List?)
          ?.whereNotNull()
          .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class DescribeScheduleResponse {
  /// The name of the schedule.
  final String name;

  /// The date and time that the schedule was created.
  final DateTime? createDate;

  /// The identifier (user name) of the user who created the schedule.
  final String? createdBy;

  /// The date or dates and time or times, in <code>cron</code> format, when the
  /// jobs are to be run for the schedule.
  final String? cronExpression;

  /// The name or names of one or more jobs to be run by using the schedule.
  final List<String>? jobNames;

  /// The identifier (user name) of the user who last modified the schedule.
  final String? lastModifiedBy;

  /// The date and time that the schedule was last modified.
  final DateTime? lastModifiedDate;

  /// The Amazon Resource Name (ARN) of the schedule.
  final String? resourceArn;

  /// Metadata tags associated with this schedule.
  final Map<String, String>? tags;

  DescribeScheduleResponse({
    required this.name,
    this.createDate,
    this.createdBy,
    this.cronExpression,
    this.jobNames,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.resourceArn,
    this.tags,
  });
  factory DescribeScheduleResponse.fromJson(Map<String, dynamic> json) {
    return DescribeScheduleResponse(
      name: json['Name'] as String,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      cronExpression: json['CronExpression'] as String?,
      jobNames: (json['JobNames'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      resourceArn: json['ResourceArn'] as String?,
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

enum EncryptionMode {
  sseKms,
  sseS3,
}

extension on EncryptionMode {
  String toValue() {
    switch (this) {
      case EncryptionMode.sseKms:
        return 'SSE-KMS';
      case EncryptionMode.sseS3:
        return 'SSE-S3';
    }
  }
}

extension on String {
  EncryptionMode toEncryptionMode() {
    switch (this) {
      case 'SSE-KMS':
        return EncryptionMode.sseKms;
      case 'SSE-S3':
        return EncryptionMode.sseS3;
    }
    throw Exception('$this is not known in enum EncryptionMode');
  }
}

/// Options that define how DataBrew will interpret a Microsoft Excel file, when
/// creating a dataset from that file.
class ExcelOptions {
  /// Specifies one or more sheet numbers in the Excel file, which will be
  /// included in the dataset.
  final List<int>? sheetIndexes;

  /// Specifies one or more named sheets in the Excel file, which will be included
  /// in the dataset.
  final List<String>? sheetNames;

  ExcelOptions({
    this.sheetIndexes,
    this.sheetNames,
  });
  factory ExcelOptions.fromJson(Map<String, dynamic> json) {
    return ExcelOptions(
      sheetIndexes: (json['SheetIndexes'] as List?)
          ?.whereNotNull()
          .map((e) => e as int)
          .toList(),
      sheetNames: (json['SheetNames'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final sheetIndexes = this.sheetIndexes;
    final sheetNames = this.sheetNames;
    return {
      if (sheetIndexes != null) 'SheetIndexes': sheetIndexes,
      if (sheetNames != null) 'SheetNames': sheetNames,
    };
  }
}

/// Options that define how Microsoft Excel input is to be interpreted by
/// DataBrew.
class FormatOptions {
  /// Options that define how Excel input is to be interpreted by DataBrew.
  final ExcelOptions? excel;

  /// Options that define how JSON input is to be interpreted by DataBrew.
  final JsonOptions? json;

  FormatOptions({
    this.excel,
    this.json,
  });
  factory FormatOptions.fromJson(Map<String, dynamic> json) {
    return FormatOptions(
      excel: json['Excel'] != null
          ? ExcelOptions.fromJson(json['Excel'] as Map<String, dynamic>)
          : null,
      json: json['Json'] != null
          ? JsonOptions.fromJson(json['Json'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final excel = this.excel;
    final json = this.json;
    return {
      if (excel != null) 'Excel': excel,
      if (json != null) 'Json': json,
    };
  }
}

/// Information on how AWS Glue DataBrew can find data, in either the AWS Glue
/// Data Catalog or Amazon S3.
class Input {
  /// The AWS Glue Data Catalog parameters for the data.
  final DataCatalogInputDefinition? dataCatalogInputDefinition;

  /// The Amazon S3 location where the data is stored.
  final S3Location? s3InputDefinition;

  Input({
    this.dataCatalogInputDefinition,
    this.s3InputDefinition,
  });
  factory Input.fromJson(Map<String, dynamic> json) {
    return Input(
      dataCatalogInputDefinition: json['DataCatalogInputDefinition'] != null
          ? DataCatalogInputDefinition.fromJson(
              json['DataCatalogInputDefinition'] as Map<String, dynamic>)
          : null,
      s3InputDefinition: json['S3InputDefinition'] != null
          ? S3Location.fromJson(
              json['S3InputDefinition'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final dataCatalogInputDefinition = this.dataCatalogInputDefinition;
    final s3InputDefinition = this.s3InputDefinition;
    return {
      if (dataCatalogInputDefinition != null)
        'DataCatalogInputDefinition': dataCatalogInputDefinition,
      if (s3InputDefinition != null) 'S3InputDefinition': s3InputDefinition,
    };
  }
}

/// Represents all of the attributes of an AWS Glue DataBrew job.
class Job {
  /// The unique name of the job.
  final String name;

  /// The ID of the AWS account that owns the job.
  final String? accountId;

  /// The date and time that the job was created.
  final DateTime? createDate;

  /// The identifier (the user name) of the user who created the job.
  final String? createdBy;

  /// A dataset that the job is to process.
  final String? datasetName;

  /// The Amazon Resource Name (ARN) of an encryption key that is used to protect
  /// a job.
  final String? encryptionKeyArn;

  /// The encryption mode for the job, which can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>SSE-KMS</code> - Server-side encryption with AWS KMS-managed keys.
  /// </li>
  /// <li>
  /// <code>SSE-S3</code> - Server-side encryption with keys managed by Amazon S3.
  /// </li>
  /// </ul>
  final EncryptionMode? encryptionMode;

  /// The identifier (the user name) of the user who last modified the job.
  final String? lastModifiedBy;

  /// The modification date and time of the job.
  final DateTime? lastModifiedDate;

  /// The current status of Amazon CloudWatch logging for the job.
  final LogSubscription? logSubscription;

  /// The maximum number of nodes that can be consumed when the job processes
  /// data.
  final int? maxCapacity;

  /// The maximum number of times to retry the job after a job run fails.
  final int? maxRetries;

  /// One or more artifacts that represent output from running the job.
  final List<Output>? outputs;

  /// The name of the project that the job is associated with.
  final String? projectName;

  /// A set of steps that the job runs.
  final RecipeReference? recipeReference;

  /// The unique Amazon Resource Name (ARN) for the job.
  final String? resourceArn;

  /// The Amazon Resource Name (ARN) of the role that will be assumed for this
  /// job.
  final String? roleArn;

  /// Metadata tags that have been applied to the job.
  final Map<String, String>? tags;

  /// The job's timeout in minutes. A job that attempts to run longer than this
  /// timeout period ends with a status of <code>TIMEOUT</code>.
  final int? timeout;

  /// The job type of the job, which must be one of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>PROFILE</code> - A job to analyze a dataset, to determine its size,
  /// data types, data distribution, and more.
  /// </li>
  /// <li>
  /// <code>RECIPE</code> - A job to apply one or more transformations to a
  /// dataset.
  /// </li>
  /// </ul>
  final JobType? type;

  Job({
    required this.name,
    this.accountId,
    this.createDate,
    this.createdBy,
    this.datasetName,
    this.encryptionKeyArn,
    this.encryptionMode,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.logSubscription,
    this.maxCapacity,
    this.maxRetries,
    this.outputs,
    this.projectName,
    this.recipeReference,
    this.resourceArn,
    this.roleArn,
    this.tags,
    this.timeout,
    this.type,
  });
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      name: json['Name'] as String,
      accountId: json['AccountId'] as String?,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      datasetName: json['DatasetName'] as String?,
      encryptionKeyArn: json['EncryptionKeyArn'] as String?,
      encryptionMode: (json['EncryptionMode'] as String?)?.toEncryptionMode(),
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      logSubscription:
          (json['LogSubscription'] as String?)?.toLogSubscription(),
      maxCapacity: json['MaxCapacity'] as int?,
      maxRetries: json['MaxRetries'] as int?,
      outputs: (json['Outputs'] as List?)
          ?.whereNotNull()
          .map((e) => Output.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectName: json['ProjectName'] as String?,
      recipeReference: json['RecipeReference'] != null
          ? RecipeReference.fromJson(
              json['RecipeReference'] as Map<String, dynamic>)
          : null,
      resourceArn: json['ResourceArn'] as String?,
      roleArn: json['RoleArn'] as String?,
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      timeout: json['Timeout'] as int?,
      type: (json['Type'] as String?)?.toJobType(),
    );
  }
}

/// Represents one run of an AWS Glue DataBrew job.
class JobRun {
  /// The number of times that DataBrew has attempted to run the job.
  final int? attempt;

  /// The date and time when the job completed processing.
  final DateTime? completedOn;

  /// The name of the dataset for the job to process.
  final String? datasetName;

  /// A message indicating an error (if any) that was encountered when the job
  /// ran.
  final String? errorMessage;

  /// The amount of time, in seconds, during which a job run consumed resources.
  final int? executionTime;

  /// The name of the job being processed during this run.
  final String? jobName;

  /// The name of an Amazon CloudWatch log group, where the job writes diagnostic
  /// messages when it runs.
  final String? logGroupName;

  /// The current status of Amazon CloudWatch logging for the job run.
  final LogSubscription? logSubscription;

  /// One or more output artifacts from a job run.
  final List<Output>? outputs;

  /// The set of steps processed by the job.
  final RecipeReference? recipeReference;

  /// The unique identifier of the job run.
  final String? runId;

  /// The identifier (the user name) of the user who initiated the job run.
  final String? startedBy;

  /// The date and time when the job run began.
  final DateTime? startedOn;

  /// The current state of the job run entity itself.
  final JobRunState? state;

  JobRun({
    this.attempt,
    this.completedOn,
    this.datasetName,
    this.errorMessage,
    this.executionTime,
    this.jobName,
    this.logGroupName,
    this.logSubscription,
    this.outputs,
    this.recipeReference,
    this.runId,
    this.startedBy,
    this.startedOn,
    this.state,
  });
  factory JobRun.fromJson(Map<String, dynamic> json) {
    return JobRun(
      attempt: json['Attempt'] as int?,
      completedOn: timeStampFromJson(json['CompletedOn']),
      datasetName: json['DatasetName'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
      executionTime: json['ExecutionTime'] as int?,
      jobName: json['JobName'] as String?,
      logGroupName: json['LogGroupName'] as String?,
      logSubscription:
          (json['LogSubscription'] as String?)?.toLogSubscription(),
      outputs: (json['Outputs'] as List?)
          ?.whereNotNull()
          .map((e) => Output.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipeReference: json['RecipeReference'] != null
          ? RecipeReference.fromJson(
              json['RecipeReference'] as Map<String, dynamic>)
          : null,
      runId: json['RunId'] as String?,
      startedBy: json['StartedBy'] as String?,
      startedOn: timeStampFromJson(json['StartedOn']),
      state: (json['State'] as String?)?.toJobRunState(),
    );
  }
}

enum JobRunState {
  starting,
  running,
  stopping,
  stopped,
  succeeded,
  failed,
  timeout,
}

extension on JobRunState {
  String toValue() {
    switch (this) {
      case JobRunState.starting:
        return 'STARTING';
      case JobRunState.running:
        return 'RUNNING';
      case JobRunState.stopping:
        return 'STOPPING';
      case JobRunState.stopped:
        return 'STOPPED';
      case JobRunState.succeeded:
        return 'SUCCEEDED';
      case JobRunState.failed:
        return 'FAILED';
      case JobRunState.timeout:
        return 'TIMEOUT';
    }
  }
}

extension on String {
  JobRunState toJobRunState() {
    switch (this) {
      case 'STARTING':
        return JobRunState.starting;
      case 'RUNNING':
        return JobRunState.running;
      case 'STOPPING':
        return JobRunState.stopping;
      case 'STOPPED':
        return JobRunState.stopped;
      case 'SUCCEEDED':
        return JobRunState.succeeded;
      case 'FAILED':
        return JobRunState.failed;
      case 'TIMEOUT':
        return JobRunState.timeout;
    }
    throw Exception('$this is not known in enum JobRunState');
  }
}

enum JobType {
  profile,
  recipe,
}

extension on JobType {
  String toValue() {
    switch (this) {
      case JobType.profile:
        return 'PROFILE';
      case JobType.recipe:
        return 'RECIPE';
    }
  }
}

extension on String {
  JobType toJobType() {
    switch (this) {
      case 'PROFILE':
        return JobType.profile;
      case 'RECIPE':
        return JobType.recipe;
    }
    throw Exception('$this is not known in enum JobType');
  }
}

/// Represents the JSON-specific options that define how input is to be
/// interpreted by AWS Glue DataBrew.
class JsonOptions {
  /// A value that specifies whether JSON input contains embedded new line
  /// characters.
  final bool? multiLine;

  JsonOptions({
    this.multiLine,
  });
  factory JsonOptions.fromJson(Map<String, dynamic> json) {
    return JsonOptions(
      multiLine: json['MultiLine'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final multiLine = this.multiLine;
    return {
      if (multiLine != null) 'MultiLine': multiLine,
    };
  }
}

class ListDatasetsResponse {
  /// A list of datasets that are defined in the current AWS account.
  final List<Dataset> datasets;

  /// A token generated by DataBrew that specifies where to continue pagination if
  /// a previous request was truncated. To obtain the next set of pages, pass in
  /// the NextToken from the response object of the previous page call.
  final String? nextToken;

  ListDatasetsResponse({
    required this.datasets,
    this.nextToken,
  });
  factory ListDatasetsResponse.fromJson(Map<String, dynamic> json) {
    return ListDatasetsResponse(
      datasets: (json['Datasets'] as List)
          .whereNotNull()
          .map((e) => Dataset.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListJobRunsResponse {
  /// A list of job runs that have occurred for the specified job.
  final List<JobRun> jobRuns;

  /// A token generated by DataBrew that specifies where to continue pagination if
  /// a previous request was truncated. To obtain the next set of pages, pass in
  /// the NextToken from the response object of the previous page call.
  final String? nextToken;

  ListJobRunsResponse({
    required this.jobRuns,
    this.nextToken,
  });
  factory ListJobRunsResponse.fromJson(Map<String, dynamic> json) {
    return ListJobRunsResponse(
      jobRuns: (json['JobRuns'] as List)
          .whereNotNull()
          .map((e) => JobRun.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListJobsResponse {
  /// A list of jobs that are defined in the current AWS account.
  final List<Job> jobs;

  /// A token generated by DataBrew that specifies where to continue pagination if
  /// a previous request was truncated. To obtain the next set of pages, pass in
  /// the NextToken from the response object of the previous page call.
  final String? nextToken;

  ListJobsResponse({
    required this.jobs,
    this.nextToken,
  });
  factory ListJobsResponse.fromJson(Map<String, dynamic> json) {
    return ListJobsResponse(
      jobs: (json['Jobs'] as List)
          .whereNotNull()
          .map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListProjectsResponse {
  /// A list of projects that are defined in the current AWS account.
  final List<Project> projects;

  /// A token generated by DataBrew that specifies where to continue pagination if
  /// a previous request was truncated. To get the next set of pages, pass in the
  /// NextToken value from the response object of the previous page call.
  final String? nextToken;

  ListProjectsResponse({
    required this.projects,
    this.nextToken,
  });
  factory ListProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ListProjectsResponse(
      projects: (json['Projects'] as List)
          .whereNotNull()
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListRecipeVersionsResponse {
  /// A list of versions for the specified recipe.
  final List<Recipe> recipes;

  /// A token generated by DataBrew that specifies where to continue pagination if
  /// a previous request was truncated. To get the next set of pages, pass in the
  /// NextToken value from the response object of the previous page call.
  final String? nextToken;

  ListRecipeVersionsResponse({
    required this.recipes,
    this.nextToken,
  });
  factory ListRecipeVersionsResponse.fromJson(Map<String, dynamic> json) {
    return ListRecipeVersionsResponse(
      recipes: (json['Recipes'] as List)
          .whereNotNull()
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListRecipesResponse {
  /// A list of recipes that are defined in the current AWS account.
  final List<Recipe> recipes;

  /// A token generated by DataBrew that specifies where to continue pagination if
  /// a previous request was truncated. To get the next set of pages, pass in the
  /// NextToken value from the response object of the previous page call.
  final String? nextToken;

  ListRecipesResponse({
    required this.recipes,
    this.nextToken,
  });
  factory ListRecipesResponse.fromJson(Map<String, dynamic> json) {
    return ListRecipesResponse(
      recipes: (json['Recipes'] as List)
          .whereNotNull()
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListSchedulesResponse {
  /// A list of schedules in the current AWS account.
  final List<Schedule> schedules;

  /// A token generated by DataBrew that specifies where to continue pagination if
  /// a previous request was truncated. To get the next set of pages, pass in the
  /// NextToken value from the response object of the previous page call.
  final String? nextToken;

  ListSchedulesResponse({
    required this.schedules,
    this.nextToken,
  });
  factory ListSchedulesResponse.fromJson(Map<String, dynamic> json) {
    return ListSchedulesResponse(
      schedules: (json['Schedules'] as List)
          .whereNotNull()
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListTagsForResourceResponse {
  /// A list of tags associated with the DataBrew resource.
  final Map<String, String>? tags;

  ListTagsForResourceResponse({
    this.tags,
  });
  factory ListTagsForResourceResponse.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResponse(
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

enum LogSubscription {
  enable,
  disable,
}

extension on LogSubscription {
  String toValue() {
    switch (this) {
      case LogSubscription.enable:
        return 'ENABLE';
      case LogSubscription.disable:
        return 'DISABLE';
    }
  }
}

extension on String {
  LogSubscription toLogSubscription() {
    switch (this) {
      case 'ENABLE':
        return LogSubscription.enable;
      case 'DISABLE':
        return LogSubscription.disable;
    }
    throw Exception('$this is not known in enum LogSubscription');
  }
}

/// Represents individual output from a particular job run.
class Output {
  /// The location in Amazon S3 where the job writes its output.
  final S3Location location;

  /// The compression algorithm used to compress the output text of the job.
  final CompressionFormat? compressionFormat;

  /// The data format of the output of the job.
  final OutputFormat? format;

  /// A value that, if true, means that any data in the location specified for
  /// output is overwritten with new output.
  final bool? overwrite;

  /// The names of one or more partition columns for the output of the job.
  final List<String>? partitionColumns;

  Output({
    required this.location,
    this.compressionFormat,
    this.format,
    this.overwrite,
    this.partitionColumns,
  });
  factory Output.fromJson(Map<String, dynamic> json) {
    return Output(
      location: S3Location.fromJson(json['Location'] as Map<String, dynamic>),
      compressionFormat:
          (json['CompressionFormat'] as String?)?.toCompressionFormat(),
      format: (json['Format'] as String?)?.toOutputFormat(),
      overwrite: json['Overwrite'] as bool?,
      partitionColumns: (json['PartitionColumns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final location = this.location;
    final compressionFormat = this.compressionFormat;
    final format = this.format;
    final overwrite = this.overwrite;
    final partitionColumns = this.partitionColumns;
    return {
      'Location': location,
      if (compressionFormat != null)
        'CompressionFormat': compressionFormat.toValue(),
      if (format != null) 'Format': format.toValue(),
      if (overwrite != null) 'Overwrite': overwrite,
      if (partitionColumns != null) 'PartitionColumns': partitionColumns,
    };
  }
}

enum OutputFormat {
  csv,
  json,
  parquet,
  glueparquet,
  avro,
  orc,
  xml,
}

extension on OutputFormat {
  String toValue() {
    switch (this) {
      case OutputFormat.csv:
        return 'CSV';
      case OutputFormat.json:
        return 'JSON';
      case OutputFormat.parquet:
        return 'PARQUET';
      case OutputFormat.glueparquet:
        return 'GLUEPARQUET';
      case OutputFormat.avro:
        return 'AVRO';
      case OutputFormat.orc:
        return 'ORC';
      case OutputFormat.xml:
        return 'XML';
    }
  }
}

extension on String {
  OutputFormat toOutputFormat() {
    switch (this) {
      case 'CSV':
        return OutputFormat.csv;
      case 'JSON':
        return OutputFormat.json;
      case 'PARQUET':
        return OutputFormat.parquet;
      case 'GLUEPARQUET':
        return OutputFormat.glueparquet;
      case 'AVRO':
        return OutputFormat.avro;
      case 'ORC':
        return OutputFormat.orc;
      case 'XML':
        return OutputFormat.xml;
    }
    throw Exception('$this is not known in enum OutputFormat');
  }
}

/// Represents all of the attributes of an AWS Glue DataBrew project.
class Project {
  /// The unique name of a project.
  final String name;

  /// The name of a recipe that will be developed during a project session.
  final String recipeName;

  /// The ID of the AWS account that owns the project.
  final String? accountId;

  /// The date and time that the project was created.
  final DateTime? createDate;

  /// The identifier (the user name) of the user who crated the project.
  final String? createdBy;

  /// The dataset that the project is to act upon.
  final String? datasetName;

  /// The identifier (user name) of the user who last modified the project.
  final String? lastModifiedBy;

  /// The last modification date and time for the project.
  final DateTime? lastModifiedDate;

  /// The date and time when the project was opened.
  final DateTime? openDate;

  /// The identifier (the user name) of the user that opened the project for use.
  final String? openedBy;

  /// The Amazon Resource Name (ARN) for the project.
  final String? resourceArn;

  /// The Amazon Resource Name (ARN) of the role that will be assumed for this
  /// project.
  final String? roleArn;

  /// The sample size and sampling type to apply to the data. If this parameter
  /// isn't specified, then the sample will consiste of the first 500 rows from
  /// the dataset.
  final Sample? sample;

  /// Metadata tags that have been applied to the project.
  final Map<String, String>? tags;

  Project({
    required this.name,
    required this.recipeName,
    this.accountId,
    this.createDate,
    this.createdBy,
    this.datasetName,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.openDate,
    this.openedBy,
    this.resourceArn,
    this.roleArn,
    this.sample,
    this.tags,
  });
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['Name'] as String,
      recipeName: json['RecipeName'] as String,
      accountId: json['AccountId'] as String?,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      datasetName: json['DatasetName'] as String?,
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      openDate: timeStampFromJson(json['OpenDate']),
      openedBy: json['OpenedBy'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      roleArn: json['RoleArn'] as String?,
      sample: json['Sample'] != null
          ? Sample.fromJson(json['Sample'] as Map<String, dynamic>)
          : null,
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class PublishRecipeResponse {
  /// The name of the recipe that you published.
  final String name;

  PublishRecipeResponse({
    required this.name,
  });
  factory PublishRecipeResponse.fromJson(Map<String, dynamic> json) {
    return PublishRecipeResponse(
      name: json['Name'] as String,
    );
  }
}

/// Represents one or more actions to be performed on an AWS Glue DataBrew
/// dataset.
class Recipe {
  /// The unique name for the recipe.
  final String name;

  /// The date and time that the recipe was created.
  final DateTime? createDate;

  /// The identifier (the user name) of the user who created the recipe.
  final String? createdBy;

  /// The description of the recipe.
  final String? description;

  /// The identifier (user name) of the user who last modified the recipe.
  final String? lastModifiedBy;

  /// The last modification date and time of the recipe.
  final DateTime? lastModifiedDate;

  /// The name of the project that the recipe is associated with.
  final String? projectName;

  /// The identifier (the user name) of the user who published the recipe.
  final String? publishedBy;

  /// The date and time when the recipe was published.
  final DateTime? publishedDate;

  /// The identifier for the version for the recipe.
  final String? recipeVersion;

  /// The Amazon Resource Name (ARN) for the recipe.
  final String? resourceArn;

  /// A list of steps that are defined by the recipe.
  final List<RecipeStep>? steps;

  /// Metadata tags that have been applied to the recipe.
  final Map<String, String>? tags;

  Recipe({
    required this.name,
    this.createDate,
    this.createdBy,
    this.description,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.projectName,
    this.publishedBy,
    this.publishedDate,
    this.recipeVersion,
    this.resourceArn,
    this.steps,
    this.tags,
  });
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['Name'] as String,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      description: json['Description'] as String?,
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      projectName: json['ProjectName'] as String?,
      publishedBy: json['PublishedBy'] as String?,
      publishedDate: timeStampFromJson(json['PublishedDate']),
      recipeVersion: json['RecipeVersion'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      steps: (json['Steps'] as List?)
          ?.whereNotNull()
          .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// Represents a transformation and associated parameters that are used to apply
/// a change to an AWS Glue DataBrew dataset. For more information, see <a
/// href="https://docs.aws.amazon.com/databrew/latest/dg/recipe-structure.html">Recipe
/// structure</a> and <a
/// href="https://docs.aws.amazon.com/databrew/latest/dg/recipe-actions-reference.html">ecipe
/// actions reference</a> .
class RecipeAction {
  /// The name of a valid DataBrew transformation to be performed on the data.
  final String operation;

  /// Contextual parameters for the transformation.
  final Map<String, String>? parameters;

  RecipeAction({
    required this.operation,
    this.parameters,
  });
  factory RecipeAction.fromJson(Map<String, dynamic> json) {
    return RecipeAction(
      operation: json['Operation'] as String,
      parameters: (json['Parameters'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }

  Map<String, dynamic> toJson() {
    final operation = this.operation;
    final parameters = this.parameters;
    return {
      'Operation': operation,
      if (parameters != null) 'Parameters': parameters,
    };
  }
}

/// Represents all of the attributes of an AWS Glue DataBrew recipe.
class RecipeReference {
  /// The name of the recipe.
  final String name;

  /// The identifier for the version for the recipe.
  final String? recipeVersion;

  RecipeReference({
    required this.name,
    this.recipeVersion,
  });
  factory RecipeReference.fromJson(Map<String, dynamic> json) {
    return RecipeReference(
      name: json['Name'] as String,
      recipeVersion: json['RecipeVersion'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final recipeVersion = this.recipeVersion;
    return {
      'Name': name,
      if (recipeVersion != null) 'RecipeVersion': recipeVersion,
    };
  }
}

/// Represents a single step to be performed in an AWS Glue DataBrew recipe.
class RecipeStep {
  /// The particular action to be performed in the recipe step.
  final RecipeAction action;

  /// One or more conditions that must be met, in order for the recipe step to
  /// succeed.
  /// <note>
  /// All of the conditions in the array must be met. In other words, all of the
  /// conditions must be combined using a logical AND operation.
  /// </note>
  final List<ConditionExpression>? conditionExpressions;

  RecipeStep({
    required this.action,
    this.conditionExpressions,
  });
  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      action: RecipeAction.fromJson(json['Action'] as Map<String, dynamic>),
      conditionExpressions: (json['ConditionExpressions'] as List?)
          ?.whereNotNull()
          .map((e) => ConditionExpression.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final action = this.action;
    final conditionExpressions = this.conditionExpressions;
    return {
      'Action': action,
      if (conditionExpressions != null)
        'ConditionExpressions': conditionExpressions,
    };
  }
}

/// Represents any errors encountered when attempting to delete multiple recipe
/// versions.
class RecipeVersionErrorDetail {
  /// The HTTP status code for the error.
  final String? errorCode;

  /// The text of the error message.
  final String? errorMessage;

  /// The identifier for the recipe version associated with this error.
  final String? recipeVersion;

  RecipeVersionErrorDetail({
    this.errorCode,
    this.errorMessage,
    this.recipeVersion,
  });
  factory RecipeVersionErrorDetail.fromJson(Map<String, dynamic> json) {
    return RecipeVersionErrorDetail(
      errorCode: json['ErrorCode'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
      recipeVersion: json['RecipeVersion'] as String?,
    );
  }
}

/// An Amazon S3 location (bucket name an object key) where DataBrew can read
/// input data, or write output from a job.
class S3Location {
  /// The S3 bucket name.
  final String bucket;

  /// The unique name of the object in the bucket.
  final String? key;

  S3Location({
    required this.bucket,
    this.key,
  });
  factory S3Location.fromJson(Map<String, dynamic> json) {
    return S3Location(
      bucket: json['Bucket'] as String,
      key: json['Key'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final bucket = this.bucket;
    final key = this.key;
    return {
      'Bucket': bucket,
      if (key != null) 'Key': key,
    };
  }
}

/// Represents the sample size and sampling type for AWS Glue DataBrew to use
/// for interactive data analysis.
class Sample {
  /// The way in which DataBrew obtains rows from a dataset.
  final SampleType type;

  /// The number of rows in the sample.
  final int? size;

  Sample({
    required this.type,
    this.size,
  });
  factory Sample.fromJson(Map<String, dynamic> json) {
    return Sample(
      type: (json['Type'] as String).toSampleType(),
      size: json['Size'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final type = this.type;
    final size = this.size;
    return {
      'Type': type.toValue(),
      if (size != null) 'Size': size,
    };
  }
}

enum SampleType {
  firstN,
  lastN,
  random,
}

extension on SampleType {
  String toValue() {
    switch (this) {
      case SampleType.firstN:
        return 'FIRST_N';
      case SampleType.lastN:
        return 'LAST_N';
      case SampleType.random:
        return 'RANDOM';
    }
  }
}

extension on String {
  SampleType toSampleType() {
    switch (this) {
      case 'FIRST_N':
        return SampleType.firstN;
      case 'LAST_N':
        return SampleType.lastN;
      case 'RANDOM':
        return SampleType.random;
    }
    throw Exception('$this is not known in enum SampleType');
  }
}

/// Represents one or more dates and times when a job is to run.
class Schedule {
  /// The name of the schedule.
  final String name;

  /// The ID of the AWS account that owns the schedule.
  final String? accountId;

  /// The date and time that the schedule was created.
  final DateTime? createDate;

  /// The identifier (the user name) of the user who created the schedule.
  final String? createdBy;

  /// The date(s) and time(s), in <code>cron</code> format, when the job will run.
  final String? cronExpression;

  /// A list of jobs to be run, according to the schedule.
  final List<String>? jobNames;

  /// The identifier (the user name) of the user who last modified the schedule.
  final String? lastModifiedBy;

  /// The date and time when the schedule was last modified.
  final DateTime? lastModifiedDate;

  /// The Amazon Resource Name (ARN) of the schedule.
  final String? resourceArn;

  /// Metadata tags that have been applied to the schedule.
  final Map<String, String>? tags;

  Schedule({
    required this.name,
    this.accountId,
    this.createDate,
    this.createdBy,
    this.cronExpression,
    this.jobNames,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.resourceArn,
    this.tags,
  });
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      name: json['Name'] as String,
      accountId: json['AccountId'] as String?,
      createDate: timeStampFromJson(json['CreateDate']),
      createdBy: json['CreatedBy'] as String?,
      cronExpression: json['CronExpression'] as String?,
      jobNames: (json['JobNames'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      resourceArn: json['ResourceArn'] as String?,
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class SendProjectSessionActionResponse {
  /// The name of the project that was affected by the action.
  final String name;

  /// A unique identifier for the action that was performed.
  final int? actionId;

  /// A message indicating the result of performing the action.
  final String? result;

  SendProjectSessionActionResponse({
    required this.name,
    this.actionId,
    this.result,
  });
  factory SendProjectSessionActionResponse.fromJson(Map<String, dynamic> json) {
    return SendProjectSessionActionResponse(
      name: json['Name'] as String,
      actionId: json['ActionId'] as int?,
      result: json['Result'] as String?,
    );
  }
}

enum SessionStatus {
  assigned,
  failed,
  initializing,
  provisioning,
  ready,
  recycling,
  rotating,
  terminated,
  terminating,
  updating,
}

extension on SessionStatus {
  String toValue() {
    switch (this) {
      case SessionStatus.assigned:
        return 'ASSIGNED';
      case SessionStatus.failed:
        return 'FAILED';
      case SessionStatus.initializing:
        return 'INITIALIZING';
      case SessionStatus.provisioning:
        return 'PROVISIONING';
      case SessionStatus.ready:
        return 'READY';
      case SessionStatus.recycling:
        return 'RECYCLING';
      case SessionStatus.rotating:
        return 'ROTATING';
      case SessionStatus.terminated:
        return 'TERMINATED';
      case SessionStatus.terminating:
        return 'TERMINATING';
      case SessionStatus.updating:
        return 'UPDATING';
    }
  }
}

extension on String {
  SessionStatus toSessionStatus() {
    switch (this) {
      case 'ASSIGNED':
        return SessionStatus.assigned;
      case 'FAILED':
        return SessionStatus.failed;
      case 'INITIALIZING':
        return SessionStatus.initializing;
      case 'PROVISIONING':
        return SessionStatus.provisioning;
      case 'READY':
        return SessionStatus.ready;
      case 'RECYCLING':
        return SessionStatus.recycling;
      case 'ROTATING':
        return SessionStatus.rotating;
      case 'TERMINATED':
        return SessionStatus.terminated;
      case 'TERMINATING':
        return SessionStatus.terminating;
      case 'UPDATING':
        return SessionStatus.updating;
    }
    throw Exception('$this is not known in enum SessionStatus');
  }
}

enum Source {
  s3,
  dataCatalog,
}

extension on Source {
  String toValue() {
    switch (this) {
      case Source.s3:
        return 'S3';
      case Source.dataCatalog:
        return 'DATA-CATALOG';
    }
  }
}

extension on String {
  Source toSource() {
    switch (this) {
      case 'S3':
        return Source.s3;
      case 'DATA-CATALOG':
        return Source.dataCatalog;
    }
    throw Exception('$this is not known in enum Source');
  }
}

class StartJobRunResponse {
  /// A system-generated identifier for this particular job run.
  final String runId;

  StartJobRunResponse({
    required this.runId,
  });
  factory StartJobRunResponse.fromJson(Map<String, dynamic> json) {
    return StartJobRunResponse(
      runId: json['RunId'] as String,
    );
  }
}

class StartProjectSessionResponse {
  /// The name of the project to be acted upon.
  final String name;

  /// A system-generated identifier for the session.
  final String? clientSessionId;

  StartProjectSessionResponse({
    required this.name,
    this.clientSessionId,
  });
  factory StartProjectSessionResponse.fromJson(Map<String, dynamic> json) {
    return StartProjectSessionResponse(
      name: json['Name'] as String,
      clientSessionId: json['ClientSessionId'] as String?,
    );
  }
}

class StopJobRunResponse {
  /// The ID of the job run that you stopped.
  final String runId;

  StopJobRunResponse({
    required this.runId,
  });
  factory StopJobRunResponse.fromJson(Map<String, dynamic> json) {
    return StopJobRunResponse(
      runId: json['RunId'] as String,
    );
  }
}

class TagResourceResponse {
  TagResourceResponse();
  factory TagResourceResponse.fromJson(Map<String, dynamic> _) {
    return TagResourceResponse();
  }
}

class UntagResourceResponse {
  UntagResourceResponse();
  factory UntagResourceResponse.fromJson(Map<String, dynamic> _) {
    return UntagResourceResponse();
  }
}

class UpdateDatasetResponse {
  /// The name of the dataset that you updated.
  final String name;

  UpdateDatasetResponse({
    required this.name,
  });
  factory UpdateDatasetResponse.fromJson(Map<String, dynamic> json) {
    return UpdateDatasetResponse(
      name: json['Name'] as String,
    );
  }
}

class UpdateProfileJobResponse {
  /// The name of the job that was updated.
  final String name;

  UpdateProfileJobResponse({
    required this.name,
  });
  factory UpdateProfileJobResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileJobResponse(
      name: json['Name'] as String,
    );
  }
}

class UpdateProjectResponse {
  /// The name of the project that you updated.
  final String name;

  /// The date and time that the project was last modified.
  final DateTime? lastModifiedDate;

  UpdateProjectResponse({
    required this.name,
    this.lastModifiedDate,
  });
  factory UpdateProjectResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProjectResponse(
      name: json['Name'] as String,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
    );
  }
}

class UpdateRecipeJobResponse {
  /// The name of the job that you updated.
  final String name;

  UpdateRecipeJobResponse({
    required this.name,
  });
  factory UpdateRecipeJobResponse.fromJson(Map<String, dynamic> json) {
    return UpdateRecipeJobResponse(
      name: json['Name'] as String,
    );
  }
}

class UpdateRecipeResponse {
  /// The name of the recipe that was updated.
  final String name;

  UpdateRecipeResponse({
    required this.name,
  });
  factory UpdateRecipeResponse.fromJson(Map<String, dynamic> json) {
    return UpdateRecipeResponse(
      name: json['Name'] as String,
    );
  }
}

class UpdateScheduleResponse {
  /// The name of the schedule that was updated.
  final String name;

  UpdateScheduleResponse({
    required this.name,
  });
  factory UpdateScheduleResponse.fromJson(Map<String, dynamic> json) {
    return UpdateScheduleResponse(
      name: json['Name'] as String,
    );
  }
}

/// Represents the data being being transformed during an AWS Glue DataBrew
/// project session.
class ViewFrame {
  /// The starting index for the range of columns to return in the view frame.
  final int startColumnIndex;

  /// The number of columns to include in the view frame, beginning with the
  /// <code>StartColumnIndex</code> value and ignoring any columns in the
  /// <code>HiddenColumns</code> list.
  final int? columnRange;

  /// A list of columns to hide in the view frame.
  final List<String>? hiddenColumns;

  ViewFrame({
    required this.startColumnIndex,
    this.columnRange,
    this.hiddenColumns,
  });
  Map<String, dynamic> toJson() {
    final startColumnIndex = this.startColumnIndex;
    final columnRange = this.columnRange;
    final hiddenColumns = this.hiddenColumns;
    return {
      'StartColumnIndex': startColumnIndex,
      if (columnRange != null) 'ColumnRange': columnRange,
      if (hiddenColumns != null) 'HiddenColumns': hiddenColumns,
    };
  }
}

class AccessDeniedException extends _s.GenericAwsException {
  AccessDeniedException({String? type, String? message})
      : super(type: type, code: 'AccessDeniedException', message: message);
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

class ServiceQuotaExceededException extends _s.GenericAwsException {
  ServiceQuotaExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'ServiceQuotaExceededException',
            message: message);
}

class ValidationException extends _s.GenericAwsException {
  ValidationException({String? type, String? message})
      : super(type: type, code: 'ValidationException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'AccessDeniedException': (type, message) =>
      AccessDeniedException(type: type, message: message),
  'ConflictException': (type, message) =>
      ConflictException(type: type, message: message),
  'InternalServerException': (type, message) =>
      InternalServerException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ServiceQuotaExceededException': (type, message) =>
      ServiceQuotaExceededException(type: type, message: message),
  'ValidationException': (type, message) =>
      ValidationException(type: type, message: message),
};
