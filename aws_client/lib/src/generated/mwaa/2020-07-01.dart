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

/// This section contains the Amazon Managed Workflows for Apache Airflow (MWAA)
/// API reference documentation. For more information, see <a
/// href="https://docs.aws.amazon.com/mwaa/latest/userguide/what-is-mwaa.html">What
/// Is Amazon MWAA?</a>.
class Mwaa {
  final _s.RestJsonProtocol _protocol;
  Mwaa({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'airflow',
            signingName: 'airflow',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  /// Create a CLI token to use Airflow CLI.
  ///
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [name] :
  /// Create a CLI token request for a MWAA environment.
  Future<CreateCliTokenResponse> createCliToken({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      80,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z][0-9a-zA-Z-_]*$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri: '/clitoken/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateCliTokenResponse.fromJson(response);
  }

  /// JSON blob that describes the environment to create.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [dagS3Path] :
  /// The relative path to the DAG folder on your Amazon S3 storage bucket. For
  /// example, <code>dags</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-import.html">Importing
  /// DAGs on Amazon MWAA</a>.
  ///
  /// Parameter [executionRoleArn] :
  /// The Amazon Resource Name (ARN) of the execution role for your environment.
  /// An execution role is an AWS Identity and Access Management (IAM) role that
  /// grants MWAA permission to access AWS services and resources used by your
  /// environment. For example,
  /// <code>arn:aws:iam::123456789:role/my-execution-role</code>. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/mwaa/latest/userguide/manage-access.html">Managing
  /// access to Amazon Managed Workflows for Apache Airflow</a>.
  ///
  /// Parameter [name] :
  /// The name of your MWAA environment.
  ///
  /// Parameter [networkConfiguration] :
  /// The VPC networking components you want to use for your environment. At
  /// least two private subnet identifiers and one VPC security group identifier
  /// are required to create an environment. For more information, see <a
  /// href="https://docs.aws.amazon.com/mwaa/latest/userguide/vpc-mwaa.html">Creating
  /// the VPC network for a MWAA environment</a>.
  ///
  /// Parameter [sourceBucketArn] :
  /// The Amazon Resource Name (ARN) of your Amazon S3 storage bucket. For
  /// example, <code>arn:aws:s3:::airflow-mybucketname</code>.
  ///
  /// Parameter [airflowConfigurationOptions] :
  /// The Apache Airflow configuration setting you want to override in your
  /// environment. For more information, see <a
  /// href="https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-env-variables.html">Environment
  /// configuration</a>.
  ///
  /// Parameter [airflowVersion] :
  /// The Apache Airflow version you want to use for your environment.
  ///
  /// Parameter [environmentClass] :
  /// The environment class you want to use for your environment. The
  /// environment class determines the size of the containers and database used
  /// for your Apache Airflow services.
  ///
  /// Parameter [kmsKey] :
  /// The AWS Key Management Service (KMS) key to encrypt and decrypt the data
  /// in your environment. You can use an AWS KMS key managed by MWAA, or a
  /// custom KMS key (advanced). For more information, see <a
  /// href="https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html?icmpid=docs_console_unmapped#master_keys">Customer
  /// master keys (CMKs)</a> in the AWS KMS developer guide.
  ///
  /// Parameter [loggingConfiguration] :
  /// The Apache Airflow logs you want to send to Amazon CloudWatch Logs.
  ///
  /// Parameter [maxWorkers] :
  /// The maximum number of workers that you want to run in your environment.
  /// MWAA scales the number of Apache Airflow workers and the Fargate
  /// containers that run your tasks up to the number you specify in this field.
  /// When there are no more tasks running, and no more in the queue, MWAA
  /// disposes of the extra containers leaving the one worker that is included
  /// with your environment.
  ///
  /// Parameter [pluginsS3ObjectVersion] :
  /// The <code>plugins.zip</code> file version you want to use.
  ///
  /// Parameter [pluginsS3Path] :
  /// The relative path to the <code>plugins.zip</code> file on your Amazon S3
  /// storage bucket. For example, <code>plugins.zip</code>. If a relative path
  /// is provided in the request, then <code>PluginsS3ObjectVersion</code> is
  /// required. For more information, see <a
  /// href="https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-import.html">Importing
  /// DAGs on Amazon MWAA</a>.
  ///
  /// Parameter [requirementsS3ObjectVersion] :
  /// The <code>requirements.txt</code> file version you want to use.
  ///
  /// Parameter [requirementsS3Path] :
  /// The relative path to the <code>requirements.txt</code> file on your Amazon
  /// S3 storage bucket. For example, <code>requirements.txt</code>. If a
  /// relative path is provided in the request, then
  /// <code>RequirementsS3ObjectVersion</code> is required. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-import.html">Importing
  /// DAGs on Amazon MWAA</a>.
  ///
  /// Parameter [tags] :
  /// The metadata tags you want to attach to your environment. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
  /// AWS resources</a>.
  ///
  /// Parameter [webserverAccessMode] :
  /// The networking access of your Apache Airflow web server. A public network
  /// allows your Airflow UI to be accessed over the Internet by users granted
  /// access in your IAM policy. A private network limits access of your Airflow
  /// UI to users within your VPC. For more information, see <a
  /// href="https://docs.aws.amazon.com/mwaa/latest/userguide/vpc-mwaa.html">Creating
  /// the VPC network for a MWAA environment</a>.
  ///
  /// Parameter [weeklyMaintenanceWindowStart] :
  /// The day and time you want MWAA to start weekly maintenance updates on your
  /// environment.
  Future<CreateEnvironmentOutput> createEnvironment({
    required String dagS3Path,
    required String executionRoleArn,
    required String name,
    required NetworkConfiguration networkConfiguration,
    required String sourceBucketArn,
    Map<String, String>? airflowConfigurationOptions,
    String? airflowVersion,
    String? environmentClass,
    String? kmsKey,
    LoggingConfigurationInput? loggingConfiguration,
    int? maxWorkers,
    String? pluginsS3ObjectVersion,
    String? pluginsS3Path,
    String? requirementsS3ObjectVersion,
    String? requirementsS3Path,
    Map<String, String>? tags,
    WebserverAccessMode? webserverAccessMode,
    String? weeklyMaintenanceWindowStart,
  }) async {
    ArgumentError.checkNotNull(dagS3Path, 'dagS3Path');
    _s.validateStringLength(
      'dagS3Path',
      dagS3Path,
      1,
      1024,
      isRequired: true,
    );
    _s.validateStringPattern(
      'dagS3Path',
      dagS3Path,
      r'''.*''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(executionRoleArn, 'executionRoleArn');
    _s.validateStringLength(
      'executionRoleArn',
      executionRoleArn,
      1,
      1224,
      isRequired: true,
    );
    _s.validateStringPattern(
      'executionRoleArn',
      executionRoleArn,
      r'''^arn:aws(-[a-z]+)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      80,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z][0-9a-zA-Z-_]*$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(networkConfiguration, 'networkConfiguration');
    ArgumentError.checkNotNull(sourceBucketArn, 'sourceBucketArn');
    _s.validateStringLength(
      'sourceBucketArn',
      sourceBucketArn,
      1,
      1224,
      isRequired: true,
    );
    _s.validateStringPattern(
      'sourceBucketArn',
      sourceBucketArn,
      r'''^arn:aws(-[a-z]+)?:s3:::airflow-[a-z0-9.\-]+$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'airflowVersion',
      airflowVersion,
      1,
      32,
    );
    _s.validateStringPattern(
      'airflowVersion',
      airflowVersion,
      r'''^[0-9a-z.]+$''',
    );
    _s.validateStringLength(
      'environmentClass',
      environmentClass,
      1,
      1024,
    );
    _s.validateStringLength(
      'kmsKey',
      kmsKey,
      1,
      1224,
    );
    _s.validateStringPattern(
      'kmsKey',
      kmsKey,
      r'''^(((arn:aws(-[a-z]+)?:kms:[a-z]{2}-[a-z]+-\d:\d+:)?key\/)?[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}|(arn:aws(-[a-z]+)?:kms:[a-z]{2}-[a-z]+-\d:\d+:)?alias/.+)$''',
    );
    _s.validateNumRange(
      'maxWorkers',
      maxWorkers,
      1,
      1152921504606846976,
    );
    _s.validateStringLength(
      'pluginsS3ObjectVersion',
      pluginsS3ObjectVersion,
      1,
      1024,
    );
    _s.validateStringLength(
      'pluginsS3Path',
      pluginsS3Path,
      1,
      1024,
    );
    _s.validateStringPattern(
      'pluginsS3Path',
      pluginsS3Path,
      r'''.*''',
    );
    _s.validateStringLength(
      'requirementsS3ObjectVersion',
      requirementsS3ObjectVersion,
      1,
      1024,
    );
    _s.validateStringLength(
      'requirementsS3Path',
      requirementsS3Path,
      1,
      1024,
    );
    _s.validateStringPattern(
      'requirementsS3Path',
      requirementsS3Path,
      r'''.*''',
    );
    _s.validateStringLength(
      'weeklyMaintenanceWindowStart',
      weeklyMaintenanceWindowStart,
      1,
      9,
    );
    _s.validateStringPattern(
      'weeklyMaintenanceWindowStart',
      weeklyMaintenanceWindowStart,
      r'''(MON|TUE|WED|THU|FRI|SAT|SUN):([01]\d|2[0-3]):(00|30)''',
    );
    final $payload = <String, dynamic>{
      'DagS3Path': dagS3Path,
      'ExecutionRoleArn': executionRoleArn,
      'NetworkConfiguration': networkConfiguration,
      'SourceBucketArn': sourceBucketArn,
      if (airflowConfigurationOptions != null)
        'AirflowConfigurationOptions': airflowConfigurationOptions,
      if (airflowVersion != null) 'AirflowVersion': airflowVersion,
      if (environmentClass != null) 'EnvironmentClass': environmentClass,
      if (kmsKey != null) 'KmsKey': kmsKey,
      if (loggingConfiguration != null)
        'LoggingConfiguration': loggingConfiguration,
      if (maxWorkers != null) 'MaxWorkers': maxWorkers,
      if (pluginsS3ObjectVersion != null)
        'PluginsS3ObjectVersion': pluginsS3ObjectVersion,
      if (pluginsS3Path != null) 'PluginsS3Path': pluginsS3Path,
      if (requirementsS3ObjectVersion != null)
        'RequirementsS3ObjectVersion': requirementsS3ObjectVersion,
      if (requirementsS3Path != null) 'RequirementsS3Path': requirementsS3Path,
      if (tags != null) 'Tags': tags,
      if (webserverAccessMode != null)
        'WebserverAccessMode': webserverAccessMode.toValue(),
      if (weeklyMaintenanceWindowStart != null)
        'WeeklyMaintenanceWindowStart': weeklyMaintenanceWindowStart,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/environments/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateEnvironmentOutput.fromJson(response);
  }

  /// Create a JWT token to be used to login to Airflow Web UI with claims based
  /// Authentication.
  ///
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// Create an Airflow Web UI login token request for a MWAA environment.
  Future<CreateWebLoginTokenResponse> createWebLoginToken({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      80,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z][0-9a-zA-Z-_]*$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri: '/webtoken/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateWebLoginTokenResponse.fromJson(response);
  }

  /// Delete an existing environment.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of the environment to delete.
  Future<void> deleteEnvironment({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      80,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z][0-9a-zA-Z-_]*$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/environments/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Get details of an existing environment.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of the environment to retrieve.
  Future<GetEnvironmentOutput> getEnvironment({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      80,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z][0-9a-zA-Z-_]*$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/environments/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetEnvironmentOutput.fromJson(response);
  }

  /// List Amazon MWAA Environments.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [maxResults] :
  /// The maximum results when listing MWAA environments.
  ///
  /// Parameter [nextToken] :
  /// The Next Token when listing MWAA environments.
  Future<ListEnvironmentsOutput> listEnvironments({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      25,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      2048,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'MaxResults': [maxResults.toString()],
      if (nextToken != null) 'NextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/environments',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListEnvironmentsOutput.fromJson(response);
  }

  /// List the tags for MWAA environments.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [resourceArn] :
  /// The ARN of the MWAA environment.
  Future<ListTagsForResourceOutput> listTagsForResource({
    required String resourceArn,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      1,
      1224,
      isRequired: true,
    );
    _s.validateStringPattern(
      'resourceArn',
      resourceArn,
      r'''^arn:aws(-[a-z]+)?:airflow:[a-z0-9\-]+:\d{12}:environment/\w+''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return ListTagsForResourceOutput.fromJson(response);
  }

  /// An operation for publishing metrics from the customers to the Ops plane.
  ///
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [environmentName] :
  /// Publishes environment metric data to Amazon CloudWatch.
  ///
  /// Parameter [metricData] :
  /// Publishes metric data points to Amazon CloudWatch. CloudWatch associates
  /// the data points with the specified metrica.
  Future<void> publishMetrics({
    required String environmentName,
    required List<MetricDatum> metricData,
  }) async {
    ArgumentError.checkNotNull(environmentName, 'environmentName');
    _s.validateStringLength(
      'environmentName',
      environmentName,
      1,
      80,
      isRequired: true,
    );
    _s.validateStringPattern(
      'environmentName',
      environmentName,
      r'''^[a-zA-Z][0-9a-zA-Z-_]*$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(metricData, 'metricData');
    final $payload = <String, dynamic>{
      'MetricData': metricData,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/metrics/environments/${Uri.encodeComponent(environmentName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Add tag to the MWAA environments.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [resourceArn] :
  /// The tag resource ARN of the MWAA environments.
  ///
  /// Parameter [tags] :
  /// The tag resource tag of the MWAA environments.
  Future<void> tagResource({
    required String resourceArn,
    required Map<String, String> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      1,
      1224,
      isRequired: true,
    );
    _s.validateStringPattern(
      'resourceArn',
      resourceArn,
      r'''^arn:aws(-[a-z]+)?:airflow:[a-z0-9\-]+:\d{12}:environment/\w+''',
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

  /// Remove a tag from the MWAA environments.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [resourceArn] :
  /// The tag resource ARN of the MWAA environments.
  ///
  /// Parameter [tagKeys] :
  /// The tag resource key of the MWAA environments.
  Future<void> untagResource({
    required String resourceArn,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      1,
      1224,
      isRequired: true,
    );
    _s.validateStringPattern(
      'resourceArn',
      resourceArn,
      r'''^arn:aws(-[a-z]+)?:airflow:[a-z0-9\-]+:\d{12}:environment/\w+''',
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

  /// Update an MWAA environment.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of your Amazon MWAA environment that you wish to update.
  ///
  /// Parameter [airflowConfigurationOptions] :
  /// The Airflow Configuration Options to update of your Amazon MWAA
  /// environment.
  ///
  /// Parameter [airflowVersion] :
  /// The Airflow Version to update of your Amazon MWAA environment.
  ///
  /// Parameter [dagS3Path] :
  /// The Dags folder S3 Path to update of your Amazon MWAA environment.
  ///
  /// Parameter [environmentClass] :
  /// The Environment Class to update of your Amazon MWAA environment.
  ///
  /// Parameter [executionRoleArn] :
  /// The Executio Role ARN to update of your Amazon MWAA environment.
  ///
  /// Parameter [loggingConfiguration] :
  /// The Logging Configuration to update of your Amazon MWAA environment.
  ///
  /// Parameter [maxWorkers] :
  /// The Maximum Workers to update of your Amazon MWAA environment.
  ///
  /// Parameter [networkConfiguration] :
  /// The Network Configuration to update of your Amazon MWAA environment.
  ///
  /// Parameter [pluginsS3ObjectVersion] :
  /// The Plugins.zip S3 Object Version to update of your Amazon MWAA
  /// environment.
  ///
  /// Parameter [pluginsS3Path] :
  /// The Plugins.zip S3 Path to update of your Amazon MWAA environment.
  ///
  /// Parameter [requirementsS3ObjectVersion] :
  /// The Requirements.txt S3 ObjectV ersion to update of your Amazon MWAA
  /// environment.
  ///
  /// Parameter [requirementsS3Path] :
  /// The Requirements.txt S3 Path to update of your Amazon MWAA environment.
  ///
  /// Parameter [sourceBucketArn] :
  /// The S3 Source Bucket ARN to update of your Amazon MWAA environment.
  ///
  /// Parameter [webserverAccessMode] :
  /// The Webserver Access Mode to update of your Amazon MWAA environment.
  ///
  /// Parameter [weeklyMaintenanceWindowStart] :
  /// The Weekly Maintenance Window Start to update of your Amazon MWAA
  /// environment.
  Future<UpdateEnvironmentOutput> updateEnvironment({
    required String name,
    Map<String, String>? airflowConfigurationOptions,
    String? airflowVersion,
    String? dagS3Path,
    String? environmentClass,
    String? executionRoleArn,
    LoggingConfigurationInput? loggingConfiguration,
    int? maxWorkers,
    UpdateNetworkConfigurationInput? networkConfiguration,
    String? pluginsS3ObjectVersion,
    String? pluginsS3Path,
    String? requirementsS3ObjectVersion,
    String? requirementsS3Path,
    String? sourceBucketArn,
    WebserverAccessMode? webserverAccessMode,
    String? weeklyMaintenanceWindowStart,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      80,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z][0-9a-zA-Z-_]*$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'airflowVersion',
      airflowVersion,
      1,
      32,
    );
    _s.validateStringPattern(
      'airflowVersion',
      airflowVersion,
      r'''^[0-9a-z.]+$''',
    );
    _s.validateStringLength(
      'dagS3Path',
      dagS3Path,
      1,
      1024,
    );
    _s.validateStringPattern(
      'dagS3Path',
      dagS3Path,
      r'''.*''',
    );
    _s.validateStringLength(
      'environmentClass',
      environmentClass,
      1,
      1024,
    );
    _s.validateStringLength(
      'executionRoleArn',
      executionRoleArn,
      1,
      1224,
    );
    _s.validateStringPattern(
      'executionRoleArn',
      executionRoleArn,
      r'''^arn:aws(-[a-z]+)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$''',
    );
    _s.validateNumRange(
      'maxWorkers',
      maxWorkers,
      1,
      1152921504606846976,
    );
    _s.validateStringLength(
      'pluginsS3ObjectVersion',
      pluginsS3ObjectVersion,
      1,
      1024,
    );
    _s.validateStringLength(
      'pluginsS3Path',
      pluginsS3Path,
      1,
      1024,
    );
    _s.validateStringPattern(
      'pluginsS3Path',
      pluginsS3Path,
      r'''.*''',
    );
    _s.validateStringLength(
      'requirementsS3ObjectVersion',
      requirementsS3ObjectVersion,
      1,
      1024,
    );
    _s.validateStringLength(
      'requirementsS3Path',
      requirementsS3Path,
      1,
      1024,
    );
    _s.validateStringPattern(
      'requirementsS3Path',
      requirementsS3Path,
      r'''.*''',
    );
    _s.validateStringLength(
      'sourceBucketArn',
      sourceBucketArn,
      1,
      1224,
    );
    _s.validateStringPattern(
      'sourceBucketArn',
      sourceBucketArn,
      r'''^arn:aws(-[a-z]+)?:s3:::airflow-[a-z0-9.\-]+$''',
    );
    _s.validateStringLength(
      'weeklyMaintenanceWindowStart',
      weeklyMaintenanceWindowStart,
      1,
      9,
    );
    _s.validateStringPattern(
      'weeklyMaintenanceWindowStart',
      weeklyMaintenanceWindowStart,
      r'''(MON|TUE|WED|THU|FRI|SAT|SUN):([01]\d|2[0-3]):(00|30)''',
    );
    final $payload = <String, dynamic>{
      if (airflowConfigurationOptions != null)
        'AirflowConfigurationOptions': airflowConfigurationOptions,
      if (airflowVersion != null) 'AirflowVersion': airflowVersion,
      if (dagS3Path != null) 'DagS3Path': dagS3Path,
      if (environmentClass != null) 'EnvironmentClass': environmentClass,
      if (executionRoleArn != null) 'ExecutionRoleArn': executionRoleArn,
      if (loggingConfiguration != null)
        'LoggingConfiguration': loggingConfiguration,
      if (maxWorkers != null) 'MaxWorkers': maxWorkers,
      if (networkConfiguration != null)
        'NetworkConfiguration': networkConfiguration,
      if (pluginsS3ObjectVersion != null)
        'PluginsS3ObjectVersion': pluginsS3ObjectVersion,
      if (pluginsS3Path != null) 'PluginsS3Path': pluginsS3Path,
      if (requirementsS3ObjectVersion != null)
        'RequirementsS3ObjectVersion': requirementsS3ObjectVersion,
      if (requirementsS3Path != null) 'RequirementsS3Path': requirementsS3Path,
      if (sourceBucketArn != null) 'SourceBucketArn': sourceBucketArn,
      if (webserverAccessMode != null)
        'WebserverAccessMode': webserverAccessMode.toValue(),
      if (weeklyMaintenanceWindowStart != null)
        'WeeklyMaintenanceWindowStart': weeklyMaintenanceWindowStart,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PATCH',
      requestUri: '/environments/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateEnvironmentOutput.fromJson(response);
  }
}

class CreateCliTokenResponse {
  /// Create an Airflow CLI login token response for the provided JWT token.
  final String? cliToken;

  /// Create an Airflow CLI login token response for the provided webserver
  /// hostname.
  final String? webServerHostname;

  CreateCliTokenResponse({
    this.cliToken,
    this.webServerHostname,
  });
  factory CreateCliTokenResponse.fromJson(Map<String, dynamic> json) {
    return CreateCliTokenResponse(
      cliToken: json['CliToken'] as String?,
      webServerHostname: json['WebServerHostname'] as String?,
    );
  }
}

class CreateEnvironmentOutput {
  /// The resulting Amazon MWAA envirnonment ARN.
  final String? arn;

  CreateEnvironmentOutput({
    this.arn,
  });
  factory CreateEnvironmentOutput.fromJson(Map<String, dynamic> json) {
    return CreateEnvironmentOutput(
      arn: json['Arn'] as String?,
    );
  }
}

class CreateWebLoginTokenResponse {
  /// Create an Airflow Web UI login token response for the provided webserver
  /// hostname.
  final String? webServerHostname;

  /// Create an Airflow Web UI login token response for the provided JWT token.
  final String? webToken;

  CreateWebLoginTokenResponse({
    this.webServerHostname,
    this.webToken,
  });
  factory CreateWebLoginTokenResponse.fromJson(Map<String, dynamic> json) {
    return CreateWebLoginTokenResponse(
      webServerHostname: json['WebServerHostname'] as String?,
      webToken: json['WebToken'] as String?,
    );
  }
}

class DeleteEnvironmentOutput {
  DeleteEnvironmentOutput();
  factory DeleteEnvironmentOutput.fromJson(Map<String, dynamic> _) {
    return DeleteEnvironmentOutput();
  }
}

/// Internal only API.
class Dimension {
  /// Internal only API.
  final String name;

  /// Internal only API.
  final String value;

  Dimension({
    required this.name,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final value = this.value;
    return {
      'Name': name,
      'Value': value,
    };
  }
}

/// An Amazon MWAA environment.
class Environment {
  /// The Airflow Configuration Options of the Amazon MWAA Environment.
  final Map<String, String>? airflowConfigurationOptions;

  /// The AirflowV ersion of the Amazon MWAA Environment.
  final String? airflowVersion;

  /// The ARN of the Amazon MWAA Environment.
  final String? arn;

  /// The Created At date of the Amazon MWAA Environment.
  final DateTime? createdAt;

  /// The Dags S3 Path of the Amazon MWAA Environment.
  final String? dagS3Path;

  /// The Environment Class (size) of the Amazon MWAA Environment.
  final String? environmentClass;

  /// The Execution Role ARN of the Amazon MWAA Environment.
  final String? executionRoleArn;

  /// The Kms Key of the Amazon MWAA Environment.
  final String? kmsKey;
  final LastUpdate? lastUpdate;

  /// The Logging Configuration of the Amazon MWAA Environment.
  final LoggingConfiguration? loggingConfiguration;

  /// The Maximum Workers of the Amazon MWAA Environment.
  final int? maxWorkers;

  /// The name of the Amazon MWAA Environment.
  final String? name;
  final NetworkConfiguration? networkConfiguration;

  /// The Plugins.zip S3 Object Version of the Amazon MWAA Environment.
  final String? pluginsS3ObjectVersion;

  /// The Plugins.zip S3 Path of the Amazon MWAA Environment.
  final String? pluginsS3Path;

  /// The Requirements.txt file S3 Object Version of the Amazon MWAA Environment.
  final String? requirementsS3ObjectVersion;

  /// The Requirement.txt S3 Path of the Amazon MWAA Environment.
  final String? requirementsS3Path;

  /// The Service Role ARN of the Amazon MWAA Environment.
  final String? serviceRoleArn;

  /// The Source S3 Bucket ARN of the Amazon MWAA Environment.
  final String? sourceBucketArn;

  /// The status of the Amazon MWAA Environment.
  final EnvironmentStatus? status;

  /// The Tags of the Amazon MWAA Environment.
  final Map<String, String>? tags;

  /// The Webserver Access Mode of the Amazon MWAA Environment (public or private
  /// only).
  final WebserverAccessMode? webserverAccessMode;

  /// The Webserver URL of the Amazon MWAA Environment.
  final String? webserverUrl;

  /// The Weekly Maintenance Window Start of the Amazon MWAA Environment.
  final String? weeklyMaintenanceWindowStart;

  Environment({
    this.airflowConfigurationOptions,
    this.airflowVersion,
    this.arn,
    this.createdAt,
    this.dagS3Path,
    this.environmentClass,
    this.executionRoleArn,
    this.kmsKey,
    this.lastUpdate,
    this.loggingConfiguration,
    this.maxWorkers,
    this.name,
    this.networkConfiguration,
    this.pluginsS3ObjectVersion,
    this.pluginsS3Path,
    this.requirementsS3ObjectVersion,
    this.requirementsS3Path,
    this.serviceRoleArn,
    this.sourceBucketArn,
    this.status,
    this.tags,
    this.webserverAccessMode,
    this.webserverUrl,
    this.weeklyMaintenanceWindowStart,
  });
  factory Environment.fromJson(Map<String, dynamic> json) {
    return Environment(
      airflowConfigurationOptions:
          (json['AirflowConfigurationOptions'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as String)),
      airflowVersion: json['AirflowVersion'] as String?,
      arn: json['Arn'] as String?,
      createdAt: timeStampFromJson(json['CreatedAt']),
      dagS3Path: json['DagS3Path'] as String?,
      environmentClass: json['EnvironmentClass'] as String?,
      executionRoleArn: json['ExecutionRoleArn'] as String?,
      kmsKey: json['KmsKey'] as String?,
      lastUpdate: json['LastUpdate'] != null
          ? LastUpdate.fromJson(json['LastUpdate'] as Map<String, dynamic>)
          : null,
      loggingConfiguration: json['LoggingConfiguration'] != null
          ? LoggingConfiguration.fromJson(
              json['LoggingConfiguration'] as Map<String, dynamic>)
          : null,
      maxWorkers: json['MaxWorkers'] as int?,
      name: json['Name'] as String?,
      networkConfiguration: json['NetworkConfiguration'] != null
          ? NetworkConfiguration.fromJson(
              json['NetworkConfiguration'] as Map<String, dynamic>)
          : null,
      pluginsS3ObjectVersion: json['PluginsS3ObjectVersion'] as String?,
      pluginsS3Path: json['PluginsS3Path'] as String?,
      requirementsS3ObjectVersion:
          json['RequirementsS3ObjectVersion'] as String?,
      requirementsS3Path: json['RequirementsS3Path'] as String?,
      serviceRoleArn: json['ServiceRoleArn'] as String?,
      sourceBucketArn: json['SourceBucketArn'] as String?,
      status: (json['Status'] as String?)?.toEnvironmentStatus(),
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      webserverAccessMode:
          (json['WebserverAccessMode'] as String?)?.toWebserverAccessMode(),
      webserverUrl: json['WebserverUrl'] as String?,
      weeklyMaintenanceWindowStart:
          json['WeeklyMaintenanceWindowStart'] as String?,
    );
  }
}

enum EnvironmentStatus {
  creating,
  createFailed,
  available,
  updating,
  deleting,
  deleted,
}

extension on EnvironmentStatus {
  String toValue() {
    switch (this) {
      case EnvironmentStatus.creating:
        return 'CREATING';
      case EnvironmentStatus.createFailed:
        return 'CREATE_FAILED';
      case EnvironmentStatus.available:
        return 'AVAILABLE';
      case EnvironmentStatus.updating:
        return 'UPDATING';
      case EnvironmentStatus.deleting:
        return 'DELETING';
      case EnvironmentStatus.deleted:
        return 'DELETED';
    }
  }
}

extension on String {
  EnvironmentStatus toEnvironmentStatus() {
    switch (this) {
      case 'CREATING':
        return EnvironmentStatus.creating;
      case 'CREATE_FAILED':
        return EnvironmentStatus.createFailed;
      case 'AVAILABLE':
        return EnvironmentStatus.available;
      case 'UPDATING':
        return EnvironmentStatus.updating;
      case 'DELETING':
        return EnvironmentStatus.deleting;
      case 'DELETED':
        return EnvironmentStatus.deleted;
    }
    throw Exception('$this is not known in enum EnvironmentStatus');
  }
}

class GetEnvironmentOutput {
  /// A JSON blob with environment details.
  final Environment? environment;

  GetEnvironmentOutput({
    this.environment,
  });
  factory GetEnvironmentOutput.fromJson(Map<String, dynamic> json) {
    return GetEnvironmentOutput(
      environment: json['Environment'] != null
          ? Environment.fromJson(json['Environment'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Last update information for the environment.
class LastUpdate {
  /// Time that last update occurred.
  final DateTime? createdAt;

  /// Error string of last update, if applicable.
  final UpdateError? error;

  /// Status of last update of SUCCESS, FAILED, CREATING, DELETING.
  final UpdateStatus? status;

  LastUpdate({
    this.createdAt,
    this.error,
    this.status,
  });
  factory LastUpdate.fromJson(Map<String, dynamic> json) {
    return LastUpdate(
      createdAt: timeStampFromJson(json['CreatedAt']),
      error: json['Error'] != null
          ? UpdateError.fromJson(json['Error'] as Map<String, dynamic>)
          : null,
      status: (json['Status'] as String?)?.toUpdateStatus(),
    );
  }
}

class ListEnvironmentsOutput {
  /// The list of Amazon MWAA Environments.
  final List<String> environments;

  /// The Next Token when listing MWAA environments.
  final String? nextToken;

  ListEnvironmentsOutput({
    required this.environments,
    this.nextToken,
  });
  factory ListEnvironmentsOutput.fromJson(Map<String, dynamic> json) {
    return ListEnvironmentsOutput(
      environments: (json['Environments'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListTagsForResourceOutput {
  /// The tags of the MWAA environments.
  final Map<String, String>? tags;

  ListTagsForResourceOutput({
    this.tags,
  });
  factory ListTagsForResourceOutput.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceOutput(
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// The Logging Configuration of your Amazon MWAA environment.
class LoggingConfiguration {
  final ModuleLoggingConfiguration? dagProcessingLogs;
  final ModuleLoggingConfiguration? schedulerLogs;
  final ModuleLoggingConfiguration? taskLogs;
  final ModuleLoggingConfiguration? webserverLogs;
  final ModuleLoggingConfiguration? workerLogs;

  LoggingConfiguration({
    this.dagProcessingLogs,
    this.schedulerLogs,
    this.taskLogs,
    this.webserverLogs,
    this.workerLogs,
  });
  factory LoggingConfiguration.fromJson(Map<String, dynamic> json) {
    return LoggingConfiguration(
      dagProcessingLogs: json['DagProcessingLogs'] != null
          ? ModuleLoggingConfiguration.fromJson(
              json['DagProcessingLogs'] as Map<String, dynamic>)
          : null,
      schedulerLogs: json['SchedulerLogs'] != null
          ? ModuleLoggingConfiguration.fromJson(
              json['SchedulerLogs'] as Map<String, dynamic>)
          : null,
      taskLogs: json['TaskLogs'] != null
          ? ModuleLoggingConfiguration.fromJson(
              json['TaskLogs'] as Map<String, dynamic>)
          : null,
      webserverLogs: json['WebserverLogs'] != null
          ? ModuleLoggingConfiguration.fromJson(
              json['WebserverLogs'] as Map<String, dynamic>)
          : null,
      workerLogs: json['WorkerLogs'] != null
          ? ModuleLoggingConfiguration.fromJson(
              json['WorkerLogs'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The Logging Configuration of your Amazon MWAA environment.
class LoggingConfigurationInput {
  final ModuleLoggingConfigurationInput? dagProcessingLogs;
  final ModuleLoggingConfigurationInput? schedulerLogs;
  final ModuleLoggingConfigurationInput? taskLogs;
  final ModuleLoggingConfigurationInput? webserverLogs;
  final ModuleLoggingConfigurationInput? workerLogs;

  LoggingConfigurationInput({
    this.dagProcessingLogs,
    this.schedulerLogs,
    this.taskLogs,
    this.webserverLogs,
    this.workerLogs,
  });
  Map<String, dynamic> toJson() {
    final dagProcessingLogs = this.dagProcessingLogs;
    final schedulerLogs = this.schedulerLogs;
    final taskLogs = this.taskLogs;
    final webserverLogs = this.webserverLogs;
    final workerLogs = this.workerLogs;
    return {
      if (dagProcessingLogs != null) 'DagProcessingLogs': dagProcessingLogs,
      if (schedulerLogs != null) 'SchedulerLogs': schedulerLogs,
      if (taskLogs != null) 'TaskLogs': taskLogs,
      if (webserverLogs != null) 'WebserverLogs': webserverLogs,
      if (workerLogs != null) 'WorkerLogs': workerLogs,
    };
  }
}

enum LoggingLevel {
  critical,
  error,
  warning,
  info,
  debug,
}

extension on LoggingLevel {
  String toValue() {
    switch (this) {
      case LoggingLevel.critical:
        return 'CRITICAL';
      case LoggingLevel.error:
        return 'ERROR';
      case LoggingLevel.warning:
        return 'WARNING';
      case LoggingLevel.info:
        return 'INFO';
      case LoggingLevel.debug:
        return 'DEBUG';
    }
  }
}

extension on String {
  LoggingLevel toLoggingLevel() {
    switch (this) {
      case 'CRITICAL':
        return LoggingLevel.critical;
      case 'ERROR':
        return LoggingLevel.error;
      case 'WARNING':
        return LoggingLevel.warning;
      case 'INFO':
        return LoggingLevel.info;
      case 'DEBUG':
        return LoggingLevel.debug;
    }
    throw Exception('$this is not known in enum LoggingLevel');
  }
}

/// Internal only API.
class MetricDatum {
  /// Internal only API.
  final String metricName;

  /// Internal only API.
  final DateTime timestamp;

  /// Internal only API.
  final List<Dimension>? dimensions;

  /// Internal only API.
  final StatisticSet? statisticValues;
  final Unit? unit;

  /// Internal only API.
  final double? value;

  MetricDatum({
    required this.metricName,
    required this.timestamp,
    this.dimensions,
    this.statisticValues,
    this.unit,
    this.value,
  });
  Map<String, dynamic> toJson() {
    final metricName = this.metricName;
    final timestamp = this.timestamp;
    final dimensions = this.dimensions;
    final statisticValues = this.statisticValues;
    final unit = this.unit;
    final value = this.value;
    return {
      'MetricName': metricName,
      'Timestamp': unixTimestampToJson(timestamp),
      if (dimensions != null) 'Dimensions': dimensions,
      if (statisticValues != null) 'StatisticValues': statisticValues,
      if (unit != null) 'Unit': unit.toValue(),
      if (value != null) 'Value': value,
    };
  }
}

/// A JSON blob that provides configuration to use for logging with respect to
/// the various Apache Airflow services: DagProcessingLogs, SchedulerLogs,
/// TaskLogs, WebserverLogs, and WorkerLogs.
class ModuleLoggingConfiguration {
  /// Provides the ARN for the CloudWatch group where the logs will be published.
  final String? cloudWatchLogGroupArn;

  /// Defines that the logging module is enabled.
  final bool? enabled;

  /// Defines the log level, which can be CRITICAL, ERROR, WARNING, or INFO.
  final LoggingLevel? logLevel;

  ModuleLoggingConfiguration({
    this.cloudWatchLogGroupArn,
    this.enabled,
    this.logLevel,
  });
  factory ModuleLoggingConfiguration.fromJson(Map<String, dynamic> json) {
    return ModuleLoggingConfiguration(
      cloudWatchLogGroupArn: json['CloudWatchLogGroupArn'] as String?,
      enabled: json['Enabled'] as bool?,
      logLevel: (json['LogLevel'] as String?)?.toLoggingLevel(),
    );
  }
}

/// A JSON blob that provides configuration to use for logging with respect to
/// the various Apache Airflow services: DagProcessingLogs, SchedulerLogs,
/// TaskLogs, WebserverLogs, and WorkerLogs.
class ModuleLoggingConfigurationInput {
  /// Defines that the logging module is enabled.
  final bool enabled;

  /// Defines the log level, which can be CRITICAL, ERROR, WARNING, or INFO.
  final LoggingLevel logLevel;

  ModuleLoggingConfigurationInput({
    required this.enabled,
    required this.logLevel,
  });
  Map<String, dynamic> toJson() {
    final enabled = this.enabled;
    final logLevel = this.logLevel;
    return {
      'Enabled': enabled,
      'LogLevel': logLevel.toValue(),
    };
  }
}

/// Provide the security group and subnet IDs for the workers and scheduler.
class NetworkConfiguration {
  /// A JSON list of 1 or more security groups IDs by name, in the same VPC as the
  /// subnets.
  final List<String>? securityGroupIds;

  /// Provide a JSON list of 2 subnet IDs by name. These must be private subnets,
  /// in the same VPC, in two different availability zones.
  final List<String>? subnetIds;

  NetworkConfiguration({
    this.securityGroupIds,
    this.subnetIds,
  });
  factory NetworkConfiguration.fromJson(Map<String, dynamic> json) {
    return NetworkConfiguration(
      securityGroupIds: (json['SecurityGroupIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      subnetIds: (json['SubnetIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final securityGroupIds = this.securityGroupIds;
    final subnetIds = this.subnetIds;
    return {
      if (securityGroupIds != null) 'SecurityGroupIds': securityGroupIds,
      if (subnetIds != null) 'SubnetIds': subnetIds,
    };
  }
}

class PublishMetricsOutput {
  PublishMetricsOutput();
  factory PublishMetricsOutput.fromJson(Map<String, dynamic> _) {
    return PublishMetricsOutput();
  }
}

/// Internal only API.
class StatisticSet {
  /// Internal only API.
  final double? maximum;

  /// Internal only API.
  final double? minimum;

  /// Internal only API.
  final int? sampleCount;

  /// Internal only API.
  final double? sum;

  StatisticSet({
    this.maximum,
    this.minimum,
    this.sampleCount,
    this.sum,
  });
  Map<String, dynamic> toJson() {
    final maximum = this.maximum;
    final minimum = this.minimum;
    final sampleCount = this.sampleCount;
    final sum = this.sum;
    return {
      if (maximum != null) 'Maximum': maximum,
      if (minimum != null) 'Minimum': minimum,
      if (sampleCount != null) 'SampleCount': sampleCount,
      if (sum != null) 'Sum': sum,
    };
  }
}

class TagResourceOutput {
  TagResourceOutput();
  factory TagResourceOutput.fromJson(Map<String, dynamic> _) {
    return TagResourceOutput();
  }
}

/// Unit
enum Unit {
  seconds,
  microseconds,
  milliseconds,
  bytes,
  kilobytes,
  megabytes,
  gigabytes,
  terabytes,
  bits,
  kilobits,
  megabits,
  gigabits,
  terabits,
  percent,
  count,
  bytesSecond,
  kilobytesSecond,
  megabytesSecond,
  gigabytesSecond,
  terabytesSecond,
  bitsSecond,
  kilobitsSecond,
  megabitsSecond,
  gigabitsSecond,
  terabitsSecond,
  countSecond,
  none,
}

extension on Unit {
  String toValue() {
    switch (this) {
      case Unit.seconds:
        return 'Seconds';
      case Unit.microseconds:
        return 'Microseconds';
      case Unit.milliseconds:
        return 'Milliseconds';
      case Unit.bytes:
        return 'Bytes';
      case Unit.kilobytes:
        return 'Kilobytes';
      case Unit.megabytes:
        return 'Megabytes';
      case Unit.gigabytes:
        return 'Gigabytes';
      case Unit.terabytes:
        return 'Terabytes';
      case Unit.bits:
        return 'Bits';
      case Unit.kilobits:
        return 'Kilobits';
      case Unit.megabits:
        return 'Megabits';
      case Unit.gigabits:
        return 'Gigabits';
      case Unit.terabits:
        return 'Terabits';
      case Unit.percent:
        return 'Percent';
      case Unit.count:
        return 'Count';
      case Unit.bytesSecond:
        return 'Bytes/Second';
      case Unit.kilobytesSecond:
        return 'Kilobytes/Second';
      case Unit.megabytesSecond:
        return 'Megabytes/Second';
      case Unit.gigabytesSecond:
        return 'Gigabytes/Second';
      case Unit.terabytesSecond:
        return 'Terabytes/Second';
      case Unit.bitsSecond:
        return 'Bits/Second';
      case Unit.kilobitsSecond:
        return 'Kilobits/Second';
      case Unit.megabitsSecond:
        return 'Megabits/Second';
      case Unit.gigabitsSecond:
        return 'Gigabits/Second';
      case Unit.terabitsSecond:
        return 'Terabits/Second';
      case Unit.countSecond:
        return 'Count/Second';
      case Unit.none:
        return 'None';
    }
  }
}

extension on String {
  Unit toUnit() {
    switch (this) {
      case 'Seconds':
        return Unit.seconds;
      case 'Microseconds':
        return Unit.microseconds;
      case 'Milliseconds':
        return Unit.milliseconds;
      case 'Bytes':
        return Unit.bytes;
      case 'Kilobytes':
        return Unit.kilobytes;
      case 'Megabytes':
        return Unit.megabytes;
      case 'Gigabytes':
        return Unit.gigabytes;
      case 'Terabytes':
        return Unit.terabytes;
      case 'Bits':
        return Unit.bits;
      case 'Kilobits':
        return Unit.kilobits;
      case 'Megabits':
        return Unit.megabits;
      case 'Gigabits':
        return Unit.gigabits;
      case 'Terabits':
        return Unit.terabits;
      case 'Percent':
        return Unit.percent;
      case 'Count':
        return Unit.count;
      case 'Bytes/Second':
        return Unit.bytesSecond;
      case 'Kilobytes/Second':
        return Unit.kilobytesSecond;
      case 'Megabytes/Second':
        return Unit.megabytesSecond;
      case 'Gigabytes/Second':
        return Unit.gigabytesSecond;
      case 'Terabytes/Second':
        return Unit.terabytesSecond;
      case 'Bits/Second':
        return Unit.bitsSecond;
      case 'Kilobits/Second':
        return Unit.kilobitsSecond;
      case 'Megabits/Second':
        return Unit.megabitsSecond;
      case 'Gigabits/Second':
        return Unit.gigabitsSecond;
      case 'Terabits/Second':
        return Unit.terabitsSecond;
      case 'Count/Second':
        return Unit.countSecond;
      case 'None':
        return Unit.none;
    }
    throw Exception('$this is not known in enum Unit');
  }
}

class UntagResourceOutput {
  UntagResourceOutput();
  factory UntagResourceOutput.fromJson(Map<String, dynamic> _) {
    return UntagResourceOutput();
  }
}

class UpdateEnvironmentOutput {
  /// The ARN to update of your Amazon MWAA environment.
  final String? arn;

  UpdateEnvironmentOutput({
    this.arn,
  });
  factory UpdateEnvironmentOutput.fromJson(Map<String, dynamic> json) {
    return UpdateEnvironmentOutput(
      arn: json['Arn'] as String?,
    );
  }
}

/// Error information of update, if applicable.
class UpdateError {
  /// Error code of update.
  final String? errorCode;

  /// Error message of update.
  final String? errorMessage;

  UpdateError({
    this.errorCode,
    this.errorMessage,
  });
  factory UpdateError.fromJson(Map<String, dynamic> json) {
    return UpdateError(
      errorCode: json['ErrorCode'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
    );
  }
}

/// Provide the security group and subnet IDs for the workers and scheduler.
class UpdateNetworkConfigurationInput {
  /// Provide a JSON list of 1 or more security groups IDs by name, in the same
  /// VPC as the subnets.
  final List<String> securityGroupIds;

  UpdateNetworkConfigurationInput({
    required this.securityGroupIds,
  });
  Map<String, dynamic> toJson() {
    final securityGroupIds = this.securityGroupIds;
    return {
      'SecurityGroupIds': securityGroupIds,
    };
  }
}

enum UpdateStatus {
  success,
  pending,
  failed,
}

extension on UpdateStatus {
  String toValue() {
    switch (this) {
      case UpdateStatus.success:
        return 'SUCCESS';
      case UpdateStatus.pending:
        return 'PENDING';
      case UpdateStatus.failed:
        return 'FAILED';
    }
  }
}

extension on String {
  UpdateStatus toUpdateStatus() {
    switch (this) {
      case 'SUCCESS':
        return UpdateStatus.success;
      case 'PENDING':
        return UpdateStatus.pending;
      case 'FAILED':
        return UpdateStatus.failed;
    }
    throw Exception('$this is not known in enum UpdateStatus');
  }
}

enum WebserverAccessMode {
  privateOnly,
  publicOnly,
}

extension on WebserverAccessMode {
  String toValue() {
    switch (this) {
      case WebserverAccessMode.privateOnly:
        return 'PRIVATE_ONLY';
      case WebserverAccessMode.publicOnly:
        return 'PUBLIC_ONLY';
    }
  }
}

extension on String {
  WebserverAccessMode toWebserverAccessMode() {
    switch (this) {
      case 'PRIVATE_ONLY':
        return WebserverAccessMode.privateOnly;
      case 'PUBLIC_ONLY':
        return WebserverAccessMode.publicOnly;
    }
    throw Exception('$this is not known in enum WebserverAccessMode');
  }
}

class AccessDeniedException extends _s.GenericAwsException {
  AccessDeniedException({String? type, String? message})
      : super(type: type, code: 'AccessDeniedException', message: message);
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
  'AccessDeniedException': (type, message) =>
      AccessDeniedException(type: type, message: message),
  'InternalServerException': (type, message) =>
      InternalServerException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ValidationException': (type, message) =>
      ValidationException(type: type, message: message),
};
