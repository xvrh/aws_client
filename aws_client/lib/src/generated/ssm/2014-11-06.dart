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

/// AWS Systems Manager is a collection of capabilities that helps you automate
/// management tasks such as collecting system inventory, applying operating
/// system (OS) patches, automating the creation of Amazon Machine Images
/// (AMIs), and configuring operating systems (OSs) and applications at scale.
/// Systems Manager lets you remotely and securely manage the configuration of
/// your managed instances. A <i>managed instance</i> is any Amazon Elastic
/// Compute Cloud instance (EC2 instance), or any on-premises server or virtual
/// machine (VM) in your hybrid environment that has been configured for Systems
/// Manager.
class Ssm {
  final _s.JsonProtocol _protocol;
  Ssm({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'ssm',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  /// Adds or overwrites one or more tags for the specified resource. Tags are
  /// metadata that you can assign to your documents, managed instances,
  /// maintenance windows, Parameter Store parameters, and patch baselines. Tags
  /// enable you to categorize your resources in different ways, for example, by
  /// purpose, owner, or environment. Each tag consists of a key and an optional
  /// value, both of which you define. For example, you could define a set of
  /// tags for your account's managed instances that helps you track each
  /// instance's owner and stack level. For example: Key=Owner and
  /// Value=DbAdmin, SysAdmin, or Dev. Or Key=Stack and Value=Production,
  /// Pre-Production, or Test.
  ///
  /// Each resource can have a maximum of 50 tags.
  ///
  /// We recommend that you devise a set of tag keys that meets your needs for
  /// each resource type. Using a consistent set of tag keys makes it easier for
  /// you to manage your resources. You can search and filter the resources
  /// based on the tags you add. Tags don't have any semantic meaning to and are
  /// interpreted strictly as a string of characters.
  ///
  /// For more information about using tags with EC2 instances, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html">Tagging
  /// your Amazon EC2 resources</a> in the <i>Amazon EC2 User Guide</i>.
  ///
  /// May throw [InvalidResourceType].
  /// May throw [InvalidResourceId].
  /// May throw [InternalServerError].
  /// May throw [TooManyTagsError].
  /// May throw [TooManyUpdates].
  ///
  /// Parameter [resourceId] :
  /// The resource ID you want to tag.
  ///
  /// Use the ID of the resource. Here are some examples:
  ///
  /// ManagedInstance: mi-012345abcde
  ///
  /// MaintenanceWindow: mw-012345abcde
  ///
  /// PatchBaseline: pb-012345abcde
  ///
  /// For the Document and Parameter values, use the name of the resource.
  /// <note>
  /// The ManagedInstance type for this API action is only for on-premises
  /// managed instances. You must specify the name of the managed instance in
  /// the following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.
  /// </note>
  ///
  /// Parameter [resourceType] :
  /// Specifies the type of resource you are tagging.
  /// <note>
  /// The ManagedInstance type for this API action is for on-premises managed
  /// instances. You must specify the name of the managed instance in the
  /// following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.
  /// </note>
  ///
  /// Parameter [tags] :
  /// One or more tags. The value parameter is required, but if you don't want
  /// the tag to have a value, specify the parameter with no value, and we set
  /// the value to an empty string.
  /// <important>
  /// Do not enter personally identifiable information in this field.
  /// </important>
  Future<void> addTagsToResource({
    required String resourceId,
    required ResourceTypeForTagging resourceType,
    required List<Tag> tags,
  }) async {
    ArgumentError.checkNotNull(resourceId, 'resourceId');
    ArgumentError.checkNotNull(resourceType, 'resourceType');
    ArgumentError.checkNotNull(tags, 'tags');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.AddTagsToResource'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceId': resourceId,
        'ResourceType': resourceType.toValue(),
        'Tags': tags,
      },
    );
  }

  /// Attempts to cancel the command specified by the Command ID. There is no
  /// guarantee that the command will be terminated and the underlying process
  /// stopped.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidCommandId].
  /// May throw [InvalidInstanceId].
  /// May throw [DuplicateInstanceId].
  ///
  /// Parameter [commandId] :
  /// The ID of the command you want to cancel.
  ///
  /// Parameter [instanceIds] :
  /// (Optional) A list of instance IDs on which you want to cancel the command.
  /// If not provided, the command is canceled on every instance on which it was
  /// requested.
  Future<void> cancelCommand({
    required String commandId,
    List<String>? instanceIds,
  }) async {
    ArgumentError.checkNotNull(commandId, 'commandId');
    _s.validateStringLength(
      'commandId',
      commandId,
      36,
      36,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CancelCommand'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'CommandId': commandId,
        if (instanceIds != null) 'InstanceIds': instanceIds,
      },
    );
  }

  /// Stops a maintenance window execution that is already in progress and
  /// cancels any tasks in the window that have not already starting running.
  /// (Tasks already in progress will continue to completion.)
  ///
  /// May throw [InternalServerError].
  /// May throw [DoesNotExistException].
  ///
  /// Parameter [windowExecutionId] :
  /// The ID of the maintenance window execution to stop.
  Future<CancelMaintenanceWindowExecutionResult>
      cancelMaintenanceWindowExecution({
    required String windowExecutionId,
  }) async {
    ArgumentError.checkNotNull(windowExecutionId, 'windowExecutionId');
    _s.validateStringLength(
      'windowExecutionId',
      windowExecutionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowExecutionId',
      windowExecutionId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CancelMaintenanceWindowExecution'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowExecutionId': windowExecutionId,
      },
    );

    return CancelMaintenanceWindowExecutionResult.fromJson(jsonResponse.body);
  }

  /// Generates an activation code and activation ID you can use to register
  /// your on-premises server or virtual machine (VM) with Systems Manager.
  /// Registering these machines with Systems Manager makes it possible to
  /// manage them using Systems Manager capabilities. You use the activation
  /// code and ID when installing SSM Agent on machines in your hybrid
  /// environment. For more information about requirements for managing
  /// on-premises instances and VMs using Systems Manager, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-managedinstances.html">Setting
  /// up AWS Systems Manager for hybrid environments</a> in the <i>AWS Systems
  /// Manager User Guide</i>.
  /// <note>
  /// On-premises servers or VMs that are registered with Systems Manager and
  /// EC2 instances that you manage with Systems Manager are all called
  /// <i>managed instances</i>.
  /// </note>
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [iamRole] :
  /// The Amazon Identity and Access Management (IAM) role that you want to
  /// assign to the managed instance. This IAM role must provide AssumeRole
  /// permissions for the Systems Manager service principal
  /// <code>ssm.amazonaws.com</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-service-role.html">Create
  /// an IAM service role for a hybrid environment</a> in the <i>AWS Systems
  /// Manager User Guide</i>.
  ///
  /// Parameter [defaultInstanceName] :
  /// The name of the registered, managed instance as it will appear in the
  /// Systems Manager console or when you use the AWS command line tools to list
  /// Systems Manager resources.
  /// <important>
  /// Do not enter personally identifiable information in this field.
  /// </important>
  ///
  /// Parameter [description] :
  /// A user-defined description of the resource that you want to register with
  /// Systems Manager.
  /// <important>
  /// Do not enter personally identifiable information in this field.
  /// </important>
  ///
  /// Parameter [expirationDate] :
  /// The date by which this activation request should expire. The default value
  /// is 24 hours.
  ///
  /// Parameter [registrationLimit] :
  /// Specify the maximum number of managed instances you want to register. The
  /// default value is 1 instance.
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. Tags enable you to
  /// categorize a resource in different ways, such as by purpose, owner, or
  /// environment. For example, you might want to tag an activation to identify
  /// which servers or virtual machines (VMs) in your on-premises environment
  /// you intend to activate. In this case, you could specify the following key
  /// name/value pairs:
  ///
  /// <ul>
  /// <li>
  /// <code>Key=OS,Value=Windows</code>
  /// </li>
  /// <li>
  /// <code>Key=Environment,Value=Production</code>
  /// </li>
  /// </ul> <important>
  /// When you install SSM Agent on your on-premises servers and VMs, you
  /// specify an activation ID and code. When you specify the activation ID and
  /// code, tags assigned to the activation are automatically applied to the
  /// on-premises servers or VMs.
  /// </important>
  /// You can't add tags to or delete tags from an existing activation. You can
  /// tag your on-premises servers and VMs after they connect to Systems Manager
  /// for the first time and are assigned a managed instance ID. This means they
  /// are listed in the AWS Systems Manager console with an ID that is prefixed
  /// with "mi-". For information about how to add tags to your managed
  /// instances, see <a>AddTagsToResource</a>. For information about how to
  /// remove tags from your managed instances, see
  /// <a>RemoveTagsFromResource</a>.
  Future<CreateActivationResult> createActivation({
    required String iamRole,
    String? defaultInstanceName,
    String? description,
    DateTime? expirationDate,
    int? registrationLimit,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(iamRole, 'iamRole');
    _s.validateStringLength(
      'iamRole',
      iamRole,
      0,
      64,
      isRequired: true,
    );
    _s.validateStringLength(
      'defaultInstanceName',
      defaultInstanceName,
      0,
      256,
    );
    _s.validateStringPattern(
      'defaultInstanceName',
      defaultInstanceName,
      r'''^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$''',
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      256,
    );
    _s.validateNumRange(
      'registrationLimit',
      registrationLimit,
      1,
      1000,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateActivation'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'IamRole': iamRole,
        if (defaultInstanceName != null)
          'DefaultInstanceName': defaultInstanceName,
        if (description != null) 'Description': description,
        if (expirationDate != null)
          'ExpirationDate': unixTimestampToJson(expirationDate),
        if (registrationLimit != null) 'RegistrationLimit': registrationLimit,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateActivationResult.fromJson(jsonResponse.body);
  }

  /// A State Manager association defines the state that you want to maintain on
  /// your instances. For example, an association can specify that anti-virus
  /// software must be installed and running on your instances, or that certain
  /// ports must be closed. For static targets, the association specifies a
  /// schedule for when the configuration is reapplied. For dynamic targets,
  /// such as an AWS Resource Group or an AWS Autoscaling Group, State Manager
  /// applies the configuration when new instances are added to the group. The
  /// association also specifies actions to take when applying the
  /// configuration. For example, an association for anti-virus software might
  /// run once a day. If the software is not installed, then State Manager
  /// installs it. If the software is installed, but the service is not running,
  /// then the association might instruct State Manager to start the service.
  ///
  /// May throw [AssociationAlreadyExists].
  /// May throw [AssociationLimitExceeded].
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentVersion].
  /// May throw [InvalidInstanceId].
  /// May throw [UnsupportedPlatformType].
  /// May throw [InvalidOutputLocation].
  /// May throw [InvalidParameters].
  /// May throw [InvalidTarget].
  /// May throw [InvalidSchedule].
  ///
  /// Parameter [name] :
  /// The name of the SSM document that contains the configuration information
  /// for the instance. You can specify Command or Automation documents.
  ///
  /// You can specify AWS-predefined documents, documents you created, or a
  /// document that is shared with you from another account.
  ///
  /// For SSM documents that are shared with you from other AWS accounts, you
  /// must specify the complete SSM document ARN, in the following format:
  ///
  /// <code>arn:<i>partition</i>:ssm:<i>region</i>:<i>account-id</i>:document/<i>document-name</i>
  /// </code>
  ///
  /// For example:
  ///
  /// <code>arn:aws:ssm:us-east-2:12345678912:document/My-Shared-Document</code>
  ///
  /// For AWS-predefined documents and SSM documents you created in your
  /// account, you only need to specify the document name. For example,
  /// <code>AWS-ApplyPatchBaseline</code> or <code>My-Document</code>.
  ///
  /// Parameter [applyOnlyAtCronInterval] :
  /// By default, when you create a new associations, the system runs it
  /// immediately after it is created and then according to the schedule you
  /// specified. Specify this option if you don't want an association to run
  /// immediately after you create it. This parameter is not supported for rate
  /// expressions.
  ///
  /// Parameter [associationName] :
  /// Specify a descriptive name for the association.
  ///
  /// Parameter [automationTargetParameterName] :
  /// Specify the target for the association. This target is required for
  /// associations that use an Automation document and target resources by using
  /// rate controls.
  ///
  /// Parameter [complianceSeverity] :
  /// The severity level to assign to the association.
  ///
  /// Parameter [documentVersion] :
  /// The document version you want to associate with the target(s). Can be a
  /// specific version or the default version.
  ///
  /// Parameter [instanceId] :
  /// The instance ID.
  /// <note>
  /// <code>InstanceId</code> has been deprecated. To specify an instance ID for
  /// an association, use the <code>Targets</code> parameter. Requests that
  /// include the parameter <code>InstanceID</code> with SSM documents that use
  /// schema version 2.0 or later will fail. In addition, if you use the
  /// parameter <code>InstanceId</code>, you cannot use the parameters
  /// <code>AssociationName</code>, <code>DocumentVersion</code>,
  /// <code>MaxErrors</code>, <code>MaxConcurrency</code>,
  /// <code>OutputLocation</code>, or <code>ScheduleExpression</code>. To use
  /// these parameters, you must use the <code>Targets</code> parameter.
  /// </note>
  ///
  /// Parameter [maxConcurrency] :
  /// The maximum number of targets allowed to run the association at the same
  /// time. You can specify a number, for example 10, or a percentage of the
  /// target set, for example 10%. The default value is 100%, which means all
  /// targets run the association at the same time.
  ///
  /// If a new instance starts and attempts to run an association while Systems
  /// Manager is running MaxConcurrency associations, the association is allowed
  /// to run. During the next association interval, the new instance will
  /// process its association within the limit specified for MaxConcurrency.
  ///
  /// Parameter [maxErrors] :
  /// The number of errors that are allowed before the system stops sending
  /// requests to run the association on additional targets. You can specify
  /// either an absolute number of errors, for example 10, or a percentage of
  /// the target set, for example 10%. If you specify 3, for example, the system
  /// stops sending requests when the fourth error is received. If you specify
  /// 0, then the system stops sending requests after the first error is
  /// returned. If you run an association on 50 instances and set MaxError to
  /// 10%, then the system stops sending the request when the sixth error is
  /// received.
  ///
  /// Executions that are already running an association when MaxErrors is
  /// reached are allowed to complete, but some of these executions may fail as
  /// well. If you need to ensure that there won't be more than max-errors
  /// failed executions, set MaxConcurrency to 1 so that executions proceed one
  /// at a time.
  ///
  /// Parameter [outputLocation] :
  /// An S3 bucket where you want to store the output details of the request.
  ///
  /// Parameter [parameters] :
  /// The parameters for the runtime configuration of the document.
  ///
  /// Parameter [scheduleExpression] :
  /// A cron expression when the association will be applied to the target(s).
  ///
  /// Parameter [syncCompliance] :
  /// The mode for generating association compliance. You can specify
  /// <code>AUTO</code> or <code>MANUAL</code>. In <code>AUTO</code> mode, the
  /// system uses the status of the association execution to determine the
  /// compliance status. If the association execution runs successfully, then
  /// the association is <code>COMPLIANT</code>. If the association execution
  /// doesn't run successfully, the association is <code>NON-COMPLIANT</code>.
  ///
  /// In <code>MANUAL</code> mode, you must specify the
  /// <code>AssociationId</code> as a parameter for the
  /// <a>PutComplianceItems</a> API action. In this case, compliance data is not
  /// managed by State Manager. It is managed by your direct call to the
  /// <a>PutComplianceItems</a> API action.
  ///
  /// By default, all associations use <code>AUTO</code> mode.
  ///
  /// Parameter [targetLocations] :
  /// A location is a combination of AWS Regions and AWS accounts where you want
  /// to run the association. Use this action to create an association in
  /// multiple Regions and multiple accounts.
  ///
  /// Parameter [targets] :
  /// The targets for the association. You can target instances by using tags,
  /// AWS Resource Groups, all instances in an AWS account, or individual
  /// instance IDs. For more information about choosing targets for an
  /// association, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-state-manager-targets-and-rate-controls.html">Using
  /// targets and rate controls with State Manager associations</a> in the
  /// <i>AWS Systems Manager User Guide</i>.
  Future<CreateAssociationResult> createAssociation({
    required String name,
    bool? applyOnlyAtCronInterval,
    String? associationName,
    String? automationTargetParameterName,
    AssociationComplianceSeverity? complianceSeverity,
    String? documentVersion,
    String? instanceId,
    String? maxConcurrency,
    String? maxErrors,
    InstanceAssociationOutputLocation? outputLocation,
    Map<String, List<String>>? parameters,
    String? scheduleExpression,
    AssociationSyncCompliance? syncCompliance,
    List<TargetLocation>? targetLocations,
    List<Target>? targets,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'associationName',
      associationName,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    _s.validateStringLength(
      'automationTargetParameterName',
      automationTargetParameterName,
      1,
      50,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
    );
    _s.validateStringLength(
      'maxConcurrency',
      maxConcurrency,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxConcurrency',
      maxConcurrency,
      r'''^([1-9][0-9]*|[1-9][0-9]%|[1-9]%|100%)$''',
    );
    _s.validateStringLength(
      'maxErrors',
      maxErrors,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxErrors',
      maxErrors,
      r'''^([1-9][0-9]*|[0]|[1-9][0-9]%|[0-9]%|100%)$''',
    );
    _s.validateStringLength(
      'scheduleExpression',
      scheduleExpression,
      1,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateAssociation'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (applyOnlyAtCronInterval != null)
          'ApplyOnlyAtCronInterval': applyOnlyAtCronInterval,
        if (associationName != null) 'AssociationName': associationName,
        if (automationTargetParameterName != null)
          'AutomationTargetParameterName': automationTargetParameterName,
        if (complianceSeverity != null)
          'ComplianceSeverity': complianceSeverity.toValue(),
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (instanceId != null) 'InstanceId': instanceId,
        if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
        if (maxErrors != null) 'MaxErrors': maxErrors,
        if (outputLocation != null) 'OutputLocation': outputLocation,
        if (parameters != null) 'Parameters': parameters,
        if (scheduleExpression != null)
          'ScheduleExpression': scheduleExpression,
        if (syncCompliance != null) 'SyncCompliance': syncCompliance.toValue(),
        if (targetLocations != null) 'TargetLocations': targetLocations,
        if (targets != null) 'Targets': targets,
      },
    );

    return CreateAssociationResult.fromJson(jsonResponse.body);
  }

  /// Associates the specified Systems Manager document with the specified
  /// instances or targets.
  ///
  /// When you associate a document with one or more instances using instance
  /// IDs or tags, SSM Agent running on the instance processes the document and
  /// configures the instance as specified.
  ///
  /// If you associate a document with an instance that already has an
  /// associated document, the system returns the AssociationAlreadyExists
  /// exception.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentVersion].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidParameters].
  /// May throw [DuplicateInstanceId].
  /// May throw [AssociationLimitExceeded].
  /// May throw [UnsupportedPlatformType].
  /// May throw [InvalidOutputLocation].
  /// May throw [InvalidTarget].
  /// May throw [InvalidSchedule].
  ///
  /// Parameter [entries] :
  /// One or more associations.
  Future<CreateAssociationBatchResult> createAssociationBatch({
    required List<CreateAssociationBatchRequestEntry> entries,
  }) async {
    ArgumentError.checkNotNull(entries, 'entries');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateAssociationBatch'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Entries': entries,
      },
    );

    return CreateAssociationBatchResult.fromJson(jsonResponse.body);
  }

  /// Creates a Systems Manager (SSM) document. An SSM document defines the
  /// actions that Systems Manager performs on your managed instances. For more
  /// information about SSM documents, including information about supported
  /// schemas, features, and syntax, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-ssm-docs.html">AWS
  /// Systems Manager Documents</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// May throw [DocumentAlreadyExists].
  /// May throw [MaxDocumentSizeExceeded].
  /// May throw [InternalServerError].
  /// May throw [InvalidDocumentContent].
  /// May throw [DocumentLimitExceeded].
  /// May throw [InvalidDocumentSchemaVersion].
  ///
  /// Parameter [content] :
  /// The content for the new SSM document in JSON or YAML format. We recommend
  /// storing the contents for your new document in an external JSON or YAML
  /// file and referencing the file in a command.
  ///
  /// For examples, see the following topics in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// <ul>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-document-api.html">Create
  /// an SSM document (AWS API)</a>
  /// </li>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-document-cli.html">Create
  /// an SSM document (AWS CLI)</a>
  /// </li>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/create-ssm-document-api.html">Create
  /// an SSM document (API)</a>
  /// </li>
  /// </ul>
  ///
  /// Parameter [name] :
  /// A name for the Systems Manager document.
  /// <important>
  /// You can't use the following strings as document name prefixes. These are
  /// reserved by AWS for use as document name prefixes:
  ///
  /// <ul>
  /// <li>
  /// <code>aws-</code>
  /// </li>
  /// <li>
  /// <code>amazon</code>
  /// </li>
  /// <li>
  /// <code>amzn</code>
  /// </li>
  /// </ul> </important>
  ///
  /// Parameter [attachments] :
  /// A list of key and value pairs that describe attachments to a version of a
  /// document.
  ///
  /// Parameter [documentFormat] :
  /// Specify the document format for the request. The document format can be
  /// JSON, YAML, or TEXT. JSON is the default format.
  ///
  /// Parameter [documentType] :
  /// The type of document to create.
  ///
  /// Parameter [requires] :
  /// A list of SSM documents required by a document. This parameter is used
  /// exclusively by AWS AppConfig. When a user creates an AppConfig
  /// configuration in an SSM document, the user must also specify a required
  /// document for validation purposes. In this case, an
  /// <code>ApplicationConfiguration</code> document requires an
  /// <code>ApplicationConfigurationSchema</code> document for validation
  /// purposes. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/appconfig.html">AWS
  /// AppConfig</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. Tags enable you to
  /// categorize a resource in different ways, such as by purpose, owner, or
  /// environment. For example, you might want to tag an SSM document to
  /// identify the types of targets or the environment where it will run. In
  /// this case, you could specify the following key name/value pairs:
  ///
  /// <ul>
  /// <li>
  /// <code>Key=OS,Value=Windows</code>
  /// </li>
  /// <li>
  /// <code>Key=Environment,Value=Production</code>
  /// </li>
  /// </ul> <note>
  /// To add tags to an existing SSM document, use the <a>AddTagsToResource</a>
  /// action.
  /// </note>
  ///
  /// Parameter [targetType] :
  /// Specify a target type to define the kinds of resources the document can
  /// run on. For example, to run a document on EC2 instances, specify the
  /// following value: /AWS::EC2::Instance. If you specify a value of '/' the
  /// document can run on all types of resources. If you don't specify a value,
  /// the document can't run on any resources. For a list of valid resource
  /// types, see <a
  /// href="http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html">AWS
  /// resource and property types reference</a> in the <i>AWS CloudFormation
  /// User Guide</i>.
  ///
  /// Parameter [versionName] :
  /// An optional field specifying the version of the artifact you are creating
  /// with the document. For example, "Release 12, Update 6". This value is
  /// unique across all versions of a document, and cannot be changed.
  Future<CreateDocumentResult> createDocument({
    required String content,
    required String name,
    List<AttachmentsSource>? attachments,
    DocumentFormat? documentFormat,
    DocumentType? documentType,
    List<DocumentRequires>? requires,
    List<Tag>? tags,
    String? targetType,
    String? versionName,
  }) async {
    ArgumentError.checkNotNull(content, 'content');
    _s.validateStringLength(
      'content',
      content,
      1,
      1152921504606846976,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'targetType',
      targetType,
      0,
      200,
    );
    _s.validateStringPattern(
      'targetType',
      targetType,
      r'''^\/[\w\.\-\:\/]*$''',
    );
    _s.validateStringPattern(
      'versionName',
      versionName,
      r'''^[a-zA-Z0-9_\-.]{1,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateDocument'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Content': content,
        'Name': name,
        if (attachments != null) 'Attachments': attachments,
        if (documentFormat != null) 'DocumentFormat': documentFormat.toValue(),
        if (documentType != null) 'DocumentType': documentType.toValue(),
        if (requires != null) 'Requires': requires,
        if (tags != null) 'Tags': tags,
        if (targetType != null) 'TargetType': targetType,
        if (versionName != null) 'VersionName': versionName,
      },
    );

    return CreateDocumentResult.fromJson(jsonResponse.body);
  }

  /// Creates a new maintenance window.
  /// <note>
  /// The value you specify for <code>Duration</code> determines the specific
  /// end time for the maintenance window based on the time it begins. No
  /// maintenance window tasks are permitted to start after the resulting
  /// endtime minus the number of hours you specify for <code>Cutoff</code>. For
  /// example, if the maintenance window starts at 3 PM, the duration is three
  /// hours, and the value you specify for <code>Cutoff</code> is one hour, no
  /// maintenance window tasks can start after 5 PM.
  /// </note>
  ///
  /// May throw [IdempotentParameterMismatch].
  /// May throw [ResourceLimitExceededException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [allowUnassociatedTargets] :
  /// Enables a maintenance window task to run on managed instances, even if you
  /// have not registered those instances as targets. If enabled, then you must
  /// specify the unregistered instances (by instance ID) when you register a
  /// task with the maintenance window.
  ///
  /// If you don't enable this option, then you must specify
  /// previously-registered targets when you register a task with the
  /// maintenance window.
  ///
  /// Parameter [cutoff] :
  /// The number of hours before the end of the maintenance window that Systems
  /// Manager stops scheduling new tasks for execution.
  ///
  /// Parameter [duration] :
  /// The duration of the maintenance window in hours.
  ///
  /// Parameter [name] :
  /// The name of the maintenance window.
  ///
  /// Parameter [schedule] :
  /// The schedule of the maintenance window in the form of a cron or rate
  /// expression.
  ///
  /// Parameter [clientToken] :
  /// User-provided idempotency token.
  ///
  /// Parameter [description] :
  /// An optional description for the maintenance window. We recommend
  /// specifying a description to help you organize your maintenance windows.
  ///
  /// Parameter [endDate] :
  /// The date and time, in ISO-8601 Extended format, for when you want the
  /// maintenance window to become inactive. EndDate allows you to set a date
  /// and time in the future when the maintenance window will no longer run.
  ///
  /// Parameter [scheduleOffset] :
  /// The number of days to wait after the date and time specified by a CRON
  /// expression before running the maintenance window.
  ///
  /// For example, the following cron expression schedules a maintenance window
  /// to run on the third Tuesday of every month at 11:30 PM.
  ///
  /// <code>cron(30 23 ? * TUE#3 *)</code>
  ///
  /// If the schedule offset is <code>2</code>, the maintenance window won't run
  /// until two days later.
  ///
  /// Parameter [scheduleTimezone] :
  /// The time zone that the scheduled maintenance window executions are based
  /// on, in Internet Assigned Numbers Authority (IANA) format. For example:
  /// "America/Los_Angeles", "UTC", or "Asia/Seoul". For more information, see
  /// the <a href="https://www.iana.org/time-zones">Time Zone Database</a> on
  /// the IANA website.
  ///
  /// Parameter [startDate] :
  /// The date and time, in ISO-8601 Extended format, for when you want the
  /// maintenance window to become active. StartDate allows you to delay
  /// activation of the maintenance window until the specified future date.
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. Tags enable you to
  /// categorize a resource in different ways, such as by purpose, owner, or
  /// environment. For example, you might want to tag a maintenance window to
  /// identify the type of tasks it will run, the types of targets, and the
  /// environment it will run in. In this case, you could specify the following
  /// key name/value pairs:
  ///
  /// <ul>
  /// <li>
  /// <code>Key=TaskType,Value=AgentUpdate</code>
  /// </li>
  /// <li>
  /// <code>Key=OS,Value=Windows</code>
  /// </li>
  /// <li>
  /// <code>Key=Environment,Value=Production</code>
  /// </li>
  /// </ul> <note>
  /// To add tags to an existing maintenance window, use the
  /// <a>AddTagsToResource</a> action.
  /// </note>
  Future<CreateMaintenanceWindowResult> createMaintenanceWindow({
    required bool allowUnassociatedTargets,
    required int cutoff,
    required int duration,
    required String name,
    required String schedule,
    String? clientToken,
    String? description,
    String? endDate,
    int? scheduleOffset,
    String? scheduleTimezone,
    String? startDate,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(
        allowUnassociatedTargets, 'allowUnassociatedTargets');
    ArgumentError.checkNotNull(cutoff, 'cutoff');
    _s.validateNumRange(
      'cutoff',
      cutoff,
      0,
      23,
      isRequired: true,
    );
    ArgumentError.checkNotNull(duration, 'duration');
    _s.validateNumRange(
      'duration',
      duration,
      1,
      24,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(schedule, 'schedule');
    _s.validateStringLength(
      'schedule',
      schedule,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientToken',
      clientToken,
      1,
      64,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      128,
    );
    _s.validateNumRange(
      'scheduleOffset',
      scheduleOffset,
      1,
      6,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AllowUnassociatedTargets': allowUnassociatedTargets,
        'Cutoff': cutoff,
        'Duration': duration,
        'Name': name,
        'Schedule': schedule,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (description != null) 'Description': description,
        if (endDate != null) 'EndDate': endDate,
        if (scheduleOffset != null) 'ScheduleOffset': scheduleOffset,
        if (scheduleTimezone != null) 'ScheduleTimezone': scheduleTimezone,
        if (startDate != null) 'StartDate': startDate,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateMaintenanceWindowResult.fromJson(jsonResponse.body);
  }

  /// Creates a new OpsItem. You must have permission in AWS Identity and Access
  /// Management (IAM) to create a new OpsItem. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html">Getting
  /// started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Operations engineers and IT professionals use OpsCenter to view,
  /// investigate, and remediate operational issues impacting the performance
  /// and health of their AWS resources. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html">AWS
  /// Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// May throw [InternalServerError].
  /// May throw [OpsItemAlreadyExistsException].
  /// May throw [OpsItemLimitExceededException].
  /// May throw [OpsItemInvalidParameterException].
  ///
  /// Parameter [description] :
  /// Information about the OpsItem.
  ///
  /// Parameter [source] :
  /// The origin of the OpsItem, such as Amazon EC2 or Systems Manager.
  /// <note>
  /// The source name can't contain the following strings: aws, amazon, and
  /// amzn.
  /// </note>
  ///
  /// Parameter [title] :
  /// A short heading that describes the nature of the OpsItem and the impacted
  /// resource.
  ///
  /// Parameter [actualEndTime] :
  /// The time a runbook workflow ended. Currently reported only for the OpsItem
  /// type <code>/aws/changerequest</code>.
  ///
  /// Parameter [actualStartTime] :
  /// The time a runbook workflow started. Currently reported only for the
  /// OpsItem type <code>/aws/changerequest</code>.
  ///
  /// Parameter [category] :
  /// Specify a category to assign to an OpsItem.
  ///
  /// Parameter [notifications] :
  /// The Amazon Resource Name (ARN) of an SNS topic where notifications are
  /// sent when this OpsItem is edited or changed.
  ///
  /// Parameter [operationalData] :
  /// Operational data is custom data that provides useful reference details
  /// about the OpsItem. For example, you can specify log files, error strings,
  /// license keys, troubleshooting tips, or other relevant data. You enter
  /// operational data as key-value pairs. The key has a maximum length of 128
  /// characters. The value has a maximum size of 20 KB.
  /// <important>
  /// Operational data keys <i>can't</i> begin with the following: amazon, aws,
  /// amzn, ssm, /amazon, /aws, /amzn, /ssm.
  /// </important>
  /// You can choose to make the data searchable by other users in the account
  /// or you can restrict search access. Searchable data means that all users
  /// with access to the OpsItem Overview page (as provided by the
  /// <a>DescribeOpsItems</a> API action) can view and search on the specified
  /// data. Operational data that is not searchable is only viewable by users
  /// who have access to the OpsItem (as provided by the <a>GetOpsItem</a> API
  /// action).
  ///
  /// Use the <code>/aws/resources</code> key in OperationalData to specify a
  /// related resource in the request. Use the <code>/aws/automations</code> key
  /// in OperationalData to associate an Automation runbook with the OpsItem. To
  /// view AWS CLI example commands that use these keys, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-creating-OpsItems.html#OpsCenter-manually-create-OpsItems">Creating
  /// OpsItems manually</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [opsItemType] :
  /// The type of OpsItem to create. Currently, the only valid values are
  /// <code>/aws/changerequest</code> and <code>/aws/issue</code>.
  ///
  /// Parameter [plannedEndTime] :
  /// The time specified in a change request for a runbook workflow to end.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  ///
  /// Parameter [plannedStartTime] :
  /// The time specified in a change request for a runbook workflow to start.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  ///
  /// Parameter [priority] :
  /// The importance of this OpsItem in relation to other OpsItems in the
  /// system.
  ///
  /// Parameter [relatedOpsItems] :
  /// One or more OpsItems that share something in common with the current
  /// OpsItems. For example, related OpsItems can include OpsItems with similar
  /// error messages, impacted resources, or statuses for the impacted resource.
  ///
  /// Parameter [severity] :
  /// Specify a severity to assign to an OpsItem.
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. You can restrict access
  /// to OpsItems by using an inline IAM policy that specifies tags. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html#OpsCenter-getting-started-user-permissions">Getting
  /// started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Tags use a key-value pair. For example:
  ///
  /// <code>Key=Department,Value=Finance</code>
  /// <note>
  /// To add tags to an existing OpsItem, use the <a>AddTagsToResource</a>
  /// action.
  /// </note>
  Future<CreateOpsItemResponse> createOpsItem({
    required String description,
    required String source,
    required String title,
    DateTime? actualEndTime,
    DateTime? actualStartTime,
    String? category,
    List<OpsItemNotification>? notifications,
    Map<String, OpsItemDataValue>? operationalData,
    String? opsItemType,
    DateTime? plannedEndTime,
    DateTime? plannedStartTime,
    int? priority,
    List<RelatedOpsItem>? relatedOpsItems,
    String? severity,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(description, 'description');
    _s.validateStringLength(
      'description',
      description,
      1,
      1024,
      isRequired: true,
    );
    _s.validateStringPattern(
      'description',
      description,
      r'''[\s\S]*\S[\s\S]*''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(source, 'source');
    _s.validateStringLength(
      'source',
      source,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'source',
      source,
      r'''^(?!\s*$).+''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(title, 'title');
    _s.validateStringLength(
      'title',
      title,
      1,
      1024,
      isRequired: true,
    );
    _s.validateStringPattern(
      'title',
      title,
      r'''^(?!\s*$).+''',
      isRequired: true,
    );
    _s.validateStringLength(
      'category',
      category,
      1,
      64,
    );
    _s.validateStringPattern(
      'category',
      category,
      r'''^(?!\s*$).+''',
    );
    _s.validateNumRange(
      'priority',
      priority,
      1,
      5,
    );
    _s.validateStringLength(
      'severity',
      severity,
      1,
      64,
    );
    _s.validateStringPattern(
      'severity',
      severity,
      r'''^(?!\s*$).+''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateOpsItem'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Description': description,
        'Source': source,
        'Title': title,
        if (actualEndTime != null)
          'ActualEndTime': unixTimestampToJson(actualEndTime),
        if (actualStartTime != null)
          'ActualStartTime': unixTimestampToJson(actualStartTime),
        if (category != null) 'Category': category,
        if (notifications != null) 'Notifications': notifications,
        if (operationalData != null) 'OperationalData': operationalData,
        if (opsItemType != null) 'OpsItemType': opsItemType,
        if (plannedEndTime != null)
          'PlannedEndTime': unixTimestampToJson(plannedEndTime),
        if (plannedStartTime != null)
          'PlannedStartTime': unixTimestampToJson(plannedStartTime),
        if (priority != null) 'Priority': priority,
        if (relatedOpsItems != null) 'RelatedOpsItems': relatedOpsItems,
        if (severity != null) 'Severity': severity,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateOpsItemResponse.fromJson(jsonResponse.body);
  }

  /// If you create a new application in Application Manager, Systems Manager
  /// calls this API action to specify information about the new application,
  /// including the application type.
  ///
  /// May throw [OpsMetadataAlreadyExistsException].
  /// May throw [OpsMetadataTooManyUpdatesException].
  /// May throw [OpsMetadataInvalidArgumentException].
  /// May throw [OpsMetadataLimitExceededException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [resourceId] :
  /// A resource ID for a new Application Manager application.
  ///
  /// Parameter [metadata] :
  /// Metadata for a new Application Manager application.
  Future<CreateOpsMetadataResult> createOpsMetadata({
    required String resourceId,
    Map<String, MetadataValue>? metadata,
  }) async {
    ArgumentError.checkNotNull(resourceId, 'resourceId');
    _s.validateStringLength(
      'resourceId',
      resourceId,
      1,
      1024,
      isRequired: true,
    );
    _s.validateStringPattern(
      'resourceId',
      resourceId,
      r'''^(?!\s*$).+''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateOpsMetadata'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceId': resourceId,
        if (metadata != null) 'Metadata': metadata,
      },
    );

    return CreateOpsMetadataResult.fromJson(jsonResponse.body);
  }

  /// Creates a patch baseline.
  /// <note>
  /// For information about valid key and value pairs in
  /// <code>PatchFilters</code> for each supported operating system type, see <a
  /// href="http://docs.aws.amazon.com/systems-manager/latest/APIReference/API_PatchFilter.html">PatchFilter</a>.
  /// </note>
  ///
  /// May throw [IdempotentParameterMismatch].
  /// May throw [ResourceLimitExceededException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [name] :
  /// The name of the patch baseline.
  ///
  /// Parameter [approvalRules] :
  /// A set of rules used to include patches in the baseline.
  ///
  /// Parameter [approvedPatches] :
  /// A list of explicitly approved patches for the baseline.
  ///
  /// For information about accepted formats for lists of approved patches and
  /// rejected patches, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html">About
  /// package name formats for approved and rejected patch lists</a> in the
  /// <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [approvedPatchesComplianceLevel] :
  /// Defines the compliance level for approved patches. This means that if an
  /// approved patch is reported as missing, this is the severity of the
  /// compliance violation. The default value is UNSPECIFIED.
  ///
  /// Parameter [approvedPatchesEnableNonSecurity] :
  /// Indicates whether the list of approved patches includes non-security
  /// updates that should be applied to the instances. The default value is
  /// 'false'. Applies to Linux instances only.
  ///
  /// Parameter [clientToken] :
  /// User-provided idempotency token.
  ///
  /// Parameter [description] :
  /// A description of the patch baseline.
  ///
  /// Parameter [globalFilters] :
  /// A set of global filters used to include patches in the baseline.
  ///
  /// Parameter [operatingSystem] :
  /// Defines the operating system the patch baseline applies to. The Default
  /// value is WINDOWS.
  ///
  /// Parameter [rejectedPatches] :
  /// A list of explicitly rejected patches for the baseline.
  ///
  /// For information about accepted formats for lists of approved patches and
  /// rejected patches, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html">About
  /// package name formats for approved and rejected patch lists</a> in the
  /// <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [rejectedPatchesAction] :
  /// The action for Patch Manager to take on patches included in the
  /// RejectedPackages list.
  ///
  /// <ul>
  /// <li>
  /// <b>ALLOW_AS_DEPENDENCY</b>: A package in the Rejected patches list is
  /// installed only if it is a dependency of another package. It is considered
  /// compliant with the patch baseline, and its status is reported as
  /// <i>InstalledOther</i>. This is the default action if no option is
  /// specified.
  /// </li>
  /// <li>
  /// <b>BLOCK</b>: Packages in the RejectedPatches list, and packages that
  /// include them as dependencies, are not installed under any circumstances.
  /// If a package was installed before it was added to the Rejected patches
  /// list, it is considered non-compliant with the patch baseline, and its
  /// status is reported as <i>InstalledRejected</i>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [sources] :
  /// Information about the patches to use to update the instances, including
  /// target operating systems and source repositories. Applies to Linux
  /// instances only.
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. Tags enable you to
  /// categorize a resource in different ways, such as by purpose, owner, or
  /// environment. For example, you might want to tag a patch baseline to
  /// identify the severity level of patches it specifies and the operating
  /// system family it applies to. In this case, you could specify the following
  /// key name/value pairs:
  ///
  /// <ul>
  /// <li>
  /// <code>Key=PatchSeverity,Value=Critical</code>
  /// </li>
  /// <li>
  /// <code>Key=OS,Value=Windows</code>
  /// </li>
  /// </ul> <note>
  /// To add tags to an existing patch baseline, use the
  /// <a>AddTagsToResource</a> action.
  /// </note>
  Future<CreatePatchBaselineResult> createPatchBaseline({
    required String name,
    PatchRuleGroup? approvalRules,
    List<String>? approvedPatches,
    PatchComplianceLevel? approvedPatchesComplianceLevel,
    bool? approvedPatchesEnableNonSecurity,
    String? clientToken,
    String? description,
    PatchFilterGroup? globalFilters,
    OperatingSystem? operatingSystem,
    List<String>? rejectedPatches,
    PatchAction? rejectedPatchesAction,
    List<PatchSource>? sources,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'clientToken',
      clientToken,
      1,
      64,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      1024,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreatePatchBaseline'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (approvalRules != null) 'ApprovalRules': approvalRules,
        if (approvedPatches != null) 'ApprovedPatches': approvedPatches,
        if (approvedPatchesComplianceLevel != null)
          'ApprovedPatchesComplianceLevel':
              approvedPatchesComplianceLevel.toValue(),
        if (approvedPatchesEnableNonSecurity != null)
          'ApprovedPatchesEnableNonSecurity': approvedPatchesEnableNonSecurity,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (description != null) 'Description': description,
        if (globalFilters != null) 'GlobalFilters': globalFilters,
        if (operatingSystem != null)
          'OperatingSystem': operatingSystem.toValue(),
        if (rejectedPatches != null) 'RejectedPatches': rejectedPatches,
        if (rejectedPatchesAction != null)
          'RejectedPatchesAction': rejectedPatchesAction.toValue(),
        if (sources != null) 'Sources': sources,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreatePatchBaselineResult.fromJson(jsonResponse.body);
  }

  /// A resource data sync helps you view data from multiple sources in a single
  /// location. Systems Manager offers two types of resource data sync:
  /// <code>SyncToDestination</code> and <code>SyncFromSource</code>.
  ///
  /// You can configure Systems Manager Inventory to use the
  /// <code>SyncToDestination</code> type to synchronize Inventory data from
  /// multiple AWS Regions to a single S3 bucket. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-inventory-datasync.html">Configuring
  /// Resource Data Sync for Inventory</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// You can configure Systems Manager Explorer to use the
  /// <code>SyncFromSource</code> type to synchronize operational work items
  /// (OpsItems) and operational data (OpsData) from multiple AWS Regions to a
  /// single S3 bucket. This type can synchronize OpsItems and OpsData from
  /// multiple AWS accounts and Regions or <code>EntireOrganization</code> by
  /// using AWS Organizations. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/Explorer-resource-data-sync.html">Setting
  /// up Systems Manager Explorer to display data from multiple accounts and
  /// Regions</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// A resource data sync is an asynchronous operation that returns
  /// immediately. After a successful initial sync is completed, the system
  /// continuously syncs data. To check the status of a sync, use the
  /// <a>ListResourceDataSync</a>.
  /// <note>
  /// By default, data is not encrypted in Amazon S3. We strongly recommend that
  /// you enable encryption in Amazon S3 to ensure secure data storage. We also
  /// recommend that you secure access to the Amazon S3 bucket by creating a
  /// restrictive bucket policy.
  /// </note>
  ///
  /// May throw [InternalServerError].
  /// May throw [ResourceDataSyncCountExceededException].
  /// May throw [ResourceDataSyncAlreadyExistsException].
  /// May throw [ResourceDataSyncInvalidConfigurationException].
  ///
  /// Parameter [syncName] :
  /// A name for the configuration.
  ///
  /// Parameter [s3Destination] :
  /// Amazon S3 configuration details for the sync. This parameter is required
  /// if the <code>SyncType</code> value is SyncToDestination.
  ///
  /// Parameter [syncSource] :
  /// Specify information about the data sources to synchronize. This parameter
  /// is required if the <code>SyncType</code> value is SyncFromSource.
  ///
  /// Parameter [syncType] :
  /// Specify <code>SyncToDestination</code> to create a resource data sync that
  /// synchronizes data to an S3 bucket for Inventory. If you specify
  /// <code>SyncToDestination</code>, you must provide a value for
  /// <code>S3Destination</code>. Specify <code>SyncFromSource</code> to
  /// synchronize data from a single account and multiple Regions, or multiple
  /// AWS accounts and Regions, as listed in AWS Organizations for Explorer. If
  /// you specify <code>SyncFromSource</code>, you must provide a value for
  /// <code>SyncSource</code>. The default value is
  /// <code>SyncToDestination</code>.
  Future<void> createResourceDataSync({
    required String syncName,
    ResourceDataSyncS3Destination? s3Destination,
    ResourceDataSyncSource? syncSource,
    String? syncType,
  }) async {
    ArgumentError.checkNotNull(syncName, 'syncName');
    _s.validateStringLength(
      'syncName',
      syncName,
      1,
      64,
      isRequired: true,
    );
    _s.validateStringLength(
      'syncType',
      syncType,
      1,
      64,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.CreateResourceDataSync'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SyncName': syncName,
        if (s3Destination != null) 'S3Destination': s3Destination,
        if (syncSource != null) 'SyncSource': syncSource,
        if (syncType != null) 'SyncType': syncType,
      },
    );
  }

  /// Deletes an activation. You are not required to delete an activation. If
  /// you delete an activation, you can no longer use it to register additional
  /// managed instances. Deleting an activation does not de-register managed
  /// instances. You must manually de-register managed instances.
  ///
  /// May throw [InvalidActivationId].
  /// May throw [InvalidActivation].
  /// May throw [InternalServerError].
  /// May throw [TooManyUpdates].
  ///
  /// Parameter [activationId] :
  /// The ID of the activation that you want to delete.
  Future<void> deleteActivation({
    required String activationId,
  }) async {
    ArgumentError.checkNotNull(activationId, 'activationId');
    _s.validateStringPattern(
      'activationId',
      activationId,
      r'''^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteActivation'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ActivationId': activationId,
      },
    );
  }

  /// Disassociates the specified Systems Manager document from the specified
  /// instance.
  ///
  /// When you disassociate a document from an instance, it does not change the
  /// configuration of the instance. To change the configuration state of an
  /// instance after you disassociate a document, you must create a new document
  /// with the desired configuration and associate it with the instance.
  ///
  /// May throw [AssociationDoesNotExist].
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidInstanceId].
  /// May throw [TooManyUpdates].
  ///
  /// Parameter [associationId] :
  /// The association ID that you want to delete.
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance.
  ///
  /// Parameter [name] :
  /// The name of the Systems Manager document.
  Future<void> deleteAssociation({
    String? associationId,
    String? instanceId,
    String? name,
  }) async {
    _s.validateStringPattern(
      'associationId',
      associationId,
      r'''[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}''',
    );
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteAssociation'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (associationId != null) 'AssociationId': associationId,
        if (instanceId != null) 'InstanceId': instanceId,
        if (name != null) 'Name': name,
      },
    );
  }

  /// Deletes the Systems Manager document and all instance associations to the
  /// document.
  ///
  /// Before you delete the document, we recommend that you use
  /// <a>DeleteAssociation</a> to disassociate all instances that are associated
  /// with the document.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentOperation].
  /// May throw [AssociatedInstances].
  ///
  /// Parameter [name] :
  /// The name of the document.
  ///
  /// Parameter [documentVersion] :
  /// The version of the document that you want to delete. If not provided, all
  /// versions of the document are deleted.
  ///
  /// Parameter [force] :
  /// Some SSM document types require that you specify a <code>Force</code> flag
  /// before you can delete the document. For example, you must specify a
  /// <code>Force</code> flag to delete a document of type
  /// <code>ApplicationConfigurationSchema</code>. You can restrict access to
  /// the <code>Force</code> flag in an AWS Identity and Access Management (IAM)
  /// policy.
  ///
  /// Parameter [versionName] :
  /// The version name of the document that you want to delete. If not provided,
  /// all versions of the document are deleted.
  Future<void> deleteDocument({
    required String name,
    String? documentVersion,
    bool? force,
    String? versionName,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringPattern(
      'versionName',
      versionName,
      r'''^[a-zA-Z0-9_\-.]{1,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteDocument'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (force != null) 'Force': force,
        if (versionName != null) 'VersionName': versionName,
      },
    );
  }

  /// Delete a custom inventory type or the data associated with a custom
  /// Inventory type. Deleting a custom inventory type is also referred to as
  /// deleting a custom inventory schema.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidTypeNameException].
  /// May throw [InvalidOptionException].
  /// May throw [InvalidDeleteInventoryParametersException].
  /// May throw [InvalidInventoryRequestException].
  ///
  /// Parameter [typeName] :
  /// The name of the custom inventory type for which you want to delete either
  /// all previously collected data or the inventory type itself.
  ///
  /// Parameter [clientToken] :
  /// User-provided idempotency token.
  ///
  /// Parameter [dryRun] :
  /// Use this option to view a summary of the deletion request without deleting
  /// any data or the data type. This option is useful when you only want to
  /// understand what will be deleted. Once you validate that the data to be
  /// deleted is what you intend to delete, you can run the same command without
  /// specifying the <code>DryRun</code> option.
  ///
  /// Parameter [schemaDeleteOption] :
  /// Use the <code>SchemaDeleteOption</code> to delete a custom inventory type
  /// (schema). If you don't choose this option, the system only deletes
  /// existing inventory data associated with the custom inventory type. Choose
  /// one of the following options:
  ///
  /// DisableSchema: If you choose this option, the system ignores all inventory
  /// data for the specified version, and any earlier versions. To enable this
  /// schema again, you must call the <code>PutInventory</code> action for a
  /// version greater than the disabled version.
  ///
  /// DeleteSchema: This option deletes the specified custom type from the
  /// Inventory service. You can recreate the schema later, if you want.
  Future<DeleteInventoryResult> deleteInventory({
    required String typeName,
    String? clientToken,
    bool? dryRun,
    InventorySchemaDeleteOption? schemaDeleteOption,
  }) async {
    ArgumentError.checkNotNull(typeName, 'typeName');
    _s.validateStringLength(
      'typeName',
      typeName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'typeName',
      typeName,
      r'''^(AWS|Custom):.*$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'clientToken',
      clientToken,
      r'''[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteInventory'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TypeName': typeName,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (dryRun != null) 'DryRun': dryRun,
        if (schemaDeleteOption != null)
          'SchemaDeleteOption': schemaDeleteOption.toValue(),
      },
    );

    return DeleteInventoryResult.fromJson(jsonResponse.body);
  }

  /// Deletes a maintenance window.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window to delete.
  Future<DeleteMaintenanceWindowResult> deleteMaintenanceWindow({
    required String windowId,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
      },
    );

    return DeleteMaintenanceWindowResult.fromJson(jsonResponse.body);
  }

  /// Delete OpsMetadata related to an application.
  ///
  /// May throw [OpsMetadataNotFoundException].
  /// May throw [OpsMetadataInvalidArgumentException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [opsMetadataArn] :
  /// The Amazon Resource Name (ARN) of an OpsMetadata Object to delete.
  Future<void> deleteOpsMetadata({
    required String opsMetadataArn,
  }) async {
    ArgumentError.checkNotNull(opsMetadataArn, 'opsMetadataArn');
    _s.validateStringLength(
      'opsMetadataArn',
      opsMetadataArn,
      1,
      1011,
      isRequired: true,
    );
    _s.validateStringPattern(
      'opsMetadataArn',
      opsMetadataArn,
      r'''arn:(aws[a-zA-Z-]*)?:ssm:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:opsmetadata\/([a-zA-Z0-9-_\.\/]*)''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteOpsMetadata'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'OpsMetadataArn': opsMetadataArn,
      },
    );
  }

  /// Delete a parameter from the system.
  ///
  /// May throw [InternalServerError].
  /// May throw [ParameterNotFound].
  ///
  /// Parameter [name] :
  /// The name of the parameter to delete.
  Future<void> deleteParameter({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      2048,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteParameter'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
      },
    );
  }

  /// Delete a list of parameters.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [names] :
  /// The names of the parameters to delete.
  Future<DeleteParametersResult> deleteParameters({
    required List<String> names,
  }) async {
    ArgumentError.checkNotNull(names, 'names');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteParameters'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Names': names,
      },
    );

    return DeleteParametersResult.fromJson(jsonResponse.body);
  }

  /// Deletes a patch baseline.
  ///
  /// May throw [ResourceInUseException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [baselineId] :
  /// The ID of the patch baseline to delete.
  Future<DeletePatchBaselineResult> deletePatchBaseline({
    required String baselineId,
  }) async {
    ArgumentError.checkNotNull(baselineId, 'baselineId');
    _s.validateStringLength(
      'baselineId',
      baselineId,
      20,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'baselineId',
      baselineId,
      r'''^[a-zA-Z0-9_\-:/]{20,128}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeletePatchBaseline'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BaselineId': baselineId,
      },
    );

    return DeletePatchBaselineResult.fromJson(jsonResponse.body);
  }

  /// Deletes a Resource Data Sync configuration. After the configuration is
  /// deleted, changes to data on managed instances are no longer synced to or
  /// from the target. Deleting a sync configuration does not delete data.
  ///
  /// May throw [InternalServerError].
  /// May throw [ResourceDataSyncNotFoundException].
  /// May throw [ResourceDataSyncInvalidConfigurationException].
  ///
  /// Parameter [syncName] :
  /// The name of the configuration to delete.
  ///
  /// Parameter [syncType] :
  /// Specify the type of resource data sync to delete.
  Future<void> deleteResourceDataSync({
    required String syncName,
    String? syncType,
  }) async {
    ArgumentError.checkNotNull(syncName, 'syncName');
    _s.validateStringLength(
      'syncName',
      syncName,
      1,
      64,
      isRequired: true,
    );
    _s.validateStringLength(
      'syncType',
      syncType,
      1,
      64,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeleteResourceDataSync'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SyncName': syncName,
        if (syncType != null) 'SyncType': syncType,
      },
    );
  }

  /// Removes the server or virtual machine from the list of registered servers.
  /// You can reregister the instance again at any time. If you don't plan to
  /// use Run Command on the server, we suggest uninstalling SSM Agent first.
  ///
  /// May throw [InvalidInstanceId].
  /// May throw [InternalServerError].
  ///
  /// Parameter [instanceId] :
  /// The ID assigned to the managed instance when you registered it using the
  /// activation process.
  Future<void> deregisterManagedInstance({
    required String instanceId,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''^mi-[0-9a-f]{17}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeregisterManagedInstance'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceId': instanceId,
      },
    );
  }

  /// Removes a patch group from a patch baseline.
  ///
  /// May throw [InvalidResourceId].
  /// May throw [InternalServerError].
  ///
  /// Parameter [baselineId] :
  /// The ID of the patch baseline to deregister the patch group from.
  ///
  /// Parameter [patchGroup] :
  /// The name of the patch group that should be deregistered from the patch
  /// baseline.
  Future<DeregisterPatchBaselineForPatchGroupResult>
      deregisterPatchBaselineForPatchGroup({
    required String baselineId,
    required String patchGroup,
  }) async {
    ArgumentError.checkNotNull(baselineId, 'baselineId');
    _s.validateStringLength(
      'baselineId',
      baselineId,
      20,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'baselineId',
      baselineId,
      r'''^[a-zA-Z0-9_\-:/]{20,128}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(patchGroup, 'patchGroup');
    _s.validateStringLength(
      'patchGroup',
      patchGroup,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringPattern(
      'patchGroup',
      patchGroup,
      r'''^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeregisterPatchBaselineForPatchGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BaselineId': baselineId,
        'PatchGroup': patchGroup,
      },
    );

    return DeregisterPatchBaselineForPatchGroupResult.fromJson(
        jsonResponse.body);
  }

  /// Removes a target from a maintenance window.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  /// May throw [TargetInUseException].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window the target should be removed from.
  ///
  /// Parameter [windowTargetId] :
  /// The ID of the target definition to remove.
  ///
  /// Parameter [safe] :
  /// The system checks if the target is being referenced by a task. If the
  /// target is being referenced, the system returns an error and does not
  /// deregister the target from the maintenance window.
  Future<DeregisterTargetFromMaintenanceWindowResult>
      deregisterTargetFromMaintenanceWindow({
    required String windowId,
    required String windowTargetId,
    bool? safe,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowTargetId, 'windowTargetId');
    _s.validateStringLength(
      'windowTargetId',
      windowTargetId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowTargetId',
      windowTargetId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeregisterTargetFromMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        'WindowTargetId': windowTargetId,
        if (safe != null) 'Safe': safe,
      },
    );

    return DeregisterTargetFromMaintenanceWindowResult.fromJson(
        jsonResponse.body);
  }

  /// Removes a task from a maintenance window.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window the task should be removed from.
  ///
  /// Parameter [windowTaskId] :
  /// The ID of the task to remove from the maintenance window.
  Future<DeregisterTaskFromMaintenanceWindowResult>
      deregisterTaskFromMaintenanceWindow({
    required String windowId,
    required String windowTaskId,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowTaskId, 'windowTaskId');
    _s.validateStringLength(
      'windowTaskId',
      windowTaskId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowTaskId',
      windowTaskId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DeregisterTaskFromMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        'WindowTaskId': windowTaskId,
      },
    );

    return DeregisterTaskFromMaintenanceWindowResult.fromJson(
        jsonResponse.body);
  }

  /// Describes details about the activation, such as the date and time the
  /// activation was created, its expiration date, the IAM role assigned to the
  /// instances in the activation, and the number of instances registered by
  /// using this activation.
  ///
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// A filter to view information about your activations.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<DescribeActivationsResult> describeActivations({
    List<DescribeActivationsFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeActivations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeActivationsResult.fromJson(jsonResponse.body);
  }

  /// Describes the association for the specified target or instance. If you
  /// created the association by using the <code>Targets</code> parameter, then
  /// you must retrieve the association by using the association ID. If you
  /// created the association by specifying an instance ID and a Systems Manager
  /// document, then you retrieve the association by specifying the document
  /// name and the instance ID.
  ///
  /// May throw [AssociationDoesNotExist].
  /// May throw [InvalidAssociationVersion].
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidInstanceId].
  ///
  /// Parameter [associationId] :
  /// The association ID for which you want information.
  ///
  /// Parameter [associationVersion] :
  /// Specify the association version to retrieve. To view the latest version,
  /// either specify <code>$LATEST</code> for this parameter, or omit this
  /// parameter. To view a list of all associations for an instance, use
  /// <a>ListAssociations</a>. To get a list of versions for a specific
  /// association, use <a>ListAssociationVersions</a>.
  ///
  /// Parameter [instanceId] :
  /// The instance ID.
  ///
  /// Parameter [name] :
  /// The name of the Systems Manager document.
  Future<DescribeAssociationResult> describeAssociation({
    String? associationId,
    String? associationVersion,
    String? instanceId,
    String? name,
  }) async {
    _s.validateStringPattern(
      'associationId',
      associationId,
      r'''[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}''',
    );
    _s.validateStringPattern(
      'associationVersion',
      associationVersion,
      r'''([$]LATEST)|([1-9][0-9]*)''',
    );
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeAssociation'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (associationId != null) 'AssociationId': associationId,
        if (associationVersion != null)
          'AssociationVersion': associationVersion,
        if (instanceId != null) 'InstanceId': instanceId,
        if (name != null) 'Name': name,
      },
    );

    return DescribeAssociationResult.fromJson(jsonResponse.body);
  }

  /// Use this API action to view information about a specific execution of a
  /// specific association.
  ///
  /// May throw [InternalServerError].
  /// May throw [AssociationDoesNotExist].
  /// May throw [InvalidNextToken].
  /// May throw [AssociationExecutionDoesNotExist].
  ///
  /// Parameter [associationId] :
  /// The association ID that includes the execution for which you want to view
  /// details.
  ///
  /// Parameter [executionId] :
  /// The execution ID for which you want to view details.
  ///
  /// Parameter [filters] :
  /// Filters for the request. You can specify the following filters and values.
  ///
  /// Status (EQUAL)
  ///
  /// ResourceId (EQUAL)
  ///
  /// ResourceType (EQUAL)
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<DescribeAssociationExecutionTargetsResult>
      describeAssociationExecutionTargets({
    required String associationId,
    required String executionId,
    List<AssociationExecutionTargetsFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(associationId, 'associationId');
    _s.validateStringPattern(
      'associationId',
      associationId,
      r'''[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(executionId, 'executionId');
    _s.validateStringPattern(
      'executionId',
      executionId,
      r'''[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeAssociationExecutionTargets'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AssociationId': associationId,
        'ExecutionId': executionId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeAssociationExecutionTargetsResult.fromJson(
        jsonResponse.body);
  }

  /// Use this API action to view all executions for a specific association ID.
  ///
  /// May throw [InternalServerError].
  /// May throw [AssociationDoesNotExist].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [associationId] :
  /// The association ID for which you want to view execution history details.
  ///
  /// Parameter [filters] :
  /// Filters for the request. You can specify the following filters and values.
  ///
  /// ExecutionId (EQUAL)
  ///
  /// Status (EQUAL)
  ///
  /// CreatedTime (EQUAL, GREATER_THAN, LESS_THAN)
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<DescribeAssociationExecutionsResult> describeAssociationExecutions({
    required String associationId,
    List<AssociationExecutionFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(associationId, 'associationId');
    _s.validateStringPattern(
      'associationId',
      associationId,
      r'''[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeAssociationExecutions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AssociationId': associationId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeAssociationExecutionsResult.fromJson(jsonResponse.body);
  }

  /// Provides details about all active and terminated Automation executions.
  ///
  /// May throw [InvalidFilterKey].
  /// May throw [InvalidFilterValue].
  /// May throw [InvalidNextToken].
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// Filters used to limit the scope of executions that are requested.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeAutomationExecutionsResult> describeAutomationExecutions({
    List<AutomationExecutionFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeAutomationExecutions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeAutomationExecutionsResult.fromJson(jsonResponse.body);
  }

  /// Information about all active and terminated step executions in an
  /// Automation workflow.
  ///
  /// May throw [AutomationExecutionNotFoundException].
  /// May throw [InvalidNextToken].
  /// May throw [InvalidFilterKey].
  /// May throw [InvalidFilterValue].
  /// May throw [InternalServerError].
  ///
  /// Parameter [automationExecutionId] :
  /// The Automation execution ID for which you want step execution
  /// descriptions.
  ///
  /// Parameter [filters] :
  /// One or more filters to limit the number of step executions returned by the
  /// request.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [reverseOrder] :
  /// A boolean that indicates whether to list step executions in reverse order
  /// by start time. The default value is false.
  Future<DescribeAutomationStepExecutionsResult>
      describeAutomationStepExecutions({
    required String automationExecutionId,
    List<StepExecutionFilter>? filters,
    int? maxResults,
    String? nextToken,
    bool? reverseOrder,
  }) async {
    ArgumentError.checkNotNull(automationExecutionId, 'automationExecutionId');
    _s.validateStringLength(
      'automationExecutionId',
      automationExecutionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeAutomationStepExecutions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AutomationExecutionId': automationExecutionId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (reverseOrder != null) 'ReverseOrder': reverseOrder,
      },
    );

    return DescribeAutomationStepExecutionsResult.fromJson(jsonResponse.body);
  }

  /// Lists all patches eligible to be included in a patch baseline.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// Filters used to scope down the returned patches.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of patches to return (per page).
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeAvailablePatchesResult> describeAvailablePatches({
    List<PatchOrchestratorFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeAvailablePatches'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeAvailablePatchesResult.fromJson(jsonResponse.body);
  }

  /// Describes the specified Systems Manager document.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentVersion].
  ///
  /// Parameter [name] :
  /// The name of the Systems Manager document.
  ///
  /// Parameter [documentVersion] :
  /// The document version for which you want information. Can be a specific
  /// version or the default version.
  ///
  /// Parameter [versionName] :
  /// An optional field specifying the version of the artifact associated with
  /// the document. For example, "Release 12, Update 6". This value is unique
  /// across all versions of a document, and cannot be changed.
  Future<DescribeDocumentResult> describeDocument({
    required String name,
    String? documentVersion,
    String? versionName,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringPattern(
      'versionName',
      versionName,
      r'''^[a-zA-Z0-9_\-.]{1,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeDocument'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (versionName != null) 'VersionName': versionName,
      },
    );

    return DescribeDocumentResult.fromJson(jsonResponse.body);
  }

  /// Describes the permissions for a Systems Manager document. If you created
  /// the document, you are the owner. If a document is shared, it can either be
  /// shared privately (by specifying a user's AWS account ID) or publicly
  /// (<i>All</i>).
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidPermissionType].
  ///
  /// Parameter [name] :
  /// The name of the document for which you are the owner.
  ///
  /// Parameter [permissionType] :
  /// The permission type for the document. The permission type can be
  /// <i>Share</i>.
  Future<DescribeDocumentPermissionResponse> describeDocumentPermission({
    required String name,
    required DocumentPermissionType permissionType,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(permissionType, 'permissionType');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeDocumentPermission'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        'PermissionType': permissionType.toValue(),
      },
    );

    return DescribeDocumentPermissionResponse.fromJson(jsonResponse.body);
  }

  /// All associations for the instance(s).
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [instanceId] :
  /// The instance ID for which you want to view all associations.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeEffectiveInstanceAssociationsResult>
      describeEffectiveInstanceAssociations({
    required String instanceId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      5,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeEffectiveInstanceAssociations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceId': instanceId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeEffectiveInstanceAssociationsResult.fromJson(
        jsonResponse.body);
  }

  /// Retrieves the current effective patches (the patch and the approval state)
  /// for the specified patch baseline. Note that this API applies only to
  /// Windows patch baselines.
  ///
  /// May throw [InvalidResourceId].
  /// May throw [DoesNotExistException].
  /// May throw [UnsupportedOperatingSystem].
  /// May throw [InternalServerError].
  ///
  /// Parameter [baselineId] :
  /// The ID of the patch baseline to retrieve the effective patches for.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of patches to return (per page).
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeEffectivePatchesForPatchBaselineResult>
      describeEffectivePatchesForPatchBaseline({
    required String baselineId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(baselineId, 'baselineId');
    _s.validateStringLength(
      'baselineId',
      baselineId,
      20,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'baselineId',
      baselineId,
      r'''^[a-zA-Z0-9_\-:/]{20,128}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeEffectivePatchesForPatchBaseline'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BaselineId': baselineId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeEffectivePatchesForPatchBaselineResult.fromJson(
        jsonResponse.body);
  }

  /// The status of the associations for the instance(s).
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [instanceId] :
  /// The instance IDs for which you want association status information.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeInstanceAssociationsStatusResult>
      describeInstanceAssociationsStatus({
    required String instanceId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeInstanceAssociationsStatus'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceId': instanceId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeInstanceAssociationsStatusResult.fromJson(jsonResponse.body);
  }

  /// Describes one or more of your instances, including information about the
  /// operating system platform, the version of SSM Agent installed on the
  /// instance, instance status, and so on.
  ///
  /// If you specify one or more instance IDs, it returns information for those
  /// instances. If you do not specify instance IDs, it returns information for
  /// all your instances. If you specify an instance ID that is not valid or an
  /// instance that you do not own, you receive an error.
  /// <note>
  /// The IamRole field for this API action is the Amazon Identity and Access
  /// Management (IAM) role assigned to on-premises instances. This call does
  /// not return the IAM role for EC2 instances.
  /// </note>
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidNextToken].
  /// May throw [InvalidInstanceInformationFilterValue].
  /// May throw [InvalidFilterKey].
  ///
  /// Parameter [filters] :
  /// One or more filters. Use a filter to return a more specific list of
  /// instances. You can filter based on tags applied to EC2 instances. Use this
  /// <code>Filters</code> data type instead of
  /// <code>InstanceInformationFilterList</code>, which is deprecated.
  ///
  /// Parameter [instanceInformationFilterList] :
  /// This is a legacy method. We recommend that you don't use this method.
  /// Instead, use the <code>Filters</code> data type. <code>Filters</code>
  /// enables you to return instance information by filtering based on tags
  /// applied to managed instances.
  /// <note>
  /// Attempting to use <code>InstanceInformationFilterList</code> and
  /// <code>Filters</code> leads to an exception error.
  /// </note>
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeInstanceInformationResult> describeInstanceInformation({
    List<InstanceInformationStringFilter>? filters,
    List<InstanceInformationFilter>? instanceInformationFilterList,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      5,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeInstanceInformation'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (instanceInformationFilterList != null)
          'InstanceInformationFilterList': instanceInformationFilterList,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeInstanceInformationResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the high-level patch state of one or more instances.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [instanceIds] :
  /// The ID of the instance whose patch state information should be retrieved.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of instances to return (per page).
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeInstancePatchStatesResult> describeInstancePatchStates({
    required List<String> instanceIds,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(instanceIds, 'instanceIds');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeInstancePatchStates'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceIds': instanceIds,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeInstancePatchStatesResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the high-level patch state for the instances in the specified
  /// patch group.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [patchGroup] :
  /// The name of the patch group for which the patch state information should
  /// be retrieved.
  ///
  /// Parameter [filters] :
  /// Each entry in the array is a structure containing:
  ///
  /// Key (string between 1 and 200 characters)
  ///
  /// Values (array containing a single string)
  ///
  /// Type (string "Equal", "NotEqual", "LessThan", "GreaterThan")
  ///
  /// Parameter [maxResults] :
  /// The maximum number of patches to return (per page).
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeInstancePatchStatesForPatchGroupResult>
      describeInstancePatchStatesForPatchGroup({
    required String patchGroup,
    List<InstancePatchStateFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(patchGroup, 'patchGroup');
    _s.validateStringLength(
      'patchGroup',
      patchGroup,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringPattern(
      'patchGroup',
      patchGroup,
      r'''^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeInstancePatchStatesForPatchGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'PatchGroup': patchGroup,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeInstancePatchStatesForPatchGroupResult.fromJson(
        jsonResponse.body);
  }

  /// Retrieves information about the patches on the specified instance and
  /// their state relative to the patch baseline being used for the instance.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance whose patch state information should be retrieved.
  ///
  /// Parameter [filters] :
  /// An array of structures. Each entry in the array is a structure containing
  /// a Key, Value combination. Valid values for Key are
  /// <code>Classification</code> | <code>KBId</code> | <code>Severity</code> |
  /// <code>State</code>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of patches to return (per page).
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeInstancePatchesResult> describeInstancePatches({
    required String instanceId,
    List<PatchOrchestratorFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeInstancePatches'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceId': instanceId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeInstancePatchesResult.fromJson(jsonResponse.body);
  }

  /// Describes a specific delete inventory operation.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDeletionIdException].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [deletionId] :
  /// Specify the delete inventory ID for which you want information. This ID
  /// was returned by the <code>DeleteInventory</code> action.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<DescribeInventoryDeletionsResult> describeInventoryDeletions({
    String? deletionId,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateStringPattern(
      'deletionId',
      deletionId,
      r'''[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}''',
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeInventoryDeletions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (deletionId != null) 'DeletionId': deletionId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeInventoryDeletionsResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the individual task executions (one per target) for a particular
  /// task run as part of a maintenance window execution.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [taskId] :
  /// The ID of the specific task in the maintenance window task that should be
  /// retrieved.
  ///
  /// Parameter [windowExecutionId] :
  /// The ID of the maintenance window execution the task is part of.
  ///
  /// Parameter [filters] :
  /// Optional filters used to scope down the returned task invocations. The
  /// supported filter key is STATUS with the corresponding values PENDING,
  /// IN_PROGRESS, SUCCESS, FAILED, TIMED_OUT, CANCELLING, and CANCELLED.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeMaintenanceWindowExecutionTaskInvocationsResult>
      describeMaintenanceWindowExecutionTaskInvocations({
    required String taskId,
    required String windowExecutionId,
    List<MaintenanceWindowFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(taskId, 'taskId');
    _s.validateStringLength(
      'taskId',
      taskId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'taskId',
      taskId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowExecutionId, 'windowExecutionId');
    _s.validateStringLength(
      'windowExecutionId',
      windowExecutionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowExecutionId',
      windowExecutionId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AmazonSSM.DescribeMaintenanceWindowExecutionTaskInvocations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskId': taskId,
        'WindowExecutionId': windowExecutionId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeMaintenanceWindowExecutionTaskInvocationsResult.fromJson(
        jsonResponse.body);
  }

  /// For a given maintenance window execution, lists the tasks that were run.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowExecutionId] :
  /// The ID of the maintenance window execution whose task executions should be
  /// retrieved.
  ///
  /// Parameter [filters] :
  /// Optional filters used to scope down the returned tasks. The supported
  /// filter key is STATUS with the corresponding values PENDING, IN_PROGRESS,
  /// SUCCESS, FAILED, TIMED_OUT, CANCELLING, and CANCELLED.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeMaintenanceWindowExecutionTasksResult>
      describeMaintenanceWindowExecutionTasks({
    required String windowExecutionId,
    List<MaintenanceWindowFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(windowExecutionId, 'windowExecutionId');
    _s.validateStringLength(
      'windowExecutionId',
      windowExecutionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowExecutionId',
      windowExecutionId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeMaintenanceWindowExecutionTasks'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowExecutionId': windowExecutionId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeMaintenanceWindowExecutionTasksResult.fromJson(
        jsonResponse.body);
  }

  /// Lists the executions of a maintenance window. This includes information
  /// about when the maintenance window was scheduled to be active, and
  /// information about tasks registered and run with the maintenance window.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window whose executions should be retrieved.
  ///
  /// Parameter [filters] :
  /// Each entry in the array is a structure containing:
  ///
  /// Key (string, between 1 and 128 characters)
  ///
  /// Values (array of strings, each string is between 1 and 256 characters)
  ///
  /// The supported Keys are ExecutedBefore and ExecutedAfter with the value
  /// being a date/time string such as 2016-11-04T05:00:00Z.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeMaintenanceWindowExecutionsResult>
      describeMaintenanceWindowExecutions({
    required String windowId,
    List<MaintenanceWindowFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeMaintenanceWindowExecutions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeMaintenanceWindowExecutionsResult.fromJson(
        jsonResponse.body);
  }

  /// Retrieves information about upcoming executions of a maintenance window.
  ///
  /// May throw [InternalServerError].
  /// May throw [DoesNotExistException].
  ///
  /// Parameter [filters] :
  /// Filters used to limit the range of results. For example, you can limit
  /// maintenance window executions to only those scheduled before or after a
  /// certain date and time.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [resourceType] :
  /// The type of resource you want to retrieve information about. For example,
  /// "INSTANCE".
  ///
  /// Parameter [targets] :
  /// The instance ID or key/value pair to retrieve information about.
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window to retrieve information about.
  Future<DescribeMaintenanceWindowScheduleResult>
      describeMaintenanceWindowSchedule({
    List<PatchOrchestratorFilter>? filters,
    int? maxResults,
    String? nextToken,
    MaintenanceWindowResourceType? resourceType,
    List<Target>? targets,
    String? windowId,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1152921504606846976,
    );
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeMaintenanceWindowSchedule'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (resourceType != null) 'ResourceType': resourceType.toValue(),
        if (targets != null) 'Targets': targets,
        if (windowId != null) 'WindowId': windowId,
      },
    );

    return DescribeMaintenanceWindowScheduleResult.fromJson(jsonResponse.body);
  }

  /// Lists the targets registered with the maintenance window.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window whose targets should be retrieved.
  ///
  /// Parameter [filters] :
  /// Optional filters that can be used to narrow down the scope of the returned
  /// window targets. The supported filter keys are Type, WindowTargetId and
  /// OwnerInformation.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeMaintenanceWindowTargetsResult>
      describeMaintenanceWindowTargets({
    required String windowId,
    List<MaintenanceWindowFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeMaintenanceWindowTargets'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeMaintenanceWindowTargetsResult.fromJson(jsonResponse.body);
  }

  /// Lists the tasks in a maintenance window.
  /// <note>
  /// For maintenance window tasks without a specified target, you cannot supply
  /// values for <code>--max-errors</code> and <code>--max-concurrency</code>.
  /// Instead, the system inserts a placeholder value of <code>1</code>, which
  /// may be reported in the response to this command. These values do not
  /// affect the running of your task and can be ignored.
  /// </note>
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window whose tasks should be retrieved.
  ///
  /// Parameter [filters] :
  /// Optional filters used to narrow down the scope of the returned tasks. The
  /// supported filter keys are WindowTaskId, TaskArn, Priority, and TaskType.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeMaintenanceWindowTasksResult> describeMaintenanceWindowTasks({
    required String windowId,
    List<MaintenanceWindowFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeMaintenanceWindowTasks'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeMaintenanceWindowTasksResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the maintenance windows in an AWS account.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// Optional filters used to narrow down the scope of the returned maintenance
  /// windows. Supported filter keys are <b>Name</b> and <b>Enabled</b>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeMaintenanceWindowsResult> describeMaintenanceWindows({
    List<MaintenanceWindowFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      10,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeMaintenanceWindows'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeMaintenanceWindowsResult.fromJson(jsonResponse.body);
  }

  /// Retrieves information about the maintenance window targets or tasks that
  /// an instance is associated with.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [resourceType] :
  /// The type of resource you want to retrieve information about. For example,
  /// "INSTANCE".
  ///
  /// Parameter [targets] :
  /// The instance ID or key/value pair to retrieve information about.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeMaintenanceWindowsForTargetResult>
      describeMaintenanceWindowsForTarget({
    required MaintenanceWindowResourceType resourceType,
    required List<Target> targets,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceType, 'resourceType');
    ArgumentError.checkNotNull(targets, 'targets');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeMaintenanceWindowsForTarget'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceType': resourceType.toValue(),
        'Targets': targets,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeMaintenanceWindowsForTargetResult.fromJson(
        jsonResponse.body);
  }

  /// Query a set of OpsItems. You must have permission in AWS Identity and
  /// Access Management (IAM) to query a list of OpsItems. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html">Getting
  /// started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Operations engineers and IT professionals use OpsCenter to view,
  /// investigate, and remediate operational issues impacting the performance
  /// and health of their AWS resources. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html">AWS
  /// Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  ///
  /// Parameter [opsItemFilters] :
  /// One or more filters to limit the response.
  ///
  /// <ul>
  /// <li>
  /// Key: CreatedTime
  ///
  /// Operations: GreaterThan, LessThan
  /// </li>
  /// <li>
  /// Key: LastModifiedBy
  ///
  /// Operations: Contains, Equals
  /// </li>
  /// <li>
  /// Key: LastModifiedTime
  ///
  /// Operations: GreaterThan, LessThan
  /// </li>
  /// <li>
  /// Key: Priority
  ///
  /// Operations: Equals
  /// </li>
  /// <li>
  /// Key: Source
  ///
  /// Operations: Contains, Equals
  /// </li>
  /// <li>
  /// Key: Status
  ///
  /// Operations: Equals
  /// </li>
  /// <li>
  /// Key: Title
  ///
  /// Operations: Contains
  /// </li>
  /// <li>
  /// Key: OperationalData*
  ///
  /// Operations: Equals
  /// </li>
  /// <li>
  /// Key: OperationalDataKey
  ///
  /// Operations: Equals
  /// </li>
  /// <li>
  /// Key: OperationalDataValue
  ///
  /// Operations: Equals, Contains
  /// </li>
  /// <li>
  /// Key: OpsItemId
  ///
  /// Operations: Equals
  /// </li>
  /// <li>
  /// Key: ResourceId
  ///
  /// Operations: Contains
  /// </li>
  /// <li>
  /// Key: AutomationId
  ///
  /// Operations: Equals
  /// </li>
  /// </ul>
  /// *If you filter the response by using the OperationalData operator, specify
  /// a key-value pair by using the following JSON format:
  /// {"key":"key_name","value":"a_value"}
  Future<DescribeOpsItemsResponse> describeOpsItems({
    int? maxResults,
    String? nextToken,
    List<OpsItemFilter>? opsItemFilters,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeOpsItems'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (opsItemFilters != null) 'OpsItemFilters': opsItemFilters,
      },
    );

    return DescribeOpsItemsResponse.fromJson(jsonResponse.body);
  }

  /// Get information about a parameter.
  /// <note>
  /// Request results are returned on a best-effort basis. If you specify
  /// <code>MaxResults</code> in the request, the response includes information
  /// up to the limit specified. The number of items returned, however, can be
  /// between zero and the value of <code>MaxResults</code>. If the service
  /// reaches an internal limit while processing the results, it stops the
  /// operation and returns the matching values up to that point and a
  /// <code>NextToken</code>. You can specify the <code>NextToken</code> in a
  /// subsequent call to get the next set of results.
  /// </note>
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidFilterKey].
  /// May throw [InvalidFilterOption].
  /// May throw [InvalidFilterValue].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [filters] :
  /// This data type is deprecated. Instead, use <code>ParameterFilters</code>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [parameterFilters] :
  /// Filters to limit the request results.
  Future<DescribeParametersResult> describeParameters({
    List<ParametersFilter>? filters,
    int? maxResults,
    String? nextToken,
    List<ParameterStringFilter>? parameterFilters,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeParameters'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (parameterFilters != null) 'ParameterFilters': parameterFilters,
      },
    );

    return DescribeParametersResult.fromJson(jsonResponse.body);
  }

  /// Lists the patch baselines in your AWS account.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// Each element in the array is a structure containing:
  ///
  /// Key: (string, "NAME_PREFIX" or "OWNER")
  ///
  /// Value: (array of strings, exactly 1 entry, between 1 and 255 characters)
  ///
  /// Parameter [maxResults] :
  /// The maximum number of patch baselines to return (per page).
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribePatchBaselinesResult> describePatchBaselines({
    List<PatchOrchestratorFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribePatchBaselines'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribePatchBaselinesResult.fromJson(jsonResponse.body);
  }

  /// Returns high-level aggregated patch compliance state for a patch group.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [patchGroup] :
  /// The name of the patch group whose patch snapshot should be retrieved.
  Future<DescribePatchGroupStateResult> describePatchGroupState({
    required String patchGroup,
  }) async {
    ArgumentError.checkNotNull(patchGroup, 'patchGroup');
    _s.validateStringLength(
      'patchGroup',
      patchGroup,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringPattern(
      'patchGroup',
      patchGroup,
      r'''^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribePatchGroupState'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'PatchGroup': patchGroup,
      },
    );

    return DescribePatchGroupStateResult.fromJson(jsonResponse.body);
  }

  /// Lists all patch groups that have been registered with patch baselines.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// One or more filters. Use a filter to return a more specific list of
  /// results.
  ///
  /// For <code>DescribePatchGroups</code>,valid filter keys include the
  /// following:
  ///
  /// <ul>
  /// <li>
  /// <code>NAME_PREFIX</code>: The name of the patch group. Wildcards (*) are
  /// accepted.
  /// </li>
  /// <li>
  /// <code>OPERATING_SYSTEM</code>: The supported operating system type to
  /// return results for. For valid operating system values, see
  /// <a>GetDefaultPatchBaselineRequest$OperatingSystem</a> in
  /// <a>CreatePatchBaseline</a>.
  ///
  /// Examples:
  ///
  /// <ul>
  /// <li>
  /// <code>--filters Key=NAME_PREFIX,Values=MyPatchGroup*</code>
  /// </li>
  /// <li>
  /// <code>--filters Key=OPERATING_SYSTEM,Values=AMAZON_LINUX_2</code>
  /// </li>
  /// </ul> </li>
  /// </ul>
  ///
  /// Parameter [maxResults] :
  /// The maximum number of patch groups to return (per page).
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribePatchGroupsResult> describePatchGroups({
    List<PatchOrchestratorFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribePatchGroups'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribePatchGroupsResult.fromJson(jsonResponse.body);
  }

  /// Lists the properties of available patches organized by product, product
  /// family, classification, severity, and other properties of available
  /// patches. You can use the reported properties in the filters you specify in
  /// requests for actions such as <a>CreatePatchBaseline</a>,
  /// <a>UpdatePatchBaseline</a>, <a>DescribeAvailablePatches</a>, and
  /// <a>DescribePatchBaselines</a>.
  ///
  /// The following section lists the properties that can be used in filters for
  /// each major operating system type:
  /// <dl> <dt>AMAZON_LINUX</dt> <dd>
  /// Valid properties: PRODUCT, CLASSIFICATION, SEVERITY
  /// </dd> <dt>AMAZON_LINUX_2</dt> <dd>
  /// Valid properties: PRODUCT, CLASSIFICATION, SEVERITY
  /// </dd> <dt>CENTOS</dt> <dd>
  /// Valid properties: PRODUCT, CLASSIFICATION, SEVERITY
  /// </dd> <dt>DEBIAN</dt> <dd>
  /// Valid properties: PRODUCT, PRIORITY
  /// </dd> <dt>MACOS</dt> <dd>
  /// Valid properties: PRODUCT, CLASSIFICATION
  /// </dd> <dt>ORACLE_LINUX</dt> <dd>
  /// Valid properties: PRODUCT, CLASSIFICATION, SEVERITY
  /// </dd> <dt>REDHAT_ENTERPRISE_LINUX</dt> <dd>
  /// Valid properties: PRODUCT, CLASSIFICATION, SEVERITY
  /// </dd> <dt>SUSE</dt> <dd>
  /// Valid properties: PRODUCT, CLASSIFICATION, SEVERITY
  /// </dd> <dt>UBUNTU</dt> <dd>
  /// Valid properties: PRODUCT, PRIORITY
  /// </dd> <dt>WINDOWS</dt> <dd>
  /// Valid properties: PRODUCT, PRODUCT_FAMILY, CLASSIFICATION, MSRC_SEVERITY
  /// </dd> </dl>
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [operatingSystem] :
  /// The operating system type for which to list patches.
  ///
  /// Parameter [property] :
  /// The patch property for which you want to view patch details.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [patchSet] :
  /// Indicates whether to list patches for the Windows operating system or for
  /// Microsoft applications. Not applicable for the Linux or macOS operating
  /// systems.
  Future<DescribePatchPropertiesResult> describePatchProperties({
    required OperatingSystem operatingSystem,
    required PatchProperty property,
    int? maxResults,
    String? nextToken,
    PatchSet? patchSet,
  }) async {
    ArgumentError.checkNotNull(operatingSystem, 'operatingSystem');
    ArgumentError.checkNotNull(property, 'property');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribePatchProperties'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'OperatingSystem': operatingSystem.toValue(),
        'Property': property.toValue(),
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (patchSet != null) 'PatchSet': patchSet.toValue(),
      },
    );

    return DescribePatchPropertiesResult.fromJson(jsonResponse.body);
  }

  /// Retrieves a list of all active sessions (both connected and disconnected)
  /// or terminated sessions from the past 30 days.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidFilterKey].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [state] :
  /// The session status to retrieve a list of sessions for. For example,
  /// "Active".
  ///
  /// Parameter [filters] :
  /// One or more filters to limit the type of sessions returned by the request.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeSessionsResponse> describeSessions({
    required SessionState state,
    List<SessionFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(state, 'state');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      200,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.DescribeSessions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'State': state.toValue(),
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeSessionsResponse.fromJson(jsonResponse.body);
  }

  /// Get detailed information about a particular Automation execution.
  ///
  /// May throw [AutomationExecutionNotFoundException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [automationExecutionId] :
  /// The unique identifier for an existing automation execution to examine. The
  /// execution ID is returned by StartAutomationExecution when the execution of
  /// an Automation document is initiated.
  Future<GetAutomationExecutionResult> getAutomationExecution({
    required String automationExecutionId,
  }) async {
    ArgumentError.checkNotNull(automationExecutionId, 'automationExecutionId');
    _s.validateStringLength(
      'automationExecutionId',
      automationExecutionId,
      36,
      36,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetAutomationExecution'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AutomationExecutionId': automationExecutionId,
      },
    );

    return GetAutomationExecutionResult.fromJson(jsonResponse.body);
  }

  /// Gets the state of the AWS Systems Manager Change Calendar at an optional,
  /// specified time. If you specify a time, <code>GetCalendarState</code>
  /// returns the state of the calendar at a specific time, and returns the next
  /// time that the Change Calendar state will transition. If you do not specify
  /// a time, <code>GetCalendarState</code> assumes the current time. Change
  /// Calendar entries have two possible states: <code>OPEN</code> or
  /// <code>CLOSED</code>.
  ///
  /// If you specify more than one calendar in a request, the command returns
  /// the status of <code>OPEN</code> only if all calendars in the request are
  /// open. If one or more calendars in the request are closed, the status
  /// returned is <code>CLOSED</code>.
  ///
  /// For more information about Systems Manager Change Calendar, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-change-calendar.html">AWS
  /// Systems Manager Change Calendar</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentType].
  /// May throw [UnsupportedCalendarException].
  ///
  /// Parameter [calendarNames] :
  /// The names or Amazon Resource Names (ARNs) of the Systems Manager documents
  /// that represent the calendar entries for which you want to get the state.
  ///
  /// Parameter [atTime] :
  /// (Optional) The specific time for which you want to get calendar state
  /// information, in <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO
  /// 8601</a> format. If you do not add <code>AtTime</code>, the current time
  /// is assumed.
  Future<GetCalendarStateResponse> getCalendarState({
    required List<String> calendarNames,
    String? atTime,
  }) async {
    ArgumentError.checkNotNull(calendarNames, 'calendarNames');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetCalendarState'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'CalendarNames': calendarNames,
        if (atTime != null) 'AtTime': atTime,
      },
    );

    return GetCalendarStateResponse.fromJson(jsonResponse.body);
  }

  /// Returns detailed information about command execution for an invocation or
  /// plugin.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidCommandId].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidPluginName].
  /// May throw [InvocationDoesNotExist].
  ///
  /// Parameter [commandId] :
  /// (Required) The parent command ID of the invocation plugin.
  ///
  /// Parameter [instanceId] :
  /// (Required) The ID of the managed instance targeted by the command. A
  /// managed instance can be an EC2 instance or an instance in your hybrid
  /// environment that is configured for Systems Manager.
  ///
  /// Parameter [pluginName] :
  /// (Optional) The name of the plugin for which you want detailed results. If
  /// the document contains only one plugin, the name can be omitted and the
  /// details will be returned.
  ///
  /// Plugin names are also referred to as step names in Systems Manager
  /// documents.
  Future<GetCommandInvocationResult> getCommandInvocation({
    required String commandId,
    required String instanceId,
    String? pluginName,
  }) async {
    ArgumentError.checkNotNull(commandId, 'commandId');
    _s.validateStringLength(
      'commandId',
      commandId,
      36,
      36,
      isRequired: true,
    );
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    _s.validateStringLength(
      'pluginName',
      pluginName,
      4,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetCommandInvocation'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'CommandId': commandId,
        'InstanceId': instanceId,
        if (pluginName != null) 'PluginName': pluginName,
      },
    );

    return GetCommandInvocationResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the Session Manager connection status for an instance to
  /// determine whether it is running and ready to receive Session Manager
  /// connections.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [target] :
  /// The ID of the instance.
  Future<GetConnectionStatusResponse> getConnectionStatus({
    required String target,
  }) async {
    ArgumentError.checkNotNull(target, 'target');
    _s.validateStringLength(
      'target',
      target,
      1,
      400,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetConnectionStatus'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Target': target,
      },
    );

    return GetConnectionStatusResponse.fromJson(jsonResponse.body);
  }

  /// Retrieves the default patch baseline. Note that Systems Manager supports
  /// creating multiple default patch baselines. For example, you can create a
  /// default patch baseline for each operating system.
  ///
  /// If you do not specify an operating system value, the default patch
  /// baseline for Windows is returned.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [operatingSystem] :
  /// Returns the default patch baseline for the specified operating system.
  Future<GetDefaultPatchBaselineResult> getDefaultPatchBaseline({
    OperatingSystem? operatingSystem,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetDefaultPatchBaseline'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (operatingSystem != null)
          'OperatingSystem': operatingSystem.toValue(),
      },
    );

    return GetDefaultPatchBaselineResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the current snapshot for the patch baseline the instance uses.
  /// This API is primarily used by the AWS-RunPatchBaseline Systems Manager
  /// document.
  ///
  /// May throw [InternalServerError].
  /// May throw [UnsupportedOperatingSystem].
  /// May throw [UnsupportedFeatureRequiredException].
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance for which the appropriate patch snapshot should be
  /// retrieved.
  ///
  /// Parameter [snapshotId] :
  /// The user-defined snapshot ID.
  Future<GetDeployablePatchSnapshotForInstanceResult>
      getDeployablePatchSnapshotForInstance({
    required String instanceId,
    required String snapshotId,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(snapshotId, 'snapshotId');
    _s.validateStringLength(
      'snapshotId',
      snapshotId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'snapshotId',
      snapshotId,
      r'''^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetDeployablePatchSnapshotForInstance'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceId': instanceId,
        'SnapshotId': snapshotId,
      },
    );

    return GetDeployablePatchSnapshotForInstanceResult.fromJson(
        jsonResponse.body);
  }

  /// Gets the contents of the specified Systems Manager document.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentVersion].
  ///
  /// Parameter [name] :
  /// The name of the Systems Manager document.
  ///
  /// Parameter [documentFormat] :
  /// Returns the document in the specified format. The document format can be
  /// either JSON or YAML. JSON is the default format.
  ///
  /// Parameter [documentVersion] :
  /// The document version for which you want information.
  ///
  /// Parameter [versionName] :
  /// An optional field specifying the version of the artifact associated with
  /// the document. For example, "Release 12, Update 6". This value is unique
  /// across all versions of a document and can't be changed.
  Future<GetDocumentResult> getDocument({
    required String name,
    DocumentFormat? documentFormat,
    String? documentVersion,
    String? versionName,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringPattern(
      'versionName',
      versionName,
      r'''^[a-zA-Z0-9_\-.]{1,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetDocument'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (documentFormat != null) 'DocumentFormat': documentFormat.toValue(),
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (versionName != null) 'VersionName': versionName,
      },
    );

    return GetDocumentResult.fromJson(jsonResponse.body);
  }

  /// Query inventory information.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidFilter].
  /// May throw [InvalidInventoryGroupException].
  /// May throw [InvalidNextToken].
  /// May throw [InvalidTypeNameException].
  /// May throw [InvalidAggregatorException].
  /// May throw [InvalidResultAttributeException].
  ///
  /// Parameter [aggregators] :
  /// Returns counts of inventory types based on one or more expressions. For
  /// example, if you aggregate by using an expression that uses the
  /// <code>AWS:InstanceInformation.PlatformType</code> type, you can see a
  /// count of how many Windows and Linux instances exist in your inventoried
  /// fleet.
  ///
  /// Parameter [filters] :
  /// One or more filters. Use a filter to return a more specific list of
  /// results.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [resultAttributes] :
  /// The list of inventory item types to return.
  Future<GetInventoryResult> getInventory({
    List<InventoryAggregator>? aggregators,
    List<InventoryFilter>? filters,
    int? maxResults,
    String? nextToken,
    List<ResultAttribute>? resultAttributes,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetInventory'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (aggregators != null) 'Aggregators': aggregators,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (resultAttributes != null) 'ResultAttributes': resultAttributes,
      },
    );

    return GetInventoryResult.fromJson(jsonResponse.body);
  }

  /// Return a list of inventory type names for the account, or return a list of
  /// attribute names for a specific Inventory item type.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidTypeNameException].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [aggregator] :
  /// Returns inventory schemas that support aggregation. For example, this call
  /// returns the <code>AWS:InstanceInformation</code> type, because it supports
  /// aggregation based on the <code>PlatformName</code>,
  /// <code>PlatformType</code>, and <code>PlatformVersion</code> attributes.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [subType] :
  /// Returns the sub-type schema for a specified inventory type.
  ///
  /// Parameter [typeName] :
  /// The type of inventory item to return.
  Future<GetInventorySchemaResult> getInventorySchema({
    bool? aggregator,
    int? maxResults,
    String? nextToken,
    bool? subType,
    String? typeName,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      50,
      200,
    );
    _s.validateStringLength(
      'typeName',
      typeName,
      0,
      100,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetInventorySchema'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (aggregator != null) 'Aggregator': aggregator,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (subType != null) 'SubType': subType,
        if (typeName != null) 'TypeName': typeName,
      },
    );

    return GetInventorySchemaResult.fromJson(jsonResponse.body);
  }

  /// Retrieves a maintenance window.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window for which you want to retrieve
  /// information.
  Future<GetMaintenanceWindowResult> getMaintenanceWindow({
    required String windowId,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
      },
    );

    return GetMaintenanceWindowResult.fromJson(jsonResponse.body);
  }

  /// Retrieves details about a specific a maintenance window execution.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowExecutionId] :
  /// The ID of the maintenance window execution that includes the task.
  Future<GetMaintenanceWindowExecutionResult> getMaintenanceWindowExecution({
    required String windowExecutionId,
  }) async {
    ArgumentError.checkNotNull(windowExecutionId, 'windowExecutionId');
    _s.validateStringLength(
      'windowExecutionId',
      windowExecutionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowExecutionId',
      windowExecutionId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetMaintenanceWindowExecution'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowExecutionId': windowExecutionId,
      },
    );

    return GetMaintenanceWindowExecutionResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the details about a specific task run as part of a maintenance
  /// window execution.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [taskId] :
  /// The ID of the specific task execution in the maintenance window task that
  /// should be retrieved.
  ///
  /// Parameter [windowExecutionId] :
  /// The ID of the maintenance window execution that includes the task.
  Future<GetMaintenanceWindowExecutionTaskResult>
      getMaintenanceWindowExecutionTask({
    required String taskId,
    required String windowExecutionId,
  }) async {
    ArgumentError.checkNotNull(taskId, 'taskId');
    _s.validateStringLength(
      'taskId',
      taskId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'taskId',
      taskId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowExecutionId, 'windowExecutionId');
    _s.validateStringLength(
      'windowExecutionId',
      windowExecutionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowExecutionId',
      windowExecutionId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetMaintenanceWindowExecutionTask'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskId': taskId,
        'WindowExecutionId': windowExecutionId,
      },
    );

    return GetMaintenanceWindowExecutionTaskResult.fromJson(jsonResponse.body);
  }

  /// Retrieves information about a specific task running on a specific target.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [invocationId] :
  /// The invocation ID to retrieve.
  ///
  /// Parameter [taskId] :
  /// The ID of the specific task in the maintenance window task that should be
  /// retrieved.
  ///
  /// Parameter [windowExecutionId] :
  /// The ID of the maintenance window execution for which the task is a part.
  Future<GetMaintenanceWindowExecutionTaskInvocationResult>
      getMaintenanceWindowExecutionTaskInvocation({
    required String invocationId,
    required String taskId,
    required String windowExecutionId,
  }) async {
    ArgumentError.checkNotNull(invocationId, 'invocationId');
    _s.validateStringLength(
      'invocationId',
      invocationId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'invocationId',
      invocationId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(taskId, 'taskId');
    _s.validateStringLength(
      'taskId',
      taskId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'taskId',
      taskId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowExecutionId, 'windowExecutionId');
    _s.validateStringLength(
      'windowExecutionId',
      windowExecutionId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowExecutionId',
      windowExecutionId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetMaintenanceWindowExecutionTaskInvocation'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InvocationId': invocationId,
        'TaskId': taskId,
        'WindowExecutionId': windowExecutionId,
      },
    );

    return GetMaintenanceWindowExecutionTaskInvocationResult.fromJson(
        jsonResponse.body);
  }

  /// Lists the tasks in a maintenance window.
  /// <note>
  /// For maintenance window tasks without a specified target, you cannot supply
  /// values for <code>--max-errors</code> and <code>--max-concurrency</code>.
  /// Instead, the system inserts a placeholder value of <code>1</code>, which
  /// may be reported in the response to this command. These values do not
  /// affect the running of your task and can be ignored.
  /// </note>
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The maintenance window ID that includes the task to retrieve.
  ///
  /// Parameter [windowTaskId] :
  /// The maintenance window task ID to retrieve.
  Future<GetMaintenanceWindowTaskResult> getMaintenanceWindowTask({
    required String windowId,
    required String windowTaskId,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowTaskId, 'windowTaskId');
    _s.validateStringLength(
      'windowTaskId',
      windowTaskId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowTaskId',
      windowTaskId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetMaintenanceWindowTask'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        'WindowTaskId': windowTaskId,
      },
    );

    return GetMaintenanceWindowTaskResult.fromJson(jsonResponse.body);
  }

  /// Get information about an OpsItem by using the ID. You must have permission
  /// in AWS Identity and Access Management (IAM) to view information about an
  /// OpsItem. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html">Getting
  /// started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Operations engineers and IT professionals use OpsCenter to view,
  /// investigate, and remediate operational issues impacting the performance
  /// and health of their AWS resources. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html">AWS
  /// Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// May throw [InternalServerError].
  /// May throw [OpsItemNotFoundException].
  ///
  /// Parameter [opsItemId] :
  /// The ID of the OpsItem that you want to get.
  Future<GetOpsItemResponse> getOpsItem({
    required String opsItemId,
  }) async {
    ArgumentError.checkNotNull(opsItemId, 'opsItemId');
    _s.validateStringPattern(
      'opsItemId',
      opsItemId,
      r'''^(oi)-[0-9a-f]{12}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetOpsItem'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'OpsItemId': opsItemId,
      },
    );

    return GetOpsItemResponse.fromJson(jsonResponse.body);
  }

  /// View operational metadata related to an application in Application
  /// Manager.
  ///
  /// May throw [OpsMetadataNotFoundException].
  /// May throw [OpsMetadataInvalidArgumentException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [opsMetadataArn] :
  /// The Amazon Resource Name (ARN) of an OpsMetadata Object to view.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<GetOpsMetadataResult> getOpsMetadata({
    required String opsMetadataArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(opsMetadataArn, 'opsMetadataArn');
    _s.validateStringLength(
      'opsMetadataArn',
      opsMetadataArn,
      1,
      1011,
      isRequired: true,
    );
    _s.validateStringPattern(
      'opsMetadataArn',
      opsMetadataArn,
      r'''arn:(aws[a-zA-Z-]*)?:ssm:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:opsmetadata\/([a-zA-Z0-9-_\.\/]*)''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      10,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetOpsMetadata'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'OpsMetadataArn': opsMetadataArn,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return GetOpsMetadataResult.fromJson(jsonResponse.body);
  }

  /// View a summary of OpsItems based on specified filters and aggregators.
  ///
  /// May throw [InternalServerError].
  /// May throw [ResourceDataSyncNotFoundException].
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  /// May throw [InvalidTypeNameException].
  /// May throw [InvalidAggregatorException].
  ///
  /// Parameter [aggregators] :
  /// Optional aggregators that return counts of OpsItems based on one or more
  /// expressions.
  ///
  /// Parameter [filters] :
  /// Optional filters used to scope down the returned OpsItems.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  ///
  /// Parameter [resultAttributes] :
  /// The OpsItem data type to return.
  ///
  /// Parameter [syncName] :
  /// Specify the name of a resource data sync to get.
  Future<GetOpsSummaryResult> getOpsSummary({
    List<OpsAggregator>? aggregators,
    List<OpsFilter>? filters,
    int? maxResults,
    String? nextToken,
    List<OpsResultAttribute>? resultAttributes,
    String? syncName,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    _s.validateStringLength(
      'syncName',
      syncName,
      1,
      64,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetOpsSummary'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (aggregators != null) 'Aggregators': aggregators,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (resultAttributes != null) 'ResultAttributes': resultAttributes,
        if (syncName != null) 'SyncName': syncName,
      },
    );

    return GetOpsSummaryResult.fromJson(jsonResponse.body);
  }

  /// Get information about a parameter by using the parameter name. Don't
  /// confuse this API action with the <a>GetParameters</a> API action.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidKeyId].
  /// May throw [ParameterNotFound].
  /// May throw [ParameterVersionNotFound].
  ///
  /// Parameter [name] :
  /// The name of the parameter you want to query.
  ///
  /// Parameter [withDecryption] :
  /// Return decrypted values for secure string parameters. This flag is ignored
  /// for String and StringList parameter types.
  Future<GetParameterResult> getParameter({
    required String name,
    bool? withDecryption,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      2048,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetParameter'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (withDecryption != null) 'WithDecryption': withDecryption,
      },
    );

    return GetParameterResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the history of all changes to a parameter.
  ///
  /// May throw [InternalServerError].
  /// May throw [ParameterNotFound].
  /// May throw [InvalidNextToken].
  /// May throw [InvalidKeyId].
  ///
  /// Parameter [name] :
  /// The name of the parameter for which you want to review history.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [withDecryption] :
  /// Return decrypted values for secure string parameters. This flag is ignored
  /// for String and StringList parameter types.
  Future<GetParameterHistoryResult> getParameterHistory({
    required String name,
    int? maxResults,
    String? nextToken,
    bool? withDecryption,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      2048,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetParameterHistory'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (withDecryption != null) 'WithDecryption': withDecryption,
      },
    );

    return GetParameterHistoryResult.fromJson(jsonResponse.body);
  }

  /// Get details of a parameter. Don't confuse this API action with the
  /// <a>GetParameter</a> API action.
  ///
  /// May throw [InvalidKeyId].
  /// May throw [InternalServerError].
  ///
  /// Parameter [names] :
  /// Names of the parameters for which you want to query information.
  ///
  /// Parameter [withDecryption] :
  /// Return decrypted secure string value. Return decrypted values for secure
  /// string parameters. This flag is ignored for String and StringList
  /// parameter types.
  Future<GetParametersResult> getParameters({
    required List<String> names,
    bool? withDecryption,
  }) async {
    ArgumentError.checkNotNull(names, 'names');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetParameters'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Names': names,
        if (withDecryption != null) 'WithDecryption': withDecryption,
      },
    );

    return GetParametersResult.fromJson(jsonResponse.body);
  }

  /// Retrieve information about one or more parameters in a specific hierarchy.
  /// <note>
  /// Request results are returned on a best-effort basis. If you specify
  /// <code>MaxResults</code> in the request, the response includes information
  /// up to the limit specified. The number of items returned, however, can be
  /// between zero and the value of <code>MaxResults</code>. If the service
  /// reaches an internal limit while processing the results, it stops the
  /// operation and returns the matching values up to that point and a
  /// <code>NextToken</code>. You can specify the <code>NextToken</code> in a
  /// subsequent call to get the next set of results.
  /// </note>
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidFilterKey].
  /// May throw [InvalidFilterOption].
  /// May throw [InvalidFilterValue].
  /// May throw [InvalidKeyId].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [path] :
  /// The hierarchy for the parameter. Hierarchies start with a forward slash
  /// (/) and end with the parameter name. A parameter name hierarchy can have a
  /// maximum of 15 levels. Here is an example of a hierarchy:
  /// <code>/Finance/Prod/IAD/WinServ2016/license33</code>
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  ///
  /// Parameter [parameterFilters] :
  /// Filters to limit the request results.
  /// <note>
  /// For <code>GetParametersByPath</code>, the following filter
  /// <code>Key</code> names are supported: <code>Type</code>,
  /// <code>KeyId</code>, <code>Label</code>, and <code>DataType</code>.
  ///
  /// The following <code>Key</code> values are not supported for
  /// <code>GetParametersByPath</code>: <code>tag</code>, <code>Name</code>,
  /// <code>Path</code>, and <code>Tier</code>.
  /// </note>
  ///
  /// Parameter [recursive] :
  /// Retrieve all parameters within a hierarchy.
  /// <important>
  /// If a user has access to a path, then the user can access all levels of
  /// that path. For example, if a user has permission to access path
  /// <code>/a</code>, then the user can also access <code>/a/b</code>. Even if
  /// a user has explicitly been denied access in IAM for parameter
  /// <code>/a/b</code>, they can still call the GetParametersByPath API action
  /// recursively for <code>/a</code> and view <code>/a/b</code>.
  /// </important>
  ///
  /// Parameter [withDecryption] :
  /// Retrieve all parameters in a hierarchy with their value decrypted.
  Future<GetParametersByPathResult> getParametersByPath({
    required String path,
    int? maxResults,
    String? nextToken,
    List<ParameterStringFilter>? parameterFilters,
    bool? recursive,
    bool? withDecryption,
  }) async {
    ArgumentError.checkNotNull(path, 'path');
    _s.validateStringLength(
      'path',
      path,
      1,
      2048,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      10,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetParametersByPath'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Path': path,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (parameterFilters != null) 'ParameterFilters': parameterFilters,
        if (recursive != null) 'Recursive': recursive,
        if (withDecryption != null) 'WithDecryption': withDecryption,
      },
    );

    return GetParametersByPathResult.fromJson(jsonResponse.body);
  }

  /// Retrieves information about a patch baseline.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InvalidResourceId].
  /// May throw [InternalServerError].
  ///
  /// Parameter [baselineId] :
  /// The ID of the patch baseline to retrieve.
  Future<GetPatchBaselineResult> getPatchBaseline({
    required String baselineId,
  }) async {
    ArgumentError.checkNotNull(baselineId, 'baselineId');
    _s.validateStringLength(
      'baselineId',
      baselineId,
      20,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'baselineId',
      baselineId,
      r'''^[a-zA-Z0-9_\-:/]{20,128}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetPatchBaseline'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BaselineId': baselineId,
      },
    );

    return GetPatchBaselineResult.fromJson(jsonResponse.body);
  }

  /// Retrieves the patch baseline that should be used for the specified patch
  /// group.
  ///
  /// May throw [InternalServerError].
  ///
  /// Parameter [patchGroup] :
  /// The name of the patch group whose patch baseline should be retrieved.
  ///
  /// Parameter [operatingSystem] :
  /// Returns he operating system rule specified for patch groups using the
  /// patch baseline.
  Future<GetPatchBaselineForPatchGroupResult> getPatchBaselineForPatchGroup({
    required String patchGroup,
    OperatingSystem? operatingSystem,
  }) async {
    ArgumentError.checkNotNull(patchGroup, 'patchGroup');
    _s.validateStringLength(
      'patchGroup',
      patchGroup,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringPattern(
      'patchGroup',
      patchGroup,
      r'''^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetPatchBaselineForPatchGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'PatchGroup': patchGroup,
        if (operatingSystem != null)
          'OperatingSystem': operatingSystem.toValue(),
      },
    );

    return GetPatchBaselineForPatchGroupResult.fromJson(jsonResponse.body);
  }

  /// <code>ServiceSetting</code> is an account-level setting for an AWS
  /// service. This setting defines how a user interacts with or uses a service
  /// or a feature of a service. For example, if an AWS service charges money to
  /// the account based on feature or service usage, then the AWS service team
  /// might create a default setting of "false". This means the user can't use
  /// this feature unless they change the setting to "true" and intentionally
  /// opt in for a paid feature.
  ///
  /// Services map a <code>SettingId</code> object to a setting value. AWS
  /// services teams define the default value for a <code>SettingId</code>. You
  /// can't create a new <code>SettingId</code>, but you can overwrite the
  /// default value if you have the <code>ssm:UpdateServiceSetting</code>
  /// permission for the setting. Use the <a>UpdateServiceSetting</a> API action
  /// to change the default setting. Or use the <a>ResetServiceSetting</a> to
  /// change the value back to the original value defined by the AWS service
  /// team.
  ///
  /// Query the current service setting for the account.
  ///
  /// May throw [InternalServerError].
  /// May throw [ServiceSettingNotFound].
  ///
  /// Parameter [settingId] :
  /// The ID of the service setting to get. The setting ID can be
  /// <code>/ssm/parameter-store/default-parameter-tier</code>,
  /// <code>/ssm/parameter-store/high-throughput-enabled</code>, or
  /// <code>/ssm/managed-instance/activation-tier</code>.
  Future<GetServiceSettingResult> getServiceSetting({
    required String settingId,
  }) async {
    ArgumentError.checkNotNull(settingId, 'settingId');
    _s.validateStringLength(
      'settingId',
      settingId,
      1,
      1000,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.GetServiceSetting'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SettingId': settingId,
      },
    );

    return GetServiceSettingResult.fromJson(jsonResponse.body);
  }

  /// A parameter label is a user-defined alias to help you manage different
  /// versions of a parameter. When you modify a parameter, Systems Manager
  /// automatically saves a new version and increments the version number by
  /// one. A label can help you remember the purpose of a parameter when there
  /// are multiple versions.
  ///
  /// Parameter labels have the following requirements and restrictions.
  ///
  /// <ul>
  /// <li>
  /// A version of a parameter can have a maximum of 10 labels.
  /// </li>
  /// <li>
  /// You can't attach the same label to different versions of the same
  /// parameter. For example, if version 1 has the label Production, then you
  /// can't attach Production to version 2.
  /// </li>
  /// <li>
  /// You can move a label from one version of a parameter to another.
  /// </li>
  /// <li>
  /// You can't create a label when you create a new parameter. You must attach
  /// a label to a specific version of a parameter.
  /// </li>
  /// <li>
  /// You can't delete a parameter label. If you no longer want to use a
  /// parameter label, then you must move it to a different version of a
  /// parameter.
  /// </li>
  /// <li>
  /// A label can have a maximum of 100 characters.
  /// </li>
  /// <li>
  /// Labels can contain letters (case sensitive), numbers, periods (.), hyphens
  /// (-), or underscores (_).
  /// </li>
  /// <li>
  /// Labels can't begin with a number, "aws," or "ssm" (not case sensitive). If
  /// a label fails to meet these requirements, then the label is not associated
  /// with a parameter and the system displays it in the list of InvalidLabels.
  /// </li>
  /// </ul>
  ///
  /// May throw [InternalServerError].
  /// May throw [TooManyUpdates].
  /// May throw [ParameterNotFound].
  /// May throw [ParameterVersionNotFound].
  /// May throw [ParameterVersionLabelLimitExceeded].
  ///
  /// Parameter [labels] :
  /// One or more labels to attach to the specified parameter version.
  ///
  /// Parameter [name] :
  /// The parameter name on which you want to attach one or more labels.
  ///
  /// Parameter [parameterVersion] :
  /// The specific version of the parameter on which you want to attach one or
  /// more labels. If no version is specified, the system attaches the label to
  /// the latest version.
  Future<LabelParameterVersionResult> labelParameterVersion({
    required List<String> labels,
    required String name,
    int? parameterVersion,
  }) async {
    ArgumentError.checkNotNull(labels, 'labels');
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      2048,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.LabelParameterVersion'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Labels': labels,
        'Name': name,
        if (parameterVersion != null) 'ParameterVersion': parameterVersion,
      },
    );

    return LabelParameterVersionResult.fromJson(jsonResponse.body);
  }

  /// Retrieves all versions of an association for a specific association ID.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidNextToken].
  /// May throw [AssociationDoesNotExist].
  ///
  /// Parameter [associationId] :
  /// The association ID for which you want to view all versions.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<ListAssociationVersionsResult> listAssociationVersions({
    required String associationId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(associationId, 'associationId');
    _s.validateStringPattern(
      'associationId',
      associationId,
      r'''[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListAssociationVersions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AssociationId': associationId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListAssociationVersionsResult.fromJson(jsonResponse.body);
  }

  /// Returns all State Manager associations in the current AWS account and
  /// Region. You can limit the results to a specific State Manager association
  /// document or instance by specifying a filter.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [associationFilterList] :
  /// One or more filters. Use a filter to return a more specific list of
  /// results.
  /// <note>
  /// Filtering associations using the <code>InstanceID</code> attribute only
  /// returns legacy associations created using the <code>InstanceID</code>
  /// attribute. Associations targeting the instance that are part of the Target
  /// Attributes <code>ResourceGroup</code> or <code>Tags</code> are not
  /// returned.
  /// </note>
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<ListAssociationsResult> listAssociations({
    List<AssociationFilter>? associationFilterList,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListAssociations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (associationFilterList != null)
          'AssociationFilterList': associationFilterList,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListAssociationsResult.fromJson(jsonResponse.body);
  }

  /// An invocation is copy of a command sent to a specific instance. A command
  /// can apply to one or more instances. A command invocation applies to one
  /// instance. For example, if a user runs SendCommand against three instances,
  /// then a command invocation is created for each requested instance ID.
  /// ListCommandInvocations provide status about command execution.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidCommandId].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidFilterKey].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [commandId] :
  /// (Optional) The invocations for a specific command ID.
  ///
  /// Parameter [details] :
  /// (Optional) If set this returns the response of the command executions and
  /// any command output. By default this is set to False.
  ///
  /// Parameter [filters] :
  /// (Optional) One or more filters. Use a filter to return a more specific
  /// list of results.
  ///
  /// Parameter [instanceId] :
  /// (Optional) The command execution details for a specific instance ID.
  ///
  /// Parameter [maxResults] :
  /// (Optional) The maximum number of items to return for this call. The call
  /// also returns a token that you can specify in a subsequent call to get the
  /// next set of results.
  ///
  /// Parameter [nextToken] :
  /// (Optional) The token for the next set of items to return. (You received
  /// this token from a previous call.)
  Future<ListCommandInvocationsResult> listCommandInvocations({
    String? commandId,
    bool? details,
    List<CommandFilter>? filters,
    String? instanceId,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateStringLength(
      'commandId',
      commandId,
      36,
      36,
    );
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListCommandInvocations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (commandId != null) 'CommandId': commandId,
        if (details != null) 'Details': details,
        if (filters != null) 'Filters': filters,
        if (instanceId != null) 'InstanceId': instanceId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListCommandInvocationsResult.fromJson(jsonResponse.body);
  }

  /// Lists the commands requested by users of the AWS account.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidCommandId].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidFilterKey].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [commandId] :
  /// (Optional) If provided, lists only the specified command.
  ///
  /// Parameter [filters] :
  /// (Optional) One or more filters. Use a filter to return a more specific
  /// list of results.
  ///
  /// Parameter [instanceId] :
  /// (Optional) Lists commands issued against this instance ID.
  /// <note>
  /// You can't specify an instance ID in the same command that you specify
  /// <code>Status</code> = <code>Pending</code>. This is because the command
  /// has not reached the instance yet.
  /// </note>
  ///
  /// Parameter [maxResults] :
  /// (Optional) The maximum number of items to return for this call. The call
  /// also returns a token that you can specify in a subsequent call to get the
  /// next set of results.
  ///
  /// Parameter [nextToken] :
  /// (Optional) The token for the next set of items to return. (You received
  /// this token from a previous call.)
  Future<ListCommandsResult> listCommands({
    String? commandId,
    List<CommandFilter>? filters,
    String? instanceId,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateStringLength(
      'commandId',
      commandId,
      36,
      36,
    );
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListCommands'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (commandId != null) 'CommandId': commandId,
        if (filters != null) 'Filters': filters,
        if (instanceId != null) 'InstanceId': instanceId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListCommandsResult.fromJson(jsonResponse.body);
  }

  /// For a specified resource ID, this API action returns a list of compliance
  /// statuses for different resource types. Currently, you can only specify one
  /// resource ID per call. List results depend on the criteria specified in the
  /// filter.
  ///
  /// May throw [InvalidResourceType].
  /// May throw [InvalidResourceId].
  /// May throw [InternalServerError].
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [filters] :
  /// One or more compliance filters. Use a filter to return a more specific
  /// list of results.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  ///
  /// Parameter [resourceIds] :
  /// The ID for the resources from which to get compliance information.
  /// Currently, you can only specify one resource ID.
  ///
  /// Parameter [resourceTypes] :
  /// The type of resource from which to get compliance information. Currently,
  /// the only supported resource type is <code>ManagedInstance</code>.
  Future<ListComplianceItemsResult> listComplianceItems({
    List<ComplianceStringFilter>? filters,
    int? maxResults,
    String? nextToken,
    List<String>? resourceIds,
    List<String>? resourceTypes,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListComplianceItems'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (resourceIds != null) 'ResourceIds': resourceIds,
        if (resourceTypes != null) 'ResourceTypes': resourceTypes,
      },
    );

    return ListComplianceItemsResult.fromJson(jsonResponse.body);
  }

  /// Returns a summary count of compliant and non-compliant resources for a
  /// compliance type. For example, this call can return State Manager
  /// associations, patches, or custom compliance types according to the filter
  /// criteria that you specify.
  ///
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// One or more compliance or inventory filters. Use a filter to return a more
  /// specific list of results.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. Currently, you can
  /// specify null or 50. The call also returns a token that you can specify in
  /// a subsequent call to get the next set of results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<ListComplianceSummariesResult> listComplianceSummaries({
    List<ComplianceStringFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListComplianceSummaries'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListComplianceSummariesResult.fromJson(jsonResponse.body);
  }

  /// Information about approval reviews for a version of an SSM document.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentVersion].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [metadata] :
  /// The type of data for which details are being requested. Currently, the
  /// only supported value is <code>DocumentReviews</code>.
  ///
  /// Parameter [name] :
  /// The name of the document.
  ///
  /// Parameter [documentVersion] :
  /// The version of the document.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<ListDocumentMetadataHistoryResponse> listDocumentMetadataHistory({
    required DocumentMetadataEnum metadata,
    required String name,
    String? documentVersion,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(metadata, 'metadata');
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListDocumentMetadataHistory'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Metadata': metadata.toValue(),
        'Name': name,
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListDocumentMetadataHistoryResponse.fromJson(jsonResponse.body);
  }

  /// List all versions for a document.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidNextToken].
  /// May throw [InvalidDocument].
  ///
  /// Parameter [name] :
  /// The name of the document. You can specify an Amazon Resource Name (ARN).
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<ListDocumentVersionsResult> listDocumentVersions({
    required String name,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListDocumentVersions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListDocumentVersionsResult.fromJson(jsonResponse.body);
  }

  /// Returns all Systems Manager (SSM) documents in the current AWS account and
  /// Region. You can limit the results of this request by using a filter.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidNextToken].
  /// May throw [InvalidFilterKey].
  ///
  /// Parameter [documentFilterList] :
  /// This data type is deprecated. Instead, use <code>Filters</code>.
  ///
  /// Parameter [filters] :
  /// One or more DocumentKeyValuesFilter objects. Use a filter to return a more
  /// specific list of results. For keys, you can specify one or more key-value
  /// pair tags that have been applied to a document. Other valid keys include
  /// <code>Owner</code>, <code>Name</code>, <code>PlatformTypes</code>,
  /// <code>DocumentType</code>, and <code>TargetType</code>. For example, to
  /// return documents you own use <code>Key=Owner,Values=Self</code>. To
  /// specify a custom key-value pair, use the format
  /// <code>Key=tag:tagName,Values=valueName</code>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<ListDocumentsResult> listDocuments({
    List<DocumentFilter>? documentFilterList,
    List<DocumentKeyValuesFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListDocuments'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (documentFilterList != null)
          'DocumentFilterList': documentFilterList,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListDocumentsResult.fromJson(jsonResponse.body);
  }

  /// A list of inventory items returned by the request.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidTypeNameException].
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [instanceId] :
  /// The instance ID for which you want inventory information.
  ///
  /// Parameter [typeName] :
  /// The type of inventory item for which you want information.
  ///
  /// Parameter [filters] :
  /// One or more filters. Use a filter to return a more specific list of
  /// results.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<ListInventoryEntriesResult> listInventoryEntries({
    required String instanceId,
    required String typeName,
    List<InventoryFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(typeName, 'typeName');
    _s.validateStringLength(
      'typeName',
      typeName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'typeName',
      typeName,
      r'''^(AWS|Custom):.*$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListInventoryEntries'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceId': instanceId,
        'TypeName': typeName,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListInventoryEntriesResult.fromJson(jsonResponse.body);
  }

  /// Returns a list of all OpsItem events in the current AWS account and
  /// Region. You can limit the results to events associated with specific
  /// OpsItems by specifying a filter.
  ///
  /// May throw [InternalServerError].
  /// May throw [OpsItemNotFoundException].
  /// May throw [OpsItemLimitExceededException].
  /// May throw [OpsItemInvalidParameterException].
  ///
  /// Parameter [filters] :
  /// One or more OpsItem filters. Use a filter to return a more specific list
  /// of results.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<ListOpsItemEventsResponse> listOpsItemEvents({
    List<OpsItemEventFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListOpsItemEvents'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListOpsItemEventsResponse.fromJson(jsonResponse.body);
  }

  /// Systems Manager calls this API action when displaying all Application
  /// Manager OpsMetadata objects or blobs.
  ///
  /// May throw [OpsMetadataInvalidArgumentException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// One or more filters to limit the number of OpsMetadata objects returned by
  /// the call.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<ListOpsMetadataResult> listOpsMetadata({
    List<OpsMetadataFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListOpsMetadata'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListOpsMetadataResult.fromJson(jsonResponse.body);
  }

  /// Returns a resource-level summary count. The summary includes information
  /// about compliant and non-compliant statuses and detailed compliance-item
  /// severity counts, according to the filter criteria you specify.
  ///
  /// May throw [InvalidFilter].
  /// May throw [InvalidNextToken].
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// One or more filters. Use a filter to return a more specific list of
  /// results.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  Future<ListResourceComplianceSummariesResult>
      listResourceComplianceSummaries({
    List<ComplianceStringFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListResourceComplianceSummaries'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListResourceComplianceSummariesResult.fromJson(jsonResponse.body);
  }

  /// Lists your resource data sync configurations. Includes information about
  /// the last time a sync attempted to start, the last sync status, and the
  /// last time a sync successfully completed.
  ///
  /// The number of sync configurations might be too large to return using a
  /// single call to <code>ListResourceDataSync</code>. You can limit the number
  /// of sync configurations returned by using the <code>MaxResults</code>
  /// parameter. To determine whether there are more sync configurations to
  /// list, check the value of <code>NextToken</code> in the output. If there
  /// are more sync configurations to list, you can request them by specifying
  /// the <code>NextToken</code> returned in the call to the parameter of a
  /// subsequent call.
  ///
  /// May throw [ResourceDataSyncInvalidConfigurationException].
  /// May throw [InternalServerError].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to return for this call. The call also returns
  /// a token that you can specify in a subsequent call to get the next set of
  /// results.
  ///
  /// Parameter [nextToken] :
  /// A token to start the list. Use this token to get the next set of results.
  ///
  /// Parameter [syncType] :
  /// View a list of resource data syncs according to the sync type. Specify
  /// <code>SyncToDestination</code> to view resource data syncs that
  /// synchronize data to an Amazon S3 bucket. Specify
  /// <code>SyncFromSource</code> to view resource data syncs from AWS
  /// Organizations or from multiple AWS Regions.
  Future<ListResourceDataSyncResult> listResourceDataSync({
    int? maxResults,
    String? nextToken,
    String? syncType,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    _s.validateStringLength(
      'syncType',
      syncType,
      1,
      64,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListResourceDataSync'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (syncType != null) 'SyncType': syncType,
      },
    );

    return ListResourceDataSyncResult.fromJson(jsonResponse.body);
  }

  /// Returns a list of the tags assigned to the specified resource.
  ///
  /// May throw [InvalidResourceType].
  /// May throw [InvalidResourceId].
  /// May throw [InternalServerError].
  ///
  /// Parameter [resourceId] :
  /// The resource ID for which you want to see a list of tags.
  ///
  /// Parameter [resourceType] :
  /// Returns a list of tags for a specific resource type.
  Future<ListTagsForResourceResult> listTagsForResource({
    required String resourceId,
    required ResourceTypeForTagging resourceType,
  }) async {
    ArgumentError.checkNotNull(resourceId, 'resourceId');
    ArgumentError.checkNotNull(resourceType, 'resourceType');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ListTagsForResource'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceId': resourceId,
        'ResourceType': resourceType.toValue(),
      },
    );

    return ListTagsForResourceResult.fromJson(jsonResponse.body);
  }

  /// Shares a Systems Manager document publicly or privately. If you share a
  /// document privately, you must specify the AWS user account IDs for those
  /// people who can use the document. If you share a document publicly, you
  /// must specify <i>All</i> as the account ID.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidPermissionType].
  /// May throw [DocumentPermissionLimit].
  /// May throw [DocumentLimitExceeded].
  ///
  /// Parameter [name] :
  /// The name of the document that you want to share.
  ///
  /// Parameter [permissionType] :
  /// The permission type for the document. The permission type can be
  /// <i>Share</i>.
  ///
  /// Parameter [accountIdsToAdd] :
  /// The AWS user accounts that should have access to the document. The account
  /// IDs can either be a group of account IDs or <i>All</i>.
  ///
  /// Parameter [accountIdsToRemove] :
  /// The AWS user accounts that should no longer have access to the document.
  /// The AWS user account can either be a group of account IDs or <i>All</i>.
  /// This action has a higher priority than <i>AccountIdsToAdd</i>. If you
  /// specify an account ID to add and the same ID to remove, the system removes
  /// access to the document.
  ///
  /// Parameter [sharedDocumentVersion] :
  /// (Optional) The version of the document to share. If it's not specified,
  /// the system choose the <code>Default</code> version to share.
  Future<void> modifyDocumentPermission({
    required String name,
    required DocumentPermissionType permissionType,
    List<String>? accountIdsToAdd,
    List<String>? accountIdsToRemove,
    String? sharedDocumentVersion,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(permissionType, 'permissionType');
    _s.validateStringLength(
      'sharedDocumentVersion',
      sharedDocumentVersion,
      0,
      8,
    );
    _s.validateStringPattern(
      'sharedDocumentVersion',
      sharedDocumentVersion,
      r'''([$]LATEST|[$]DEFAULT|[$]ALL)''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ModifyDocumentPermission'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        'PermissionType': permissionType.toValue(),
        if (accountIdsToAdd != null) 'AccountIdsToAdd': accountIdsToAdd,
        if (accountIdsToRemove != null)
          'AccountIdsToRemove': accountIdsToRemove,
        if (sharedDocumentVersion != null)
          'SharedDocumentVersion': sharedDocumentVersion,
      },
    );
  }

  /// Registers a compliance type and other compliance details on a designated
  /// resource. This action lets you register custom compliance details with a
  /// resource. This call overwrites existing compliance information on the
  /// resource, so you must provide a full list of compliance items each time
  /// that you send the request.
  ///
  /// ComplianceType can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// ExecutionId: The execution ID when the patch, association, or custom
  /// compliance item was applied.
  /// </li>
  /// <li>
  /// ExecutionType: Specify patch, association, or Custom:<code>string</code>.
  /// </li>
  /// <li>
  /// ExecutionTime. The time the patch, association, or custom compliance item
  /// was applied to the instance.
  /// </li>
  /// <li>
  /// Id: The patch, association, or custom compliance ID.
  /// </li>
  /// <li>
  /// Title: A title.
  /// </li>
  /// <li>
  /// Status: The status of the compliance item. For example,
  /// <code>approved</code> for patches, or <code>Failed</code> for
  /// associations.
  /// </li>
  /// <li>
  /// Severity: A patch severity. For example, <code>critical</code>.
  /// </li>
  /// <li>
  /// DocumentName: A SSM document name. For example, AWS-RunPatchBaseline.
  /// </li>
  /// <li>
  /// DocumentVersion: An SSM document version number. For example, 4.
  /// </li>
  /// <li>
  /// Classification: A patch classification. For example, <code>security
  /// updates</code>.
  /// </li>
  /// <li>
  /// PatchBaselineId: A patch baseline ID.
  /// </li>
  /// <li>
  /// PatchSeverity: A patch severity. For example, <code>Critical</code>.
  /// </li>
  /// <li>
  /// PatchState: A patch state. For example,
  /// <code>InstancesWithFailedPatches</code>.
  /// </li>
  /// <li>
  /// PatchGroup: The name of a patch group.
  /// </li>
  /// <li>
  /// InstalledTime: The time the association, patch, or custom compliance item
  /// was applied to the resource. Specify the time by using the following
  /// format: yyyy-MM-dd'T'HH:mm:ss'Z'
  /// </li>
  /// </ul>
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidItemContentException].
  /// May throw [TotalSizeLimitExceededException].
  /// May throw [ItemSizeLimitExceededException].
  /// May throw [ComplianceTypeCountLimitExceededException].
  /// May throw [InvalidResourceType].
  /// May throw [InvalidResourceId].
  ///
  /// Parameter [complianceType] :
  /// Specify the compliance type. For example, specify Association (for a State
  /// Manager association), Patch, or Custom:<code>string</code>.
  ///
  /// Parameter [executionSummary] :
  /// A summary of the call execution that includes an execution ID, the type of
  /// execution (for example, <code>Command</code>), and the date/time of the
  /// execution using a datetime object that is saved in the following format:
  /// yyyy-MM-dd'T'HH:mm:ss'Z'.
  ///
  /// Parameter [items] :
  /// Information about the compliance as defined by the resource type. For
  /// example, for a patch compliance type, <code>Items</code> includes
  /// information about the PatchSeverity, Classification, and so on.
  ///
  /// Parameter [resourceId] :
  /// Specify an ID for this resource. For a managed instance, this is the
  /// instance ID.
  ///
  /// Parameter [resourceType] :
  /// Specify the type of resource. <code>ManagedInstance</code> is currently
  /// the only supported resource type.
  ///
  /// Parameter [itemContentHash] :
  /// MD5 or SHA-256 content hash. The content hash is used to determine if
  /// existing information should be overwritten or ignored. If the content
  /// hashes match, the request to put compliance information is ignored.
  ///
  /// Parameter [uploadType] :
  /// The mode for uploading compliance items. You can specify
  /// <code>COMPLETE</code> or <code>PARTIAL</code>. In <code>COMPLETE</code>
  /// mode, the system overwrites all existing compliance information for the
  /// resource. You must provide a full list of compliance items each time you
  /// send the request.
  ///
  /// In <code>PARTIAL</code> mode, the system overwrites compliance information
  /// for a specific association. The association must be configured with
  /// <code>SyncCompliance</code> set to <code>MANUAL</code>. By default, all
  /// requests use <code>COMPLETE</code> mode.
  /// <note>
  /// This attribute is only valid for association compliance.
  /// </note>
  Future<void> putComplianceItems({
    required String complianceType,
    required ComplianceExecutionSummary executionSummary,
    required List<ComplianceItemEntry> items,
    required String resourceId,
    required String resourceType,
    String? itemContentHash,
    ComplianceUploadType? uploadType,
  }) async {
    ArgumentError.checkNotNull(complianceType, 'complianceType');
    _s.validateStringLength(
      'complianceType',
      complianceType,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'complianceType',
      complianceType,
      r'''[A-Za-z0-9_\-]\w+|Custom:[a-zA-Z0-9_\-]\w+''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(executionSummary, 'executionSummary');
    ArgumentError.checkNotNull(items, 'items');
    ArgumentError.checkNotNull(resourceId, 'resourceId');
    _s.validateStringLength(
      'resourceId',
      resourceId,
      1,
      100,
      isRequired: true,
    );
    ArgumentError.checkNotNull(resourceType, 'resourceType');
    _s.validateStringLength(
      'resourceType',
      resourceType,
      1,
      50,
      isRequired: true,
    );
    _s.validateStringLength(
      'itemContentHash',
      itemContentHash,
      0,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.PutComplianceItems'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ComplianceType': complianceType,
        'ExecutionSummary': executionSummary,
        'Items': items,
        'ResourceId': resourceId,
        'ResourceType': resourceType,
        if (itemContentHash != null) 'ItemContentHash': itemContentHash,
        if (uploadType != null) 'UploadType': uploadType.toValue(),
      },
    );
  }

  /// Bulk update custom inventory items on one more instance. The request adds
  /// an inventory item, if it doesn't already exist, or updates an inventory
  /// item, if it does exist.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidTypeNameException].
  /// May throw [InvalidItemContentException].
  /// May throw [TotalSizeLimitExceededException].
  /// May throw [ItemSizeLimitExceededException].
  /// May throw [ItemContentMismatchException].
  /// May throw [CustomSchemaCountLimitExceededException].
  /// May throw [UnsupportedInventorySchemaVersionException].
  /// May throw [UnsupportedInventoryItemContextException].
  /// May throw [InvalidInventoryItemContextException].
  /// May throw [SubTypeCountLimitExceededException].
  ///
  /// Parameter [instanceId] :
  /// An instance ID where you want to add or update inventory items.
  ///
  /// Parameter [items] :
  /// The inventory items that you want to add or update on instances.
  Future<PutInventoryResult> putInventory({
    required String instanceId,
    required List<InventoryItem> items,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(items, 'items');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.PutInventory'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'InstanceId': instanceId,
        'Items': items,
      },
    );

    return PutInventoryResult.fromJson(jsonResponse.body);
  }

  /// Add a parameter to the system.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidKeyId].
  /// May throw [ParameterLimitExceeded].
  /// May throw [TooManyUpdates].
  /// May throw [ParameterAlreadyExists].
  /// May throw [HierarchyLevelLimitExceededException].
  /// May throw [HierarchyTypeMismatchException].
  /// May throw [InvalidAllowedPatternException].
  /// May throw [ParameterMaxVersionLimitExceeded].
  /// May throw [ParameterPatternMismatchException].
  /// May throw [UnsupportedParameterType].
  /// May throw [PoliciesLimitExceededException].
  /// May throw [InvalidPolicyTypeException].
  /// May throw [InvalidPolicyAttributeException].
  /// May throw [IncompatiblePolicyException].
  ///
  /// Parameter [name] :
  /// The fully qualified name of the parameter that you want to add to the
  /// system. The fully qualified name includes the complete hierarchy of the
  /// parameter path and name. For parameters in a hierarchy, you must include a
  /// leading forward slash character (/) when you create or reference a
  /// parameter. For example: <code>/Dev/DBServer/MySQL/db-string13</code>
  ///
  /// Naming Constraints:
  ///
  /// <ul>
  /// <li>
  /// Parameter names are case sensitive.
  /// </li>
  /// <li>
  /// A parameter name must be unique within an AWS Region
  /// </li>
  /// <li>
  /// A parameter name can't be prefixed with "aws" or "ssm" (case-insensitive).
  /// </li>
  /// <li>
  /// Parameter names can include only the following symbols and letters:
  /// <code>a-zA-Z0-9_.-/</code>
  /// </li>
  /// <li>
  /// A parameter name can't include spaces.
  /// </li>
  /// <li>
  /// Parameter hierarchies are limited to a maximum depth of fifteen levels.
  /// </li>
  /// </ul>
  /// For additional information about valid values for parameter names, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-parameter-name-constraints.html">About
  /// requirements and constraints for parameter names</a> in the <i>AWS Systems
  /// Manager User Guide</i>.
  /// <note>
  /// The maximum length constraint listed below includes capacity for
  /// additional system attributes that are not part of the name. The maximum
  /// length for a parameter name, including the full length of the parameter
  /// ARN, is 1011 characters. For example, the length of the following
  /// parameter name is 65 characters, not 20 characters:
  ///
  /// <code>arn:aws:ssm:us-east-2:111122223333:parameter/ExampleParameterName</code>
  /// </note>
  ///
  /// Parameter [value] :
  /// The parameter value that you want to add to the system. Standard
  /// parameters have a value limit of 4 KB. Advanced parameters have a value
  /// limit of 8 KB.
  /// <note>
  /// Parameters can't be referenced or nested in the values of other
  /// parameters. You can't include <code>{{}}</code> or
  /// <code>{{ssm:<i>parameter-name</i>}}</code> in a parameter value.
  /// </note>
  ///
  /// Parameter [allowedPattern] :
  /// A regular expression used to validate the parameter value. For example,
  /// for String types with values restricted to numbers, you can specify the
  /// following: AllowedPattern=^\d+$
  ///
  /// Parameter [dataType] :
  /// The data type for a <code>String</code> parameter. Supported data types
  /// include plain text and Amazon Machine Image IDs.
  ///
  /// <b>The following data type values are supported.</b>
  ///
  /// <ul>
  /// <li>
  /// <code>text</code>
  /// </li>
  /// <li>
  /// <code>aws:ec2:image</code>
  /// </li>
  /// </ul>
  /// When you create a <code>String</code> parameter and specify
  /// <code>aws:ec2:image</code>, Systems Manager validates the parameter value
  /// is in the required format, such as <code>ami-12345abcdeEXAMPLE</code>, and
  /// that the specified AMI is available in your AWS account. For more
  /// information, see <a
  /// href="http://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html">Native
  /// parameter support for Amazon Machine Image IDs</a> in the <i>AWS Systems
  /// Manager User Guide</i>.
  ///
  /// Parameter [description] :
  /// Information about the parameter that you want to add to the system.
  /// Optional but recommended.
  /// <important>
  /// Do not enter personally identifiable information in this field.
  /// </important>
  ///
  /// Parameter [keyId] :
  /// The KMS Key ID that you want to use to encrypt a parameter. Either the
  /// default AWS Key Management Service (AWS KMS) key automatically assigned to
  /// your AWS account or a custom key. Required for parameters that use the
  /// <code>SecureString</code> data type.
  ///
  /// If you don't specify a key ID, the system uses the default key associated
  /// with your AWS account.
  ///
  /// <ul>
  /// <li>
  /// To use your default AWS KMS key, choose the <code>SecureString</code> data
  /// type, and do <i>not</i> specify the <code>Key ID</code> when you create
  /// the parameter. The system automatically populates <code>Key ID</code> with
  /// your default KMS key.
  /// </li>
  /// <li>
  /// To use a custom KMS key, choose the <code>SecureString</code> data type
  /// with the <code>Key ID</code> parameter.
  /// </li>
  /// </ul>
  ///
  /// Parameter [overwrite] :
  /// Overwrite an existing parameter. If not specified, will default to
  /// "false".
  ///
  /// Parameter [policies] :
  /// One or more policies to apply to a parameter. This action takes a JSON
  /// array. Parameter Store supports the following policy types:
  ///
  /// Expiration: This policy deletes the parameter after it expires. When you
  /// create the policy, you specify the expiration date. You can update the
  /// expiration date and time by updating the policy. Updating the
  /// <i>parameter</i> does not affect the expiration date and time. When the
  /// expiration time is reached, Parameter Store deletes the parameter.
  ///
  /// ExpirationNotification: This policy triggers an event in Amazon CloudWatch
  /// Events that notifies you about the expiration. By using this policy, you
  /// can receive notification before or after the expiration time is reached,
  /// in units of days or hours.
  ///
  /// NoChangeNotification: This policy triggers a CloudWatch event if a
  /// parameter has not been modified for a specified period of time. This
  /// policy type is useful when, for example, a secret needs to be changed
  /// within a period of time, but it has not been changed.
  ///
  /// All existing policies are preserved until you send new policies or an
  /// empty policy. For more information about parameter policies, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-policies.html">Assigning
  /// parameter policies</a>.
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. Tags enable you to
  /// categorize a resource in different ways, such as by purpose, owner, or
  /// environment. For example, you might want to tag a Systems Manager
  /// parameter to identify the type of resource to which it applies, the
  /// environment, or the type of configuration data referenced by the
  /// parameter. In this case, you could specify the following key name/value
  /// pairs:
  ///
  /// <ul>
  /// <li>
  /// <code>Key=Resource,Value=S3bucket</code>
  /// </li>
  /// <li>
  /// <code>Key=OS,Value=Windows</code>
  /// </li>
  /// <li>
  /// <code>Key=ParameterType,Value=LicenseKey</code>
  /// </li>
  /// </ul> <note>
  /// To add tags to an existing Systems Manager parameter, use the
  /// <a>AddTagsToResource</a> action.
  /// </note>
  ///
  /// Parameter [tier] :
  /// The parameter tier to assign to a parameter.
  ///
  /// Parameter Store offers a standard tier and an advanced tier for
  /// parameters. Standard parameters have a content size limit of 4 KB and
  /// can't be configured to use parameter policies. You can create a maximum of
  /// 10,000 standard parameters for each Region in an AWS account. Standard
  /// parameters are offered at no additional cost.
  ///
  /// Advanced parameters have a content size limit of 8 KB and can be
  /// configured to use parameter policies. You can create a maximum of 100,000
  /// advanced parameters for each Region in an AWS account. Advanced parameters
  /// incur a charge. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html">Standard
  /// and advanced parameter tiers</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// You can change a standard parameter to an advanced parameter any time. But
  /// you can't revert an advanced parameter to a standard parameter. Reverting
  /// an advanced parameter to a standard parameter would result in data loss
  /// because the system would truncate the size of the parameter from 8 KB to 4
  /// KB. Reverting would also remove any policies attached to the parameter.
  /// Lastly, advanced parameters use a different form of encryption than
  /// standard parameters.
  ///
  /// If you no longer need an advanced parameter, or if you no longer want to
  /// incur charges for an advanced parameter, you must delete it and recreate
  /// it as a new standard parameter.
  ///
  /// <b>Using the Default Tier Configuration</b>
  ///
  /// In <code>PutParameter</code> requests, you can specify the tier to create
  /// the parameter in. Whenever you specify a tier in the request, Parameter
  /// Store creates or updates the parameter according to that request. However,
  /// if you do not specify a tier in a request, Parameter Store assigns the
  /// tier based on the current Parameter Store default tier configuration.
  ///
  /// The default tier when you begin using Parameter Store is the
  /// standard-parameter tier. If you use the advanced-parameter tier, you can
  /// specify one of the following as the default:
  ///
  /// <ul>
  /// <li>
  /// <b>Advanced</b>: With this option, Parameter Store evaluates all requests
  /// as advanced parameters.
  /// </li>
  /// <li>
  /// <b>Intelligent-Tiering</b>: With this option, Parameter Store evaluates
  /// each request to determine if the parameter is standard or advanced.
  ///
  /// If the request doesn't include any options that require an advanced
  /// parameter, the parameter is created in the standard-parameter tier. If one
  /// or more options requiring an advanced parameter are included in the
  /// request, Parameter Store create a parameter in the advanced-parameter
  /// tier.
  ///
  /// This approach helps control your parameter-related costs by always
  /// creating standard parameters unless an advanced parameter is necessary.
  /// </li>
  /// </ul>
  /// Options that require an advanced parameter include the following:
  ///
  /// <ul>
  /// <li>
  /// The content size of the parameter is more than 4 KB.
  /// </li>
  /// <li>
  /// The parameter uses a parameter policy.
  /// </li>
  /// <li>
  /// More than 10,000 parameters already exist in your AWS account in the
  /// current Region.
  /// </li>
  /// </ul>
  /// For more information about configuring the default tier option, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/ps-default-tier.html">Specifying
  /// a default parameter tier</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [type] :
  /// The type of parameter that you want to add to the system.
  /// <note>
  /// <code>SecureString</code> is not currently supported for AWS
  /// CloudFormation templates.
  /// </note>
  /// Items in a <code>StringList</code> must be separated by a comma (,). You
  /// can't use other punctuation or special character to escape items in the
  /// list. If you have a parameter value that requires a comma, then use the
  /// <code>String</code> data type.
  /// <important>
  /// Specifying a parameter type is not required when updating a parameter. You
  /// must specify a parameter type when creating a parameter.
  /// </important>
  Future<PutParameterResult> putParameter({
    required String name,
    required String value,
    String? allowedPattern,
    String? dataType,
    String? description,
    String? keyId,
    bool? overwrite,
    String? policies,
    List<Tag>? tags,
    ParameterTier? tier,
    ParameterType? type,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(value, 'value');
    _s.validateStringLength(
      'allowedPattern',
      allowedPattern,
      0,
      1024,
    );
    _s.validateStringLength(
      'dataType',
      dataType,
      0,
      128,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      1024,
    );
    _s.validateStringLength(
      'keyId',
      keyId,
      1,
      256,
    );
    _s.validateStringPattern(
      'keyId',
      keyId,
      r'''^([a-zA-Z0-9:/_-]+)$''',
    );
    _s.validateStringLength(
      'policies',
      policies,
      1,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.PutParameter'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        'Value': value,
        if (allowedPattern != null) 'AllowedPattern': allowedPattern,
        if (dataType != null) 'DataType': dataType,
        if (description != null) 'Description': description,
        if (keyId != null) 'KeyId': keyId,
        if (overwrite != null) 'Overwrite': overwrite,
        if (policies != null) 'Policies': policies,
        if (tags != null) 'Tags': tags,
        if (tier != null) 'Tier': tier.toValue(),
        if (type != null) 'Type': type.toValue(),
      },
    );

    return PutParameterResult.fromJson(jsonResponse.body);
  }

  /// Defines the default patch baseline for the relevant operating system.
  ///
  /// To reset the AWS predefined patch baseline as the default, specify the
  /// full patch baseline ARN as the baseline ID value. For example, for CentOS,
  /// specify
  /// <code>arn:aws:ssm:us-east-2:733109147000:patchbaseline/pb-0574b43a65ea646ed</code>
  /// instead of <code>pb-0574b43a65ea646ed</code>.
  ///
  /// May throw [InvalidResourceId].
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [baselineId] :
  /// The ID of the patch baseline that should be the default patch baseline.
  Future<RegisterDefaultPatchBaselineResult> registerDefaultPatchBaseline({
    required String baselineId,
  }) async {
    ArgumentError.checkNotNull(baselineId, 'baselineId');
    _s.validateStringLength(
      'baselineId',
      baselineId,
      20,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'baselineId',
      baselineId,
      r'''^[a-zA-Z0-9_\-:/]{20,128}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.RegisterDefaultPatchBaseline'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BaselineId': baselineId,
      },
    );

    return RegisterDefaultPatchBaselineResult.fromJson(jsonResponse.body);
  }

  /// Registers a patch baseline for a patch group.
  ///
  /// May throw [AlreadyExistsException].
  /// May throw [DoesNotExistException].
  /// May throw [InvalidResourceId].
  /// May throw [ResourceLimitExceededException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [baselineId] :
  /// The ID of the patch baseline to register the patch group with.
  ///
  /// Parameter [patchGroup] :
  /// The name of the patch group that should be registered with the patch
  /// baseline.
  Future<RegisterPatchBaselineForPatchGroupResult>
      registerPatchBaselineForPatchGroup({
    required String baselineId,
    required String patchGroup,
  }) async {
    ArgumentError.checkNotNull(baselineId, 'baselineId');
    _s.validateStringLength(
      'baselineId',
      baselineId,
      20,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'baselineId',
      baselineId,
      r'''^[a-zA-Z0-9_\-:/]{20,128}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(patchGroup, 'patchGroup');
    _s.validateStringLength(
      'patchGroup',
      patchGroup,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringPattern(
      'patchGroup',
      patchGroup,
      r'''^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.RegisterPatchBaselineForPatchGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BaselineId': baselineId,
        'PatchGroup': patchGroup,
      },
    );

    return RegisterPatchBaselineForPatchGroupResult.fromJson(jsonResponse.body);
  }

  /// Registers a target with a maintenance window.
  ///
  /// May throw [IdempotentParameterMismatch].
  /// May throw [DoesNotExistException].
  /// May throw [ResourceLimitExceededException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [resourceType] :
  /// The type of target being registered with the maintenance window.
  ///
  /// Parameter [targets] :
  /// The targets to register with the maintenance window. In other words, the
  /// instances to run commands on when the maintenance window runs.
  ///
  /// You can specify targets using instance IDs, resource group names, or tags
  /// that have been applied to instances.
  ///
  /// <b>Example 1</b>: Specify instance IDs
  ///
  /// <code>Key=InstanceIds,Values=<i>instance-id-1</i>,<i>instance-id-2</i>,<i>instance-id-3</i>
  /// </code>
  ///
  /// <b>Example 2</b>: Use tag key-pairs applied to instances
  ///
  /// <code>Key=tag:<i>my-tag-key</i>,Values=<i>my-tag-value-1</i>,<i>my-tag-value-2</i>
  /// </code>
  ///
  /// <b>Example 3</b>: Use tag-keys applied to instances
  ///
  /// <code>Key=tag-key,Values=<i>my-tag-key-1</i>,<i>my-tag-key-2</i> </code>
  ///
  /// <b>Example 4</b>: Use resource group names
  ///
  /// <code>Key=resource-groups:Name,Values=<i>resource-group-name</i> </code>
  ///
  /// <b>Example 5</b>: Use filters for resource group types
  ///
  /// <code>Key=resource-groups:ResourceTypeFilters,Values=<i>resource-type-1</i>,<i>resource-type-2</i>
  /// </code>
  /// <note>
  /// For <code>Key=resource-groups:ResourceTypeFilters</code>, specify resource
  /// types in the following format
  ///
  /// <code>Key=resource-groups:ResourceTypeFilters,Values=<i>AWS::EC2::INSTANCE</i>,<i>AWS::EC2::VPC</i>
  /// </code>
  /// </note>
  /// For more information about these examples formats, including the best use
  /// case for each one, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/mw-cli-tutorial-targets-examples.html">Examples:
  /// Register targets with a maintenance window</a> in the <i>AWS Systems
  /// Manager User Guide</i>.
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window the target should be registered with.
  ///
  /// Parameter [clientToken] :
  /// User-provided idempotency token.
  ///
  /// Parameter [description] :
  /// An optional description for the target.
  ///
  /// Parameter [name] :
  /// An optional name for the target.
  ///
  /// Parameter [ownerInformation] :
  /// User-provided value that will be included in any CloudWatch events raised
  /// while running tasks for these targets in this maintenance window.
  Future<RegisterTargetWithMaintenanceWindowResult>
      registerTargetWithMaintenanceWindow({
    required MaintenanceWindowResourceType resourceType,
    required List<Target> targets,
    required String windowId,
    String? clientToken,
    String? description,
    String? name,
    String? ownerInformation,
  }) async {
    ArgumentError.checkNotNull(resourceType, 'resourceType');
    ArgumentError.checkNotNull(targets, 'targets');
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'clientToken',
      clientToken,
      1,
      64,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      128,
    );
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    _s.validateStringLength(
      'ownerInformation',
      ownerInformation,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.RegisterTargetWithMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceType': resourceType.toValue(),
        'Targets': targets,
        'WindowId': windowId,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (description != null) 'Description': description,
        if (name != null) 'Name': name,
        if (ownerInformation != null) 'OwnerInformation': ownerInformation,
      },
    );

    return RegisterTargetWithMaintenanceWindowResult.fromJson(
        jsonResponse.body);
  }

  /// Adds a new task to a maintenance window.
  ///
  /// May throw [IdempotentParameterMismatch].
  /// May throw [DoesNotExistException].
  /// May throw [ResourceLimitExceededException].
  /// May throw [FeatureNotAvailableException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [taskArn] :
  /// The ARN of the task to run.
  ///
  /// Parameter [taskType] :
  /// The type of task being registered.
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window the task should be added to.
  ///
  /// Parameter [clientToken] :
  /// User-provided idempotency token.
  ///
  /// Parameter [description] :
  /// An optional description for the task.
  ///
  /// Parameter [loggingInfo] :
  /// A structure containing information about an S3 bucket to write
  /// instance-level logs to.
  /// <note>
  /// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
  /// contain logs, instead use the <code>OutputS3BucketName</code> and
  /// <code>OutputS3KeyPrefix</code> options in the
  /// <code>TaskInvocationParameters</code> structure. For information about how
  /// Systems Manager handles these options for the supported maintenance window
  /// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  ///
  /// Parameter [maxConcurrency] :
  /// The maximum number of targets this task can be run for in parallel.
  /// <note>
  /// For maintenance window tasks without a target specified, you cannot supply
  /// a value for this option. Instead, the system inserts a placeholder value
  /// of <code>1</code>. This value does not affect the running of your task.
  /// </note>
  ///
  /// Parameter [maxErrors] :
  /// The maximum number of errors allowed before this task stops being
  /// scheduled.
  /// <note>
  /// For maintenance window tasks without a target specified, you cannot supply
  /// a value for this option. Instead, the system inserts a placeholder value
  /// of <code>1</code>. This value does not affect the running of your task.
  /// </note>
  ///
  /// Parameter [name] :
  /// An optional name for the task.
  ///
  /// Parameter [priority] :
  /// The priority of the task in the maintenance window, the lower the number
  /// the higher the priority. Tasks in a maintenance window are scheduled in
  /// priority order with tasks that have the same priority scheduled in
  /// parallel.
  ///
  /// Parameter [serviceRoleArn] :
  /// The ARN of the IAM service role for Systems Manager to assume when running
  /// a maintenance window task. If you do not specify a service role ARN,
  /// Systems Manager uses your account's service-linked role. If no
  /// service-linked role for Systems Manager exists in your account, it is
  /// created when you run <code>RegisterTaskWithMaintenanceWindow</code>.
  ///
  /// For more information, see the following topics in the in the <i>AWS
  /// Systems Manager User Guide</i>:
  ///
  /// <ul>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/using-service-linked-roles.html#slr-permissions">Using
  /// service-linked roles for Systems Manager</a>
  /// </li>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html#maintenance-window-tasks-service-role">Should
  /// I use a service-linked role or a custom service role to run maintenance
  /// window tasks? </a>
  /// </li>
  /// </ul>
  ///
  /// Parameter [targets] :
  /// The targets (either instances or maintenance window targets).
  /// <note>
  /// One or more targets must be specified for maintenance window Run
  /// Command-type tasks. Depending on the task, targets are optional for other
  /// maintenance window task types (Automation, AWS Lambda, and AWS Step
  /// Functions). For more information about running tasks that do not specify
  /// targets, see see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html">Registering
  /// maintenance window tasks without targets</a> in the <i>AWS Systems Manager
  /// User Guide</i>.
  /// </note>
  /// Specify instances using the following format:
  ///
  /// <code>Key=InstanceIds,Values=&lt;instance-id-1&gt;,&lt;instance-id-2&gt;</code>
  ///
  /// Specify maintenance window targets using the following format:
  ///
  /// <code>Key=WindowTargetIds,Values=&lt;window-target-id-1&gt;,&lt;window-target-id-2&gt;</code>
  ///
  /// Parameter [taskInvocationParameters] :
  /// The parameters that the task should use during execution. Populate only
  /// the fields that match the task type. All other fields should be empty.
  ///
  /// Parameter [taskParameters] :
  /// The parameters that should be passed to the task when it is run.
  /// <note>
  /// <code>TaskParameters</code> has been deprecated. To specify parameters to
  /// pass to a task when it runs, instead use the <code>Parameters</code>
  /// option in the <code>TaskInvocationParameters</code> structure. For
  /// information about how Systems Manager handles these options for the
  /// supported maintenance window task types, see
  /// <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  Future<RegisterTaskWithMaintenanceWindowResult>
      registerTaskWithMaintenanceWindow({
    required String taskArn,
    required MaintenanceWindowTaskType taskType,
    required String windowId,
    String? clientToken,
    String? description,
    LoggingInfo? loggingInfo,
    String? maxConcurrency,
    String? maxErrors,
    String? name,
    int? priority,
    String? serviceRoleArn,
    List<Target>? targets,
    MaintenanceWindowTaskInvocationParameters? taskInvocationParameters,
    Map<String, MaintenanceWindowTaskParameterValueExpression>? taskParameters,
  }) async {
    ArgumentError.checkNotNull(taskArn, 'taskArn');
    _s.validateStringLength(
      'taskArn',
      taskArn,
      1,
      1600,
      isRequired: true,
    );
    ArgumentError.checkNotNull(taskType, 'taskType');
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'clientToken',
      clientToken,
      1,
      64,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      128,
    );
    _s.validateStringLength(
      'maxConcurrency',
      maxConcurrency,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxConcurrency',
      maxConcurrency,
      r'''^([1-9][0-9]*|[1-9][0-9]%|[1-9]%|100%)$''',
    );
    _s.validateStringLength(
      'maxErrors',
      maxErrors,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxErrors',
      maxErrors,
      r'''^([1-9][0-9]*|[0]|[1-9][0-9]%|[0-9]%|100%)$''',
    );
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    _s.validateNumRange(
      'priority',
      priority,
      0,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.RegisterTaskWithMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskArn': taskArn,
        'TaskType': taskType.toValue(),
        'WindowId': windowId,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (description != null) 'Description': description,
        if (loggingInfo != null) 'LoggingInfo': loggingInfo,
        if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
        if (maxErrors != null) 'MaxErrors': maxErrors,
        if (name != null) 'Name': name,
        if (priority != null) 'Priority': priority,
        if (serviceRoleArn != null) 'ServiceRoleArn': serviceRoleArn,
        if (targets != null) 'Targets': targets,
        if (taskInvocationParameters != null)
          'TaskInvocationParameters': taskInvocationParameters,
        if (taskParameters != null) 'TaskParameters': taskParameters,
      },
    );

    return RegisterTaskWithMaintenanceWindowResult.fromJson(jsonResponse.body);
  }

  /// Removes tag keys from the specified resource.
  ///
  /// May throw [InvalidResourceType].
  /// May throw [InvalidResourceId].
  /// May throw [InternalServerError].
  /// May throw [TooManyUpdates].
  ///
  /// Parameter [resourceId] :
  /// The ID of the resource from which you want to remove tags. For example:
  ///
  /// ManagedInstance: mi-012345abcde
  ///
  /// MaintenanceWindow: mw-012345abcde
  ///
  /// PatchBaseline: pb-012345abcde
  ///
  /// For the Document and Parameter values, use the name of the resource.
  /// <note>
  /// The ManagedInstance type for this API action is only for on-premises
  /// managed instances. Specify the name of the managed instance in the
  /// following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.
  /// </note>
  ///
  /// Parameter [resourceType] :
  /// The type of resource from which you want to remove a tag.
  /// <note>
  /// The ManagedInstance type for this API action is only for on-premises
  /// managed instances. Specify the name of the managed instance in the
  /// following format: mi-ID_number. For example, mi-1a2b3c4d5e6f.
  /// </note>
  ///
  /// Parameter [tagKeys] :
  /// Tag keys that you want to remove from the specified resource.
  Future<void> removeTagsFromResource({
    required String resourceId,
    required ResourceTypeForTagging resourceType,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceId, 'resourceId');
    ArgumentError.checkNotNull(resourceType, 'resourceType');
    ArgumentError.checkNotNull(tagKeys, 'tagKeys');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.RemoveTagsFromResource'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceId': resourceId,
        'ResourceType': resourceType.toValue(),
        'TagKeys': tagKeys,
      },
    );
  }

  /// <code>ServiceSetting</code> is an account-level setting for an AWS
  /// service. This setting defines how a user interacts with or uses a service
  /// or a feature of a service. For example, if an AWS service charges money to
  /// the account based on feature or service usage, then the AWS service team
  /// might create a default setting of "false". This means the user can't use
  /// this feature unless they change the setting to "true" and intentionally
  /// opt in for a paid feature.
  ///
  /// Services map a <code>SettingId</code> object to a setting value. AWS
  /// services teams define the default value for a <code>SettingId</code>. You
  /// can't create a new <code>SettingId</code>, but you can overwrite the
  /// default value if you have the <code>ssm:UpdateServiceSetting</code>
  /// permission for the setting. Use the <a>GetServiceSetting</a> API action to
  /// view the current value. Use the <a>UpdateServiceSetting</a> API action to
  /// change the default setting.
  ///
  /// Reset the service setting for the account to the default value as
  /// provisioned by the AWS service team.
  ///
  /// May throw [InternalServerError].
  /// May throw [ServiceSettingNotFound].
  /// May throw [TooManyUpdates].
  ///
  /// Parameter [settingId] :
  /// The Amazon Resource Name (ARN) of the service setting to reset. The
  /// setting ID can be
  /// <code>/ssm/parameter-store/default-parameter-tier</code>,
  /// <code>/ssm/parameter-store/high-throughput-enabled</code>, or
  /// <code>/ssm/managed-instance/activation-tier</code>. For example,
  /// <code>arn:aws:ssm:us-east-1:111122223333:servicesetting/ssm/parameter-store/high-throughput-enabled</code>.
  Future<ResetServiceSettingResult> resetServiceSetting({
    required String settingId,
  }) async {
    ArgumentError.checkNotNull(settingId, 'settingId');
    _s.validateStringLength(
      'settingId',
      settingId,
      1,
      1000,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ResetServiceSetting'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SettingId': settingId,
      },
    );

    return ResetServiceSettingResult.fromJson(jsonResponse.body);
  }

  /// Reconnects a session to an instance after it has been disconnected.
  /// Connections can be resumed for disconnected sessions, but not terminated
  /// sessions.
  /// <note>
  /// This command is primarily for use by client machines to automatically
  /// reconnect during intermittent network issues. It is not intended for any
  /// other use.
  /// </note>
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [sessionId] :
  /// The ID of the disconnected session to resume.
  Future<ResumeSessionResponse> resumeSession({
    required String sessionId,
  }) async {
    ArgumentError.checkNotNull(sessionId, 'sessionId');
    _s.validateStringLength(
      'sessionId',
      sessionId,
      1,
      96,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.ResumeSession'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SessionId': sessionId,
      },
    );

    return ResumeSessionResponse.fromJson(jsonResponse.body);
  }

  /// Sends a signal to an Automation execution to change the current behavior
  /// or status of the execution.
  ///
  /// May throw [AutomationExecutionNotFoundException].
  /// May throw [AutomationStepNotFoundException].
  /// May throw [InvalidAutomationSignalException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [automationExecutionId] :
  /// The unique identifier for an existing Automation execution that you want
  /// to send the signal to.
  ///
  /// Parameter [signalType] :
  /// The type of signal to send to an Automation execution.
  ///
  /// Parameter [payload] :
  /// The data sent with the signal. The data schema depends on the type of
  /// signal used in the request.
  ///
  /// For <code>Approve</code> and <code>Reject</code> signal types, the payload
  /// is an optional comment that you can send with the signal type. For
  /// example:
  ///
  /// <code>Comment="Looks good"</code>
  ///
  /// For <code>StartStep</code> and <code>Resume</code> signal types, you must
  /// send the name of the Automation step to start or resume as the payload.
  /// For example:
  ///
  /// <code>StepName="step1"</code>
  ///
  /// For the <code>StopStep</code> signal type, you must send the step
  /// execution ID as the payload. For example:
  ///
  /// <code>StepExecutionId="97fff367-fc5a-4299-aed8-0123456789ab"</code>
  Future<void> sendAutomationSignal({
    required String automationExecutionId,
    required SignalType signalType,
    Map<String, List<String>>? payload,
  }) async {
    ArgumentError.checkNotNull(automationExecutionId, 'automationExecutionId');
    _s.validateStringLength(
      'automationExecutionId',
      automationExecutionId,
      36,
      36,
      isRequired: true,
    );
    ArgumentError.checkNotNull(signalType, 'signalType');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.SendAutomationSignal'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AutomationExecutionId': automationExecutionId,
        'SignalType': signalType.toValue(),
        if (payload != null) 'Payload': payload,
      },
    );
  }

  /// Runs commands on one or more managed instances.
  ///
  /// May throw [DuplicateInstanceId].
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentVersion].
  /// May throw [InvalidOutputFolder].
  /// May throw [InvalidParameters].
  /// May throw [UnsupportedPlatformType].
  /// May throw [MaxDocumentSizeExceeded].
  /// May throw [InvalidRole].
  /// May throw [InvalidNotificationConfig].
  ///
  /// Parameter [documentName] :
  /// Required. The name of the Systems Manager document to run. This can be a
  /// public document or a custom document.
  ///
  /// Parameter [cloudWatchOutputConfig] :
  /// Enables Systems Manager to send Run Command output to Amazon CloudWatch
  /// Logs.
  ///
  /// Parameter [comment] :
  /// User-specified information about the command, such as a brief description
  /// of what the command should do.
  ///
  /// Parameter [documentHash] :
  /// The Sha256 or Sha1 hash created by the system when the document was
  /// created.
  /// <note>
  /// Sha1 hashes have been deprecated.
  /// </note>
  ///
  /// Parameter [documentHashType] :
  /// Sha256 or Sha1.
  /// <note>
  /// Sha1 hashes have been deprecated.
  /// </note>
  ///
  /// Parameter [documentVersion] :
  /// The SSM document version to use in the request. You can specify $DEFAULT,
  /// $LATEST, or a specific version number. If you run commands by using the
  /// AWS CLI, then you must escape the first two options by using a backslash.
  /// If you specify a version number, then you don't need to use the backslash.
  /// For example:
  ///
  /// --document-version "\$DEFAULT"
  ///
  /// --document-version "\$LATEST"
  ///
  /// --document-version "3"
  ///
  /// Parameter [instanceIds] :
  /// The IDs of the instances where the command should run. Specifying instance
  /// IDs is most useful when you are targeting a limited number of instances,
  /// though you can specify up to 50 IDs.
  ///
  /// To target a larger number of instances, or if you prefer not to list
  /// individual instance IDs, we recommend using the <code>Targets</code>
  /// option instead. Using <code>Targets</code>, which accepts tag key-value
  /// pairs to identify the instances to send commands to, you can a send
  /// command to tens, hundreds, or thousands of instances at once.
  ///
  /// For more information about how to use targets, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html">Using
  /// targets and rate controls to send commands to a fleet</a> in the <i>AWS
  /// Systems Manager User Guide</i>.
  ///
  /// Parameter [maxConcurrency] :
  /// (Optional) The maximum number of instances that are allowed to run the
  /// command at the same time. You can specify a number such as 10 or a
  /// percentage such as 10%. The default value is 50. For more information
  /// about how to use MaxConcurrency, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-velocity">Using
  /// concurrency controls</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [maxErrors] :
  /// The maximum number of errors allowed without the command failing. When the
  /// command fails one more time beyond the value of MaxErrors, the systems
  /// stops sending the command to additional targets. You can specify a number
  /// like 10 or a percentage like 10%. The default value is 0. For more
  /// information about how to use MaxErrors, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-maxerrors">Using
  /// error controls</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [notificationConfig] :
  /// Configurations for sending notifications.
  ///
  /// Parameter [outputS3BucketName] :
  /// The name of the S3 bucket where command execution responses should be
  /// stored.
  ///
  /// Parameter [outputS3KeyPrefix] :
  /// The directory structure within the S3 bucket where the responses should be
  /// stored.
  ///
  /// Parameter [outputS3Region] :
  /// (Deprecated) You can no longer specify this parameter. The system ignores
  /// it. Instead, Systems Manager automatically determines the Region of the S3
  /// bucket.
  ///
  /// Parameter [parameters] :
  /// The required and optional parameters specified in the document being run.
  ///
  /// Parameter [serviceRoleArn] :
  /// The ARN of the IAM service role to use to publish Amazon Simple
  /// Notification Service (Amazon SNS) notifications for Run Command commands.
  ///
  /// Parameter [targets] :
  /// An array of search criteria that targets instances using a
  /// <code>Key,Value</code> combination that you specify. Specifying targets is
  /// most useful when you want to send a command to a large number of instances
  /// at once. Using <code>Targets</code>, which accepts tag key-value pairs to
  /// identify instances, you can send a command to tens, hundreds, or thousands
  /// of instances at once.
  ///
  /// To send a command to a smaller number of instances, you can use the
  /// <code>InstanceIds</code> option instead.
  ///
  /// For more information about how to use targets, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html">Sending
  /// commands to a fleet</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [timeoutSeconds] :
  /// If this time is reached and the command has not already started running,
  /// it will not run.
  Future<SendCommandResult> sendCommand({
    required String documentName,
    CloudWatchOutputConfig? cloudWatchOutputConfig,
    String? comment,
    String? documentHash,
    DocumentHashType? documentHashType,
    String? documentVersion,
    List<String>? instanceIds,
    String? maxConcurrency,
    String? maxErrors,
    NotificationConfig? notificationConfig,
    String? outputS3BucketName,
    String? outputS3KeyPrefix,
    String? outputS3Region,
    Map<String, List<String>>? parameters,
    String? serviceRoleArn,
    List<Target>? targets,
    int? timeoutSeconds,
  }) async {
    ArgumentError.checkNotNull(documentName, 'documentName');
    _s.validateStringPattern(
      'documentName',
      documentName,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'comment',
      comment,
      0,
      100,
    );
    _s.validateStringLength(
      'documentHash',
      documentHash,
      0,
      256,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringLength(
      'maxConcurrency',
      maxConcurrency,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxConcurrency',
      maxConcurrency,
      r'''^([1-9][0-9]*|[1-9][0-9]%|[1-9]%|100%)$''',
    );
    _s.validateStringLength(
      'maxErrors',
      maxErrors,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxErrors',
      maxErrors,
      r'''^([1-9][0-9]*|[0]|[1-9][0-9]%|[0-9]%|100%)$''',
    );
    _s.validateStringLength(
      'outputS3BucketName',
      outputS3BucketName,
      3,
      63,
    );
    _s.validateStringLength(
      'outputS3KeyPrefix',
      outputS3KeyPrefix,
      0,
      500,
    );
    _s.validateStringLength(
      'outputS3Region',
      outputS3Region,
      3,
      20,
    );
    _s.validateNumRange(
      'timeoutSeconds',
      timeoutSeconds,
      30,
      2592000,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.SendCommand'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DocumentName': documentName,
        if (cloudWatchOutputConfig != null)
          'CloudWatchOutputConfig': cloudWatchOutputConfig,
        if (comment != null) 'Comment': comment,
        if (documentHash != null) 'DocumentHash': documentHash,
        if (documentHashType != null)
          'DocumentHashType': documentHashType.toValue(),
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (instanceIds != null) 'InstanceIds': instanceIds,
        if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
        if (maxErrors != null) 'MaxErrors': maxErrors,
        if (notificationConfig != null)
          'NotificationConfig': notificationConfig,
        if (outputS3BucketName != null)
          'OutputS3BucketName': outputS3BucketName,
        if (outputS3KeyPrefix != null) 'OutputS3KeyPrefix': outputS3KeyPrefix,
        if (outputS3Region != null) 'OutputS3Region': outputS3Region,
        if (parameters != null) 'Parameters': parameters,
        if (serviceRoleArn != null) 'ServiceRoleArn': serviceRoleArn,
        if (targets != null) 'Targets': targets,
        if (timeoutSeconds != null) 'TimeoutSeconds': timeoutSeconds,
      },
    );

    return SendCommandResult.fromJson(jsonResponse.body);
  }

  /// Use this API action to run an association immediately and only one time.
  /// This action can be helpful when troubleshooting associations.
  ///
  /// May throw [InvalidAssociation].
  /// May throw [AssociationDoesNotExist].
  ///
  /// Parameter [associationIds] :
  /// The association IDs that you want to run immediately and only one time.
  Future<void> startAssociationsOnce({
    required List<String> associationIds,
  }) async {
    ArgumentError.checkNotNull(associationIds, 'associationIds');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.StartAssociationsOnce'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AssociationIds': associationIds,
      },
    );
  }

  /// Initiates execution of an Automation document.
  ///
  /// May throw [AutomationDefinitionNotFoundException].
  /// May throw [InvalidAutomationExecutionParametersException].
  /// May throw [AutomationExecutionLimitExceededException].
  /// May throw [AutomationDefinitionVersionNotFoundException].
  /// May throw [IdempotentParameterMismatch].
  /// May throw [InvalidTarget].
  /// May throw [InternalServerError].
  ///
  /// Parameter [documentName] :
  /// The name of the Automation document to use for this execution.
  ///
  /// Parameter [clientToken] :
  /// User-provided idempotency token. The token must be unique, is case
  /// insensitive, enforces the UUID format, and can't be reused.
  ///
  /// Parameter [documentVersion] :
  /// The version of the Automation document to use for this execution.
  ///
  /// Parameter [maxConcurrency] :
  /// The maximum number of targets allowed to run this task in parallel. You
  /// can specify a number, such as 10, or a percentage, such as 10%. The
  /// default value is 10.
  ///
  /// Parameter [maxErrors] :
  /// The number of errors that are allowed before the system stops running the
  /// automation on additional targets. You can specify either an absolute
  /// number of errors, for example 10, or a percentage of the target set, for
  /// example 10%. If you specify 3, for example, the system stops running the
  /// automation when the fourth error is received. If you specify 0, then the
  /// system stops running the automation on additional targets after the first
  /// error result is returned. If you run an automation on 50 resources and set
  /// max-errors to 10%, then the system stops running the automation on
  /// additional targets when the sixth error is received.
  ///
  /// Executions that are already running an automation when max-errors is
  /// reached are allowed to complete, but some of these executions may fail as
  /// well. If you need to ensure that there won't be more than max-errors
  /// failed executions, set max-concurrency to 1 so the executions proceed one
  /// at a time.
  ///
  /// Parameter [mode] :
  /// The execution mode of the automation. Valid modes include the following:
  /// Auto and Interactive. The default mode is Auto.
  ///
  /// Parameter [parameters] :
  /// A key-value map of execution parameters, which match the declared
  /// parameters in the Automation document.
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. You can specify a maximum
  /// of five tags for an automation. Tags enable you to categorize a resource
  /// in different ways, such as by purpose, owner, or environment. For example,
  /// you might want to tag an automation to identify an environment or
  /// operating system. In this case, you could specify the following key
  /// name/value pairs:
  ///
  /// <ul>
  /// <li>
  /// <code>Key=environment,Value=test</code>
  /// </li>
  /// <li>
  /// <code>Key=OS,Value=Windows</code>
  /// </li>
  /// </ul> <note>
  /// To add tags to an existing patch baseline, use the
  /// <a>AddTagsToResource</a> action.
  /// </note>
  ///
  /// Parameter [targetLocations] :
  /// A location is a combination of AWS Regions and/or AWS accounts where you
  /// want to run the Automation. Use this action to start an Automation in
  /// multiple Regions and multiple accounts. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation-multiple-accounts-and-regions.html">Running
  /// Automation workflows in multiple AWS Regions and accounts</a> in the
  /// <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [targetMaps] :
  /// A key-value mapping of document parameters to target resources. Both
  /// Targets and TargetMaps cannot be specified together.
  ///
  /// Parameter [targetParameterName] :
  /// The name of the parameter used as the target resource for the
  /// rate-controlled execution. Required if you specify targets.
  ///
  /// Parameter [targets] :
  /// A key-value mapping to target resources. Required if you specify
  /// TargetParameterName.
  Future<StartAutomationExecutionResult> startAutomationExecution({
    required String documentName,
    String? clientToken,
    String? documentVersion,
    String? maxConcurrency,
    String? maxErrors,
    ExecutionMode? mode,
    Map<String, List<String>>? parameters,
    List<Tag>? tags,
    List<TargetLocation>? targetLocations,
    List<Map<String, List<String>>>? targetMaps,
    String? targetParameterName,
    List<Target>? targets,
  }) async {
    ArgumentError.checkNotNull(documentName, 'documentName');
    _s.validateStringPattern(
      'documentName',
      documentName,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'clientToken',
      clientToken,
      36,
      36,
    );
    _s.validateStringPattern(
      'clientToken',
      clientToken,
      r'''[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}''',
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringLength(
      'maxConcurrency',
      maxConcurrency,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxConcurrency',
      maxConcurrency,
      r'''^([1-9][0-9]*|[1-9][0-9]%|[1-9]%|100%)$''',
    );
    _s.validateStringLength(
      'maxErrors',
      maxErrors,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxErrors',
      maxErrors,
      r'''^([1-9][0-9]*|[0]|[1-9][0-9]%|[0-9]%|100%)$''',
    );
    _s.validateStringLength(
      'targetParameterName',
      targetParameterName,
      1,
      50,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.StartAutomationExecution'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DocumentName': documentName,
        if (clientToken != null) 'ClientToken': clientToken,
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
        if (maxErrors != null) 'MaxErrors': maxErrors,
        if (mode != null) 'Mode': mode.toValue(),
        if (parameters != null) 'Parameters': parameters,
        if (tags != null) 'Tags': tags,
        if (targetLocations != null) 'TargetLocations': targetLocations,
        if (targetMaps != null) 'TargetMaps': targetMaps,
        if (targetParameterName != null)
          'TargetParameterName': targetParameterName,
        if (targets != null) 'Targets': targets,
      },
    );

    return StartAutomationExecutionResult.fromJson(jsonResponse.body);
  }

  /// Creates a change request for Change Manager. The runbooks (Automation
  /// documents) specified in the change request run only after all required
  /// approvals for the change request have been received.
  ///
  /// May throw [AutomationDefinitionNotFoundException].
  /// May throw [InvalidAutomationExecutionParametersException].
  /// May throw [AutomationExecutionLimitExceededException].
  /// May throw [AutomationDefinitionVersionNotFoundException].
  /// May throw [IdempotentParameterMismatch].
  /// May throw [InternalServerError].
  /// May throw [AutomationDefinitionNotApprovedException].
  ///
  /// Parameter [documentName] :
  /// The name of the change template document to run during the runbook
  /// workflow.
  ///
  /// Parameter [runbooks] :
  /// Information about the Automation runbooks (Automation documents) that are
  /// run during the runbook workflow.
  /// <note>
  /// The Automation runbooks specified for the runbook workflow can't run until
  /// all required approvals for the change request have been received.
  /// </note>
  ///
  /// Parameter [changeRequestName] :
  /// The name of the change request associated with the runbook workflow to be
  /// run.
  ///
  /// Parameter [clientToken] :
  /// The user-provided idempotency token. The token must be unique, is case
  /// insensitive, enforces the UUID format, and can't be reused.
  ///
  /// Parameter [documentVersion] :
  /// The version of the change template document to run during the runbook
  /// workflow.
  ///
  /// Parameter [parameters] :
  /// A key-value map of parameters that match the declared parameters in the
  /// change template document.
  ///
  /// Parameter [scheduledTime] :
  /// The date and time specified in the change request to run the Automation
  /// runbooks.
  /// <note>
  /// The Automation runbooks specified for the runbook workflow can't run until
  /// all required approvals for the change request have been received.
  /// </note>
  ///
  /// Parameter [tags] :
  /// Optional metadata that you assign to a resource. You can specify a maximum
  /// of five tags for a change request. Tags enable you to categorize a
  /// resource in different ways, such as by purpose, owner, or environment. For
  /// example, you might want to tag a change request to identify an environment
  /// or target AWS Region. In this case, you could specify the following
  /// key-value pairs:
  ///
  /// <ul>
  /// <li>
  /// <code>Key=Environment,Value=Production</code>
  /// </li>
  /// <li>
  /// <code>Key=Region,Value=us-east-2</code>
  /// </li>
  /// </ul>
  Future<StartChangeRequestExecutionResult> startChangeRequestExecution({
    required String documentName,
    required List<Runbook> runbooks,
    String? changeRequestName,
    String? clientToken,
    String? documentVersion,
    Map<String, List<String>>? parameters,
    DateTime? scheduledTime,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(documentName, 'documentName');
    _s.validateStringPattern(
      'documentName',
      documentName,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(runbooks, 'runbooks');
    _s.validateStringLength(
      'changeRequestName',
      changeRequestName,
      1,
      1024,
    );
    _s.validateStringLength(
      'clientToken',
      clientToken,
      36,
      36,
    );
    _s.validateStringPattern(
      'clientToken',
      clientToken,
      r'''[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}''',
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.StartChangeRequestExecution'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DocumentName': documentName,
        'Runbooks': runbooks,
        if (changeRequestName != null) 'ChangeRequestName': changeRequestName,
        if (clientToken != null) 'ClientToken': clientToken,
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (parameters != null) 'Parameters': parameters,
        if (scheduledTime != null)
          'ScheduledTime': unixTimestampToJson(scheduledTime),
        if (tags != null) 'Tags': tags,
      },
    );

    return StartChangeRequestExecutionResult.fromJson(jsonResponse.body);
  }

  /// Initiates a connection to a target (for example, an instance) for a
  /// Session Manager session. Returns a URL and token that can be used to open
  /// a WebSocket connection for sending input and receiving outputs.
  /// <note>
  /// AWS CLI usage: <code>start-session</code> is an interactive command that
  /// requires the Session Manager plugin to be installed on the client machine
  /// making the call. For information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html">Install
  /// the Session Manager plugin for the AWS CLI</a> in the <i>AWS Systems
  /// Manager User Guide</i>.
  ///
  /// AWS Tools for PowerShell usage: Start-SSMSession is not currently
  /// supported by AWS Tools for PowerShell on Windows local machines.
  /// </note>
  ///
  /// May throw [InvalidDocument].
  /// May throw [TargetNotConnected].
  /// May throw [InternalServerError].
  ///
  /// Parameter [target] :
  /// The instance to connect to for the session.
  ///
  /// Parameter [documentName] :
  /// The name of the SSM document to define the parameters and plugin settings
  /// for the session. For example, <code>SSM-SessionManagerRunShell</code>. You
  /// can call the <a>GetDocument</a> API to verify the document exists before
  /// attempting to start a session. If no document name is provided, a shell to
  /// the instance is launched by default.
  ///
  /// Parameter [parameters] :
  /// Reserved for future use.
  Future<StartSessionResponse> startSession({
    required String target,
    String? documentName,
    Map<String, List<String>>? parameters,
  }) async {
    ArgumentError.checkNotNull(target, 'target');
    _s.validateStringLength(
      'target',
      target,
      1,
      400,
      isRequired: true,
    );
    _s.validateStringPattern(
      'documentName',
      documentName,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.StartSession'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Target': target,
        if (documentName != null) 'DocumentName': documentName,
        if (parameters != null) 'Parameters': parameters,
      },
    );

    return StartSessionResponse.fromJson(jsonResponse.body);
  }

  /// Stop an Automation that is currently running.
  ///
  /// May throw [AutomationExecutionNotFoundException].
  /// May throw [InvalidAutomationStatusUpdateException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [automationExecutionId] :
  /// The execution ID of the Automation to stop.
  ///
  /// Parameter [type] :
  /// The stop request type. Valid types include the following: Cancel and
  /// Complete. The default type is Cancel.
  Future<void> stopAutomationExecution({
    required String automationExecutionId,
    StopType? type,
  }) async {
    ArgumentError.checkNotNull(automationExecutionId, 'automationExecutionId');
    _s.validateStringLength(
      'automationExecutionId',
      automationExecutionId,
      36,
      36,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.StopAutomationExecution'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AutomationExecutionId': automationExecutionId,
        if (type != null) 'Type': type.toValue(),
      },
    );
  }

  /// Permanently ends a session and closes the data connection between the
  /// Session Manager client and SSM Agent on the instance. A terminated session
  /// cannot be resumed.
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [sessionId] :
  /// The ID of the session to terminate.
  Future<TerminateSessionResponse> terminateSession({
    required String sessionId,
  }) async {
    ArgumentError.checkNotNull(sessionId, 'sessionId');
    _s.validateStringLength(
      'sessionId',
      sessionId,
      1,
      96,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.TerminateSession'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SessionId': sessionId,
      },
    );

    return TerminateSessionResponse.fromJson(jsonResponse.body);
  }

  /// Updates an association. You can update the association name and version,
  /// the document version, schedule, parameters, and Amazon S3 output.
  ///
  /// In order to call this API action, your IAM user account, group, or role
  /// must be configured with permission to call the <a>DescribeAssociation</a>
  /// API action. If you don't have permission to call DescribeAssociation, then
  /// you receive the following error: <code>An error occurred
  /// (AccessDeniedException) when calling the UpdateAssociation operation:
  /// User: &lt;user_arn&gt; is not authorized to perform:
  /// ssm:DescribeAssociation on resource: &lt;resource_arn&gt;</code>
  /// <important>
  /// When you update an association, the association immediately runs against
  /// the specified targets.
  /// </important>
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidSchedule].
  /// May throw [InvalidParameters].
  /// May throw [InvalidOutputLocation].
  /// May throw [InvalidDocumentVersion].
  /// May throw [AssociationDoesNotExist].
  /// May throw [InvalidUpdate].
  /// May throw [TooManyUpdates].
  /// May throw [InvalidDocument].
  /// May throw [InvalidTarget].
  /// May throw [InvalidAssociationVersion].
  /// May throw [AssociationVersionLimitExceeded].
  ///
  /// Parameter [associationId] :
  /// The ID of the association you want to update.
  ///
  /// Parameter [applyOnlyAtCronInterval] :
  /// By default, when you update an association, the system runs it immediately
  /// after it is updated and then according to the schedule you specified.
  /// Specify this option if you don't want an association to run immediately
  /// after you update it. This parameter is not supported for rate expressions.
  ///
  /// Also, if you specified this option when you created the association, you
  /// can reset it. To do so, specify the
  /// <code>no-apply-only-at-cron-interval</code> parameter when you update the
  /// association from the command line. This parameter forces the association
  /// to run immediately after updating it and according to the interval
  /// specified.
  ///
  /// Parameter [associationName] :
  /// The name of the association that you want to update.
  ///
  /// Parameter [associationVersion] :
  /// This parameter is provided for concurrency control purposes. You must
  /// specify the latest association version in the service. If you want to
  /// ensure that this request succeeds, either specify <code>$LATEST</code>, or
  /// omit this parameter.
  ///
  /// Parameter [automationTargetParameterName] :
  /// Specify the target for the association. This target is required for
  /// associations that use an Automation document and target resources by using
  /// rate controls.
  ///
  /// Parameter [complianceSeverity] :
  /// The severity level to assign to the association.
  ///
  /// Parameter [documentVersion] :
  /// The document version you want update for the association.
  ///
  /// Parameter [maxConcurrency] :
  /// The maximum number of targets allowed to run the association at the same
  /// time. You can specify a number, for example 10, or a percentage of the
  /// target set, for example 10%. The default value is 100%, which means all
  /// targets run the association at the same time.
  ///
  /// If a new instance starts and attempts to run an association while Systems
  /// Manager is running MaxConcurrency associations, the association is allowed
  /// to run. During the next association interval, the new instance will
  /// process its association within the limit specified for MaxConcurrency.
  ///
  /// Parameter [maxErrors] :
  /// The number of errors that are allowed before the system stops sending
  /// requests to run the association on additional targets. You can specify
  /// either an absolute number of errors, for example 10, or a percentage of
  /// the target set, for example 10%. If you specify 3, for example, the system
  /// stops sending requests when the fourth error is received. If you specify
  /// 0, then the system stops sending requests after the first error is
  /// returned. If you run an association on 50 instances and set MaxError to
  /// 10%, then the system stops sending the request when the sixth error is
  /// received.
  ///
  /// Executions that are already running an association when MaxErrors is
  /// reached are allowed to complete, but some of these executions may fail as
  /// well. If you need to ensure that there won't be more than max-errors
  /// failed executions, set MaxConcurrency to 1 so that executions proceed one
  /// at a time.
  ///
  /// Parameter [name] :
  /// The name of the SSM document that contains the configuration information
  /// for the instance. You can specify Command or Automation documents.
  ///
  /// You can specify AWS-predefined documents, documents you created, or a
  /// document that is shared with you from another account.
  ///
  /// For SSM documents that are shared with you from other AWS accounts, you
  /// must specify the complete SSM document ARN, in the following format:
  ///
  /// <code>arn:aws:ssm:<i>region</i>:<i>account-id</i>:document/<i>document-name</i>
  /// </code>
  ///
  /// For example:
  ///
  /// <code>arn:aws:ssm:us-east-2:12345678912:document/My-Shared-Document</code>
  ///
  /// For AWS-predefined documents and SSM documents you created in your
  /// account, you only need to specify the document name. For example,
  /// <code>AWS-ApplyPatchBaseline</code> or <code>My-Document</code>.
  ///
  /// Parameter [outputLocation] :
  /// An S3 bucket where you want to store the results of this request.
  ///
  /// Parameter [parameters] :
  /// The parameters you want to update for the association. If you create a
  /// parameter using Parameter Store, you can reference the parameter using
  /// {{ssm:parameter-name}}
  ///
  /// Parameter [scheduleExpression] :
  /// The cron expression used to schedule the association that you want to
  /// update.
  ///
  /// Parameter [syncCompliance] :
  /// The mode for generating association compliance. You can specify
  /// <code>AUTO</code> or <code>MANUAL</code>. In <code>AUTO</code> mode, the
  /// system uses the status of the association execution to determine the
  /// compliance status. If the association execution runs successfully, then
  /// the association is <code>COMPLIANT</code>. If the association execution
  /// doesn't run successfully, the association is <code>NON-COMPLIANT</code>.
  ///
  /// In <code>MANUAL</code> mode, you must specify the
  /// <code>AssociationId</code> as a parameter for the
  /// <a>PutComplianceItems</a> API action. In this case, compliance data is not
  /// managed by State Manager. It is managed by your direct call to the
  /// <a>PutComplianceItems</a> API action.
  ///
  /// By default, all associations use <code>AUTO</code> mode.
  ///
  /// Parameter [targetLocations] :
  /// A location is a combination of AWS Regions and AWS accounts where you want
  /// to run the association. Use this action to update an association in
  /// multiple Regions and multiple accounts.
  ///
  /// Parameter [targets] :
  /// The targets of the association.
  Future<UpdateAssociationResult> updateAssociation({
    required String associationId,
    bool? applyOnlyAtCronInterval,
    String? associationName,
    String? associationVersion,
    String? automationTargetParameterName,
    AssociationComplianceSeverity? complianceSeverity,
    String? documentVersion,
    String? maxConcurrency,
    String? maxErrors,
    String? name,
    InstanceAssociationOutputLocation? outputLocation,
    Map<String, List<String>>? parameters,
    String? scheduleExpression,
    AssociationSyncCompliance? syncCompliance,
    List<TargetLocation>? targetLocations,
    List<Target>? targets,
  }) async {
    ArgumentError.checkNotNull(associationId, 'associationId');
    _s.validateStringPattern(
      'associationId',
      associationId,
      r'''[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'associationName',
      associationName,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    _s.validateStringPattern(
      'associationVersion',
      associationVersion,
      r'''([$]LATEST)|([1-9][0-9]*)''',
    );
    _s.validateStringLength(
      'automationTargetParameterName',
      automationTargetParameterName,
      1,
      50,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringLength(
      'maxConcurrency',
      maxConcurrency,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxConcurrency',
      maxConcurrency,
      r'''^([1-9][0-9]*|[1-9][0-9]%|[1-9]%|100%)$''',
    );
    _s.validateStringLength(
      'maxErrors',
      maxErrors,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxErrors',
      maxErrors,
      r'''^([1-9][0-9]*|[0]|[1-9][0-9]%|[0-9]%|100%)$''',
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
    );
    _s.validateStringLength(
      'scheduleExpression',
      scheduleExpression,
      1,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateAssociation'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AssociationId': associationId,
        if (applyOnlyAtCronInterval != null)
          'ApplyOnlyAtCronInterval': applyOnlyAtCronInterval,
        if (associationName != null) 'AssociationName': associationName,
        if (associationVersion != null)
          'AssociationVersion': associationVersion,
        if (automationTargetParameterName != null)
          'AutomationTargetParameterName': automationTargetParameterName,
        if (complianceSeverity != null)
          'ComplianceSeverity': complianceSeverity.toValue(),
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
        if (maxErrors != null) 'MaxErrors': maxErrors,
        if (name != null) 'Name': name,
        if (outputLocation != null) 'OutputLocation': outputLocation,
        if (parameters != null) 'Parameters': parameters,
        if (scheduleExpression != null)
          'ScheduleExpression': scheduleExpression,
        if (syncCompliance != null) 'SyncCompliance': syncCompliance.toValue(),
        if (targetLocations != null) 'TargetLocations': targetLocations,
        if (targets != null) 'Targets': targets,
      },
    );

    return UpdateAssociationResult.fromJson(jsonResponse.body);
  }

  /// Updates the status of the Systems Manager document associated with the
  /// specified instance.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidInstanceId].
  /// May throw [InvalidDocument].
  /// May throw [AssociationDoesNotExist].
  /// May throw [StatusUnchanged].
  /// May throw [TooManyUpdates].
  ///
  /// Parameter [associationStatus] :
  /// The association status.
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance.
  ///
  /// Parameter [name] :
  /// The name of the Systems Manager document.
  Future<UpdateAssociationStatusResult> updateAssociationStatus({
    required AssociationStatus associationStatus,
    required String instanceId,
    required String name,
  }) async {
    ArgumentError.checkNotNull(associationStatus, 'associationStatus');
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.:/]{3,128}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateAssociationStatus'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AssociationStatus': associationStatus,
        'InstanceId': instanceId,
        'Name': name,
      },
    );

    return UpdateAssociationStatusResult.fromJson(jsonResponse.body);
  }

  /// Updates one or more values for an SSM document.
  ///
  /// May throw [MaxDocumentSizeExceeded].
  /// May throw [DocumentVersionLimitExceeded].
  /// May throw [InternalServerError].
  /// May throw [DuplicateDocumentContent].
  /// May throw [DuplicateDocumentVersionName].
  /// May throw [InvalidDocumentContent].
  /// May throw [InvalidDocumentVersion].
  /// May throw [InvalidDocumentSchemaVersion].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentOperation].
  ///
  /// Parameter [content] :
  /// A valid JSON or YAML string.
  ///
  /// Parameter [name] :
  /// The name of the document that you want to update.
  ///
  /// Parameter [attachments] :
  /// A list of key and value pairs that describe attachments to a version of a
  /// document.
  ///
  /// Parameter [documentFormat] :
  /// Specify the document format for the new document version. Systems Manager
  /// supports JSON and YAML documents. JSON is the default format.
  ///
  /// Parameter [documentVersion] :
  /// (Required) The latest version of the document that you want to update. The
  /// latest document version can be specified using the $LATEST variable or by
  /// the version number. Updating a previous version of a document is not
  /// supported.
  ///
  /// Parameter [targetType] :
  /// Specify a new target type for the document.
  ///
  /// Parameter [versionName] :
  /// An optional field specifying the version of the artifact you are updating
  /// with the document. For example, "Release 12, Update 6". This value is
  /// unique across all versions of a document, and cannot be changed.
  Future<UpdateDocumentResult> updateDocument({
    required String content,
    required String name,
    List<AttachmentsSource>? attachments,
    DocumentFormat? documentFormat,
    String? documentVersion,
    String? targetType,
    String? versionName,
  }) async {
    ArgumentError.checkNotNull(content, 'content');
    _s.validateStringLength(
      'content',
      content,
      1,
      1152921504606846976,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    _s.validateStringLength(
      'targetType',
      targetType,
      0,
      200,
    );
    _s.validateStringPattern(
      'targetType',
      targetType,
      r'''^\/[\w\.\-\:\/]*$''',
    );
    _s.validateStringPattern(
      'versionName',
      versionName,
      r'''^[a-zA-Z0-9_\-.]{1,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateDocument'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Content': content,
        'Name': name,
        if (attachments != null) 'Attachments': attachments,
        if (documentFormat != null) 'DocumentFormat': documentFormat.toValue(),
        if (documentVersion != null) 'DocumentVersion': documentVersion,
        if (targetType != null) 'TargetType': targetType,
        if (versionName != null) 'VersionName': versionName,
      },
    );

    return UpdateDocumentResult.fromJson(jsonResponse.body);
  }

  /// Set the default version of a document.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentVersion].
  /// May throw [InvalidDocumentSchemaVersion].
  ///
  /// Parameter [documentVersion] :
  /// The version of a custom document that you want to set as the default
  /// version.
  ///
  /// Parameter [name] :
  /// The name of a custom document that you want to set as the default version.
  Future<UpdateDocumentDefaultVersionResult> updateDocumentDefaultVersion({
    required String documentVersion,
    required String name,
  }) async {
    ArgumentError.checkNotNull(documentVersion, 'documentVersion');
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''(^[1-9][0-9]*$)''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateDocumentDefaultVersion'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DocumentVersion': documentVersion,
        'Name': name,
      },
    );

    return UpdateDocumentDefaultVersionResult.fromJson(jsonResponse.body);
  }

  /// Updates information related to approval reviews for a specific version of
  /// a document.
  ///
  /// May throw [InternalServerError].
  /// May throw [InvalidDocument].
  /// May throw [InvalidDocumentOperation].
  /// May throw [InvalidDocumentVersion].
  ///
  /// Parameter [documentReviews] :
  /// The document review details to update.
  ///
  /// Parameter [name] :
  /// The name of the document for which a version is to be updated.
  ///
  /// Parameter [documentVersion] :
  /// The version of a document to update.
  Future<void> updateDocumentMetadata({
    required DocumentReviews documentReviews,
    required String name,
    String? documentVersion,
  }) async {
    ArgumentError.checkNotNull(documentReviews, 'documentReviews');
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
      isRequired: true,
    );
    _s.validateStringPattern(
      'documentVersion',
      documentVersion,
      r'''([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateDocumentMetadata'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DocumentReviews': documentReviews,
        'Name': name,
        if (documentVersion != null) 'DocumentVersion': documentVersion,
      },
    );
  }

  /// Updates an existing maintenance window. Only specified parameters are
  /// modified.
  /// <note>
  /// The value you specify for <code>Duration</code> determines the specific
  /// end time for the maintenance window based on the time it begins. No
  /// maintenance window tasks are permitted to start after the resulting
  /// endtime minus the number of hours you specify for <code>Cutoff</code>. For
  /// example, if the maintenance window starts at 3 PM, the duration is three
  /// hours, and the value you specify for <code>Cutoff</code> is one hour, no
  /// maintenance window tasks can start after 5 PM.
  /// </note>
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The ID of the maintenance window to update.
  ///
  /// Parameter [allowUnassociatedTargets] :
  /// Whether targets must be registered with the maintenance window before
  /// tasks can be defined for those targets.
  ///
  /// Parameter [cutoff] :
  /// The number of hours before the end of the maintenance window that Systems
  /// Manager stops scheduling new tasks for execution.
  ///
  /// Parameter [description] :
  /// An optional description for the update request.
  ///
  /// Parameter [duration] :
  /// The duration of the maintenance window in hours.
  ///
  /// Parameter [enabled] :
  /// Whether the maintenance window is enabled.
  ///
  /// Parameter [endDate] :
  /// The date and time, in ISO-8601 Extended format, for when you want the
  /// maintenance window to become inactive. EndDate allows you to set a date
  /// and time in the future when the maintenance window will no longer run.
  ///
  /// Parameter [name] :
  /// The name of the maintenance window.
  ///
  /// Parameter [replace] :
  /// If True, then all fields that are required by the CreateMaintenanceWindow
  /// action are also required for this API request. Optional fields that are
  /// not specified are set to null.
  ///
  /// Parameter [schedule] :
  /// The schedule of the maintenance window in the form of a cron or rate
  /// expression.
  ///
  /// Parameter [scheduleOffset] :
  /// The number of days to wait after the date and time specified by a CRON
  /// expression before running the maintenance window.
  ///
  /// For example, the following cron expression schedules a maintenance window
  /// to run the third Tuesday of every month at 11:30 PM.
  ///
  /// <code>cron(30 23 ? * TUE#3 *)</code>
  ///
  /// If the schedule offset is <code>2</code>, the maintenance window won't run
  /// until two days later.
  ///
  /// Parameter [scheduleTimezone] :
  /// The time zone that the scheduled maintenance window executions are based
  /// on, in Internet Assigned Numbers Authority (IANA) format. For example:
  /// "America/Los_Angeles", "UTC", or "Asia/Seoul". For more information, see
  /// the <a href="https://www.iana.org/time-zones">Time Zone Database</a> on
  /// the IANA website.
  ///
  /// Parameter [startDate] :
  /// The time zone that the scheduled maintenance window executions are based
  /// on, in Internet Assigned Numbers Authority (IANA) format. For example:
  /// "America/Los_Angeles", "UTC", or "Asia/Seoul". For more information, see
  /// the <a href="https://www.iana.org/time-zones">Time Zone Database</a> on
  /// the IANA website.
  Future<UpdateMaintenanceWindowResult> updateMaintenanceWindow({
    required String windowId,
    bool? allowUnassociatedTargets,
    int? cutoff,
    String? description,
    int? duration,
    bool? enabled,
    String? endDate,
    String? name,
    bool? replace,
    String? schedule,
    int? scheduleOffset,
    String? scheduleTimezone,
    String? startDate,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'cutoff',
      cutoff,
      0,
      23,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      128,
    );
    _s.validateNumRange(
      'duration',
      duration,
      1,
      24,
    );
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    _s.validateStringLength(
      'schedule',
      schedule,
      1,
      256,
    );
    _s.validateNumRange(
      'scheduleOffset',
      scheduleOffset,
      1,
      6,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateMaintenanceWindow'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        if (allowUnassociatedTargets != null)
          'AllowUnassociatedTargets': allowUnassociatedTargets,
        if (cutoff != null) 'Cutoff': cutoff,
        if (description != null) 'Description': description,
        if (duration != null) 'Duration': duration,
        if (enabled != null) 'Enabled': enabled,
        if (endDate != null) 'EndDate': endDate,
        if (name != null) 'Name': name,
        if (replace != null) 'Replace': replace,
        if (schedule != null) 'Schedule': schedule,
        if (scheduleOffset != null) 'ScheduleOffset': scheduleOffset,
        if (scheduleTimezone != null) 'ScheduleTimezone': scheduleTimezone,
        if (startDate != null) 'StartDate': startDate,
      },
    );

    return UpdateMaintenanceWindowResult.fromJson(jsonResponse.body);
  }

  /// Modifies the target of an existing maintenance window. You can change the
  /// following:
  ///
  /// <ul>
  /// <li>
  /// Name
  /// </li>
  /// <li>
  /// Description
  /// </li>
  /// <li>
  /// Owner
  /// </li>
  /// <li>
  /// IDs for an ID target
  /// </li>
  /// <li>
  /// Tags for a Tag target
  /// </li>
  /// <li>
  /// From any supported tag type to another. The three supported tag types are
  /// ID target, Tag target, and resource group. For more information, see
  /// <a>Target</a>.
  /// </li>
  /// </ul> <note>
  /// If a parameter is null, then the corresponding field is not modified.
  /// </note>
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The maintenance window ID with which to modify the target.
  ///
  /// Parameter [windowTargetId] :
  /// The target ID to modify.
  ///
  /// Parameter [description] :
  /// An optional description for the update.
  ///
  /// Parameter [name] :
  /// A name for the update.
  ///
  /// Parameter [ownerInformation] :
  /// User-provided value that will be included in any CloudWatch events raised
  /// while running tasks for these targets in this maintenance window.
  ///
  /// Parameter [replace] :
  /// If True, then all fields that are required by the
  /// RegisterTargetWithMaintenanceWindow action are also required for this API
  /// request. Optional fields that are not specified are set to null.
  ///
  /// Parameter [targets] :
  /// The targets to add or replace.
  Future<UpdateMaintenanceWindowTargetResult> updateMaintenanceWindowTarget({
    required String windowId,
    required String windowTargetId,
    String? description,
    String? name,
    String? ownerInformation,
    bool? replace,
    List<Target>? targets,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowTargetId, 'windowTargetId');
    _s.validateStringLength(
      'windowTargetId',
      windowTargetId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowTargetId',
      windowTargetId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      128,
    );
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    _s.validateStringLength(
      'ownerInformation',
      ownerInformation,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateMaintenanceWindowTarget'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        'WindowTargetId': windowTargetId,
        if (description != null) 'Description': description,
        if (name != null) 'Name': name,
        if (ownerInformation != null) 'OwnerInformation': ownerInformation,
        if (replace != null) 'Replace': replace,
        if (targets != null) 'Targets': targets,
      },
    );

    return UpdateMaintenanceWindowTargetResult.fromJson(jsonResponse.body);
  }

  /// Modifies a task assigned to a maintenance window. You can't change the
  /// task type, but you can change the following values:
  ///
  /// <ul>
  /// <li>
  /// TaskARN. For example, you can change a RUN_COMMAND task from
  /// AWS-RunPowerShellScript to AWS-RunShellScript.
  /// </li>
  /// <li>
  /// ServiceRoleArn
  /// </li>
  /// <li>
  /// TaskInvocationParameters
  /// </li>
  /// <li>
  /// Priority
  /// </li>
  /// <li>
  /// MaxConcurrency
  /// </li>
  /// <li>
  /// MaxErrors
  /// </li>
  /// </ul> <note>
  /// One or more targets must be specified for maintenance window Run
  /// Command-type tasks. Depending on the task, targets are optional for other
  /// maintenance window task types (Automation, AWS Lambda, and AWS Step
  /// Functions). For more information about running tasks that do not specify
  /// targets, see see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html">Registering
  /// maintenance window tasks without targets</a> in the <i>AWS Systems Manager
  /// User Guide</i>.
  /// </note>
  /// If the value for a parameter in <code>UpdateMaintenanceWindowTask</code>
  /// is null, then the corresponding field is not modified. If you set
  /// <code>Replace</code> to true, then all fields required by the
  /// <a>RegisterTaskWithMaintenanceWindow</a> action are required for this
  /// request. Optional fields that aren't specified are set to null.
  /// <important>
  /// When you update a maintenance window task that has options specified in
  /// <code>TaskInvocationParameters</code>, you must provide again all the
  /// <code>TaskInvocationParameters</code> values that you want to retain. The
  /// values you do not specify again are removed. For example, suppose that
  /// when you registered a Run Command task, you specified
  /// <code>TaskInvocationParameters</code> values for <code>Comment</code>,
  /// <code>NotificationConfig</code>, and <code>OutputS3BucketName</code>. If
  /// you update the maintenance window task and specify only a different
  /// <code>OutputS3BucketName</code> value, the values for <code>Comment</code>
  /// and <code>NotificationConfig</code> are removed.
  /// </important>
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [windowId] :
  /// The maintenance window ID that contains the task to modify.
  ///
  /// Parameter [windowTaskId] :
  /// The task ID to modify.
  ///
  /// Parameter [description] :
  /// The new task description to specify.
  ///
  /// Parameter [loggingInfo] :
  /// The new logging location in Amazon S3 to specify.
  /// <note>
  /// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
  /// contain logs, instead use the <code>OutputS3BucketName</code> and
  /// <code>OutputS3KeyPrefix</code> options in the
  /// <code>TaskInvocationParameters</code> structure. For information about how
  /// Systems Manager handles these options for the supported maintenance window
  /// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  ///
  /// Parameter [maxConcurrency] :
  /// The new <code>MaxConcurrency</code> value you want to specify.
  /// <code>MaxConcurrency</code> is the number of targets that are allowed to
  /// run this task in parallel.
  /// <note>
  /// For maintenance window tasks without a target specified, you cannot supply
  /// a value for this option. Instead, the system inserts a placeholder value
  /// of <code>1</code>, which may be reported in the response to this command.
  /// This value does not affect the running of your task and can be ignored.
  /// </note>
  ///
  /// Parameter [maxErrors] :
  /// The new <code>MaxErrors</code> value to specify. <code>MaxErrors</code> is
  /// the maximum number of errors that are allowed before the task stops being
  /// scheduled.
  /// <note>
  /// For maintenance window tasks without a target specified, you cannot supply
  /// a value for this option. Instead, the system inserts a placeholder value
  /// of <code>1</code>, which may be reported in the response to this command.
  /// This value does not affect the running of your task and can be ignored.
  /// </note>
  ///
  /// Parameter [name] :
  /// The new task name to specify.
  ///
  /// Parameter [priority] :
  /// The new task priority to specify. The lower the number, the higher the
  /// priority. Tasks that have the same priority are scheduled in parallel.
  ///
  /// Parameter [replace] :
  /// If True, then all fields that are required by the
  /// RegisterTaskWithMaintenanceWindow action are also required for this API
  /// request. Optional fields that are not specified are set to null.
  ///
  /// Parameter [serviceRoleArn] :
  /// The ARN of the IAM service role for Systems Manager to assume when running
  /// a maintenance window task. If you do not specify a service role ARN,
  /// Systems Manager uses your account's service-linked role. If no
  /// service-linked role for Systems Manager exists in your account, it is
  /// created when you run <code>RegisterTaskWithMaintenanceWindow</code>.
  ///
  /// For more information, see the following topics in the in the <i>AWS
  /// Systems Manager User Guide</i>:
  ///
  /// <ul>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/using-service-linked-roles.html#slr-permissions">Using
  /// service-linked roles for Systems Manager</a>
  /// </li>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html#maintenance-window-tasks-service-role">Should
  /// I use a service-linked role or a custom service role to run maintenance
  /// window tasks? </a>
  /// </li>
  /// </ul>
  ///
  /// Parameter [targets] :
  /// The targets (either instances or tags) to modify. Instances are specified
  /// using Key=instanceids,Values=instanceID_1,instanceID_2. Tags are specified
  /// using Key=tag_name,Values=tag_value.
  /// <note>
  /// One or more targets must be specified for maintenance window Run
  /// Command-type tasks. Depending on the task, targets are optional for other
  /// maintenance window task types (Automation, AWS Lambda, and AWS Step
  /// Functions). For more information about running tasks that do not specify
  /// targets, see see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html">Registering
  /// maintenance window tasks without targets</a> in the <i>AWS Systems Manager
  /// User Guide</i>.
  /// </note>
  ///
  /// Parameter [taskArn] :
  /// The task ARN to modify.
  ///
  /// Parameter [taskInvocationParameters] :
  /// The parameters that the task should use during execution. Populate only
  /// the fields that match the task type. All other fields should be empty.
  /// <important>
  /// When you update a maintenance window task that has options specified in
  /// <code>TaskInvocationParameters</code>, you must provide again all the
  /// <code>TaskInvocationParameters</code> values that you want to retain. The
  /// values you do not specify again are removed. For example, suppose that
  /// when you registered a Run Command task, you specified
  /// <code>TaskInvocationParameters</code> values for <code>Comment</code>,
  /// <code>NotificationConfig</code>, and <code>OutputS3BucketName</code>. If
  /// you update the maintenance window task and specify only a different
  /// <code>OutputS3BucketName</code> value, the values for <code>Comment</code>
  /// and <code>NotificationConfig</code> are removed.
  /// </important>
  ///
  /// Parameter [taskParameters] :
  /// The parameters to modify.
  /// <note>
  /// <code>TaskParameters</code> has been deprecated. To specify parameters to
  /// pass to a task when it runs, instead use the <code>Parameters</code>
  /// option in the <code>TaskInvocationParameters</code> structure. For
  /// information about how Systems Manager handles these options for the
  /// supported maintenance window task types, see
  /// <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  /// The map has the following format:
  ///
  /// Key: string, between 1 and 255 characters
  ///
  /// Value: an array of strings, each string is between 1 and 255 characters
  Future<UpdateMaintenanceWindowTaskResult> updateMaintenanceWindowTask({
    required String windowId,
    required String windowTaskId,
    String? description,
    LoggingInfo? loggingInfo,
    String? maxConcurrency,
    String? maxErrors,
    String? name,
    int? priority,
    bool? replace,
    String? serviceRoleArn,
    List<Target>? targets,
    String? taskArn,
    MaintenanceWindowTaskInvocationParameters? taskInvocationParameters,
    Map<String, MaintenanceWindowTaskParameterValueExpression>? taskParameters,
  }) async {
    ArgumentError.checkNotNull(windowId, 'windowId');
    _s.validateStringLength(
      'windowId',
      windowId,
      20,
      20,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowId',
      windowId,
      r'''^mw-[0-9a-f]{17}$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(windowTaskId, 'windowTaskId');
    _s.validateStringLength(
      'windowTaskId',
      windowTaskId,
      36,
      36,
      isRequired: true,
    );
    _s.validateStringPattern(
      'windowTaskId',
      windowTaskId,
      r'''^[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      128,
    );
    _s.validateStringLength(
      'maxConcurrency',
      maxConcurrency,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxConcurrency',
      maxConcurrency,
      r'''^([1-9][0-9]*|[1-9][0-9]%|[1-9]%|100%)$''',
    );
    _s.validateStringLength(
      'maxErrors',
      maxErrors,
      1,
      7,
    );
    _s.validateStringPattern(
      'maxErrors',
      maxErrors,
      r'''^([1-9][0-9]*|[0]|[1-9][0-9]%|[0-9]%|100%)$''',
    );
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    _s.validateNumRange(
      'priority',
      priority,
      0,
      1152921504606846976,
    );
    _s.validateStringLength(
      'taskArn',
      taskArn,
      1,
      1600,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateMaintenanceWindowTask'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'WindowId': windowId,
        'WindowTaskId': windowTaskId,
        if (description != null) 'Description': description,
        if (loggingInfo != null) 'LoggingInfo': loggingInfo,
        if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
        if (maxErrors != null) 'MaxErrors': maxErrors,
        if (name != null) 'Name': name,
        if (priority != null) 'Priority': priority,
        if (replace != null) 'Replace': replace,
        if (serviceRoleArn != null) 'ServiceRoleArn': serviceRoleArn,
        if (targets != null) 'Targets': targets,
        if (taskArn != null) 'TaskArn': taskArn,
        if (taskInvocationParameters != null)
          'TaskInvocationParameters': taskInvocationParameters,
        if (taskParameters != null) 'TaskParameters': taskParameters,
      },
    );

    return UpdateMaintenanceWindowTaskResult.fromJson(jsonResponse.body);
  }

  /// Changes the Amazon Identity and Access Management (IAM) role that is
  /// assigned to the on-premises instance or virtual machines (VM). IAM roles
  /// are first assigned to these hybrid instances during the activation
  /// process. For more information, see <a>CreateActivation</a>.
  ///
  /// May throw [InvalidInstanceId].
  /// May throw [InternalServerError].
  ///
  /// Parameter [iamRole] :
  /// The IAM role you want to assign or change.
  ///
  /// Parameter [instanceId] :
  /// The ID of the managed instance where you want to update the role.
  Future<void> updateManagedInstanceRole({
    required String iamRole,
    required String instanceId,
  }) async {
    ArgumentError.checkNotNull(iamRole, 'iamRole');
    _s.validateStringLength(
      'iamRole',
      iamRole,
      0,
      64,
      isRequired: true,
    );
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringPattern(
      'instanceId',
      instanceId,
      r'''^mi-[0-9a-f]{17}$''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateManagedInstanceRole'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'IamRole': iamRole,
        'InstanceId': instanceId,
      },
    );
  }

  /// Edit or change an OpsItem. You must have permission in AWS Identity and
  /// Access Management (IAM) to update an OpsItem. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-getting-started.html">Getting
  /// started with OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Operations engineers and IT professionals use OpsCenter to view,
  /// investigate, and remediate operational issues impacting the performance
  /// and health of their AWS resources. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html">AWS
  /// Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  ///
  /// May throw [InternalServerError].
  /// May throw [OpsItemNotFoundException].
  /// May throw [OpsItemAlreadyExistsException].
  /// May throw [OpsItemLimitExceededException].
  /// May throw [OpsItemInvalidParameterException].
  ///
  /// Parameter [opsItemId] :
  /// The ID of the OpsItem.
  ///
  /// Parameter [actualEndTime] :
  /// The time a runbook workflow ended. Currently reported only for the OpsItem
  /// type <code>/aws/changerequest</code>.
  ///
  /// Parameter [actualStartTime] :
  /// The time a runbook workflow started. Currently reported only for the
  /// OpsItem type <code>/aws/changerequest</code>.
  ///
  /// Parameter [category] :
  /// Specify a new category for an OpsItem.
  ///
  /// Parameter [description] :
  /// Update the information about the OpsItem. Provide enough information so
  /// that users reading this OpsItem for the first time understand the issue.
  ///
  /// Parameter [notifications] :
  /// The Amazon Resource Name (ARN) of an SNS topic where notifications are
  /// sent when this OpsItem is edited or changed.
  ///
  /// Parameter [operationalData] :
  /// Add new keys or edit existing key-value pairs of the OperationalData map
  /// in the OpsItem object.
  ///
  /// Operational data is custom data that provides useful reference details
  /// about the OpsItem. For example, you can specify log files, error strings,
  /// license keys, troubleshooting tips, or other relevant data. You enter
  /// operational data as key-value pairs. The key has a maximum length of 128
  /// characters. The value has a maximum size of 20 KB.
  /// <important>
  /// Operational data keys <i>can't</i> begin with the following: amazon, aws,
  /// amzn, ssm, /amazon, /aws, /amzn, /ssm.
  /// </important>
  /// You can choose to make the data searchable by other users in the account
  /// or you can restrict search access. Searchable data means that all users
  /// with access to the OpsItem Overview page (as provided by the
  /// <a>DescribeOpsItems</a> API action) can view and search on the specified
  /// data. Operational data that is not searchable is only viewable by users
  /// who have access to the OpsItem (as provided by the <a>GetOpsItem</a> API
  /// action).
  ///
  /// Use the <code>/aws/resources</code> key in OperationalData to specify a
  /// related resource in the request. Use the <code>/aws/automations</code> key
  /// in OperationalData to associate an Automation runbook with the OpsItem. To
  /// view AWS CLI example commands that use these keys, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-creating-OpsItems.html#OpsCenter-manually-create-OpsItems">Creating
  /// OpsItems manually</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [operationalDataToDelete] :
  /// Keys that you want to remove from the OperationalData map.
  ///
  /// Parameter [plannedEndTime] :
  /// The time specified in a change request for a runbook workflow to end.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  ///
  /// Parameter [plannedStartTime] :
  /// The time specified in a change request for a runbook workflow to start.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  ///
  /// Parameter [priority] :
  /// The importance of this OpsItem in relation to other OpsItems in the
  /// system.
  ///
  /// Parameter [relatedOpsItems] :
  /// One or more OpsItems that share something in common with the current
  /// OpsItems. For example, related OpsItems can include OpsItems with similar
  /// error messages, impacted resources, or statuses for the impacted resource.
  ///
  /// Parameter [severity] :
  /// Specify a new severity for an OpsItem.
  ///
  /// Parameter [status] :
  /// The OpsItem status. Status can be <code>Open</code>, <code>In
  /// Progress</code>, or <code>Resolved</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-working-with-OpsItems.html#OpsCenter-working-with-OpsItems-editing-details">Editing
  /// OpsItem details</a> in the <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [title] :
  /// A short heading that describes the nature of the OpsItem and the impacted
  /// resource.
  Future<void> updateOpsItem({
    required String opsItemId,
    DateTime? actualEndTime,
    DateTime? actualStartTime,
    String? category,
    String? description,
    List<OpsItemNotification>? notifications,
    Map<String, OpsItemDataValue>? operationalData,
    List<String>? operationalDataToDelete,
    DateTime? plannedEndTime,
    DateTime? plannedStartTime,
    int? priority,
    List<RelatedOpsItem>? relatedOpsItems,
    String? severity,
    OpsItemStatus? status,
    String? title,
  }) async {
    ArgumentError.checkNotNull(opsItemId, 'opsItemId');
    _s.validateStringPattern(
      'opsItemId',
      opsItemId,
      r'''^(oi)-[0-9a-f]{12}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'category',
      category,
      1,
      64,
    );
    _s.validateStringPattern(
      'category',
      category,
      r'''^(?!\s*$).+''',
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      1024,
    );
    _s.validateStringPattern(
      'description',
      description,
      r'''[\s\S]*\S[\s\S]*''',
    );
    _s.validateNumRange(
      'priority',
      priority,
      1,
      5,
    );
    _s.validateStringLength(
      'severity',
      severity,
      1,
      64,
    );
    _s.validateStringPattern(
      'severity',
      severity,
      r'''^(?!\s*$).+''',
    );
    _s.validateStringLength(
      'title',
      title,
      1,
      1024,
    );
    _s.validateStringPattern(
      'title',
      title,
      r'''^(?!\s*$).+''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateOpsItem'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'OpsItemId': opsItemId,
        if (actualEndTime != null)
          'ActualEndTime': unixTimestampToJson(actualEndTime),
        if (actualStartTime != null)
          'ActualStartTime': unixTimestampToJson(actualStartTime),
        if (category != null) 'Category': category,
        if (description != null) 'Description': description,
        if (notifications != null) 'Notifications': notifications,
        if (operationalData != null) 'OperationalData': operationalData,
        if (operationalDataToDelete != null)
          'OperationalDataToDelete': operationalDataToDelete,
        if (plannedEndTime != null)
          'PlannedEndTime': unixTimestampToJson(plannedEndTime),
        if (plannedStartTime != null)
          'PlannedStartTime': unixTimestampToJson(plannedStartTime),
        if (priority != null) 'Priority': priority,
        if (relatedOpsItems != null) 'RelatedOpsItems': relatedOpsItems,
        if (severity != null) 'Severity': severity,
        if (status != null) 'Status': status.toValue(),
        if (title != null) 'Title': title,
      },
    );
  }

  /// Systems Manager calls this API action when you edit OpsMetadata in
  /// Application Manager.
  ///
  /// May throw [OpsMetadataNotFoundException].
  /// May throw [OpsMetadataInvalidArgumentException].
  /// May throw [OpsMetadataKeyLimitExceededException].
  /// May throw [OpsMetadataTooManyUpdatesException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [opsMetadataArn] :
  /// The Amazon Resoure Name (ARN) of the OpsMetadata Object to update.
  ///
  /// Parameter [keysToDelete] :
  /// The metadata keys to delete from the OpsMetadata object.
  ///
  /// Parameter [metadataToUpdate] :
  /// Metadata to add to an OpsMetadata object.
  Future<UpdateOpsMetadataResult> updateOpsMetadata({
    required String opsMetadataArn,
    List<String>? keysToDelete,
    Map<String, MetadataValue>? metadataToUpdate,
  }) async {
    ArgumentError.checkNotNull(opsMetadataArn, 'opsMetadataArn');
    _s.validateStringLength(
      'opsMetadataArn',
      opsMetadataArn,
      1,
      1011,
      isRequired: true,
    );
    _s.validateStringPattern(
      'opsMetadataArn',
      opsMetadataArn,
      r'''arn:(aws[a-zA-Z-]*)?:ssm:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:opsmetadata\/([a-zA-Z0-9-_\.\/]*)''',
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateOpsMetadata'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'OpsMetadataArn': opsMetadataArn,
        if (keysToDelete != null) 'KeysToDelete': keysToDelete,
        if (metadataToUpdate != null) 'MetadataToUpdate': metadataToUpdate,
      },
    );

    return UpdateOpsMetadataResult.fromJson(jsonResponse.body);
  }

  /// Modifies an existing patch baseline. Fields not specified in the request
  /// are left unchanged.
  /// <note>
  /// For information about valid key and value pairs in
  /// <code>PatchFilters</code> for each supported operating system type, see <a
  /// href="http://docs.aws.amazon.com/systems-manager/latest/APIReference/API_PatchFilter.html">PatchFilter</a>.
  /// </note>
  ///
  /// May throw [DoesNotExistException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [baselineId] :
  /// The ID of the patch baseline to update.
  ///
  /// Parameter [approvalRules] :
  /// A set of rules used to include patches in the baseline.
  ///
  /// Parameter [approvedPatches] :
  /// A list of explicitly approved patches for the baseline.
  ///
  /// For information about accepted formats for lists of approved patches and
  /// rejected patches, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html">About
  /// package name formats for approved and rejected patch lists</a> in the
  /// <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [approvedPatchesComplianceLevel] :
  /// Assigns a new compliance severity level to an existing patch baseline.
  ///
  /// Parameter [approvedPatchesEnableNonSecurity] :
  /// Indicates whether the list of approved patches includes non-security
  /// updates that should be applied to the instances. The default value is
  /// 'false'. Applies to Linux instances only.
  ///
  /// Parameter [description] :
  /// A description of the patch baseline.
  ///
  /// Parameter [globalFilters] :
  /// A set of global filters used to include patches in the baseline.
  ///
  /// Parameter [name] :
  /// The name of the patch baseline.
  ///
  /// Parameter [rejectedPatches] :
  /// A list of explicitly rejected patches for the baseline.
  ///
  /// For information about accepted formats for lists of approved patches and
  /// rejected patches, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html">About
  /// package name formats for approved and rejected patch lists</a> in the
  /// <i>AWS Systems Manager User Guide</i>.
  ///
  /// Parameter [rejectedPatchesAction] :
  /// The action for Patch Manager to take on patches included in the
  /// RejectedPackages list.
  ///
  /// <ul>
  /// <li>
  /// <b>ALLOW_AS_DEPENDENCY</b>: A package in the Rejected patches list is
  /// installed only if it is a dependency of another package. It is considered
  /// compliant with the patch baseline, and its status is reported as
  /// <i>InstalledOther</i>. This is the default action if no option is
  /// specified.
  /// </li>
  /// <li>
  /// <b>BLOCK</b>: Packages in the RejectedPatches list, and packages that
  /// include them as dependencies, are not installed under any circumstances.
  /// If a package was installed before it was added to the Rejected patches
  /// list, it is considered non-compliant with the patch baseline, and its
  /// status is reported as <i>InstalledRejected</i>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [replace] :
  /// If True, then all fields that are required by the CreatePatchBaseline
  /// action are also required for this API request. Optional fields that are
  /// not specified are set to null.
  ///
  /// Parameter [sources] :
  /// Information about the patches to use to update the instances, including
  /// target operating systems and source repositories. Applies to Linux
  /// instances only.
  Future<UpdatePatchBaselineResult> updatePatchBaseline({
    required String baselineId,
    PatchRuleGroup? approvalRules,
    List<String>? approvedPatches,
    PatchComplianceLevel? approvedPatchesComplianceLevel,
    bool? approvedPatchesEnableNonSecurity,
    String? description,
    PatchFilterGroup? globalFilters,
    String? name,
    List<String>? rejectedPatches,
    PatchAction? rejectedPatchesAction,
    bool? replace,
    List<PatchSource>? sources,
  }) async {
    ArgumentError.checkNotNull(baselineId, 'baselineId');
    _s.validateStringLength(
      'baselineId',
      baselineId,
      20,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'baselineId',
      baselineId,
      r'''^[a-zA-Z0-9_\-:/]{20,128}$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      1,
      1024,
    );
    _s.validateStringLength(
      'name',
      name,
      3,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9_\-.]{3,128}$''',
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdatePatchBaseline'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BaselineId': baselineId,
        if (approvalRules != null) 'ApprovalRules': approvalRules,
        if (approvedPatches != null) 'ApprovedPatches': approvedPatches,
        if (approvedPatchesComplianceLevel != null)
          'ApprovedPatchesComplianceLevel':
              approvedPatchesComplianceLevel.toValue(),
        if (approvedPatchesEnableNonSecurity != null)
          'ApprovedPatchesEnableNonSecurity': approvedPatchesEnableNonSecurity,
        if (description != null) 'Description': description,
        if (globalFilters != null) 'GlobalFilters': globalFilters,
        if (name != null) 'Name': name,
        if (rejectedPatches != null) 'RejectedPatches': rejectedPatches,
        if (rejectedPatchesAction != null)
          'RejectedPatchesAction': rejectedPatchesAction.toValue(),
        if (replace != null) 'Replace': replace,
        if (sources != null) 'Sources': sources,
      },
    );

    return UpdatePatchBaselineResult.fromJson(jsonResponse.body);
  }

  /// Update a resource data sync. After you create a resource data sync for a
  /// Region, you can't change the account options for that sync. For example,
  /// if you create a sync in the us-east-2 (Ohio) Region and you choose the
  /// Include only the current account option, you can't edit that sync later
  /// and choose the Include all accounts from my AWS Organizations
  /// configuration option. Instead, you must delete the first resource data
  /// sync, and create a new one.
  /// <note>
  /// This API action only supports a resource data sync that was created with a
  /// SyncFromSource <code>SyncType</code>.
  /// </note>
  ///
  /// May throw [ResourceDataSyncNotFoundException].
  /// May throw [ResourceDataSyncInvalidConfigurationException].
  /// May throw [ResourceDataSyncConflictException].
  /// May throw [InternalServerError].
  ///
  /// Parameter [syncName] :
  /// The name of the resource data sync you want to update.
  ///
  /// Parameter [syncSource] :
  /// Specify information about the data sources to synchronize.
  ///
  /// Parameter [syncType] :
  /// The type of resource data sync. The supported <code>SyncType</code> is
  /// SyncFromSource.
  Future<void> updateResourceDataSync({
    required String syncName,
    required ResourceDataSyncSource syncSource,
    required String syncType,
  }) async {
    ArgumentError.checkNotNull(syncName, 'syncName');
    _s.validateStringLength(
      'syncName',
      syncName,
      1,
      64,
      isRequired: true,
    );
    ArgumentError.checkNotNull(syncSource, 'syncSource');
    ArgumentError.checkNotNull(syncType, 'syncType');
    _s.validateStringLength(
      'syncType',
      syncType,
      1,
      64,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateResourceDataSync'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SyncName': syncName,
        'SyncSource': syncSource,
        'SyncType': syncType,
      },
    );
  }

  /// <code>ServiceSetting</code> is an account-level setting for an AWS
  /// service. This setting defines how a user interacts with or uses a service
  /// or a feature of a service. For example, if an AWS service charges money to
  /// the account based on feature or service usage, then the AWS service team
  /// might create a default setting of "false". This means the user can't use
  /// this feature unless they change the setting to "true" and intentionally
  /// opt in for a paid feature.
  ///
  /// Services map a <code>SettingId</code> object to a setting value. AWS
  /// services teams define the default value for a <code>SettingId</code>. You
  /// can't create a new <code>SettingId</code>, but you can overwrite the
  /// default value if you have the <code>ssm:UpdateServiceSetting</code>
  /// permission for the setting. Use the <a>GetServiceSetting</a> API action to
  /// view the current value. Or, use the <a>ResetServiceSetting</a> to change
  /// the value back to the original value defined by the AWS service team.
  ///
  /// Update the service setting for the account.
  ///
  /// May throw [InternalServerError].
  /// May throw [ServiceSettingNotFound].
  /// May throw [TooManyUpdates].
  ///
  /// Parameter [settingId] :
  /// The Amazon Resource Name (ARN) of the service setting to reset. For
  /// example,
  /// <code>arn:aws:ssm:us-east-1:111122223333:servicesetting/ssm/parameter-store/high-throughput-enabled</code>.
  /// The setting ID can be one of the following.
  ///
  /// <ul>
  /// <li>
  /// <code>/ssm/parameter-store/default-parameter-tier</code>
  /// </li>
  /// <li>
  /// <code>/ssm/parameter-store/high-throughput-enabled</code>
  /// </li>
  /// <li>
  /// <code>/ssm/managed-instance/activation-tier</code>
  /// </li>
  /// </ul>
  ///
  /// Parameter [settingValue] :
  /// The new value to specify for the service setting. For the
  /// <code>/ssm/parameter-store/default-parameter-tier</code> setting ID, the
  /// setting value can be one of the following.
  ///
  /// <ul>
  /// <li>
  /// Standard
  /// </li>
  /// <li>
  /// Advanced
  /// </li>
  /// <li>
  /// Intelligent-Tiering
  /// </li>
  /// </ul>
  /// For the <code>/ssm/parameter-store/high-throughput-enabled</code>, and
  /// <code>/ssm/managed-instance/activation-tier</code> setting IDs, the
  /// setting value can be true or false.
  Future<void> updateServiceSetting({
    required String settingId,
    required String settingValue,
  }) async {
    ArgumentError.checkNotNull(settingId, 'settingId');
    _s.validateStringLength(
      'settingId',
      settingId,
      1,
      1000,
      isRequired: true,
    );
    ArgumentError.checkNotNull(settingValue, 'settingValue');
    _s.validateStringLength(
      'settingValue',
      settingValue,
      1,
      4096,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AmazonSSM.UpdateServiceSetting'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SettingId': settingId,
        'SettingValue': settingValue,
      },
    );
  }
}

/// Information includes the AWS account ID where the current document is shared
/// and the version shared with that account.
class AccountSharingInfo {
  /// The AWS account ID where the current document is shared.
  final String? accountId;

  /// The version of the current document shared with the account.
  final String? sharedDocumentVersion;

  AccountSharingInfo({
    this.accountId,
    this.sharedDocumentVersion,
  });
  factory AccountSharingInfo.fromJson(Map<String, dynamic> json) {
    return AccountSharingInfo(
      accountId: json['AccountId'] as String?,
      sharedDocumentVersion: json['SharedDocumentVersion'] as String?,
    );
  }
}

/// An activation registers one or more on-premises servers or virtual machines
/// (VMs) with AWS so that you can configure those servers or VMs using Run
/// Command. A server or VM that has been registered with AWS is called a
/// managed instance.
class Activation {
  /// The ID created by Systems Manager when you submitted the activation.
  final String? activationId;

  /// The date the activation was created.
  final DateTime? createdDate;

  /// A name for the managed instance when it is created.
  final String? defaultInstanceName;

  /// A user defined description of the activation.
  final String? description;

  /// The date when this activation can no longer be used to register managed
  /// instances.
  final DateTime? expirationDate;

  /// Whether or not the activation is expired.
  final bool? expired;

  /// The Amazon Identity and Access Management (IAM) role to assign to the
  /// managed instance.
  final String? iamRole;

  /// The maximum number of managed instances that can be registered using this
  /// activation.
  final int? registrationLimit;

  /// The number of managed instances already registered with this activation.
  final int? registrationsCount;

  /// Tags assigned to the activation.
  final List<Tag>? tags;

  Activation({
    this.activationId,
    this.createdDate,
    this.defaultInstanceName,
    this.description,
    this.expirationDate,
    this.expired,
    this.iamRole,
    this.registrationLimit,
    this.registrationsCount,
    this.tags,
  });
  factory Activation.fromJson(Map<String, dynamic> json) {
    return Activation(
      activationId: json['ActivationId'] as String?,
      createdDate: timeStampFromJson(json['CreatedDate']),
      defaultInstanceName: json['DefaultInstanceName'] as String?,
      description: json['Description'] as String?,
      expirationDate: timeStampFromJson(json['ExpirationDate']),
      expired: json['Expired'] as bool?,
      iamRole: json['IamRole'] as String?,
      registrationLimit: json['RegistrationLimit'] as int?,
      registrationsCount: json['RegistrationsCount'] as int?,
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AddTagsToResourceResult {
  AddTagsToResourceResult();
  factory AddTagsToResourceResult.fromJson(Map<String, dynamic> _) {
    return AddTagsToResourceResult();
  }
}

/// Describes an association of a Systems Manager document and an instance.
class Association {
  /// The ID created by the system when you create an association. An association
  /// is a binding between a document and a set of targets with a schedule.
  final String? associationId;

  /// The association name.
  final String? associationName;

  /// The association version.
  final String? associationVersion;

  /// The version of the document used in the association.
  final String? documentVersion;

  /// The ID of the instance.
  final String? instanceId;

  /// The date on which the association was last run.
  final DateTime? lastExecutionDate;

  /// The name of the Systems Manager document.
  final String? name;

  /// Information about the association.
  final AssociationOverview? overview;

  /// A cron expression that specifies a schedule when the association runs.
  final String? scheduleExpression;

  /// The instances targeted by the request to create an association.
  final List<Target>? targets;

  Association({
    this.associationId,
    this.associationName,
    this.associationVersion,
    this.documentVersion,
    this.instanceId,
    this.lastExecutionDate,
    this.name,
    this.overview,
    this.scheduleExpression,
    this.targets,
  });
  factory Association.fromJson(Map<String, dynamic> json) {
    return Association(
      associationId: json['AssociationId'] as String?,
      associationName: json['AssociationName'] as String?,
      associationVersion: json['AssociationVersion'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      instanceId: json['InstanceId'] as String?,
      lastExecutionDate: timeStampFromJson(json['LastExecutionDate']),
      name: json['Name'] as String?,
      overview: json['Overview'] != null
          ? AssociationOverview.fromJson(
              json['Overview'] as Map<String, dynamic>)
          : null,
      scheduleExpression: json['ScheduleExpression'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

enum AssociationComplianceSeverity {
  critical,
  high,
  medium,
  low,
  unspecified,
}

extension on AssociationComplianceSeverity {
  String toValue() {
    switch (this) {
      case AssociationComplianceSeverity.critical:
        return 'CRITICAL';
      case AssociationComplianceSeverity.high:
        return 'HIGH';
      case AssociationComplianceSeverity.medium:
        return 'MEDIUM';
      case AssociationComplianceSeverity.low:
        return 'LOW';
      case AssociationComplianceSeverity.unspecified:
        return 'UNSPECIFIED';
    }
  }
}

extension on String {
  AssociationComplianceSeverity toAssociationComplianceSeverity() {
    switch (this) {
      case 'CRITICAL':
        return AssociationComplianceSeverity.critical;
      case 'HIGH':
        return AssociationComplianceSeverity.high;
      case 'MEDIUM':
        return AssociationComplianceSeverity.medium;
      case 'LOW':
        return AssociationComplianceSeverity.low;
      case 'UNSPECIFIED':
        return AssociationComplianceSeverity.unspecified;
    }
    throw Exception('$this is not known in enum AssociationComplianceSeverity');
  }
}

/// Describes the parameters for a document.
class AssociationDescription {
  /// By default, when you create a new associations, the system runs it
  /// immediately after it is created and then according to the schedule you
  /// specified. Specify this option if you don't want an association to run
  /// immediately after you create it. This parameter is not supported for rate
  /// expressions.
  final bool? applyOnlyAtCronInterval;

  /// The association ID.
  final String? associationId;

  /// The association name.
  final String? associationName;

  /// The association version.
  final String? associationVersion;

  /// Specify the target for the association. This target is required for
  /// associations that use an Automation document and target resources by using
  /// rate controls.
  final String? automationTargetParameterName;

  /// The severity level that is assigned to the association.
  final AssociationComplianceSeverity? complianceSeverity;

  /// The date when the association was made.
  final DateTime? date;

  /// The document version.
  final String? documentVersion;

  /// The ID of the instance.
  final String? instanceId;

  /// The date on which the association was last run.
  final DateTime? lastExecutionDate;

  /// The last date on which the association was successfully run.
  final DateTime? lastSuccessfulExecutionDate;

  /// The date when the association was last updated.
  final DateTime? lastUpdateAssociationDate;

  /// The maximum number of targets allowed to run the association at the same
  /// time. You can specify a number, for example 10, or a percentage of the
  /// target set, for example 10%. The default value is 100%, which means all
  /// targets run the association at the same time.
  ///
  /// If a new instance starts and attempts to run an association while Systems
  /// Manager is running MaxConcurrency associations, the association is allowed
  /// to run. During the next association interval, the new instance will process
  /// its association within the limit specified for MaxConcurrency.
  final String? maxConcurrency;

  /// The number of errors that are allowed before the system stops sending
  /// requests to run the association on additional targets. You can specify
  /// either an absolute number of errors, for example 10, or a percentage of the
  /// target set, for example 10%. If you specify 3, for example, the system stops
  /// sending requests when the fourth error is received. If you specify 0, then
  /// the system stops sending requests after the first error is returned. If you
  /// run an association on 50 instances and set MaxError to 10%, then the system
  /// stops sending the request when the sixth error is received.
  ///
  /// Executions that are already running an association when MaxErrors is reached
  /// are allowed to complete, but some of these executions may fail as well. If
  /// you need to ensure that there won't be more than max-errors failed
  /// executions, set MaxConcurrency to 1 so that executions proceed one at a
  /// time.
  final String? maxErrors;

  /// The name of the Systems Manager document.
  final String? name;

  /// An S3 bucket where you want to store the output details of the request.
  final InstanceAssociationOutputLocation? outputLocation;

  /// Information about the association.
  final AssociationOverview? overview;

  /// A description of the parameters for a document.
  final Map<String, List<String>>? parameters;

  /// A cron expression that specifies a schedule when the association runs.
  final String? scheduleExpression;

  /// The association status.
  final AssociationStatus? status;

  /// The mode for generating association compliance. You can specify
  /// <code>AUTO</code> or <code>MANUAL</code>. In <code>AUTO</code> mode, the
  /// system uses the status of the association execution to determine the
  /// compliance status. If the association execution runs successfully, then the
  /// association is <code>COMPLIANT</code>. If the association execution doesn't
  /// run successfully, the association is <code>NON-COMPLIANT</code>.
  ///
  /// In <code>MANUAL</code> mode, you must specify the <code>AssociationId</code>
  /// as a parameter for the <a>PutComplianceItems</a> API action. In this case,
  /// compliance data is not managed by State Manager. It is managed by your
  /// direct call to the <a>PutComplianceItems</a> API action.
  ///
  /// By default, all associations use <code>AUTO</code> mode.
  final AssociationSyncCompliance? syncCompliance;

  /// The combination of AWS Regions and AWS accounts where you want to run the
  /// association.
  final List<TargetLocation>? targetLocations;

  /// The instances targeted by the request.
  final List<Target>? targets;

  AssociationDescription({
    this.applyOnlyAtCronInterval,
    this.associationId,
    this.associationName,
    this.associationVersion,
    this.automationTargetParameterName,
    this.complianceSeverity,
    this.date,
    this.documentVersion,
    this.instanceId,
    this.lastExecutionDate,
    this.lastSuccessfulExecutionDate,
    this.lastUpdateAssociationDate,
    this.maxConcurrency,
    this.maxErrors,
    this.name,
    this.outputLocation,
    this.overview,
    this.parameters,
    this.scheduleExpression,
    this.status,
    this.syncCompliance,
    this.targetLocations,
    this.targets,
  });
  factory AssociationDescription.fromJson(Map<String, dynamic> json) {
    return AssociationDescription(
      applyOnlyAtCronInterval: json['ApplyOnlyAtCronInterval'] as bool?,
      associationId: json['AssociationId'] as String?,
      associationName: json['AssociationName'] as String?,
      associationVersion: json['AssociationVersion'] as String?,
      automationTargetParameterName:
          json['AutomationTargetParameterName'] as String?,
      complianceSeverity: (json['ComplianceSeverity'] as String?)
          ?.toAssociationComplianceSeverity(),
      date: timeStampFromJson(json['Date']),
      documentVersion: json['DocumentVersion'] as String?,
      instanceId: json['InstanceId'] as String?,
      lastExecutionDate: timeStampFromJson(json['LastExecutionDate']),
      lastSuccessfulExecutionDate:
          timeStampFromJson(json['LastSuccessfulExecutionDate']),
      lastUpdateAssociationDate:
          timeStampFromJson(json['LastUpdateAssociationDate']),
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      name: json['Name'] as String?,
      outputLocation: json['OutputLocation'] != null
          ? InstanceAssociationOutputLocation.fromJson(
              json['OutputLocation'] as Map<String, dynamic>)
          : null,
      overview: json['Overview'] != null
          ? AssociationOverview.fromJson(
              json['Overview'] as Map<String, dynamic>)
          : null,
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      scheduleExpression: json['ScheduleExpression'] as String?,
      status: json['Status'] != null
          ? AssociationStatus.fromJson(json['Status'] as Map<String, dynamic>)
          : null,
      syncCompliance:
          (json['SyncCompliance'] as String?)?.toAssociationSyncCompliance(),
      targetLocations: (json['TargetLocations'] as List?)
          ?.whereNotNull()
          .map((e) => TargetLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Includes information about the specified association.
class AssociationExecution {
  /// The association ID.
  final String? associationId;

  /// The association version.
  final String? associationVersion;

  /// The time the execution started.
  final DateTime? createdTime;

  /// Detailed status information about the execution.
  final String? detailedStatus;

  /// The execution ID for the association.
  final String? executionId;

  /// The date of the last execution.
  final DateTime? lastExecutionDate;

  /// An aggregate status of the resources in the execution based on the status
  /// type.
  final String? resourceCountByStatus;

  /// The status of the association execution.
  final String? status;

  AssociationExecution({
    this.associationId,
    this.associationVersion,
    this.createdTime,
    this.detailedStatus,
    this.executionId,
    this.lastExecutionDate,
    this.resourceCountByStatus,
    this.status,
  });
  factory AssociationExecution.fromJson(Map<String, dynamic> json) {
    return AssociationExecution(
      associationId: json['AssociationId'] as String?,
      associationVersion: json['AssociationVersion'] as String?,
      createdTime: timeStampFromJson(json['CreatedTime']),
      detailedStatus: json['DetailedStatus'] as String?,
      executionId: json['ExecutionId'] as String?,
      lastExecutionDate: timeStampFromJson(json['LastExecutionDate']),
      resourceCountByStatus: json['ResourceCountByStatus'] as String?,
      status: json['Status'] as String?,
    );
  }
}

/// Filters used in the request.
class AssociationExecutionFilter {
  /// The key value used in the request.
  final AssociationExecutionFilterKey key;

  /// The filter type specified in the request.
  final AssociationFilterOperatorType type;

  /// The value specified for the key.
  final String value;

  AssociationExecutionFilter({
    required this.key,
    required this.type,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final type = this.type;
    final value = this.value;
    return {
      'Key': key.toValue(),
      'Type': type.toValue(),
      'Value': value,
    };
  }
}

enum AssociationExecutionFilterKey {
  executionId,
  status,
  createdTime,
}

extension on AssociationExecutionFilterKey {
  String toValue() {
    switch (this) {
      case AssociationExecutionFilterKey.executionId:
        return 'ExecutionId';
      case AssociationExecutionFilterKey.status:
        return 'Status';
      case AssociationExecutionFilterKey.createdTime:
        return 'CreatedTime';
    }
  }
}

extension on String {
  AssociationExecutionFilterKey toAssociationExecutionFilterKey() {
    switch (this) {
      case 'ExecutionId':
        return AssociationExecutionFilterKey.executionId;
      case 'Status':
        return AssociationExecutionFilterKey.status;
      case 'CreatedTime':
        return AssociationExecutionFilterKey.createdTime;
    }
    throw Exception('$this is not known in enum AssociationExecutionFilterKey');
  }
}

/// Includes information about the specified association execution.
class AssociationExecutionTarget {
  /// The association ID.
  final String? associationId;

  /// The association version.
  final String? associationVersion;

  /// Detailed information about the execution status.
  final String? detailedStatus;

  /// The execution ID.
  final String? executionId;

  /// The date of the last execution.
  final DateTime? lastExecutionDate;

  /// The location where the association details are saved.
  final OutputSource? outputSource;

  /// The resource ID, for example, the instance ID where the association ran.
  final String? resourceId;

  /// The resource type, for example, instance.
  final String? resourceType;

  /// The association execution status.
  final String? status;

  AssociationExecutionTarget({
    this.associationId,
    this.associationVersion,
    this.detailedStatus,
    this.executionId,
    this.lastExecutionDate,
    this.outputSource,
    this.resourceId,
    this.resourceType,
    this.status,
  });
  factory AssociationExecutionTarget.fromJson(Map<String, dynamic> json) {
    return AssociationExecutionTarget(
      associationId: json['AssociationId'] as String?,
      associationVersion: json['AssociationVersion'] as String?,
      detailedStatus: json['DetailedStatus'] as String?,
      executionId: json['ExecutionId'] as String?,
      lastExecutionDate: timeStampFromJson(json['LastExecutionDate']),
      outputSource: json['OutputSource'] != null
          ? OutputSource.fromJson(json['OutputSource'] as Map<String, dynamic>)
          : null,
      resourceId: json['ResourceId'] as String?,
      resourceType: json['ResourceType'] as String?,
      status: json['Status'] as String?,
    );
  }
}

/// Filters for the association execution.
class AssociationExecutionTargetsFilter {
  /// The key value used in the request.
  final AssociationExecutionTargetsFilterKey key;

  /// The value specified for the key.
  final String value;

  AssociationExecutionTargetsFilter({
    required this.key,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'Key': key.toValue(),
      'Value': value,
    };
  }
}

enum AssociationExecutionTargetsFilterKey {
  status,
  resourceId,
  resourceType,
}

extension on AssociationExecutionTargetsFilterKey {
  String toValue() {
    switch (this) {
      case AssociationExecutionTargetsFilterKey.status:
        return 'Status';
      case AssociationExecutionTargetsFilterKey.resourceId:
        return 'ResourceId';
      case AssociationExecutionTargetsFilterKey.resourceType:
        return 'ResourceType';
    }
  }
}

extension on String {
  AssociationExecutionTargetsFilterKey
      toAssociationExecutionTargetsFilterKey() {
    switch (this) {
      case 'Status':
        return AssociationExecutionTargetsFilterKey.status;
      case 'ResourceId':
        return AssociationExecutionTargetsFilterKey.resourceId;
      case 'ResourceType':
        return AssociationExecutionTargetsFilterKey.resourceType;
    }
    throw Exception(
        '$this is not known in enum AssociationExecutionTargetsFilterKey');
  }
}

/// Describes a filter.
class AssociationFilter {
  /// The name of the filter.
  /// <note>
  /// <code>InstanceId</code> has been deprecated.
  /// </note>
  final AssociationFilterKey key;

  /// The filter value.
  final String value;

  AssociationFilter({
    required this.key,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'key': key.toValue(),
      'value': value,
    };
  }
}

enum AssociationFilterKey {
  instanceId,
  name,
  associationId,
  associationStatusName,
  lastExecutedBefore,
  lastExecutedAfter,
  associationName,
  resourceGroupName,
}

extension on AssociationFilterKey {
  String toValue() {
    switch (this) {
      case AssociationFilterKey.instanceId:
        return 'InstanceId';
      case AssociationFilterKey.name:
        return 'Name';
      case AssociationFilterKey.associationId:
        return 'AssociationId';
      case AssociationFilterKey.associationStatusName:
        return 'AssociationStatusName';
      case AssociationFilterKey.lastExecutedBefore:
        return 'LastExecutedBefore';
      case AssociationFilterKey.lastExecutedAfter:
        return 'LastExecutedAfter';
      case AssociationFilterKey.associationName:
        return 'AssociationName';
      case AssociationFilterKey.resourceGroupName:
        return 'ResourceGroupName';
    }
  }
}

extension on String {
  AssociationFilterKey toAssociationFilterKey() {
    switch (this) {
      case 'InstanceId':
        return AssociationFilterKey.instanceId;
      case 'Name':
        return AssociationFilterKey.name;
      case 'AssociationId':
        return AssociationFilterKey.associationId;
      case 'AssociationStatusName':
        return AssociationFilterKey.associationStatusName;
      case 'LastExecutedBefore':
        return AssociationFilterKey.lastExecutedBefore;
      case 'LastExecutedAfter':
        return AssociationFilterKey.lastExecutedAfter;
      case 'AssociationName':
        return AssociationFilterKey.associationName;
      case 'ResourceGroupName':
        return AssociationFilterKey.resourceGroupName;
    }
    throw Exception('$this is not known in enum AssociationFilterKey');
  }
}

enum AssociationFilterOperatorType {
  equal,
  lessThan,
  greaterThan,
}

extension on AssociationFilterOperatorType {
  String toValue() {
    switch (this) {
      case AssociationFilterOperatorType.equal:
        return 'EQUAL';
      case AssociationFilterOperatorType.lessThan:
        return 'LESS_THAN';
      case AssociationFilterOperatorType.greaterThan:
        return 'GREATER_THAN';
    }
  }
}

extension on String {
  AssociationFilterOperatorType toAssociationFilterOperatorType() {
    switch (this) {
      case 'EQUAL':
        return AssociationFilterOperatorType.equal;
      case 'LESS_THAN':
        return AssociationFilterOperatorType.lessThan;
      case 'GREATER_THAN':
        return AssociationFilterOperatorType.greaterThan;
    }
    throw Exception('$this is not known in enum AssociationFilterOperatorType');
  }
}

/// Information about the association.
class AssociationOverview {
  /// Returns the number of targets for the association status. For example, if
  /// you created an association with two instances, and one of them was
  /// successful, this would return the count of instances by status.
  final Map<String, int>? associationStatusAggregatedCount;

  /// A detailed status of the association.
  final String? detailedStatus;

  /// The status of the association. Status can be: Pending, Success, or Failed.
  final String? status;

  AssociationOverview({
    this.associationStatusAggregatedCount,
    this.detailedStatus,
    this.status,
  });
  factory AssociationOverview.fromJson(Map<String, dynamic> json) {
    return AssociationOverview(
      associationStatusAggregatedCount:
          (json['AssociationStatusAggregatedCount'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as int)),
      detailedStatus: json['DetailedStatus'] as String?,
      status: json['Status'] as String?,
    );
  }
}

/// Describes an association status.
class AssociationStatus {
  /// The date when the status changed.
  final DateTime date;

  /// The reason for the status.
  final String message;

  /// The status.
  final AssociationStatusName name;

  /// A user-defined string.
  final String? additionalInfo;

  AssociationStatus({
    required this.date,
    required this.message,
    required this.name,
    this.additionalInfo,
  });
  factory AssociationStatus.fromJson(Map<String, dynamic> json) {
    return AssociationStatus(
      date: nonNullableTimeStampFromJson(json['Date'] as Object),
      message: json['Message'] as String,
      name: (json['Name'] as String).toAssociationStatusName(),
      additionalInfo: json['AdditionalInfo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final date = this.date;
    final message = this.message;
    final name = this.name;
    final additionalInfo = this.additionalInfo;
    return {
      'Date': unixTimestampToJson(date),
      'Message': message,
      'Name': name.toValue(),
      if (additionalInfo != null) 'AdditionalInfo': additionalInfo,
    };
  }
}

enum AssociationStatusName {
  pending,
  success,
  failed,
}

extension on AssociationStatusName {
  String toValue() {
    switch (this) {
      case AssociationStatusName.pending:
        return 'Pending';
      case AssociationStatusName.success:
        return 'Success';
      case AssociationStatusName.failed:
        return 'Failed';
    }
  }
}

extension on String {
  AssociationStatusName toAssociationStatusName() {
    switch (this) {
      case 'Pending':
        return AssociationStatusName.pending;
      case 'Success':
        return AssociationStatusName.success;
      case 'Failed':
        return AssociationStatusName.failed;
    }
    throw Exception('$this is not known in enum AssociationStatusName');
  }
}

enum AssociationSyncCompliance {
  auto,
  manual,
}

extension on AssociationSyncCompliance {
  String toValue() {
    switch (this) {
      case AssociationSyncCompliance.auto:
        return 'AUTO';
      case AssociationSyncCompliance.manual:
        return 'MANUAL';
    }
  }
}

extension on String {
  AssociationSyncCompliance toAssociationSyncCompliance() {
    switch (this) {
      case 'AUTO':
        return AssociationSyncCompliance.auto;
      case 'MANUAL':
        return AssociationSyncCompliance.manual;
    }
    throw Exception('$this is not known in enum AssociationSyncCompliance');
  }
}

/// Information about the association version.
class AssociationVersionInfo {
  /// By default, when you create a new associations, the system runs it
  /// immediately after it is created and then according to the schedule you
  /// specified. Specify this option if you don't want an association to run
  /// immediately after you create it. This parameter is not supported for rate
  /// expressions.
  final bool? applyOnlyAtCronInterval;

  /// The ID created by the system when the association was created.
  final String? associationId;

  /// The name specified for the association version when the association version
  /// was created.
  final String? associationName;

  /// The association version.
  final String? associationVersion;

  /// The severity level that is assigned to the association.
  final AssociationComplianceSeverity? complianceSeverity;

  /// The date the association version was created.
  final DateTime? createdDate;

  /// The version of a Systems Manager document used when the association version
  /// was created.
  final String? documentVersion;

  /// The maximum number of targets allowed to run the association at the same
  /// time. You can specify a number, for example 10, or a percentage of the
  /// target set, for example 10%. The default value is 100%, which means all
  /// targets run the association at the same time.
  ///
  /// If a new instance starts and attempts to run an association while Systems
  /// Manager is running MaxConcurrency associations, the association is allowed
  /// to run. During the next association interval, the new instance will process
  /// its association within the limit specified for MaxConcurrency.
  final String? maxConcurrency;

  /// The number of errors that are allowed before the system stops sending
  /// requests to run the association on additional targets. You can specify
  /// either an absolute number of errors, for example 10, or a percentage of the
  /// target set, for example 10%. If you specify 3, for example, the system stops
  /// sending requests when the fourth error is received. If you specify 0, then
  /// the system stops sending requests after the first error is returned. If you
  /// run an association on 50 instances and set MaxError to 10%, then the system
  /// stops sending the request when the sixth error is received.
  ///
  /// Executions that are already running an association when MaxErrors is reached
  /// are allowed to complete, but some of these executions may fail as well. If
  /// you need to ensure that there won't be more than max-errors failed
  /// executions, set MaxConcurrency to 1 so that executions proceed one at a
  /// time.
  final String? maxErrors;

  /// The name specified when the association was created.
  final String? name;

  /// The location in Amazon S3 specified for the association when the association
  /// version was created.
  final InstanceAssociationOutputLocation? outputLocation;

  /// Parameters specified when the association version was created.
  final Map<String, List<String>>? parameters;

  /// The cron or rate schedule specified for the association when the association
  /// version was created.
  final String? scheduleExpression;

  /// The mode for generating association compliance. You can specify
  /// <code>AUTO</code> or <code>MANUAL</code>. In <code>AUTO</code> mode, the
  /// system uses the status of the association execution to determine the
  /// compliance status. If the association execution runs successfully, then the
  /// association is <code>COMPLIANT</code>. If the association execution doesn't
  /// run successfully, the association is <code>NON-COMPLIANT</code>.
  ///
  /// In <code>MANUAL</code> mode, you must specify the <code>AssociationId</code>
  /// as a parameter for the <a>PutComplianceItems</a> API action. In this case,
  /// compliance data is not managed by State Manager. It is managed by your
  /// direct call to the <a>PutComplianceItems</a> API action.
  ///
  /// By default, all associations use <code>AUTO</code> mode.
  final AssociationSyncCompliance? syncCompliance;

  /// The combination of AWS Regions and AWS accounts where you wanted to run the
  /// association when this association version was created.
  final List<TargetLocation>? targetLocations;

  /// The targets specified for the association when the association version was
  /// created.
  final List<Target>? targets;

  AssociationVersionInfo({
    this.applyOnlyAtCronInterval,
    this.associationId,
    this.associationName,
    this.associationVersion,
    this.complianceSeverity,
    this.createdDate,
    this.documentVersion,
    this.maxConcurrency,
    this.maxErrors,
    this.name,
    this.outputLocation,
    this.parameters,
    this.scheduleExpression,
    this.syncCompliance,
    this.targetLocations,
    this.targets,
  });
  factory AssociationVersionInfo.fromJson(Map<String, dynamic> json) {
    return AssociationVersionInfo(
      applyOnlyAtCronInterval: json['ApplyOnlyAtCronInterval'] as bool?,
      associationId: json['AssociationId'] as String?,
      associationName: json['AssociationName'] as String?,
      associationVersion: json['AssociationVersion'] as String?,
      complianceSeverity: (json['ComplianceSeverity'] as String?)
          ?.toAssociationComplianceSeverity(),
      createdDate: timeStampFromJson(json['CreatedDate']),
      documentVersion: json['DocumentVersion'] as String?,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      name: json['Name'] as String?,
      outputLocation: json['OutputLocation'] != null
          ? InstanceAssociationOutputLocation.fromJson(
              json['OutputLocation'] as Map<String, dynamic>)
          : null,
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      scheduleExpression: json['ScheduleExpression'] as String?,
      syncCompliance:
          (json['SyncCompliance'] as String?)?.toAssociationSyncCompliance(),
      targetLocations: (json['TargetLocations'] as List?)
          ?.whereNotNull()
          .map((e) => TargetLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// A structure that includes attributes that describe a document attachment.
class AttachmentContent {
  /// The cryptographic hash value of the document content.
  final String? hash;

  /// The hash algorithm used to calculate the hash value.
  final AttachmentHashType? hashType;

  /// The name of an attachment.
  final String? name;

  /// The size of an attachment in bytes.
  final int? size;

  /// The URL location of the attachment content.
  final String? url;

  AttachmentContent({
    this.hash,
    this.hashType,
    this.name,
    this.size,
    this.url,
  });
  factory AttachmentContent.fromJson(Map<String, dynamic> json) {
    return AttachmentContent(
      hash: json['Hash'] as String?,
      hashType: (json['HashType'] as String?)?.toAttachmentHashType(),
      name: json['Name'] as String?,
      size: json['Size'] as int?,
      url: json['Url'] as String?,
    );
  }
}

enum AttachmentHashType {
  sha256,
}

extension on AttachmentHashType {
  String toValue() {
    switch (this) {
      case AttachmentHashType.sha256:
        return 'Sha256';
    }
  }
}

extension on String {
  AttachmentHashType toAttachmentHashType() {
    switch (this) {
      case 'Sha256':
        return AttachmentHashType.sha256;
    }
    throw Exception('$this is not known in enum AttachmentHashType');
  }
}

/// An attribute of an attachment, such as the attachment name.
class AttachmentInformation {
  /// The name of the attachment.
  final String? name;

  AttachmentInformation({
    this.name,
  });
  factory AttachmentInformation.fromJson(Map<String, dynamic> json) {
    return AttachmentInformation(
      name: json['Name'] as String?,
    );
  }
}

/// Identifying information about a document attachment, including the file name
/// and a key-value pair that identifies the location of an attachment to a
/// document.
class AttachmentsSource {
  /// The key of a key-value pair that identifies the location of an attachment to
  /// a document.
  final AttachmentsSourceKey? key;

  /// The name of the document attachment file.
  final String? name;

  /// The value of a key-value pair that identifies the location of an attachment
  /// to a document. The format for <b>Value</b> depends on the type of key you
  /// specify.
  ///
  /// <ul>
  /// <li>
  /// For the key <i>SourceUrl</i>, the value is an S3 bucket location. For
  /// example:
  ///
  /// <code>"Values": [ "s3://doc-example-bucket/my-folder" ]</code>
  /// </li>
  /// <li>
  /// For the key <i>S3FileUrl</i>, the value is a file in an S3 bucket. For
  /// example:
  ///
  /// <code>"Values": [ "s3://doc-example-bucket/my-folder/my-file.py" ]</code>
  /// </li>
  /// <li>
  /// For the key <i>AttachmentReference</i>, the value is constructed from the
  /// name of another SSM document in your account, a version number of that
  /// document, and a file attached to that document version that you want to
  /// reuse. For example:
  ///
  /// <code>"Values": [ "MyOtherDocument/3/my-other-file.py" ]</code>
  ///
  /// However, if the SSM document is shared with you from another account, the
  /// full SSM document ARN must be specified instead of the document name only.
  /// For example:
  ///
  /// <code>"Values": [
  /// "arn:aws:ssm:us-east-2:111122223333:document/OtherAccountDocument/3/their-file.py"
  /// ]</code>
  /// </li>
  /// </ul>
  final List<String>? values;

  AttachmentsSource({
    this.key,
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final name = this.name;
    final values = this.values;
    return {
      if (key != null) 'Key': key.toValue(),
      if (name != null) 'Name': name,
      if (values != null) 'Values': values,
    };
  }
}

enum AttachmentsSourceKey {
  sourceUrl,
  s3FileUrl,
  attachmentReference,
}

extension on AttachmentsSourceKey {
  String toValue() {
    switch (this) {
      case AttachmentsSourceKey.sourceUrl:
        return 'SourceUrl';
      case AttachmentsSourceKey.s3FileUrl:
        return 'S3FileUrl';
      case AttachmentsSourceKey.attachmentReference:
        return 'AttachmentReference';
    }
  }
}

extension on String {
  AttachmentsSourceKey toAttachmentsSourceKey() {
    switch (this) {
      case 'SourceUrl':
        return AttachmentsSourceKey.sourceUrl;
      case 'S3FileUrl':
        return AttachmentsSourceKey.s3FileUrl;
      case 'AttachmentReference':
        return AttachmentsSourceKey.attachmentReference;
    }
    throw Exception('$this is not known in enum AttachmentsSourceKey');
  }
}

/// Detailed information about the current state of an individual Automation
/// execution.
class AutomationExecution {
  /// The ID of a State Manager association used in the Automation operation.
  final String? associationId;

  /// The execution ID.
  final String? automationExecutionId;

  /// The execution status of the Automation.
  final AutomationExecutionStatus? automationExecutionStatus;

  /// The subtype of the Automation operation. Currently, the only supported value
  /// is <code>ChangeRequest</code>.
  final AutomationSubtype? automationSubtype;

  /// The name of the Change Manager change request.
  final String? changeRequestName;

  /// The action of the step that is currently running.
  final String? currentAction;

  /// The name of the step that is currently running.
  final String? currentStepName;

  /// The name of the Automation document used during the execution.
  final String? documentName;

  /// The version of the document to use during execution.
  final String? documentVersion;

  /// The Amazon Resource Name (ARN) of the user who ran the automation.
  final String? executedBy;

  /// The time the execution finished.
  final DateTime? executionEndTime;

  /// The time the execution started.
  final DateTime? executionStartTime;

  /// A message describing why an execution has failed, if the status is set to
  /// Failed.
  final String? failureMessage;

  /// The MaxConcurrency value specified by the user when the execution started.
  final String? maxConcurrency;

  /// The MaxErrors value specified by the user when the execution started.
  final String? maxErrors;

  /// The automation execution mode.
  final ExecutionMode? mode;

  /// The ID of an OpsItem that is created to represent a Change Manager change
  /// request.
  final String? opsItemId;

  /// The list of execution outputs as defined in the automation document.
  final Map<String, List<String>>? outputs;

  /// The key-value map of execution parameters, which were supplied when calling
  /// StartAutomationExecution.
  final Map<String, List<String>>? parameters;

  /// The AutomationExecutionId of the parent automation.
  final String? parentAutomationExecutionId;

  /// An aggregate of step execution statuses displayed in the AWS Console for a
  /// multi-Region and multi-account Automation execution.
  final ProgressCounters? progressCounters;

  /// A list of resolved targets in the rate control execution.
  final ResolvedTargets? resolvedTargets;

  /// Information about the Automation runbooks (Automation documents) that are
  /// run as part of a runbook workflow.
  /// <note>
  /// The Automation runbooks specified for the runbook workflow can't run until
  /// all required approvals for the change request have been received.
  /// </note>
  final List<Runbook>? runbooks;

  /// The date and time the Automation operation is scheduled to start.
  final DateTime? scheduledTime;

  /// A list of details about the current state of all steps that comprise an
  /// execution. An Automation document contains a list of steps that are run in
  /// order.
  final List<StepExecution>? stepExecutions;

  /// A boolean value that indicates if the response contains the full list of the
  /// Automation step executions. If true, use the
  /// DescribeAutomationStepExecutions API action to get the full list of step
  /// executions.
  final bool? stepExecutionsTruncated;

  /// The target of the execution.
  final String? target;

  /// The combination of AWS Regions and/or AWS accounts where you want to run the
  /// Automation.
  final List<TargetLocation>? targetLocations;

  /// The specified key-value mapping of document parameters to target resources.
  final List<Map<String, List<String>>>? targetMaps;

  /// The parameter name.
  final String? targetParameterName;

  /// The specified targets.
  final List<Target>? targets;

  AutomationExecution({
    this.associationId,
    this.automationExecutionId,
    this.automationExecutionStatus,
    this.automationSubtype,
    this.changeRequestName,
    this.currentAction,
    this.currentStepName,
    this.documentName,
    this.documentVersion,
    this.executedBy,
    this.executionEndTime,
    this.executionStartTime,
    this.failureMessage,
    this.maxConcurrency,
    this.maxErrors,
    this.mode,
    this.opsItemId,
    this.outputs,
    this.parameters,
    this.parentAutomationExecutionId,
    this.progressCounters,
    this.resolvedTargets,
    this.runbooks,
    this.scheduledTime,
    this.stepExecutions,
    this.stepExecutionsTruncated,
    this.target,
    this.targetLocations,
    this.targetMaps,
    this.targetParameterName,
    this.targets,
  });
  factory AutomationExecution.fromJson(Map<String, dynamic> json) {
    return AutomationExecution(
      associationId: json['AssociationId'] as String?,
      automationExecutionId: json['AutomationExecutionId'] as String?,
      automationExecutionStatus: (json['AutomationExecutionStatus'] as String?)
          ?.toAutomationExecutionStatus(),
      automationSubtype:
          (json['AutomationSubtype'] as String?)?.toAutomationSubtype(),
      changeRequestName: json['ChangeRequestName'] as String?,
      currentAction: json['CurrentAction'] as String?,
      currentStepName: json['CurrentStepName'] as String?,
      documentName: json['DocumentName'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      executedBy: json['ExecutedBy'] as String?,
      executionEndTime: timeStampFromJson(json['ExecutionEndTime']),
      executionStartTime: timeStampFromJson(json['ExecutionStartTime']),
      failureMessage: json['FailureMessage'] as String?,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      mode: (json['Mode'] as String?)?.toExecutionMode(),
      opsItemId: json['OpsItemId'] as String?,
      outputs: (json['Outputs'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      parentAutomationExecutionId:
          json['ParentAutomationExecutionId'] as String?,
      progressCounters: json['ProgressCounters'] != null
          ? ProgressCounters.fromJson(
              json['ProgressCounters'] as Map<String, dynamic>)
          : null,
      resolvedTargets: json['ResolvedTargets'] != null
          ? ResolvedTargets.fromJson(
              json['ResolvedTargets'] as Map<String, dynamic>)
          : null,
      runbooks: (json['Runbooks'] as List?)
          ?.whereNotNull()
          .map((e) => Runbook.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduledTime: timeStampFromJson(json['ScheduledTime']),
      stepExecutions: (json['StepExecutions'] as List?)
          ?.whereNotNull()
          .map((e) => StepExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      stepExecutionsTruncated: json['StepExecutionsTruncated'] as bool?,
      target: json['Target'] as String?,
      targetLocations: (json['TargetLocations'] as List?)
          ?.whereNotNull()
          .map((e) => TargetLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetMaps: (json['TargetMaps'] as List?)
          ?.whereNotNull()
          .map((e) => (e as Map<String, dynamic>).map((k, e) => MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())))
          .toList(),
      targetParameterName: json['TargetParameterName'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// A filter used to match specific automation executions. This is used to limit
/// the scope of Automation execution information returned.
class AutomationExecutionFilter {
  /// One or more keys to limit the results. Valid filter keys include the
  /// following: DocumentNamePrefix, ExecutionStatus, ExecutionId,
  /// ParentExecutionId, CurrentAction, StartTimeBefore, StartTimeAfter,
  /// TargetResourceGroup.
  final AutomationExecutionFilterKey key;

  /// The values used to limit the execution information associated with the
  /// filter's key.
  final List<String> values;

  AutomationExecutionFilter({
    required this.key,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      'Key': key.toValue(),
      'Values': values,
    };
  }
}

enum AutomationExecutionFilterKey {
  documentNamePrefix,
  executionStatus,
  executionId,
  parentExecutionId,
  currentAction,
  startTimeBefore,
  startTimeAfter,
  automationType,
  tagKey,
  targetResourceGroup,
  automationSubtype,
  opsItemId,
}

extension on AutomationExecutionFilterKey {
  String toValue() {
    switch (this) {
      case AutomationExecutionFilterKey.documentNamePrefix:
        return 'DocumentNamePrefix';
      case AutomationExecutionFilterKey.executionStatus:
        return 'ExecutionStatus';
      case AutomationExecutionFilterKey.executionId:
        return 'ExecutionId';
      case AutomationExecutionFilterKey.parentExecutionId:
        return 'ParentExecutionId';
      case AutomationExecutionFilterKey.currentAction:
        return 'CurrentAction';
      case AutomationExecutionFilterKey.startTimeBefore:
        return 'StartTimeBefore';
      case AutomationExecutionFilterKey.startTimeAfter:
        return 'StartTimeAfter';
      case AutomationExecutionFilterKey.automationType:
        return 'AutomationType';
      case AutomationExecutionFilterKey.tagKey:
        return 'TagKey';
      case AutomationExecutionFilterKey.targetResourceGroup:
        return 'TargetResourceGroup';
      case AutomationExecutionFilterKey.automationSubtype:
        return 'AutomationSubtype';
      case AutomationExecutionFilterKey.opsItemId:
        return 'OpsItemId';
    }
  }
}

extension on String {
  AutomationExecutionFilterKey toAutomationExecutionFilterKey() {
    switch (this) {
      case 'DocumentNamePrefix':
        return AutomationExecutionFilterKey.documentNamePrefix;
      case 'ExecutionStatus':
        return AutomationExecutionFilterKey.executionStatus;
      case 'ExecutionId':
        return AutomationExecutionFilterKey.executionId;
      case 'ParentExecutionId':
        return AutomationExecutionFilterKey.parentExecutionId;
      case 'CurrentAction':
        return AutomationExecutionFilterKey.currentAction;
      case 'StartTimeBefore':
        return AutomationExecutionFilterKey.startTimeBefore;
      case 'StartTimeAfter':
        return AutomationExecutionFilterKey.startTimeAfter;
      case 'AutomationType':
        return AutomationExecutionFilterKey.automationType;
      case 'TagKey':
        return AutomationExecutionFilterKey.tagKey;
      case 'TargetResourceGroup':
        return AutomationExecutionFilterKey.targetResourceGroup;
      case 'AutomationSubtype':
        return AutomationExecutionFilterKey.automationSubtype;
      case 'OpsItemId':
        return AutomationExecutionFilterKey.opsItemId;
    }
    throw Exception('$this is not known in enum AutomationExecutionFilterKey');
  }
}

/// Details about a specific Automation execution.
class AutomationExecutionMetadata {
  /// The ID of a State Manager association used in the Automation operation.
  final String? associationId;

  /// The execution ID.
  final String? automationExecutionId;

  /// The status of the execution.
  final AutomationExecutionStatus? automationExecutionStatus;

  /// The subtype of the Automation operation. Currently, the only supported value
  /// is <code>ChangeRequest</code>.
  final AutomationSubtype? automationSubtype;

  /// Use this filter with <a>DescribeAutomationExecutions</a>. Specify either
  /// Local or CrossAccount. CrossAccount is an Automation that runs in multiple
  /// AWS Regions and accounts. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation-multiple-accounts-and-regions.html">Running
  /// Automation workflows in multiple AWS Regions and accounts</a> in the <i>AWS
  /// Systems Manager User Guide</i>.
  final AutomationType? automationType;

  /// The name of the Change Manager change request.
  final String? changeRequestName;

  /// The action of the step that is currently running.
  final String? currentAction;

  /// The name of the step that is currently running.
  final String? currentStepName;

  /// The name of the Automation document used during execution.
  final String? documentName;

  /// The document version used during the execution.
  final String? documentVersion;

  /// The IAM role ARN of the user who ran the Automation.
  final String? executedBy;

  /// The time the execution finished. This is not populated if the execution is
  /// still in progress.
  final DateTime? executionEndTime;

  /// The time the execution started.
  final DateTime? executionStartTime;

  /// The list of execution outputs as defined in the Automation document.
  final String? failureMessage;

  /// An S3 bucket where execution information is stored.
  final String? logFile;

  /// The MaxConcurrency value specified by the user when starting the Automation.
  final String? maxConcurrency;

  /// The MaxErrors value specified by the user when starting the Automation.
  final String? maxErrors;

  /// The Automation execution mode.
  final ExecutionMode? mode;

  /// The ID of an OpsItem that is created to represent a Change Manager change
  /// request.
  final String? opsItemId;

  /// The list of execution outputs as defined in the Automation document.
  final Map<String, List<String>>? outputs;

  /// The ExecutionId of the parent Automation.
  final String? parentAutomationExecutionId;

  /// A list of targets that resolved during the execution.
  final ResolvedTargets? resolvedTargets;

  /// Information about the Automation runbooks (Automation documents) that are
  /// run during a runbook workflow in Change Manager.
  /// <note>
  /// The Automation runbooks specified for the runbook workflow can't run until
  /// all required approvals for the change request have been received.
  /// </note>
  final List<Runbook>? runbooks;

  /// The date and time the Automation operation is scheduled to start.
  final DateTime? scheduledTime;

  /// The list of execution outputs as defined in the Automation document.
  final String? target;

  /// The specified key-value mapping of document parameters to target resources.
  final List<Map<String, List<String>>>? targetMaps;

  /// The list of execution outputs as defined in the Automation document.
  final String? targetParameterName;

  /// The targets defined by the user when starting the Automation.
  final List<Target>? targets;

  AutomationExecutionMetadata({
    this.associationId,
    this.automationExecutionId,
    this.automationExecutionStatus,
    this.automationSubtype,
    this.automationType,
    this.changeRequestName,
    this.currentAction,
    this.currentStepName,
    this.documentName,
    this.documentVersion,
    this.executedBy,
    this.executionEndTime,
    this.executionStartTime,
    this.failureMessage,
    this.logFile,
    this.maxConcurrency,
    this.maxErrors,
    this.mode,
    this.opsItemId,
    this.outputs,
    this.parentAutomationExecutionId,
    this.resolvedTargets,
    this.runbooks,
    this.scheduledTime,
    this.target,
    this.targetMaps,
    this.targetParameterName,
    this.targets,
  });
  factory AutomationExecutionMetadata.fromJson(Map<String, dynamic> json) {
    return AutomationExecutionMetadata(
      associationId: json['AssociationId'] as String?,
      automationExecutionId: json['AutomationExecutionId'] as String?,
      automationExecutionStatus: (json['AutomationExecutionStatus'] as String?)
          ?.toAutomationExecutionStatus(),
      automationSubtype:
          (json['AutomationSubtype'] as String?)?.toAutomationSubtype(),
      automationType: (json['AutomationType'] as String?)?.toAutomationType(),
      changeRequestName: json['ChangeRequestName'] as String?,
      currentAction: json['CurrentAction'] as String?,
      currentStepName: json['CurrentStepName'] as String?,
      documentName: json['DocumentName'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      executedBy: json['ExecutedBy'] as String?,
      executionEndTime: timeStampFromJson(json['ExecutionEndTime']),
      executionStartTime: timeStampFromJson(json['ExecutionStartTime']),
      failureMessage: json['FailureMessage'] as String?,
      logFile: json['LogFile'] as String?,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      mode: (json['Mode'] as String?)?.toExecutionMode(),
      opsItemId: json['OpsItemId'] as String?,
      outputs: (json['Outputs'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      parentAutomationExecutionId:
          json['ParentAutomationExecutionId'] as String?,
      resolvedTargets: json['ResolvedTargets'] != null
          ? ResolvedTargets.fromJson(
              json['ResolvedTargets'] as Map<String, dynamic>)
          : null,
      runbooks: (json['Runbooks'] as List?)
          ?.whereNotNull()
          .map((e) => Runbook.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduledTime: timeStampFromJson(json['ScheduledTime']),
      target: json['Target'] as String?,
      targetMaps: (json['TargetMaps'] as List?)
          ?.whereNotNull()
          .map((e) => (e as Map<String, dynamic>).map((k, e) => MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())))
          .toList(),
      targetParameterName: json['TargetParameterName'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

enum AutomationExecutionStatus {
  pending,
  inProgress,
  waiting,
  success,
  timedOut,
  cancelling,
  cancelled,
  failed,
  pendingApproval,
  approved,
  rejected,
  scheduled,
  runbookInProgress,
  pendingChangeCalendarOverride,
  changeCalendarOverrideApproved,
  changeCalendarOverrideRejected,
  completedWithSuccess,
  completedWithFailure,
}

extension on AutomationExecutionStatus {
  String toValue() {
    switch (this) {
      case AutomationExecutionStatus.pending:
        return 'Pending';
      case AutomationExecutionStatus.inProgress:
        return 'InProgress';
      case AutomationExecutionStatus.waiting:
        return 'Waiting';
      case AutomationExecutionStatus.success:
        return 'Success';
      case AutomationExecutionStatus.timedOut:
        return 'TimedOut';
      case AutomationExecutionStatus.cancelling:
        return 'Cancelling';
      case AutomationExecutionStatus.cancelled:
        return 'Cancelled';
      case AutomationExecutionStatus.failed:
        return 'Failed';
      case AutomationExecutionStatus.pendingApproval:
        return 'PendingApproval';
      case AutomationExecutionStatus.approved:
        return 'Approved';
      case AutomationExecutionStatus.rejected:
        return 'Rejected';
      case AutomationExecutionStatus.scheduled:
        return 'Scheduled';
      case AutomationExecutionStatus.runbookInProgress:
        return 'RunbookInProgress';
      case AutomationExecutionStatus.pendingChangeCalendarOverride:
        return 'PendingChangeCalendarOverride';
      case AutomationExecutionStatus.changeCalendarOverrideApproved:
        return 'ChangeCalendarOverrideApproved';
      case AutomationExecutionStatus.changeCalendarOverrideRejected:
        return 'ChangeCalendarOverrideRejected';
      case AutomationExecutionStatus.completedWithSuccess:
        return 'CompletedWithSuccess';
      case AutomationExecutionStatus.completedWithFailure:
        return 'CompletedWithFailure';
    }
  }
}

extension on String {
  AutomationExecutionStatus toAutomationExecutionStatus() {
    switch (this) {
      case 'Pending':
        return AutomationExecutionStatus.pending;
      case 'InProgress':
        return AutomationExecutionStatus.inProgress;
      case 'Waiting':
        return AutomationExecutionStatus.waiting;
      case 'Success':
        return AutomationExecutionStatus.success;
      case 'TimedOut':
        return AutomationExecutionStatus.timedOut;
      case 'Cancelling':
        return AutomationExecutionStatus.cancelling;
      case 'Cancelled':
        return AutomationExecutionStatus.cancelled;
      case 'Failed':
        return AutomationExecutionStatus.failed;
      case 'PendingApproval':
        return AutomationExecutionStatus.pendingApproval;
      case 'Approved':
        return AutomationExecutionStatus.approved;
      case 'Rejected':
        return AutomationExecutionStatus.rejected;
      case 'Scheduled':
        return AutomationExecutionStatus.scheduled;
      case 'RunbookInProgress':
        return AutomationExecutionStatus.runbookInProgress;
      case 'PendingChangeCalendarOverride':
        return AutomationExecutionStatus.pendingChangeCalendarOverride;
      case 'ChangeCalendarOverrideApproved':
        return AutomationExecutionStatus.changeCalendarOverrideApproved;
      case 'ChangeCalendarOverrideRejected':
        return AutomationExecutionStatus.changeCalendarOverrideRejected;
      case 'CompletedWithSuccess':
        return AutomationExecutionStatus.completedWithSuccess;
      case 'CompletedWithFailure':
        return AutomationExecutionStatus.completedWithFailure;
    }
    throw Exception('$this is not known in enum AutomationExecutionStatus');
  }
}

enum AutomationSubtype {
  changeRequest,
}

extension on AutomationSubtype {
  String toValue() {
    switch (this) {
      case AutomationSubtype.changeRequest:
        return 'ChangeRequest';
    }
  }
}

extension on String {
  AutomationSubtype toAutomationSubtype() {
    switch (this) {
      case 'ChangeRequest':
        return AutomationSubtype.changeRequest;
    }
    throw Exception('$this is not known in enum AutomationSubtype');
  }
}

enum AutomationType {
  crossAccount,
  local,
}

extension on AutomationType {
  String toValue() {
    switch (this) {
      case AutomationType.crossAccount:
        return 'CrossAccount';
      case AutomationType.local:
        return 'Local';
    }
  }
}

extension on String {
  AutomationType toAutomationType() {
    switch (this) {
      case 'CrossAccount':
        return AutomationType.crossAccount;
      case 'Local':
        return AutomationType.local;
    }
    throw Exception('$this is not known in enum AutomationType');
  }
}

enum CalendarState {
  open,
  closed,
}

extension on CalendarState {
  String toValue() {
    switch (this) {
      case CalendarState.open:
        return 'OPEN';
      case CalendarState.closed:
        return 'CLOSED';
    }
  }
}

extension on String {
  CalendarState toCalendarState() {
    switch (this) {
      case 'OPEN':
        return CalendarState.open;
      case 'CLOSED':
        return CalendarState.closed;
    }
    throw Exception('$this is not known in enum CalendarState');
  }
}

/// Whether or not the command was successfully canceled. There is no guarantee
/// that a request can be canceled.
class CancelCommandResult {
  CancelCommandResult();
  factory CancelCommandResult.fromJson(Map<String, dynamic> _) {
    return CancelCommandResult();
  }
}

class CancelMaintenanceWindowExecutionResult {
  /// The ID of the maintenance window execution that has been stopped.
  final String? windowExecutionId;

  CancelMaintenanceWindowExecutionResult({
    this.windowExecutionId,
  });
  factory CancelMaintenanceWindowExecutionResult.fromJson(
      Map<String, dynamic> json) {
    return CancelMaintenanceWindowExecutionResult(
      windowExecutionId: json['WindowExecutionId'] as String?,
    );
  }
}

/// Configuration options for sending command output to CloudWatch Logs.
class CloudWatchOutputConfig {
  /// The name of the CloudWatch log group where you want to send command output.
  /// If you don't specify a group name, Systems Manager automatically creates a
  /// log group for you. The log group uses the following naming format:
  /// aws/ssm/<i>SystemsManagerDocumentName</i>.
  final String? cloudWatchLogGroupName;

  /// Enables Systems Manager to send command output to CloudWatch Logs.
  final bool? cloudWatchOutputEnabled;

  CloudWatchOutputConfig({
    this.cloudWatchLogGroupName,
    this.cloudWatchOutputEnabled,
  });
  factory CloudWatchOutputConfig.fromJson(Map<String, dynamic> json) {
    return CloudWatchOutputConfig(
      cloudWatchLogGroupName: json['CloudWatchLogGroupName'] as String?,
      cloudWatchOutputEnabled: json['CloudWatchOutputEnabled'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final cloudWatchLogGroupName = this.cloudWatchLogGroupName;
    final cloudWatchOutputEnabled = this.cloudWatchOutputEnabled;
    return {
      if (cloudWatchLogGroupName != null)
        'CloudWatchLogGroupName': cloudWatchLogGroupName,
      if (cloudWatchOutputEnabled != null)
        'CloudWatchOutputEnabled': cloudWatchOutputEnabled,
    };
  }
}

/// Describes a command request.
class Command {
  /// CloudWatch Logs information where you want Systems Manager to send the
  /// command output.
  final CloudWatchOutputConfig? cloudWatchOutputConfig;

  /// A unique identifier for this command.
  final String? commandId;

  /// User-specified information about the command, such as a brief description of
  /// what the command should do.
  final String? comment;

  /// The number of targets for which the command invocation reached a terminal
  /// state. Terminal states include the following: Success, Failed, Execution
  /// Timed Out, Delivery Timed Out, Canceled, Terminated, or Undeliverable.
  final int? completedCount;

  /// The number of targets for which the status is Delivery Timed Out.
  final int? deliveryTimedOutCount;

  /// The name of the document requested for execution.
  final String? documentName;

  /// The SSM document version.
  final String? documentVersion;

  /// The number of targets for which the status is Failed or Execution Timed Out.
  final int? errorCount;

  /// If this time is reached and the command has not already started running, it
  /// will not run. Calculated based on the ExpiresAfter user input provided as
  /// part of the SendCommand API.
  final DateTime? expiresAfter;

  /// The instance IDs against which this command was requested.
  final List<String>? instanceIds;

  /// The maximum number of instances that are allowed to run the command at the
  /// same time. You can specify a number of instances, such as 10, or a
  /// percentage of instances, such as 10%. The default value is 50. For more
  /// information about how to use MaxConcurrency, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/run-command.html">Running
  /// commands using Systems Manager Run Command</a> in the <i>AWS Systems Manager
  /// User Guide</i>.
  final String? maxConcurrency;

  /// The maximum number of errors allowed before the system stops sending the
  /// command to additional targets. You can specify a number of errors, such as
  /// 10, or a percentage or errors, such as 10%. The default value is 0. For more
  /// information about how to use MaxErrors, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/run-command.html">Running
  /// commands using Systems Manager Run Command</a> in the <i>AWS Systems Manager
  /// User Guide</i>.
  final String? maxErrors;

  /// Configurations for sending notifications about command status changes.
  final NotificationConfig? notificationConfig;

  /// The S3 bucket where the responses to the command executions should be
  /// stored. This was requested when issuing the command.
  final String? outputS3BucketName;

  /// The S3 directory path inside the bucket where the responses to the command
  /// executions should be stored. This was requested when issuing the command.
  final String? outputS3KeyPrefix;

  /// (Deprecated) You can no longer specify this parameter. The system ignores
  /// it. Instead, Systems Manager automatically determines the Region of the S3
  /// bucket.
  final String? outputS3Region;

  /// The parameter values to be inserted in the document when running the
  /// command.
  final Map<String, List<String>>? parameters;

  /// The date and time the command was requested.
  final DateTime? requestedDateTime;

  /// The IAM service role that Run Command uses to act on your behalf when
  /// sending notifications about command status changes.
  final String? serviceRole;

  /// The status of the command.
  final CommandStatus? status;

  /// A detailed status of the command execution. StatusDetails includes more
  /// information than Status because it includes states resulting from error and
  /// concurrency control parameters. StatusDetails can show different results
  /// than Status. For more information about these statuses, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html">Understanding
  /// command statuses</a> in the <i>AWS Systems Manager User Guide</i>.
  /// StatusDetails can be one of the following values:
  ///
  /// <ul>
  /// <li>
  /// Pending: The command has not been sent to any instances.
  /// </li>
  /// <li>
  /// In Progress: The command has been sent to at least one instance but has not
  /// reached a final state on all instances.
  /// </li>
  /// <li>
  /// Success: The command successfully ran on all invocations. This is a terminal
  /// state.
  /// </li>
  /// <li>
  /// Delivery Timed Out: The value of MaxErrors or more command invocations shows
  /// a status of Delivery Timed Out. This is a terminal state.
  /// </li>
  /// <li>
  /// Execution Timed Out: The value of MaxErrors or more command invocations
  /// shows a status of Execution Timed Out. This is a terminal state.
  /// </li>
  /// <li>
  /// Failed: The value of MaxErrors or more command invocations shows a status of
  /// Failed. This is a terminal state.
  /// </li>
  /// <li>
  /// Incomplete: The command was attempted on all instances and one or more
  /// invocations does not have a value of Success but not enough invocations
  /// failed for the status to be Failed. This is a terminal state.
  /// </li>
  /// <li>
  /// Canceled: The command was terminated before it was completed. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Rate Exceeded: The number of instances targeted by the command exceeded the
  /// account limit for pending invocations. The system has canceled the command
  /// before running it on any instance. This is a terminal state.
  /// </li>
  /// </ul>
  final String? statusDetails;

  /// The number of targets for the command.
  final int? targetCount;

  /// An array of search criteria that targets instances using a Key,Value
  /// combination that you specify. Targets is required if you don't provide one
  /// or more instance IDs in the call.
  final List<Target>? targets;

  /// The <code>TimeoutSeconds</code> value specified for a command.
  final int? timeoutSeconds;

  Command({
    this.cloudWatchOutputConfig,
    this.commandId,
    this.comment,
    this.completedCount,
    this.deliveryTimedOutCount,
    this.documentName,
    this.documentVersion,
    this.errorCount,
    this.expiresAfter,
    this.instanceIds,
    this.maxConcurrency,
    this.maxErrors,
    this.notificationConfig,
    this.outputS3BucketName,
    this.outputS3KeyPrefix,
    this.outputS3Region,
    this.parameters,
    this.requestedDateTime,
    this.serviceRole,
    this.status,
    this.statusDetails,
    this.targetCount,
    this.targets,
    this.timeoutSeconds,
  });
  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      cloudWatchOutputConfig: json['CloudWatchOutputConfig'] != null
          ? CloudWatchOutputConfig.fromJson(
              json['CloudWatchOutputConfig'] as Map<String, dynamic>)
          : null,
      commandId: json['CommandId'] as String?,
      comment: json['Comment'] as String?,
      completedCount: json['CompletedCount'] as int?,
      deliveryTimedOutCount: json['DeliveryTimedOutCount'] as int?,
      documentName: json['DocumentName'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      errorCount: json['ErrorCount'] as int?,
      expiresAfter: timeStampFromJson(json['ExpiresAfter']),
      instanceIds: (json['InstanceIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      notificationConfig: json['NotificationConfig'] != null
          ? NotificationConfig.fromJson(
              json['NotificationConfig'] as Map<String, dynamic>)
          : null,
      outputS3BucketName: json['OutputS3BucketName'] as String?,
      outputS3KeyPrefix: json['OutputS3KeyPrefix'] as String?,
      outputS3Region: json['OutputS3Region'] as String?,
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      requestedDateTime: timeStampFromJson(json['RequestedDateTime']),
      serviceRole: json['ServiceRole'] as String?,
      status: (json['Status'] as String?)?.toCommandStatus(),
      statusDetails: json['StatusDetails'] as String?,
      targetCount: json['TargetCount'] as int?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeoutSeconds: json['TimeoutSeconds'] as int?,
    );
  }
}

/// Describes a command filter.
/// <note>
/// An instance ID can't be specified when a command status is
/// <code>Pending</code> because the command hasn't run on the instance yet.
/// </note>
class CommandFilter {
  /// The name of the filter.
  final CommandFilterKey key;

  /// The filter value. Valid values for each filter key are as follows:
  ///
  /// <ul>
  /// <li>
  /// <b>InvokedAfter</b>: Specify a timestamp to limit your results. For example,
  /// specify <code>2018-07-07T00:00:00Z</code> to see a list of command
  /// executions occurring July 7, 2018, and later.
  /// </li>
  /// <li>
  /// <b>InvokedBefore</b>: Specify a timestamp to limit your results. For
  /// example, specify <code>2018-07-07T00:00:00Z</code> to see a list of command
  /// executions from before July 7, 2018.
  /// </li>
  /// <li>
  /// <b>Status</b>: Specify a valid command status to see a list of all command
  /// executions with that status. Status values you can specify include:
  ///
  /// <ul>
  /// <li>
  /// <code>Pending</code>
  /// </li>
  /// <li>
  /// <code>InProgress</code>
  /// </li>
  /// <li>
  /// <code>Success</code>
  /// </li>
  /// <li>
  /// <code>Cancelled</code>
  /// </li>
  /// <li>
  /// <code>Failed</code>
  /// </li>
  /// <li>
  /// <code>TimedOut</code>
  /// </li>
  /// <li>
  /// <code>Cancelling</code>
  /// </li>
  /// </ul> </li>
  /// <li>
  /// <b>DocumentName</b>: Specify name of the SSM document for which you want to
  /// see command execution results. For example, specify
  /// <code>AWS-RunPatchBaseline</code> to see command executions that used this
  /// SSM document to perform security patching operations on instances.
  /// </li>
  /// <li>
  /// <b>ExecutionStage</b>: Specify one of the following values:
  ///
  /// <ul>
  /// <li>
  /// <code>Executing</code>: Returns a list of command executions that are
  /// currently still running.
  /// </li>
  /// <li>
  /// <code>Complete</code>: Returns a list of command executions that have
  /// already completed.
  /// </li>
  /// </ul> </li>
  /// </ul>
  final String value;

  CommandFilter({
    required this.key,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'key': key.toValue(),
      'value': value,
    };
  }
}

enum CommandFilterKey {
  invokedAfter,
  invokedBefore,
  status,
  executionStage,
  documentName,
}

extension on CommandFilterKey {
  String toValue() {
    switch (this) {
      case CommandFilterKey.invokedAfter:
        return 'InvokedAfter';
      case CommandFilterKey.invokedBefore:
        return 'InvokedBefore';
      case CommandFilterKey.status:
        return 'Status';
      case CommandFilterKey.executionStage:
        return 'ExecutionStage';
      case CommandFilterKey.documentName:
        return 'DocumentName';
    }
  }
}

extension on String {
  CommandFilterKey toCommandFilterKey() {
    switch (this) {
      case 'InvokedAfter':
        return CommandFilterKey.invokedAfter;
      case 'InvokedBefore':
        return CommandFilterKey.invokedBefore;
      case 'Status':
        return CommandFilterKey.status;
      case 'ExecutionStage':
        return CommandFilterKey.executionStage;
      case 'DocumentName':
        return CommandFilterKey.documentName;
    }
    throw Exception('$this is not known in enum CommandFilterKey');
  }
}

/// An invocation is copy of a command sent to a specific instance. A command
/// can apply to one or more instances. A command invocation applies to one
/// instance. For example, if a user runs SendCommand against three instances,
/// then a command invocation is created for each requested instance ID. A
/// command invocation returns status and detail information about a command you
/// ran.
class CommandInvocation {
  /// CloudWatch Logs information where you want Systems Manager to send the
  /// command output.
  final CloudWatchOutputConfig? cloudWatchOutputConfig;

  /// The command against which this invocation was requested.
  final String? commandId;
  final List<CommandPlugin>? commandPlugins;

  /// User-specified information about the command, such as a brief description of
  /// what the command should do.
  final String? comment;

  /// The document name that was requested for execution.
  final String? documentName;

  /// The SSM document version.
  final String? documentVersion;

  /// The instance ID in which this invocation was requested.
  final String? instanceId;

  /// The name of the invocation target. For EC2 instances this is the value for
  /// the aws:Name tag. For on-premises instances, this is the name of the
  /// instance.
  final String? instanceName;

  /// Configurations for sending notifications about command status changes on a
  /// per instance basis.
  final NotificationConfig? notificationConfig;

  /// The time and date the request was sent to this instance.
  final DateTime? requestedDateTime;

  /// The IAM service role that Run Command uses to act on your behalf when
  /// sending notifications about command status changes on a per instance basis.
  final String? serviceRole;

  /// The URL to the plugin's StdErr file in Amazon S3, if the S3 bucket was
  /// defined for the parent command. For an invocation, StandardErrorUrl is
  /// populated if there is just one plugin defined for the command, and the S3
  /// bucket was defined for the command.
  final String? standardErrorUrl;

  /// The URL to the plugin's StdOut file in Amazon S3, if the S3 bucket was
  /// defined for the parent command. For an invocation, StandardOutputUrl is
  /// populated if there is just one plugin defined for the command, and the S3
  /// bucket was defined for the command.
  final String? standardOutputUrl;

  /// Whether or not the invocation succeeded, failed, or is pending.
  final CommandInvocationStatus? status;

  /// A detailed status of the command execution for each invocation (each
  /// instance targeted by the command). StatusDetails includes more information
  /// than Status because it includes states resulting from error and concurrency
  /// control parameters. StatusDetails can show different results than Status.
  /// For more information about these statuses, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html">Understanding
  /// command statuses</a> in the <i>AWS Systems Manager User Guide</i>.
  /// StatusDetails can be one of the following values:
  ///
  /// <ul>
  /// <li>
  /// Pending: The command has not been sent to the instance.
  /// </li>
  /// <li>
  /// In Progress: The command has been sent to the instance but has not reached a
  /// terminal state.
  /// </li>
  /// <li>
  /// Success: The execution of the command or plugin was successfully completed.
  /// This is a terminal state.
  /// </li>
  /// <li>
  /// Delivery Timed Out: The command was not delivered to the instance before the
  /// delivery timeout expired. Delivery timeouts do not count against the parent
  /// command's MaxErrors limit, but they do contribute to whether the parent
  /// command status is Success or Incomplete. This is a terminal state.
  /// </li>
  /// <li>
  /// Execution Timed Out: Command execution started on the instance, but the
  /// execution was not complete before the execution timeout expired. Execution
  /// timeouts count against the MaxErrors limit of the parent command. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Failed: The command was not successful on the instance. For a plugin, this
  /// indicates that the result code was not zero. For a command invocation, this
  /// indicates that the result code for one or more plugins was not zero.
  /// Invocation failures count against the MaxErrors limit of the parent command.
  /// This is a terminal state.
  /// </li>
  /// <li>
  /// Canceled: The command was terminated before it was completed. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Undeliverable: The command can't be delivered to the instance. The instance
  /// might not exist or might not be responding. Undeliverable invocations don't
  /// count against the parent command's MaxErrors limit and don't contribute to
  /// whether the parent command status is Success or Incomplete. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Terminated: The parent command exceeded its MaxErrors limit and subsequent
  /// command invocations were canceled by the system. This is a terminal state.
  /// </li>
  /// </ul>
  final String? statusDetails;

  /// Gets the trace output sent by the agent.
  final String? traceOutput;

  CommandInvocation({
    this.cloudWatchOutputConfig,
    this.commandId,
    this.commandPlugins,
    this.comment,
    this.documentName,
    this.documentVersion,
    this.instanceId,
    this.instanceName,
    this.notificationConfig,
    this.requestedDateTime,
    this.serviceRole,
    this.standardErrorUrl,
    this.standardOutputUrl,
    this.status,
    this.statusDetails,
    this.traceOutput,
  });
  factory CommandInvocation.fromJson(Map<String, dynamic> json) {
    return CommandInvocation(
      cloudWatchOutputConfig: json['CloudWatchOutputConfig'] != null
          ? CloudWatchOutputConfig.fromJson(
              json['CloudWatchOutputConfig'] as Map<String, dynamic>)
          : null,
      commandId: json['CommandId'] as String?,
      commandPlugins: (json['CommandPlugins'] as List?)
          ?.whereNotNull()
          .map((e) => CommandPlugin.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['Comment'] as String?,
      documentName: json['DocumentName'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      instanceId: json['InstanceId'] as String?,
      instanceName: json['InstanceName'] as String?,
      notificationConfig: json['NotificationConfig'] != null
          ? NotificationConfig.fromJson(
              json['NotificationConfig'] as Map<String, dynamic>)
          : null,
      requestedDateTime: timeStampFromJson(json['RequestedDateTime']),
      serviceRole: json['ServiceRole'] as String?,
      standardErrorUrl: json['StandardErrorUrl'] as String?,
      standardOutputUrl: json['StandardOutputUrl'] as String?,
      status: (json['Status'] as String?)?.toCommandInvocationStatus(),
      statusDetails: json['StatusDetails'] as String?,
      traceOutput: json['TraceOutput'] as String?,
    );
  }
}

enum CommandInvocationStatus {
  pending,
  inProgress,
  delayed,
  success,
  cancelled,
  timedOut,
  failed,
  cancelling,
}

extension on CommandInvocationStatus {
  String toValue() {
    switch (this) {
      case CommandInvocationStatus.pending:
        return 'Pending';
      case CommandInvocationStatus.inProgress:
        return 'InProgress';
      case CommandInvocationStatus.delayed:
        return 'Delayed';
      case CommandInvocationStatus.success:
        return 'Success';
      case CommandInvocationStatus.cancelled:
        return 'Cancelled';
      case CommandInvocationStatus.timedOut:
        return 'TimedOut';
      case CommandInvocationStatus.failed:
        return 'Failed';
      case CommandInvocationStatus.cancelling:
        return 'Cancelling';
    }
  }
}

extension on String {
  CommandInvocationStatus toCommandInvocationStatus() {
    switch (this) {
      case 'Pending':
        return CommandInvocationStatus.pending;
      case 'InProgress':
        return CommandInvocationStatus.inProgress;
      case 'Delayed':
        return CommandInvocationStatus.delayed;
      case 'Success':
        return CommandInvocationStatus.success;
      case 'Cancelled':
        return CommandInvocationStatus.cancelled;
      case 'TimedOut':
        return CommandInvocationStatus.timedOut;
      case 'Failed':
        return CommandInvocationStatus.failed;
      case 'Cancelling':
        return CommandInvocationStatus.cancelling;
    }
    throw Exception('$this is not known in enum CommandInvocationStatus');
  }
}

/// Describes plugin details.
class CommandPlugin {
  /// The name of the plugin. Must be one of the following: aws:updateAgent,
  /// aws:domainjoin, aws:applications, aws:runPowerShellScript, aws:psmodule,
  /// aws:cloudWatch, aws:runShellScript, or aws:updateSSMAgent.
  final String? name;

  /// Output of the plugin execution.
  final String? output;

  /// The S3 bucket where the responses to the command executions should be
  /// stored. This was requested when issuing the command. For example, in the
  /// following response:
  ///
  /// doc-example-bucket/ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix/i-02573cafcfEXAMPLE/awsrunShellScript
  ///
  /// doc-example-bucket is the name of the S3 bucket;
  ///
  /// ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix is the name of the S3 prefix;
  ///
  /// i-02573cafcfEXAMPLE is the instance ID;
  ///
  /// awsrunShellScript is the name of the plugin.
  final String? outputS3BucketName;

  /// The S3 directory path inside the bucket where the responses to the command
  /// executions should be stored. This was requested when issuing the command.
  /// For example, in the following response:
  ///
  /// doc-example-bucket/ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix/i-02573cafcfEXAMPLE/awsrunShellScript
  ///
  /// doc-example-bucket is the name of the S3 bucket;
  ///
  /// ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix is the name of the S3 prefix;
  ///
  /// i-02573cafcfEXAMPLE is the instance ID;
  ///
  /// awsrunShellScript is the name of the plugin.
  final String? outputS3KeyPrefix;

  /// (Deprecated) You can no longer specify this parameter. The system ignores
  /// it. Instead, Systems Manager automatically determines the S3 bucket region.
  final String? outputS3Region;

  /// A numeric response code generated after running the plugin.
  final int? responseCode;

  /// The time the plugin stopped running. Could stop prematurely if, for example,
  /// a cancel command was sent.
  final DateTime? responseFinishDateTime;

  /// The time the plugin started running.
  final DateTime? responseStartDateTime;

  /// The URL for the complete text written by the plugin to stderr. If execution
  /// is not yet complete, then this string is empty.
  final String? standardErrorUrl;

  /// The URL for the complete text written by the plugin to stdout in Amazon S3.
  /// If the S3 bucket for the command was not specified, then this string is
  /// empty.
  final String? standardOutputUrl;

  /// The status of this plugin. You can run a document with multiple plugins.
  final CommandPluginStatus? status;

  /// A detailed status of the plugin execution. StatusDetails includes more
  /// information than Status because it includes states resulting from error and
  /// concurrency control parameters. StatusDetails can show different results
  /// than Status. For more information about these statuses, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html">Understanding
  /// command statuses</a> in the <i>AWS Systems Manager User Guide</i>.
  /// StatusDetails can be one of the following values:
  ///
  /// <ul>
  /// <li>
  /// Pending: The command has not been sent to the instance.
  /// </li>
  /// <li>
  /// In Progress: The command has been sent to the instance but has not reached a
  /// terminal state.
  /// </li>
  /// <li>
  /// Success: The execution of the command or plugin was successfully completed.
  /// This is a terminal state.
  /// </li>
  /// <li>
  /// Delivery Timed Out: The command was not delivered to the instance before the
  /// delivery timeout expired. Delivery timeouts do not count against the parent
  /// command's MaxErrors limit, but they do contribute to whether the parent
  /// command status is Success or Incomplete. This is a terminal state.
  /// </li>
  /// <li>
  /// Execution Timed Out: Command execution started on the instance, but the
  /// execution was not complete before the execution timeout expired. Execution
  /// timeouts count against the MaxErrors limit of the parent command. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Failed: The command was not successful on the instance. For a plugin, this
  /// indicates that the result code was not zero. For a command invocation, this
  /// indicates that the result code for one or more plugins was not zero.
  /// Invocation failures count against the MaxErrors limit of the parent command.
  /// This is a terminal state.
  /// </li>
  /// <li>
  /// Canceled: The command was terminated before it was completed. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Undeliverable: The command can't be delivered to the instance. The instance
  /// might not exist, or it might not be responding. Undeliverable invocations
  /// don't count against the parent command's MaxErrors limit, and they don't
  /// contribute to whether the parent command status is Success or Incomplete.
  /// This is a terminal state.
  /// </li>
  /// <li>
  /// Terminated: The parent command exceeded its MaxErrors limit and subsequent
  /// command invocations were canceled by the system. This is a terminal state.
  /// </li>
  /// </ul>
  final String? statusDetails;

  CommandPlugin({
    this.name,
    this.output,
    this.outputS3BucketName,
    this.outputS3KeyPrefix,
    this.outputS3Region,
    this.responseCode,
    this.responseFinishDateTime,
    this.responseStartDateTime,
    this.standardErrorUrl,
    this.standardOutputUrl,
    this.status,
    this.statusDetails,
  });
  factory CommandPlugin.fromJson(Map<String, dynamic> json) {
    return CommandPlugin(
      name: json['Name'] as String?,
      output: json['Output'] as String?,
      outputS3BucketName: json['OutputS3BucketName'] as String?,
      outputS3KeyPrefix: json['OutputS3KeyPrefix'] as String?,
      outputS3Region: json['OutputS3Region'] as String?,
      responseCode: json['ResponseCode'] as int?,
      responseFinishDateTime: timeStampFromJson(json['ResponseFinishDateTime']),
      responseStartDateTime: timeStampFromJson(json['ResponseStartDateTime']),
      standardErrorUrl: json['StandardErrorUrl'] as String?,
      standardOutputUrl: json['StandardOutputUrl'] as String?,
      status: (json['Status'] as String?)?.toCommandPluginStatus(),
      statusDetails: json['StatusDetails'] as String?,
    );
  }
}

enum CommandPluginStatus {
  pending,
  inProgress,
  success,
  timedOut,
  cancelled,
  failed,
}

extension on CommandPluginStatus {
  String toValue() {
    switch (this) {
      case CommandPluginStatus.pending:
        return 'Pending';
      case CommandPluginStatus.inProgress:
        return 'InProgress';
      case CommandPluginStatus.success:
        return 'Success';
      case CommandPluginStatus.timedOut:
        return 'TimedOut';
      case CommandPluginStatus.cancelled:
        return 'Cancelled';
      case CommandPluginStatus.failed:
        return 'Failed';
    }
  }
}

extension on String {
  CommandPluginStatus toCommandPluginStatus() {
    switch (this) {
      case 'Pending':
        return CommandPluginStatus.pending;
      case 'InProgress':
        return CommandPluginStatus.inProgress;
      case 'Success':
        return CommandPluginStatus.success;
      case 'TimedOut':
        return CommandPluginStatus.timedOut;
      case 'Cancelled':
        return CommandPluginStatus.cancelled;
      case 'Failed':
        return CommandPluginStatus.failed;
    }
    throw Exception('$this is not known in enum CommandPluginStatus');
  }
}

enum CommandStatus {
  pending,
  inProgress,
  success,
  cancelled,
  failed,
  timedOut,
  cancelling,
}

extension on CommandStatus {
  String toValue() {
    switch (this) {
      case CommandStatus.pending:
        return 'Pending';
      case CommandStatus.inProgress:
        return 'InProgress';
      case CommandStatus.success:
        return 'Success';
      case CommandStatus.cancelled:
        return 'Cancelled';
      case CommandStatus.failed:
        return 'Failed';
      case CommandStatus.timedOut:
        return 'TimedOut';
      case CommandStatus.cancelling:
        return 'Cancelling';
    }
  }
}

extension on String {
  CommandStatus toCommandStatus() {
    switch (this) {
      case 'Pending':
        return CommandStatus.pending;
      case 'InProgress':
        return CommandStatus.inProgress;
      case 'Success':
        return CommandStatus.success;
      case 'Cancelled':
        return CommandStatus.cancelled;
      case 'Failed':
        return CommandStatus.failed;
      case 'TimedOut':
        return CommandStatus.timedOut;
      case 'Cancelling':
        return CommandStatus.cancelling;
    }
    throw Exception('$this is not known in enum CommandStatus');
  }
}

/// A summary of the call execution that includes an execution ID, the type of
/// execution (for example, <code>Command</code>), and the date/time of the
/// execution using a datetime object that is saved in the following format:
/// yyyy-MM-dd'T'HH:mm:ss'Z'.
class ComplianceExecutionSummary {
  /// The time the execution ran as a datetime object that is saved in the
  /// following format: yyyy-MM-dd'T'HH:mm:ss'Z'.
  final DateTime executionTime;

  /// An ID created by the system when <code>PutComplianceItems</code> was called.
  /// For example, <code>CommandID</code> is a valid execution ID. You can use
  /// this ID in subsequent calls.
  final String? executionId;

  /// The type of execution. For example, <code>Command</code> is a valid
  /// execution type.
  final String? executionType;

  ComplianceExecutionSummary({
    required this.executionTime,
    this.executionId,
    this.executionType,
  });
  factory ComplianceExecutionSummary.fromJson(Map<String, dynamic> json) {
    return ComplianceExecutionSummary(
      executionTime:
          nonNullableTimeStampFromJson(json['ExecutionTime'] as Object),
      executionId: json['ExecutionId'] as String?,
      executionType: json['ExecutionType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final executionTime = this.executionTime;
    final executionId = this.executionId;
    final executionType = this.executionType;
    return {
      'ExecutionTime': unixTimestampToJson(executionTime),
      if (executionId != null) 'ExecutionId': executionId,
      if (executionType != null) 'ExecutionType': executionType,
    };
  }
}

/// Information about the compliance as defined by the resource type. For
/// example, for a patch resource type, <code>Items</code> includes information
/// about the PatchSeverity, Classification, and so on.
class ComplianceItem {
  /// The compliance type. For example, Association (for a State Manager
  /// association), Patch, or Custom:<code>string</code> are all valid compliance
  /// types.
  final String? complianceType;

  /// A "Key": "Value" tag combination for the compliance item.
  final Map<String, String>? details;

  /// A summary for the compliance item. The summary includes an execution ID, the
  /// execution type (for example, command), and the execution time.
  final ComplianceExecutionSummary? executionSummary;

  /// An ID for the compliance item. For example, if the compliance item is a
  /// Windows patch, the ID could be the number of the KB article; for example:
  /// KB4010320.
  final String? id;

  /// An ID for the resource. For a managed instance, this is the instance ID.
  final String? resourceId;

  /// The type of resource. <code>ManagedInstance</code> is currently the only
  /// supported resource type.
  final String? resourceType;

  /// The severity of the compliance status. Severity can be one of the following:
  /// Critical, High, Medium, Low, Informational, Unspecified.
  final ComplianceSeverity? severity;

  /// The status of the compliance item. An item is either COMPLIANT,
  /// NON_COMPLIANT, or an empty string (for Windows patches that aren't
  /// applicable).
  final ComplianceStatus? status;

  /// A title for the compliance item. For example, if the compliance item is a
  /// Windows patch, the title could be the title of the KB article for the patch;
  /// for example: Security Update for Active Directory Federation Services.
  final String? title;

  ComplianceItem({
    this.complianceType,
    this.details,
    this.executionSummary,
    this.id,
    this.resourceId,
    this.resourceType,
    this.severity,
    this.status,
    this.title,
  });
  factory ComplianceItem.fromJson(Map<String, dynamic> json) {
    return ComplianceItem(
      complianceType: json['ComplianceType'] as String?,
      details: (json['Details'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      executionSummary: json['ExecutionSummary'] != null
          ? ComplianceExecutionSummary.fromJson(
              json['ExecutionSummary'] as Map<String, dynamic>)
          : null,
      id: json['Id'] as String?,
      resourceId: json['ResourceId'] as String?,
      resourceType: json['ResourceType'] as String?,
      severity: (json['Severity'] as String?)?.toComplianceSeverity(),
      status: (json['Status'] as String?)?.toComplianceStatus(),
      title: json['Title'] as String?,
    );
  }
}

/// Information about a compliance item.
class ComplianceItemEntry {
  /// The severity of the compliance status. Severity can be one of the following:
  /// Critical, High, Medium, Low, Informational, Unspecified.
  final ComplianceSeverity severity;

  /// The status of the compliance item. An item is either COMPLIANT or
  /// NON_COMPLIANT.
  final ComplianceStatus status;

  /// A "Key": "Value" tag combination for the compliance item.
  final Map<String, String>? details;

  /// The compliance item ID. For example, if the compliance item is a Windows
  /// patch, the ID could be the number of the KB article.
  final String? id;

  /// The title of the compliance item. For example, if the compliance item is a
  /// Windows patch, the title could be the title of the KB article for the patch;
  /// for example: Security Update for Active Directory Federation Services.
  final String? title;

  ComplianceItemEntry({
    required this.severity,
    required this.status,
    this.details,
    this.id,
    this.title,
  });
  Map<String, dynamic> toJson() {
    final severity = this.severity;
    final status = this.status;
    final details = this.details;
    final id = this.id;
    final title = this.title;
    return {
      'Severity': severity.toValue(),
      'Status': status.toValue(),
      if (details != null) 'Details': details,
      if (id != null) 'Id': id,
      if (title != null) 'Title': title,
    };
  }
}

enum ComplianceQueryOperatorType {
  equal,
  notEqual,
  beginWith,
  lessThan,
  greaterThan,
}

extension on ComplianceQueryOperatorType {
  String toValue() {
    switch (this) {
      case ComplianceQueryOperatorType.equal:
        return 'EQUAL';
      case ComplianceQueryOperatorType.notEqual:
        return 'NOT_EQUAL';
      case ComplianceQueryOperatorType.beginWith:
        return 'BEGIN_WITH';
      case ComplianceQueryOperatorType.lessThan:
        return 'LESS_THAN';
      case ComplianceQueryOperatorType.greaterThan:
        return 'GREATER_THAN';
    }
  }
}

extension on String {
  ComplianceQueryOperatorType toComplianceQueryOperatorType() {
    switch (this) {
      case 'EQUAL':
        return ComplianceQueryOperatorType.equal;
      case 'NOT_EQUAL':
        return ComplianceQueryOperatorType.notEqual;
      case 'BEGIN_WITH':
        return ComplianceQueryOperatorType.beginWith;
      case 'LESS_THAN':
        return ComplianceQueryOperatorType.lessThan;
      case 'GREATER_THAN':
        return ComplianceQueryOperatorType.greaterThan;
    }
    throw Exception('$this is not known in enum ComplianceQueryOperatorType');
  }
}

enum ComplianceSeverity {
  critical,
  high,
  medium,
  low,
  informational,
  unspecified,
}

extension on ComplianceSeverity {
  String toValue() {
    switch (this) {
      case ComplianceSeverity.critical:
        return 'CRITICAL';
      case ComplianceSeverity.high:
        return 'HIGH';
      case ComplianceSeverity.medium:
        return 'MEDIUM';
      case ComplianceSeverity.low:
        return 'LOW';
      case ComplianceSeverity.informational:
        return 'INFORMATIONAL';
      case ComplianceSeverity.unspecified:
        return 'UNSPECIFIED';
    }
  }
}

extension on String {
  ComplianceSeverity toComplianceSeverity() {
    switch (this) {
      case 'CRITICAL':
        return ComplianceSeverity.critical;
      case 'HIGH':
        return ComplianceSeverity.high;
      case 'MEDIUM':
        return ComplianceSeverity.medium;
      case 'LOW':
        return ComplianceSeverity.low;
      case 'INFORMATIONAL':
        return ComplianceSeverity.informational;
      case 'UNSPECIFIED':
        return ComplianceSeverity.unspecified;
    }
    throw Exception('$this is not known in enum ComplianceSeverity');
  }
}

enum ComplianceStatus {
  compliant,
  nonCompliant,
}

extension on ComplianceStatus {
  String toValue() {
    switch (this) {
      case ComplianceStatus.compliant:
        return 'COMPLIANT';
      case ComplianceStatus.nonCompliant:
        return 'NON_COMPLIANT';
    }
  }
}

extension on String {
  ComplianceStatus toComplianceStatus() {
    switch (this) {
      case 'COMPLIANT':
        return ComplianceStatus.compliant;
      case 'NON_COMPLIANT':
        return ComplianceStatus.nonCompliant;
    }
    throw Exception('$this is not known in enum ComplianceStatus');
  }
}

/// One or more filters. Use a filter to return a more specific list of results.
class ComplianceStringFilter {
  /// The name of the filter.
  final String? key;

  /// The type of comparison that should be performed for the value: Equal,
  /// NotEqual, BeginWith, LessThan, or GreaterThan.
  final ComplianceQueryOperatorType? type;

  /// The value for which to search.
  final List<String>? values;

  ComplianceStringFilter({
    this.key,
    this.type,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final type = this.type;
    final values = this.values;
    return {
      if (key != null) 'Key': key,
      if (type != null) 'Type': type.toValue(),
      if (values != null) 'Values': values,
    };
  }
}

/// A summary of compliance information by compliance type.
class ComplianceSummaryItem {
  /// The type of compliance item. For example, the compliance type can be
  /// Association, Patch, or Custom:string.
  final String? complianceType;

  /// A list of COMPLIANT items for the specified compliance type.
  final CompliantSummary? compliantSummary;

  /// A list of NON_COMPLIANT items for the specified compliance type.
  final NonCompliantSummary? nonCompliantSummary;

  ComplianceSummaryItem({
    this.complianceType,
    this.compliantSummary,
    this.nonCompliantSummary,
  });
  factory ComplianceSummaryItem.fromJson(Map<String, dynamic> json) {
    return ComplianceSummaryItem(
      complianceType: json['ComplianceType'] as String?,
      compliantSummary: json['CompliantSummary'] != null
          ? CompliantSummary.fromJson(
              json['CompliantSummary'] as Map<String, dynamic>)
          : null,
      nonCompliantSummary: json['NonCompliantSummary'] != null
          ? NonCompliantSummary.fromJson(
              json['NonCompliantSummary'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum ComplianceUploadType {
  complete,
  partial,
}

extension on ComplianceUploadType {
  String toValue() {
    switch (this) {
      case ComplianceUploadType.complete:
        return 'COMPLETE';
      case ComplianceUploadType.partial:
        return 'PARTIAL';
    }
  }
}

extension on String {
  ComplianceUploadType toComplianceUploadType() {
    switch (this) {
      case 'COMPLETE':
        return ComplianceUploadType.complete;
      case 'PARTIAL':
        return ComplianceUploadType.partial;
    }
    throw Exception('$this is not known in enum ComplianceUploadType');
  }
}

/// A summary of resources that are compliant. The summary is organized
/// according to the resource count for each compliance type.
class CompliantSummary {
  /// The total number of resources that are compliant.
  final int? compliantCount;

  /// A summary of the compliance severity by compliance type.
  final SeveritySummary? severitySummary;

  CompliantSummary({
    this.compliantCount,
    this.severitySummary,
  });
  factory CompliantSummary.fromJson(Map<String, dynamic> json) {
    return CompliantSummary(
      compliantCount: json['CompliantCount'] as int?,
      severitySummary: json['SeveritySummary'] != null
          ? SeveritySummary.fromJson(
              json['SeveritySummary'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum ConnectionStatus {
  connected,
  notConnected,
}

extension on ConnectionStatus {
  String toValue() {
    switch (this) {
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.notConnected:
        return 'NotConnected';
    }
  }
}

extension on String {
  ConnectionStatus toConnectionStatus() {
    switch (this) {
      case 'Connected':
        return ConnectionStatus.connected;
      case 'NotConnected':
        return ConnectionStatus.notConnected;
    }
    throw Exception('$this is not known in enum ConnectionStatus');
  }
}

class CreateActivationResult {
  /// The code the system generates when it processes the activation. The
  /// activation code functions like a password to validate the activation ID.
  final String? activationCode;

  /// The ID number generated by the system when it processed the activation. The
  /// activation ID functions like a user name.
  final String? activationId;

  CreateActivationResult({
    this.activationCode,
    this.activationId,
  });
  factory CreateActivationResult.fromJson(Map<String, dynamic> json) {
    return CreateActivationResult(
      activationCode: json['ActivationCode'] as String?,
      activationId: json['ActivationId'] as String?,
    );
  }
}

/// Describes the association of a Systems Manager SSM document and an instance.
class CreateAssociationBatchRequestEntry {
  /// The name of the SSM document that contains the configuration information for
  /// the instance. You can specify Command or Automation documents.
  ///
  /// You can specify AWS-predefined documents, documents you created, or a
  /// document that is shared with you from another account.
  ///
  /// For SSM documents that are shared with you from other AWS accounts, you must
  /// specify the complete SSM document ARN, in the following format:
  ///
  /// <code>arn:aws:ssm:<i>region</i>:<i>account-id</i>:document/<i>document-name</i>
  /// </code>
  ///
  /// For example:
  ///
  /// <code>arn:aws:ssm:us-east-2:12345678912:document/My-Shared-Document</code>
  ///
  /// For AWS-predefined documents and SSM documents you created in your account,
  /// you only need to specify the document name. For example,
  /// <code>AWS-ApplyPatchBaseline</code> or <code>My-Document</code>.
  final String name;

  /// By default, when you create a new associations, the system runs it
  /// immediately after it is created and then according to the schedule you
  /// specified. Specify this option if you don't want an association to run
  /// immediately after you create it. This parameter is not supported for rate
  /// expressions.
  final bool? applyOnlyAtCronInterval;

  /// Specify a descriptive name for the association.
  final String? associationName;

  /// Specify the target for the association. This target is required for
  /// associations that use an Automation document and target resources by using
  /// rate controls.
  final String? automationTargetParameterName;

  /// The severity level to assign to the association.
  final AssociationComplianceSeverity? complianceSeverity;

  /// The document version.
  final String? documentVersion;

  /// The ID of the instance.
  final String? instanceId;

  /// The maximum number of targets allowed to run the association at the same
  /// time. You can specify a number, for example 10, or a percentage of the
  /// target set, for example 10%. The default value is 100%, which means all
  /// targets run the association at the same time.
  ///
  /// If a new instance starts and attempts to run an association while Systems
  /// Manager is running MaxConcurrency associations, the association is allowed
  /// to run. During the next association interval, the new instance will process
  /// its association within the limit specified for MaxConcurrency.
  final String? maxConcurrency;

  /// The number of errors that are allowed before the system stops sending
  /// requests to run the association on additional targets. You can specify
  /// either an absolute number of errors, for example 10, or a percentage of the
  /// target set, for example 10%. If you specify 3, for example, the system stops
  /// sending requests when the fourth error is received. If you specify 0, then
  /// the system stops sending requests after the first error is returned. If you
  /// run an association on 50 instances and set MaxError to 10%, then the system
  /// stops sending the request when the sixth error is received.
  ///
  /// Executions that are already running an association when MaxErrors is reached
  /// are allowed to complete, but some of these executions may fail as well. If
  /// you need to ensure that there won't be more than max-errors failed
  /// executions, set MaxConcurrency to 1 so that executions proceed one at a
  /// time.
  final String? maxErrors;

  /// An S3 bucket where you want to store the results of this request.
  final InstanceAssociationOutputLocation? outputLocation;

  /// A description of the parameters for a document.
  final Map<String, List<String>>? parameters;

  /// A cron expression that specifies a schedule when the association runs.
  final String? scheduleExpression;

  /// The mode for generating association compliance. You can specify
  /// <code>AUTO</code> or <code>MANUAL</code>. In <code>AUTO</code> mode, the
  /// system uses the status of the association execution to determine the
  /// compliance status. If the association execution runs successfully, then the
  /// association is <code>COMPLIANT</code>. If the association execution doesn't
  /// run successfully, the association is <code>NON-COMPLIANT</code>.
  ///
  /// In <code>MANUAL</code> mode, you must specify the <code>AssociationId</code>
  /// as a parameter for the <a>PutComplianceItems</a> API action. In this case,
  /// compliance data is not managed by State Manager. It is managed by your
  /// direct call to the <a>PutComplianceItems</a> API action.
  ///
  /// By default, all associations use <code>AUTO</code> mode.
  final AssociationSyncCompliance? syncCompliance;

  /// Use this action to create an association in multiple Regions and multiple
  /// accounts.
  final List<TargetLocation>? targetLocations;

  /// The instances targeted by the request.
  final List<Target>? targets;

  CreateAssociationBatchRequestEntry({
    required this.name,
    this.applyOnlyAtCronInterval,
    this.associationName,
    this.automationTargetParameterName,
    this.complianceSeverity,
    this.documentVersion,
    this.instanceId,
    this.maxConcurrency,
    this.maxErrors,
    this.outputLocation,
    this.parameters,
    this.scheduleExpression,
    this.syncCompliance,
    this.targetLocations,
    this.targets,
  });
  factory CreateAssociationBatchRequestEntry.fromJson(
      Map<String, dynamic> json) {
    return CreateAssociationBatchRequestEntry(
      name: json['Name'] as String,
      applyOnlyAtCronInterval: json['ApplyOnlyAtCronInterval'] as bool?,
      associationName: json['AssociationName'] as String?,
      automationTargetParameterName:
          json['AutomationTargetParameterName'] as String?,
      complianceSeverity: (json['ComplianceSeverity'] as String?)
          ?.toAssociationComplianceSeverity(),
      documentVersion: json['DocumentVersion'] as String?,
      instanceId: json['InstanceId'] as String?,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      outputLocation: json['OutputLocation'] != null
          ? InstanceAssociationOutputLocation.fromJson(
              json['OutputLocation'] as Map<String, dynamic>)
          : null,
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      scheduleExpression: json['ScheduleExpression'] as String?,
      syncCompliance:
          (json['SyncCompliance'] as String?)?.toAssociationSyncCompliance(),
      targetLocations: (json['TargetLocations'] as List?)
          ?.whereNotNull()
          .map((e) => TargetLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final applyOnlyAtCronInterval = this.applyOnlyAtCronInterval;
    final associationName = this.associationName;
    final automationTargetParameterName = this.automationTargetParameterName;
    final complianceSeverity = this.complianceSeverity;
    final documentVersion = this.documentVersion;
    final instanceId = this.instanceId;
    final maxConcurrency = this.maxConcurrency;
    final maxErrors = this.maxErrors;
    final outputLocation = this.outputLocation;
    final parameters = this.parameters;
    final scheduleExpression = this.scheduleExpression;
    final syncCompliance = this.syncCompliance;
    final targetLocations = this.targetLocations;
    final targets = this.targets;
    return {
      'Name': name,
      if (applyOnlyAtCronInterval != null)
        'ApplyOnlyAtCronInterval': applyOnlyAtCronInterval,
      if (associationName != null) 'AssociationName': associationName,
      if (automationTargetParameterName != null)
        'AutomationTargetParameterName': automationTargetParameterName,
      if (complianceSeverity != null)
        'ComplianceSeverity': complianceSeverity.toValue(),
      if (documentVersion != null) 'DocumentVersion': documentVersion,
      if (instanceId != null) 'InstanceId': instanceId,
      if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
      if (maxErrors != null) 'MaxErrors': maxErrors,
      if (outputLocation != null) 'OutputLocation': outputLocation,
      if (parameters != null) 'Parameters': parameters,
      if (scheduleExpression != null) 'ScheduleExpression': scheduleExpression,
      if (syncCompliance != null) 'SyncCompliance': syncCompliance.toValue(),
      if (targetLocations != null) 'TargetLocations': targetLocations,
      if (targets != null) 'Targets': targets,
    };
  }
}

class CreateAssociationBatchResult {
  /// Information about the associations that failed.
  final List<FailedCreateAssociation>? failed;

  /// Information about the associations that succeeded.
  final List<AssociationDescription>? successful;

  CreateAssociationBatchResult({
    this.failed,
    this.successful,
  });
  factory CreateAssociationBatchResult.fromJson(Map<String, dynamic> json) {
    return CreateAssociationBatchResult(
      failed: (json['Failed'] as List?)
          ?.whereNotNull()
          .map((e) =>
              FailedCreateAssociation.fromJson(e as Map<String, dynamic>))
          .toList(),
      successful: (json['Successful'] as List?)
          ?.whereNotNull()
          .map(
              (e) => AssociationDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CreateAssociationResult {
  /// Information about the association.
  final AssociationDescription? associationDescription;

  CreateAssociationResult({
    this.associationDescription,
  });
  factory CreateAssociationResult.fromJson(Map<String, dynamic> json) {
    return CreateAssociationResult(
      associationDescription: json['AssociationDescription'] != null
          ? AssociationDescription.fromJson(
              json['AssociationDescription'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateDocumentResult {
  /// Information about the Systems Manager document.
  final DocumentDescription? documentDescription;

  CreateDocumentResult({
    this.documentDescription,
  });
  factory CreateDocumentResult.fromJson(Map<String, dynamic> json) {
    return CreateDocumentResult(
      documentDescription: json['DocumentDescription'] != null
          ? DocumentDescription.fromJson(
              json['DocumentDescription'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateMaintenanceWindowResult {
  /// The ID of the created maintenance window.
  final String? windowId;

  CreateMaintenanceWindowResult({
    this.windowId,
  });
  factory CreateMaintenanceWindowResult.fromJson(Map<String, dynamic> json) {
    return CreateMaintenanceWindowResult(
      windowId: json['WindowId'] as String?,
    );
  }
}

class CreateOpsItemResponse {
  /// The ID of the OpsItem.
  final String? opsItemId;

  CreateOpsItemResponse({
    this.opsItemId,
  });
  factory CreateOpsItemResponse.fromJson(Map<String, dynamic> json) {
    return CreateOpsItemResponse(
      opsItemId: json['OpsItemId'] as String?,
    );
  }
}

class CreateOpsMetadataResult {
  /// The Amazon Resource Name (ARN) of the OpsMetadata Object or blob created by
  /// the call.
  final String? opsMetadataArn;

  CreateOpsMetadataResult({
    this.opsMetadataArn,
  });
  factory CreateOpsMetadataResult.fromJson(Map<String, dynamic> json) {
    return CreateOpsMetadataResult(
      opsMetadataArn: json['OpsMetadataArn'] as String?,
    );
  }
}

class CreatePatchBaselineResult {
  /// The ID of the created patch baseline.
  final String? baselineId;

  CreatePatchBaselineResult({
    this.baselineId,
  });
  factory CreatePatchBaselineResult.fromJson(Map<String, dynamic> json) {
    return CreatePatchBaselineResult(
      baselineId: json['BaselineId'] as String?,
    );
  }
}

class CreateResourceDataSyncResult {
  CreateResourceDataSyncResult();
  factory CreateResourceDataSyncResult.fromJson(Map<String, dynamic> _) {
    return CreateResourceDataSyncResult();
  }
}

class DeleteActivationResult {
  DeleteActivationResult();
  factory DeleteActivationResult.fromJson(Map<String, dynamic> _) {
    return DeleteActivationResult();
  }
}

class DeleteAssociationResult {
  DeleteAssociationResult();
  factory DeleteAssociationResult.fromJson(Map<String, dynamic> _) {
    return DeleteAssociationResult();
  }
}

class DeleteDocumentResult {
  DeleteDocumentResult();
  factory DeleteDocumentResult.fromJson(Map<String, dynamic> _) {
    return DeleteDocumentResult();
  }
}

class DeleteInventoryResult {
  /// Every <code>DeleteInventory</code> action is assigned a unique ID. This
  /// option returns a unique ID. You can use this ID to query the status of a
  /// delete operation. This option is useful for ensuring that a delete operation
  /// has completed before you begin other actions.
  final String? deletionId;

  /// A summary of the delete operation. For more information about this summary,
  /// see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-inventory-custom.html#sysman-inventory-delete-summary">Deleting
  /// custom inventory</a> in the <i>AWS Systems Manager User Guide</i>.
  final InventoryDeletionSummary? deletionSummary;

  /// The name of the inventory data type specified in the request.
  final String? typeName;

  DeleteInventoryResult({
    this.deletionId,
    this.deletionSummary,
    this.typeName,
  });
  factory DeleteInventoryResult.fromJson(Map<String, dynamic> json) {
    return DeleteInventoryResult(
      deletionId: json['DeletionId'] as String?,
      deletionSummary: json['DeletionSummary'] != null
          ? InventoryDeletionSummary.fromJson(
              json['DeletionSummary'] as Map<String, dynamic>)
          : null,
      typeName: json['TypeName'] as String?,
    );
  }
}

class DeleteMaintenanceWindowResult {
  /// The ID of the deleted maintenance window.
  final String? windowId;

  DeleteMaintenanceWindowResult({
    this.windowId,
  });
  factory DeleteMaintenanceWindowResult.fromJson(Map<String, dynamic> json) {
    return DeleteMaintenanceWindowResult(
      windowId: json['WindowId'] as String?,
    );
  }
}

class DeleteOpsMetadataResult {
  DeleteOpsMetadataResult();
  factory DeleteOpsMetadataResult.fromJson(Map<String, dynamic> _) {
    return DeleteOpsMetadataResult();
  }
}

class DeleteParameterResult {
  DeleteParameterResult();
  factory DeleteParameterResult.fromJson(Map<String, dynamic> _) {
    return DeleteParameterResult();
  }
}

class DeleteParametersResult {
  /// The names of the deleted parameters.
  final List<String>? deletedParameters;

  /// The names of parameters that weren't deleted because the parameters are not
  /// valid.
  final List<String>? invalidParameters;

  DeleteParametersResult({
    this.deletedParameters,
    this.invalidParameters,
  });
  factory DeleteParametersResult.fromJson(Map<String, dynamic> json) {
    return DeleteParametersResult(
      deletedParameters: (json['DeletedParameters'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      invalidParameters: (json['InvalidParameters'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

class DeletePatchBaselineResult {
  /// The ID of the deleted patch baseline.
  final String? baselineId;

  DeletePatchBaselineResult({
    this.baselineId,
  });
  factory DeletePatchBaselineResult.fromJson(Map<String, dynamic> json) {
    return DeletePatchBaselineResult(
      baselineId: json['BaselineId'] as String?,
    );
  }
}

class DeleteResourceDataSyncResult {
  DeleteResourceDataSyncResult();
  factory DeleteResourceDataSyncResult.fromJson(Map<String, dynamic> _) {
    return DeleteResourceDataSyncResult();
  }
}

class DeregisterManagedInstanceResult {
  DeregisterManagedInstanceResult();
  factory DeregisterManagedInstanceResult.fromJson(Map<String, dynamic> _) {
    return DeregisterManagedInstanceResult();
  }
}

class DeregisterPatchBaselineForPatchGroupResult {
  /// The ID of the patch baseline the patch group was deregistered from.
  final String? baselineId;

  /// The name of the patch group deregistered from the patch baseline.
  final String? patchGroup;

  DeregisterPatchBaselineForPatchGroupResult({
    this.baselineId,
    this.patchGroup,
  });
  factory DeregisterPatchBaselineForPatchGroupResult.fromJson(
      Map<String, dynamic> json) {
    return DeregisterPatchBaselineForPatchGroupResult(
      baselineId: json['BaselineId'] as String?,
      patchGroup: json['PatchGroup'] as String?,
    );
  }
}

class DeregisterTargetFromMaintenanceWindowResult {
  /// The ID of the maintenance window the target was removed from.
  final String? windowId;

  /// The ID of the removed target definition.
  final String? windowTargetId;

  DeregisterTargetFromMaintenanceWindowResult({
    this.windowId,
    this.windowTargetId,
  });
  factory DeregisterTargetFromMaintenanceWindowResult.fromJson(
      Map<String, dynamic> json) {
    return DeregisterTargetFromMaintenanceWindowResult(
      windowId: json['WindowId'] as String?,
      windowTargetId: json['WindowTargetId'] as String?,
    );
  }
}

class DeregisterTaskFromMaintenanceWindowResult {
  /// The ID of the maintenance window the task was removed from.
  final String? windowId;

  /// The ID of the task removed from the maintenance window.
  final String? windowTaskId;

  DeregisterTaskFromMaintenanceWindowResult({
    this.windowId,
    this.windowTaskId,
  });
  factory DeregisterTaskFromMaintenanceWindowResult.fromJson(
      Map<String, dynamic> json) {
    return DeregisterTaskFromMaintenanceWindowResult(
      windowId: json['WindowId'] as String?,
      windowTaskId: json['WindowTaskId'] as String?,
    );
  }
}

/// Filter for the DescribeActivation API.
class DescribeActivationsFilter {
  /// The name of the filter.
  final DescribeActivationsFilterKeys? filterKey;

  /// The filter values.
  final List<String>? filterValues;

  DescribeActivationsFilter({
    this.filterKey,
    this.filterValues,
  });
  Map<String, dynamic> toJson() {
    final filterKey = this.filterKey;
    final filterValues = this.filterValues;
    return {
      if (filterKey != null) 'FilterKey': filterKey.toValue(),
      if (filterValues != null) 'FilterValues': filterValues,
    };
  }
}

enum DescribeActivationsFilterKeys {
  activationIds,
  defaultInstanceName,
  iamRole,
}

extension on DescribeActivationsFilterKeys {
  String toValue() {
    switch (this) {
      case DescribeActivationsFilterKeys.activationIds:
        return 'ActivationIds';
      case DescribeActivationsFilterKeys.defaultInstanceName:
        return 'DefaultInstanceName';
      case DescribeActivationsFilterKeys.iamRole:
        return 'IamRole';
    }
  }
}

extension on String {
  DescribeActivationsFilterKeys toDescribeActivationsFilterKeys() {
    switch (this) {
      case 'ActivationIds':
        return DescribeActivationsFilterKeys.activationIds;
      case 'DefaultInstanceName':
        return DescribeActivationsFilterKeys.defaultInstanceName;
      case 'IamRole':
        return DescribeActivationsFilterKeys.iamRole;
    }
    throw Exception('$this is not known in enum DescribeActivationsFilterKeys');
  }
}

class DescribeActivationsResult {
  /// A list of activations for your AWS account.
  final List<Activation>? activationList;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  DescribeActivationsResult({
    this.activationList,
    this.nextToken,
  });
  factory DescribeActivationsResult.fromJson(Map<String, dynamic> json) {
    return DescribeActivationsResult(
      activationList: (json['ActivationList'] as List?)
          ?.whereNotNull()
          .map((e) => Activation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeAssociationExecutionTargetsResult {
  /// Information about the execution.
  final List<AssociationExecutionTarget>? associationExecutionTargets;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  DescribeAssociationExecutionTargetsResult({
    this.associationExecutionTargets,
    this.nextToken,
  });
  factory DescribeAssociationExecutionTargetsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeAssociationExecutionTargetsResult(
      associationExecutionTargets: (json['AssociationExecutionTargets']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              AssociationExecutionTarget.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeAssociationExecutionsResult {
  /// A list of the executions for the specified association ID.
  final List<AssociationExecution>? associationExecutions;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  DescribeAssociationExecutionsResult({
    this.associationExecutions,
    this.nextToken,
  });
  factory DescribeAssociationExecutionsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeAssociationExecutionsResult(
      associationExecutions: (json['AssociationExecutions'] as List?)
          ?.whereNotNull()
          .map((e) => AssociationExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeAssociationResult {
  /// Information about the association.
  final AssociationDescription? associationDescription;

  DescribeAssociationResult({
    this.associationDescription,
  });
  factory DescribeAssociationResult.fromJson(Map<String, dynamic> json) {
    return DescribeAssociationResult(
      associationDescription: json['AssociationDescription'] != null
          ? AssociationDescription.fromJson(
              json['AssociationDescription'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DescribeAutomationExecutionsResult {
  /// The list of details about each automation execution which has occurred which
  /// matches the filter specification, if any.
  final List<AutomationExecutionMetadata>? automationExecutionMetadataList;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribeAutomationExecutionsResult({
    this.automationExecutionMetadataList,
    this.nextToken,
  });
  factory DescribeAutomationExecutionsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeAutomationExecutionsResult(
      automationExecutionMetadataList: (json['AutomationExecutionMetadataList']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              AutomationExecutionMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeAutomationStepExecutionsResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// A list of details about the current state of all steps that make up an
  /// execution.
  final List<StepExecution>? stepExecutions;

  DescribeAutomationStepExecutionsResult({
    this.nextToken,
    this.stepExecutions,
  });
  factory DescribeAutomationStepExecutionsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeAutomationStepExecutionsResult(
      nextToken: json['NextToken'] as String?,
      stepExecutions: (json['StepExecutions'] as List?)
          ?.whereNotNull()
          .map((e) => StepExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeAvailablePatchesResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// An array of patches. Each entry in the array is a patch structure.
  final List<Patch>? patches;

  DescribeAvailablePatchesResult({
    this.nextToken,
    this.patches,
  });
  factory DescribeAvailablePatchesResult.fromJson(Map<String, dynamic> json) {
    return DescribeAvailablePatchesResult(
      nextToken: json['NextToken'] as String?,
      patches: (json['Patches'] as List?)
          ?.whereNotNull()
          .map((e) => Patch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeDocumentPermissionResponse {
  /// The account IDs that have permission to use this document. The ID can be
  /// either an AWS account or <i>All</i>.
  final List<String>? accountIds;

  /// A list of AWS accounts where the current document is shared and the version
  /// shared with each account.
  final List<AccountSharingInfo>? accountSharingInfoList;

  DescribeDocumentPermissionResponse({
    this.accountIds,
    this.accountSharingInfoList,
  });
  factory DescribeDocumentPermissionResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeDocumentPermissionResponse(
      accountIds: (json['AccountIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      accountSharingInfoList: (json['AccountSharingInfoList'] as List?)
          ?.whereNotNull()
          .map((e) => AccountSharingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeDocumentResult {
  /// Information about the Systems Manager document.
  final DocumentDescription? document;

  DescribeDocumentResult({
    this.document,
  });
  factory DescribeDocumentResult.fromJson(Map<String, dynamic> json) {
    return DescribeDocumentResult(
      document: json['Document'] != null
          ? DocumentDescription.fromJson(
              json['Document'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DescribeEffectiveInstanceAssociationsResult {
  /// The associations for the requested instance.
  final List<InstanceAssociation>? associations;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribeEffectiveInstanceAssociationsResult({
    this.associations,
    this.nextToken,
  });
  factory DescribeEffectiveInstanceAssociationsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeEffectiveInstanceAssociationsResult(
      associations: (json['Associations'] as List?)
          ?.whereNotNull()
          .map((e) => InstanceAssociation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeEffectivePatchesForPatchBaselineResult {
  /// An array of patches and patch status.
  final List<EffectivePatch>? effectivePatches;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribeEffectivePatchesForPatchBaselineResult({
    this.effectivePatches,
    this.nextToken,
  });
  factory DescribeEffectivePatchesForPatchBaselineResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeEffectivePatchesForPatchBaselineResult(
      effectivePatches: (json['EffectivePatches'] as List?)
          ?.whereNotNull()
          .map((e) => EffectivePatch.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeInstanceAssociationsStatusResult {
  /// Status information about the association.
  final List<InstanceAssociationStatusInfo>? instanceAssociationStatusInfos;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribeInstanceAssociationsStatusResult({
    this.instanceAssociationStatusInfos,
    this.nextToken,
  });
  factory DescribeInstanceAssociationsStatusResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeInstanceAssociationsStatusResult(
      instanceAssociationStatusInfos: (json['InstanceAssociationStatusInfos']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              InstanceAssociationStatusInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeInstanceInformationResult {
  /// The instance information list.
  final List<InstanceInformation>? instanceInformationList;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribeInstanceInformationResult({
    this.instanceInformationList,
    this.nextToken,
  });
  factory DescribeInstanceInformationResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeInstanceInformationResult(
      instanceInformationList: (json['InstanceInformationList'] as List?)
          ?.whereNotNull()
          .map((e) => InstanceInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeInstancePatchStatesForPatchGroupResult {
  /// The high-level patch state for the requested instances.
  final List<InstancePatchState>? instancePatchStates;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribeInstancePatchStatesForPatchGroupResult({
    this.instancePatchStates,
    this.nextToken,
  });
  factory DescribeInstancePatchStatesForPatchGroupResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeInstancePatchStatesForPatchGroupResult(
      instancePatchStates: (json['InstancePatchStates'] as List?)
          ?.whereNotNull()
          .map((e) => InstancePatchState.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeInstancePatchStatesResult {
  /// The high-level patch state for the requested instances.
  final List<InstancePatchState>? instancePatchStates;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribeInstancePatchStatesResult({
    this.instancePatchStates,
    this.nextToken,
  });
  factory DescribeInstancePatchStatesResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeInstancePatchStatesResult(
      instancePatchStates: (json['InstancePatchStates'] as List?)
          ?.whereNotNull()
          .map((e) => InstancePatchState.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeInstancePatchesResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Each entry in the array is a structure containing:
  ///
  /// Title (string)
  ///
  /// KBId (string)
  ///
  /// Classification (string)
  ///
  /// Severity (string)
  ///
  /// State (string, such as "INSTALLED" or "FAILED")
  ///
  /// InstalledTime (DateTime)
  ///
  /// InstalledBy (string)
  final List<PatchComplianceData>? patches;

  DescribeInstancePatchesResult({
    this.nextToken,
    this.patches,
  });
  factory DescribeInstancePatchesResult.fromJson(Map<String, dynamic> json) {
    return DescribeInstancePatchesResult(
      nextToken: json['NextToken'] as String?,
      patches: (json['Patches'] as List?)
          ?.whereNotNull()
          .map((e) => PatchComplianceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeInventoryDeletionsResult {
  /// A list of status items for deleted inventory.
  final List<InventoryDeletionStatusItem>? inventoryDeletions;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  DescribeInventoryDeletionsResult({
    this.inventoryDeletions,
    this.nextToken,
  });
  factory DescribeInventoryDeletionsResult.fromJson(Map<String, dynamic> json) {
    return DescribeInventoryDeletionsResult(
      inventoryDeletions: (json['InventoryDeletions'] as List?)
          ?.whereNotNull()
          .map((e) =>
              InventoryDeletionStatusItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeMaintenanceWindowExecutionTaskInvocationsResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Information about the task invocation results per invocation.
  final List<MaintenanceWindowExecutionTaskInvocationIdentity>?
      windowExecutionTaskInvocationIdentities;

  DescribeMaintenanceWindowExecutionTaskInvocationsResult({
    this.nextToken,
    this.windowExecutionTaskInvocationIdentities,
  });
  factory DescribeMaintenanceWindowExecutionTaskInvocationsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeMaintenanceWindowExecutionTaskInvocationsResult(
      nextToken: json['NextToken'] as String?,
      windowExecutionTaskInvocationIdentities:
          (json['WindowExecutionTaskInvocationIdentities'] as List?)
              ?.whereNotNull()
              .map((e) =>
                  MaintenanceWindowExecutionTaskInvocationIdentity.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class DescribeMaintenanceWindowExecutionTasksResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Information about the task executions.
  final List<MaintenanceWindowExecutionTaskIdentity>?
      windowExecutionTaskIdentities;

  DescribeMaintenanceWindowExecutionTasksResult({
    this.nextToken,
    this.windowExecutionTaskIdentities,
  });
  factory DescribeMaintenanceWindowExecutionTasksResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeMaintenanceWindowExecutionTasksResult(
      nextToken: json['NextToken'] as String?,
      windowExecutionTaskIdentities:
          (json['WindowExecutionTaskIdentities'] as List?)
              ?.whereNotNull()
              .map((e) => MaintenanceWindowExecutionTaskIdentity.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class DescribeMaintenanceWindowExecutionsResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Information about the maintenance window executions.
  final List<MaintenanceWindowExecution>? windowExecutions;

  DescribeMaintenanceWindowExecutionsResult({
    this.nextToken,
    this.windowExecutions,
  });
  factory DescribeMaintenanceWindowExecutionsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeMaintenanceWindowExecutionsResult(
      nextToken: json['NextToken'] as String?,
      windowExecutions: (json['WindowExecutions'] as List?)
          ?.whereNotNull()
          .map((e) =>
              MaintenanceWindowExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeMaintenanceWindowScheduleResult {
  /// The token for the next set of items to return. (You use this token in the
  /// next call.)
  final String? nextToken;

  /// Information about maintenance window executions scheduled for the specified
  /// time range.
  final List<ScheduledWindowExecution>? scheduledWindowExecutions;

  DescribeMaintenanceWindowScheduleResult({
    this.nextToken,
    this.scheduledWindowExecutions,
  });
  factory DescribeMaintenanceWindowScheduleResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeMaintenanceWindowScheduleResult(
      nextToken: json['NextToken'] as String?,
      scheduledWindowExecutions: (json['ScheduledWindowExecutions'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ScheduledWindowExecution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeMaintenanceWindowTargetsResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Information about the targets in the maintenance window.
  final List<MaintenanceWindowTarget>? targets;

  DescribeMaintenanceWindowTargetsResult({
    this.nextToken,
    this.targets,
  });
  factory DescribeMaintenanceWindowTargetsResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeMaintenanceWindowTargetsResult(
      nextToken: json['NextToken'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) =>
              MaintenanceWindowTarget.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeMaintenanceWindowTasksResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Information about the tasks in the maintenance window.
  final List<MaintenanceWindowTask>? tasks;

  DescribeMaintenanceWindowTasksResult({
    this.nextToken,
    this.tasks,
  });
  factory DescribeMaintenanceWindowTasksResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeMaintenanceWindowTasksResult(
      nextToken: json['NextToken'] as String?,
      tasks: (json['Tasks'] as List?)
          ?.whereNotNull()
          .map((e) => MaintenanceWindowTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeMaintenanceWindowsForTargetResult {
  /// The token for the next set of items to return. (You use this token in the
  /// next call.)
  final String? nextToken;

  /// Information about the maintenance window targets and tasks an instance is
  /// associated with.
  final List<MaintenanceWindowIdentityForTarget>? windowIdentities;

  DescribeMaintenanceWindowsForTargetResult({
    this.nextToken,
    this.windowIdentities,
  });
  factory DescribeMaintenanceWindowsForTargetResult.fromJson(
      Map<String, dynamic> json) {
    return DescribeMaintenanceWindowsForTargetResult(
      nextToken: json['NextToken'] as String?,
      windowIdentities: (json['WindowIdentities'] as List?)
          ?.whereNotNull()
          .map((e) => MaintenanceWindowIdentityForTarget.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeMaintenanceWindowsResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Information about the maintenance windows.
  final List<MaintenanceWindowIdentity>? windowIdentities;

  DescribeMaintenanceWindowsResult({
    this.nextToken,
    this.windowIdentities,
  });
  factory DescribeMaintenanceWindowsResult.fromJson(Map<String, dynamic> json) {
    return DescribeMaintenanceWindowsResult(
      nextToken: json['NextToken'] as String?,
      windowIdentities: (json['WindowIdentities'] as List?)
          ?.whereNotNull()
          .map((e) =>
              MaintenanceWindowIdentity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeOpsItemsResponse {
  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  /// A list of OpsItems.
  final List<OpsItemSummary>? opsItemSummaries;

  DescribeOpsItemsResponse({
    this.nextToken,
    this.opsItemSummaries,
  });
  factory DescribeOpsItemsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeOpsItemsResponse(
      nextToken: json['NextToken'] as String?,
      opsItemSummaries: (json['OpsItemSummaries'] as List?)
          ?.whereNotNull()
          .map((e) => OpsItemSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeParametersResult {
  /// The token to use when requesting the next set of items.
  final String? nextToken;

  /// Parameters returned by the request.
  final List<ParameterMetadata>? parameters;

  DescribeParametersResult({
    this.nextToken,
    this.parameters,
  });
  factory DescribeParametersResult.fromJson(Map<String, dynamic> json) {
    return DescribeParametersResult(
      nextToken: json['NextToken'] as String?,
      parameters: (json['Parameters'] as List?)
          ?.whereNotNull()
          .map((e) => ParameterMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribePatchBaselinesResult {
  /// An array of PatchBaselineIdentity elements.
  final List<PatchBaselineIdentity>? baselineIdentities;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribePatchBaselinesResult({
    this.baselineIdentities,
    this.nextToken,
  });
  factory DescribePatchBaselinesResult.fromJson(Map<String, dynamic> json) {
    return DescribePatchBaselinesResult(
      baselineIdentities: (json['BaselineIdentities'] as List?)
          ?.whereNotNull()
          .map((e) => PatchBaselineIdentity.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribePatchGroupStateResult {
  /// The number of instances in the patch group.
  final int? instances;

  /// The number of instances with patches from the patch baseline that failed to
  /// install.
  final int? instancesWithFailedPatches;

  /// The number of instances with patches installed that aren't defined in the
  /// patch baseline.
  final int? instancesWithInstalledOtherPatches;

  /// The number of instances with installed patches.
  final int? instancesWithInstalledPatches;

  /// The number of instances with patches installed by Patch Manager that have
  /// not been rebooted after the patch installation. The status of these
  /// instances is NON_COMPLIANT.
  final int? instancesWithInstalledPendingRebootPatches;

  /// The number of instances with patches installed that are specified in a
  /// RejectedPatches list. Patches with a status of <i>INSTALLED_REJECTED</i>
  /// were typically installed before they were added to a RejectedPatches list.
  /// <note>
  /// If ALLOW_AS_DEPENDENCY is the specified option for RejectedPatchesAction,
  /// the value of InstancesWithInstalledRejectedPatches will always be 0 (zero).
  /// </note>
  final int? instancesWithInstalledRejectedPatches;

  /// The number of instances with missing patches from the patch baseline.
  final int? instancesWithMissingPatches;

  /// The number of instances with patches that aren't applicable.
  final int? instancesWithNotApplicablePatches;

  /// The number of instances with <code>NotApplicable</code> patches beyond the
  /// supported limit, which are not reported by name to Systems Manager
  /// Inventory.
  final int? instancesWithUnreportedNotApplicablePatches;

  DescribePatchGroupStateResult({
    this.instances,
    this.instancesWithFailedPatches,
    this.instancesWithInstalledOtherPatches,
    this.instancesWithInstalledPatches,
    this.instancesWithInstalledPendingRebootPatches,
    this.instancesWithInstalledRejectedPatches,
    this.instancesWithMissingPatches,
    this.instancesWithNotApplicablePatches,
    this.instancesWithUnreportedNotApplicablePatches,
  });
  factory DescribePatchGroupStateResult.fromJson(Map<String, dynamic> json) {
    return DescribePatchGroupStateResult(
      instances: json['Instances'] as int?,
      instancesWithFailedPatches: json['InstancesWithFailedPatches'] as int?,
      instancesWithInstalledOtherPatches:
          json['InstancesWithInstalledOtherPatches'] as int?,
      instancesWithInstalledPatches:
          json['InstancesWithInstalledPatches'] as int?,
      instancesWithInstalledPendingRebootPatches:
          json['InstancesWithInstalledPendingRebootPatches'] as int?,
      instancesWithInstalledRejectedPatches:
          json['InstancesWithInstalledRejectedPatches'] as int?,
      instancesWithMissingPatches: json['InstancesWithMissingPatches'] as int?,
      instancesWithNotApplicablePatches:
          json['InstancesWithNotApplicablePatches'] as int?,
      instancesWithUnreportedNotApplicablePatches:
          json['InstancesWithUnreportedNotApplicablePatches'] as int?,
    );
  }
}

class DescribePatchGroupsResult {
  /// Each entry in the array contains:
  ///
  /// PatchGroup: string (between 1 and 256 characters, Regex:
  /// ^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$)
  ///
  /// PatchBaselineIdentity: A PatchBaselineIdentity element.
  final List<PatchGroupPatchBaselineMapping>? mappings;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  DescribePatchGroupsResult({
    this.mappings,
    this.nextToken,
  });
  factory DescribePatchGroupsResult.fromJson(Map<String, dynamic> json) {
    return DescribePatchGroupsResult(
      mappings: (json['Mappings'] as List?)
          ?.whereNotNull()
          .map((e) => PatchGroupPatchBaselineMapping.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribePatchPropertiesResult {
  /// The token for the next set of items to return. (You use this token in the
  /// next call.)
  final String? nextToken;

  /// A list of the properties for patches matching the filter request parameters.
  final List<Map<String, String>>? properties;

  DescribePatchPropertiesResult({
    this.nextToken,
    this.properties,
  });
  factory DescribePatchPropertiesResult.fromJson(Map<String, dynamic> json) {
    return DescribePatchPropertiesResult(
      nextToken: json['NextToken'] as String?,
      properties: (json['Properties'] as List?)
          ?.whereNotNull()
          .map((e) => (e as Map<String, dynamic>)
              .map((k, e) => MapEntry(k, e as String)))
          .toList(),
    );
  }
}

class DescribeSessionsResponse {
  /// The token for the next set of items to return. (You received this token from
  /// a previous call.)
  final String? nextToken;

  /// A list of sessions meeting the request parameters.
  final List<Session>? sessions;

  DescribeSessionsResponse({
    this.nextToken,
    this.sessions,
  });
  factory DescribeSessionsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeSessionsResponse(
      nextToken: json['NextToken'] as String?,
      sessions: (json['Sessions'] as List?)
          ?.whereNotNull()
          .map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// A default version of a document.
class DocumentDefaultVersionDescription {
  /// The default version of the document.
  final String? defaultVersion;

  /// The default version of the artifact associated with the document.
  final String? defaultVersionName;

  /// The name of the document.
  final String? name;

  DocumentDefaultVersionDescription({
    this.defaultVersion,
    this.defaultVersionName,
    this.name,
  });
  factory DocumentDefaultVersionDescription.fromJson(
      Map<String, dynamic> json) {
    return DocumentDefaultVersionDescription(
      defaultVersion: json['DefaultVersion'] as String?,
      defaultVersionName: json['DefaultVersionName'] as String?,
      name: json['Name'] as String?,
    );
  }
}

/// Describes a Systems Manager document.
class DocumentDescription {
  /// The version of the document currently approved for use in the organization.
  final String? approvedVersion;

  /// Details about the document attachments, including names, locations, sizes,
  /// and so on.
  final List<AttachmentInformation>? attachmentsInformation;

  /// The user in your organization who created the document.
  final String? author;

  /// The date when the document was created.
  final DateTime? createdDate;

  /// The default version.
  final String? defaultVersion;

  /// A description of the document.
  final String? description;

  /// The document format, either JSON or YAML.
  final DocumentFormat? documentFormat;

  /// The type of document.
  final DocumentType? documentType;

  /// The document version.
  final String? documentVersion;

  /// The Sha256 or Sha1 hash created by the system when the document was created.
  /// <note>
  /// Sha1 hashes have been deprecated.
  /// </note>
  final String? hash;

  /// The hash type of the document. Valid values include <code>Sha256</code> or
  /// <code>Sha1</code>.
  /// <note>
  /// Sha1 hashes have been deprecated.
  /// </note>
  final DocumentHashType? hashType;

  /// The latest version of the document.
  final String? latestVersion;

  /// The name of the Systems Manager document.
  final String? name;

  /// The AWS user account that created the document.
  final String? owner;

  /// A description of the parameters for a document.
  final List<DocumentParameter>? parameters;

  /// The version of the document that is currently under review.
  final String? pendingReviewVersion;

  /// The list of OS platforms compatible with this Systems Manager document.
  final List<PlatformType>? platformTypes;

  /// A list of SSM documents required by a document. For example, an
  /// <code>ApplicationConfiguration</code> document requires an
  /// <code>ApplicationConfigurationSchema</code> document.
  final List<DocumentRequires>? requires;

  /// Details about the review of a document.
  final List<ReviewInformation>? reviewInformation;

  /// The current status of the review.
  final ReviewStatus? reviewStatus;

  /// The schema version.
  final String? schemaVersion;

  /// The SHA1 hash of the document, which you can use for verification.
  final String? sha1;

  /// The status of the Systems Manager document.
  final DocumentStatus? status;

  /// A message returned by AWS Systems Manager that explains the
  /// <code>Status</code> value. For example, a <code>Failed</code> status might
  /// be explained by the <code>StatusInformation</code> message, "The specified
  /// S3 bucket does not exist. Verify that the URL of the S3 bucket is correct."
  final String? statusInformation;

  /// The tags, or metadata, that have been applied to the document.
  final List<Tag>? tags;

  /// The target type which defines the kinds of resources the document can run
  /// on. For example, /AWS::EC2::Instance. For a list of valid resource types,
  /// see <a
  /// href="http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html">AWS
  /// resource and property types reference</a> in the <i>AWS CloudFormation User
  /// Guide</i>.
  final String? targetType;

  /// The version of the artifact associated with the document.
  final String? versionName;

  DocumentDescription({
    this.approvedVersion,
    this.attachmentsInformation,
    this.author,
    this.createdDate,
    this.defaultVersion,
    this.description,
    this.documentFormat,
    this.documentType,
    this.documentVersion,
    this.hash,
    this.hashType,
    this.latestVersion,
    this.name,
    this.owner,
    this.parameters,
    this.pendingReviewVersion,
    this.platformTypes,
    this.requires,
    this.reviewInformation,
    this.reviewStatus,
    this.schemaVersion,
    this.sha1,
    this.status,
    this.statusInformation,
    this.tags,
    this.targetType,
    this.versionName,
  });
  factory DocumentDescription.fromJson(Map<String, dynamic> json) {
    return DocumentDescription(
      approvedVersion: json['ApprovedVersion'] as String?,
      attachmentsInformation: (json['AttachmentsInformation'] as List?)
          ?.whereNotNull()
          .map((e) => AttachmentInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      author: json['Author'] as String?,
      createdDate: timeStampFromJson(json['CreatedDate']),
      defaultVersion: json['DefaultVersion'] as String?,
      description: json['Description'] as String?,
      documentFormat: (json['DocumentFormat'] as String?)?.toDocumentFormat(),
      documentType: (json['DocumentType'] as String?)?.toDocumentType(),
      documentVersion: json['DocumentVersion'] as String?,
      hash: json['Hash'] as String?,
      hashType: (json['HashType'] as String?)?.toDocumentHashType(),
      latestVersion: json['LatestVersion'] as String?,
      name: json['Name'] as String?,
      owner: json['Owner'] as String?,
      parameters: (json['Parameters'] as List?)
          ?.whereNotNull()
          .map((e) => DocumentParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingReviewVersion: json['PendingReviewVersion'] as String?,
      platformTypes: (json['PlatformTypes'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toPlatformType())
          .toList(),
      requires: (json['Requires'] as List?)
          ?.whereNotNull()
          .map((e) => DocumentRequires.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewInformation: (json['ReviewInformation'] as List?)
          ?.whereNotNull()
          .map((e) => ReviewInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewStatus: (json['ReviewStatus'] as String?)?.toReviewStatus(),
      schemaVersion: json['SchemaVersion'] as String?,
      sha1: json['Sha1'] as String?,
      status: (json['Status'] as String?)?.toDocumentStatus(),
      statusInformation: json['StatusInformation'] as String?,
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetType: json['TargetType'] as String?,
      versionName: json['VersionName'] as String?,
    );
  }
}

/// This data type is deprecated. Instead, use <a>DocumentKeyValuesFilter</a>.
class DocumentFilter {
  /// The name of the filter.
  final DocumentFilterKey key;

  /// The value of the filter.
  final String value;

  DocumentFilter({
    required this.key,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'key': key.toValue(),
      'value': value,
    };
  }
}

enum DocumentFilterKey {
  name,
  owner,
  platformTypes,
  documentType,
}

extension on DocumentFilterKey {
  String toValue() {
    switch (this) {
      case DocumentFilterKey.name:
        return 'Name';
      case DocumentFilterKey.owner:
        return 'Owner';
      case DocumentFilterKey.platformTypes:
        return 'PlatformTypes';
      case DocumentFilterKey.documentType:
        return 'DocumentType';
    }
  }
}

extension on String {
  DocumentFilterKey toDocumentFilterKey() {
    switch (this) {
      case 'Name':
        return DocumentFilterKey.name;
      case 'Owner':
        return DocumentFilterKey.owner;
      case 'PlatformTypes':
        return DocumentFilterKey.platformTypes;
      case 'DocumentType':
        return DocumentFilterKey.documentType;
    }
    throw Exception('$this is not known in enum DocumentFilterKey');
  }
}

enum DocumentFormat {
  yaml,
  json,
  text,
}

extension on DocumentFormat {
  String toValue() {
    switch (this) {
      case DocumentFormat.yaml:
        return 'YAML';
      case DocumentFormat.json:
        return 'JSON';
      case DocumentFormat.text:
        return 'TEXT';
    }
  }
}

extension on String {
  DocumentFormat toDocumentFormat() {
    switch (this) {
      case 'YAML':
        return DocumentFormat.yaml;
      case 'JSON':
        return DocumentFormat.json;
      case 'TEXT':
        return DocumentFormat.text;
    }
    throw Exception('$this is not known in enum DocumentFormat');
  }
}

enum DocumentHashType {
  sha256,
  sha1,
}

extension on DocumentHashType {
  String toValue() {
    switch (this) {
      case DocumentHashType.sha256:
        return 'Sha256';
      case DocumentHashType.sha1:
        return 'Sha1';
    }
  }
}

extension on String {
  DocumentHashType toDocumentHashType() {
    switch (this) {
      case 'Sha256':
        return DocumentHashType.sha256;
      case 'Sha1':
        return DocumentHashType.sha1;
    }
    throw Exception('$this is not known in enum DocumentHashType');
  }
}

/// Describes the name of a Systems Manager document.
class DocumentIdentifier {
  /// The user in your organization who created the document.
  final String? author;

  /// The document format, either JSON or YAML.
  final DocumentFormat? documentFormat;

  /// The document type.
  final DocumentType? documentType;

  /// The document version.
  final String? documentVersion;

  /// The name of the Systems Manager document.
  final String? name;

  /// The AWS user account that created the document.
  final String? owner;

  /// The operating system platform.
  final List<PlatformType>? platformTypes;

  /// A list of SSM documents required by a document. For example, an
  /// <code>ApplicationConfiguration</code> document requires an
  /// <code>ApplicationConfigurationSchema</code> document.
  final List<DocumentRequires>? requires;

  /// The current status of a document review.
  final ReviewStatus? reviewStatus;

  /// The schema version.
  final String? schemaVersion;

  /// The tags, or metadata, that have been applied to the document.
  final List<Tag>? tags;

  /// The target type which defines the kinds of resources the document can run
  /// on. For example, /AWS::EC2::Instance. For a list of valid resource types,
  /// see <a
  /// href="http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html">AWS
  /// resource and property types reference</a> in the <i>AWS CloudFormation User
  /// Guide</i>.
  final String? targetType;

  /// An optional field specifying the version of the artifact associated with the
  /// document. For example, "Release 12, Update 6". This value is unique across
  /// all versions of a document, and cannot be changed.
  final String? versionName;

  DocumentIdentifier({
    this.author,
    this.documentFormat,
    this.documentType,
    this.documentVersion,
    this.name,
    this.owner,
    this.platformTypes,
    this.requires,
    this.reviewStatus,
    this.schemaVersion,
    this.tags,
    this.targetType,
    this.versionName,
  });
  factory DocumentIdentifier.fromJson(Map<String, dynamic> json) {
    return DocumentIdentifier(
      author: json['Author'] as String?,
      documentFormat: (json['DocumentFormat'] as String?)?.toDocumentFormat(),
      documentType: (json['DocumentType'] as String?)?.toDocumentType(),
      documentVersion: json['DocumentVersion'] as String?,
      name: json['Name'] as String?,
      owner: json['Owner'] as String?,
      platformTypes: (json['PlatformTypes'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toPlatformType())
          .toList(),
      requires: (json['Requires'] as List?)
          ?.whereNotNull()
          .map((e) => DocumentRequires.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewStatus: (json['ReviewStatus'] as String?)?.toReviewStatus(),
      schemaVersion: json['SchemaVersion'] as String?,
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetType: json['TargetType'] as String?,
      versionName: json['VersionName'] as String?,
    );
  }
}

/// One or more filters. Use a filter to return a more specific list of
/// documents.
///
/// For keys, you can specify one or more tags that have been applied to a
/// document.
///
/// You can also use AWS-provided keys, some of which have specific allowed
/// values. These keys and their associated values are as follows:
/// <dl> <dt>DocumentType</dt> <dd>
/// <ul>
/// <li>
/// ApplicationConfiguration
/// </li>
/// <li>
/// ApplicationConfigurationSchema
/// </li>
/// <li>
/// Automation
/// </li>
/// <li>
/// ChangeCalendar
/// </li>
/// <li>
/// Command
/// </li>
/// <li>
/// DeploymentStrategy
/// </li>
/// <li>
/// Package
/// </li>
/// <li>
/// Policy
/// </li>
/// <li>
/// Session
/// </li>
/// </ul> </dd> <dt>Owner</dt> <dd>
/// Note that only one <code>Owner</code> can be specified in a request. For
/// example: <code>Key=Owner,Values=Self</code>.
///
/// <ul>
/// <li>
/// Amazon
/// </li>
/// <li>
/// Private
/// </li>
/// <li>
/// Public
/// </li>
/// <li>
/// Self
/// </li>
/// <li>
/// ThirdParty
/// </li>
/// </ul> </dd> <dt>PlatformTypes</dt> <dd>
/// <ul>
/// <li>
/// Linux
/// </li>
/// <li>
/// Windows
/// </li>
/// </ul> </dd> </dl>
/// <code>Name</code> is another AWS-provided key. If you use <code>Name</code>
/// as a key, you can use a name prefix to return a list of documents. For
/// example, in the AWS CLI, to return a list of all documents that begin with
/// <code>Te</code>, run the following command:
///
/// <code>aws ssm list-documents --filters Key=Name,Values=Te</code>
///
/// You can also use the <code>TargetType</code> AWS-provided key. For a list of
/// valid resource type values that can be used with this key, see <a
/// href="http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html">AWS
/// resource and property types reference</a> in the <i>AWS CloudFormation User
/// Guide</i>.
///
/// If you specify more than two keys, only documents that are identified by all
/// the tags are returned in the results. If you specify more than two values
/// for a key, documents that are identified by any of the values are returned
/// in the results.
///
/// To specify a custom key and value pair, use the format
/// <code>Key=tag:tagName,Values=valueName</code>.
///
/// For example, if you created a key called region and are using the AWS CLI to
/// call the <code>list-documents</code> command:
///
/// <code>aws ssm list-documents --filters Key=tag:region,Values=east,west
/// Key=Owner,Values=Self</code>
class DocumentKeyValuesFilter {
  /// The name of the filter key.
  final String? key;

  /// The value for the filter key.
  final List<String>? values;

  DocumentKeyValuesFilter({
    this.key,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      if (key != null) 'Key': key,
      if (values != null) 'Values': values,
    };
  }
}

enum DocumentMetadataEnum {
  documentReviews,
}

extension on DocumentMetadataEnum {
  String toValue() {
    switch (this) {
      case DocumentMetadataEnum.documentReviews:
        return 'DocumentReviews';
    }
  }
}

extension on String {
  DocumentMetadataEnum toDocumentMetadataEnum() {
    switch (this) {
      case 'DocumentReviews':
        return DocumentMetadataEnum.documentReviews;
    }
    throw Exception('$this is not known in enum DocumentMetadataEnum');
  }
}

/// Details about the response to a document review request.
class DocumentMetadataResponseInfo {
  /// Details about a reviewer's response to a document review request.
  final List<DocumentReviewerResponseSource>? reviewerResponse;

  DocumentMetadataResponseInfo({
    this.reviewerResponse,
  });
  factory DocumentMetadataResponseInfo.fromJson(Map<String, dynamic> json) {
    return DocumentMetadataResponseInfo(
      reviewerResponse: (json['ReviewerResponse'] as List?)
          ?.whereNotNull()
          .map((e) => DocumentReviewerResponseSource.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Parameters specified in a System Manager document that run on the server
/// when the command is run.
class DocumentParameter {
  /// If specified, the default values for the parameters. Parameters without a
  /// default value are required. Parameters with a default value are optional.
  final String? defaultValue;

  /// A description of what the parameter does, how to use it, the default value,
  /// and whether or not the parameter is optional.
  final String? description;

  /// The name of the parameter.
  final String? name;

  /// The type of parameter. The type can be either String or StringList.
  final DocumentParameterType? type;

  DocumentParameter({
    this.defaultValue,
    this.description,
    this.name,
    this.type,
  });
  factory DocumentParameter.fromJson(Map<String, dynamic> json) {
    return DocumentParameter(
      defaultValue: json['DefaultValue'] as String?,
      description: json['Description'] as String?,
      name: json['Name'] as String?,
      type: (json['Type'] as String?)?.toDocumentParameterType(),
    );
  }
}

enum DocumentParameterType {
  string,
  stringList,
}

extension on DocumentParameterType {
  String toValue() {
    switch (this) {
      case DocumentParameterType.string:
        return 'String';
      case DocumentParameterType.stringList:
        return 'StringList';
    }
  }
}

extension on String {
  DocumentParameterType toDocumentParameterType() {
    switch (this) {
      case 'String':
        return DocumentParameterType.string;
      case 'StringList':
        return DocumentParameterType.stringList;
    }
    throw Exception('$this is not known in enum DocumentParameterType');
  }
}

enum DocumentPermissionType {
  share,
}

extension on DocumentPermissionType {
  String toValue() {
    switch (this) {
      case DocumentPermissionType.share:
        return 'Share';
    }
  }
}

extension on String {
  DocumentPermissionType toDocumentPermissionType() {
    switch (this) {
      case 'Share':
        return DocumentPermissionType.share;
    }
    throw Exception('$this is not known in enum DocumentPermissionType');
  }
}

/// An SSM document required by the current document.
class DocumentRequires {
  /// The name of the required SSM document. The name can be an Amazon Resource
  /// Name (ARN).
  final String name;

  /// The document version required by the current document.
  final String? version;

  DocumentRequires({
    required this.name,
    this.version,
  });
  factory DocumentRequires.fromJson(Map<String, dynamic> json) {
    return DocumentRequires(
      name: json['Name'] as String,
      version: json['Version'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final version = this.version;
    return {
      'Name': name,
      if (version != null) 'Version': version,
    };
  }
}

enum DocumentReviewAction {
  sendForReview,
  updateReview,
  approve,
  reject,
}

extension on DocumentReviewAction {
  String toValue() {
    switch (this) {
      case DocumentReviewAction.sendForReview:
        return 'SendForReview';
      case DocumentReviewAction.updateReview:
        return 'UpdateReview';
      case DocumentReviewAction.approve:
        return 'Approve';
      case DocumentReviewAction.reject:
        return 'Reject';
    }
  }
}

extension on String {
  DocumentReviewAction toDocumentReviewAction() {
    switch (this) {
      case 'SendForReview':
        return DocumentReviewAction.sendForReview;
      case 'UpdateReview':
        return DocumentReviewAction.updateReview;
      case 'Approve':
        return DocumentReviewAction.approve;
      case 'Reject':
        return DocumentReviewAction.reject;
    }
    throw Exception('$this is not known in enum DocumentReviewAction');
  }
}

/// Information about comments added to a document review request.
class DocumentReviewCommentSource {
  /// The content of a comment entered by a user who requests a review of a new
  /// document version, or who reviews the new version.
  final String? content;

  /// The type of information added to a review request. Currently, only the value
  /// <code>Comment</code> is supported.
  final DocumentReviewCommentType? type;

  DocumentReviewCommentSource({
    this.content,
    this.type,
  });
  factory DocumentReviewCommentSource.fromJson(Map<String, dynamic> json) {
    return DocumentReviewCommentSource(
      content: json['Content'] as String?,
      type: (json['Type'] as String?)?.toDocumentReviewCommentType(),
    );
  }

  Map<String, dynamic> toJson() {
    final content = this.content;
    final type = this.type;
    return {
      if (content != null) 'Content': content,
      if (type != null) 'Type': type.toValue(),
    };
  }
}

enum DocumentReviewCommentType {
  comment,
}

extension on DocumentReviewCommentType {
  String toValue() {
    switch (this) {
      case DocumentReviewCommentType.comment:
        return 'Comment';
    }
  }
}

extension on String {
  DocumentReviewCommentType toDocumentReviewCommentType() {
    switch (this) {
      case 'Comment':
        return DocumentReviewCommentType.comment;
    }
    throw Exception('$this is not known in enum DocumentReviewCommentType');
  }
}

/// Information about a reviewer's response to a document review request.
class DocumentReviewerResponseSource {
  /// The comment entered by a reviewer as part of their document review response.
  final List<DocumentReviewCommentSource>? comment;

  /// The date and time that a reviewer entered a response to a document review
  /// request.
  final DateTime? createTime;

  /// The current review status of a new custom SSM document created by a member
  /// of your organization, or of the latest version of an existing SSM document.
  ///
  /// Only one version of a document can be in the APPROVED state at a time. When
  /// a new version is approved, the status of the previous version changes to
  /// REJECTED.
  ///
  /// Only one version of a document can be in review, or PENDING, at a time.
  final ReviewStatus? reviewStatus;

  /// The user in your organization assigned to review a document request.
  final String? reviewer;

  /// The date and time that a reviewer last updated a response to a document
  /// review request.
  final DateTime? updatedTime;

  DocumentReviewerResponseSource({
    this.comment,
    this.createTime,
    this.reviewStatus,
    this.reviewer,
    this.updatedTime,
  });
  factory DocumentReviewerResponseSource.fromJson(Map<String, dynamic> json) {
    return DocumentReviewerResponseSource(
      comment: (json['Comment'] as List?)
          ?.whereNotNull()
          .map((e) =>
              DocumentReviewCommentSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      createTime: timeStampFromJson(json['CreateTime']),
      reviewStatus: (json['ReviewStatus'] as String?)?.toReviewStatus(),
      reviewer: json['Reviewer'] as String?,
      updatedTime: timeStampFromJson(json['UpdatedTime']),
    );
  }
}

/// Information about a document approval review.
class DocumentReviews {
  /// The action to take on a document approval review request.
  final DocumentReviewAction action;

  /// A comment entered by a user in your organization about the document review
  /// request.
  final List<DocumentReviewCommentSource>? comment;

  DocumentReviews({
    required this.action,
    this.comment,
  });
  Map<String, dynamic> toJson() {
    final action = this.action;
    final comment = this.comment;
    return {
      'Action': action.toValue(),
      if (comment != null) 'Comment': comment,
    };
  }
}

/// The status of a document.
enum DocumentStatus {
  creating,
  active,
  updating,
  deleting,
  failed,
}

extension on DocumentStatus {
  String toValue() {
    switch (this) {
      case DocumentStatus.creating:
        return 'Creating';
      case DocumentStatus.active:
        return 'Active';
      case DocumentStatus.updating:
        return 'Updating';
      case DocumentStatus.deleting:
        return 'Deleting';
      case DocumentStatus.failed:
        return 'Failed';
    }
  }
}

extension on String {
  DocumentStatus toDocumentStatus() {
    switch (this) {
      case 'Creating':
        return DocumentStatus.creating;
      case 'Active':
        return DocumentStatus.active;
      case 'Updating':
        return DocumentStatus.updating;
      case 'Deleting':
        return DocumentStatus.deleting;
      case 'Failed':
        return DocumentStatus.failed;
    }
    throw Exception('$this is not known in enum DocumentStatus');
  }
}

enum DocumentType {
  command,
  policy,
  automation,
  session,
  package,
  applicationConfiguration,
  applicationConfigurationSchema,
  deploymentStrategy,
  changeCalendar,
  automationChangeTemplate,
}

extension on DocumentType {
  String toValue() {
    switch (this) {
      case DocumentType.command:
        return 'Command';
      case DocumentType.policy:
        return 'Policy';
      case DocumentType.automation:
        return 'Automation';
      case DocumentType.session:
        return 'Session';
      case DocumentType.package:
        return 'Package';
      case DocumentType.applicationConfiguration:
        return 'ApplicationConfiguration';
      case DocumentType.applicationConfigurationSchema:
        return 'ApplicationConfigurationSchema';
      case DocumentType.deploymentStrategy:
        return 'DeploymentStrategy';
      case DocumentType.changeCalendar:
        return 'ChangeCalendar';
      case DocumentType.automationChangeTemplate:
        return 'Automation.ChangeTemplate';
    }
  }
}

extension on String {
  DocumentType toDocumentType() {
    switch (this) {
      case 'Command':
        return DocumentType.command;
      case 'Policy':
        return DocumentType.policy;
      case 'Automation':
        return DocumentType.automation;
      case 'Session':
        return DocumentType.session;
      case 'Package':
        return DocumentType.package;
      case 'ApplicationConfiguration':
        return DocumentType.applicationConfiguration;
      case 'ApplicationConfigurationSchema':
        return DocumentType.applicationConfigurationSchema;
      case 'DeploymentStrategy':
        return DocumentType.deploymentStrategy;
      case 'ChangeCalendar':
        return DocumentType.changeCalendar;
      case 'Automation.ChangeTemplate':
        return DocumentType.automationChangeTemplate;
    }
    throw Exception('$this is not known in enum DocumentType');
  }
}

/// Version information about the document.
class DocumentVersionInfo {
  /// The date the document was created.
  final DateTime? createdDate;

  /// The document format, either JSON or YAML.
  final DocumentFormat? documentFormat;

  /// The document version.
  final String? documentVersion;

  /// An identifier for the default version of the document.
  final bool? isDefaultVersion;

  /// The document name.
  final String? name;

  /// The current status of the approval review for the latest version of the
  /// document.
  final ReviewStatus? reviewStatus;

  /// The status of the Systems Manager document, such as <code>Creating</code>,
  /// <code>Active</code>, <code>Failed</code>, and <code>Deleting</code>.
  final DocumentStatus? status;

  /// A message returned by AWS Systems Manager that explains the
  /// <code>Status</code> value. For example, a <code>Failed</code> status might
  /// be explained by the <code>StatusInformation</code> message, "The specified
  /// S3 bucket does not exist. Verify that the URL of the S3 bucket is correct."
  final String? statusInformation;

  /// The version of the artifact associated with the document. For example,
  /// "Release 12, Update 6". This value is unique across all versions of a
  /// document, and cannot be changed.
  final String? versionName;

  DocumentVersionInfo({
    this.createdDate,
    this.documentFormat,
    this.documentVersion,
    this.isDefaultVersion,
    this.name,
    this.reviewStatus,
    this.status,
    this.statusInformation,
    this.versionName,
  });
  factory DocumentVersionInfo.fromJson(Map<String, dynamic> json) {
    return DocumentVersionInfo(
      createdDate: timeStampFromJson(json['CreatedDate']),
      documentFormat: (json['DocumentFormat'] as String?)?.toDocumentFormat(),
      documentVersion: json['DocumentVersion'] as String?,
      isDefaultVersion: json['IsDefaultVersion'] as bool?,
      name: json['Name'] as String?,
      reviewStatus: (json['ReviewStatus'] as String?)?.toReviewStatus(),
      status: (json['Status'] as String?)?.toDocumentStatus(),
      statusInformation: json['StatusInformation'] as String?,
      versionName: json['VersionName'] as String?,
    );
  }
}

/// The EffectivePatch structure defines metadata about a patch along with the
/// approval state of the patch in a particular patch baseline. The approval
/// state includes information about whether the patch is currently approved,
/// due to be approved by a rule, explicitly approved, or explicitly rejected
/// and the date the patch was or will be approved.
class EffectivePatch {
  /// Provides metadata for a patch, including information such as the KB ID,
  /// severity, classification and a URL for where more information can be
  /// obtained about the patch.
  final Patch? patch;

  /// The status of the patch in a patch baseline. This includes information about
  /// whether the patch is currently approved, due to be approved by a rule,
  /// explicitly approved, or explicitly rejected and the date the patch was or
  /// will be approved.
  final PatchStatus? patchStatus;

  EffectivePatch({
    this.patch,
    this.patchStatus,
  });
  factory EffectivePatch.fromJson(Map<String, dynamic> json) {
    return EffectivePatch(
      patch: json['Patch'] != null
          ? Patch.fromJson(json['Patch'] as Map<String, dynamic>)
          : null,
      patchStatus: json['PatchStatus'] != null
          ? PatchStatus.fromJson(json['PatchStatus'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum ExecutionMode {
  auto,
  interactive,
}

extension on ExecutionMode {
  String toValue() {
    switch (this) {
      case ExecutionMode.auto:
        return 'Auto';
      case ExecutionMode.interactive:
        return 'Interactive';
    }
  }
}

extension on String {
  ExecutionMode toExecutionMode() {
    switch (this) {
      case 'Auto':
        return ExecutionMode.auto;
      case 'Interactive':
        return ExecutionMode.interactive;
    }
    throw Exception('$this is not known in enum ExecutionMode');
  }
}

/// Describes a failed association.
class FailedCreateAssociation {
  /// The association.
  final CreateAssociationBatchRequestEntry? entry;

  /// The source of the failure.
  final Fault? fault;

  /// A description of the failure.
  final String? message;

  FailedCreateAssociation({
    this.entry,
    this.fault,
    this.message,
  });
  factory FailedCreateAssociation.fromJson(Map<String, dynamic> json) {
    return FailedCreateAssociation(
      entry: json['Entry'] != null
          ? CreateAssociationBatchRequestEntry.fromJson(
              json['Entry'] as Map<String, dynamic>)
          : null,
      fault: (json['Fault'] as String?)?.toFault(),
      message: json['Message'] as String?,
    );
  }
}

/// Information about an Automation failure.
class FailureDetails {
  /// Detailed information about the Automation step failure.
  final Map<String, List<String>>? details;

  /// The stage of the Automation execution when the failure occurred. The stages
  /// include the following: InputValidation, PreVerification, Invocation,
  /// PostVerification.
  final String? failureStage;

  /// The type of Automation failure. Failure types include the following: Action,
  /// Permission, Throttling, Verification, Internal.
  final String? failureType;

  FailureDetails({
    this.details,
    this.failureStage,
    this.failureType,
  });
  factory FailureDetails.fromJson(Map<String, dynamic> json) {
    return FailureDetails(
      details: (json['Details'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      failureStage: json['FailureStage'] as String?,
      failureType: json['FailureType'] as String?,
    );
  }
}

enum Fault {
  client,
  server,
  unknown,
}

extension on Fault {
  String toValue() {
    switch (this) {
      case Fault.client:
        return 'Client';
      case Fault.server:
        return 'Server';
      case Fault.unknown:
        return 'Unknown';
    }
  }
}

extension on String {
  Fault toFault() {
    switch (this) {
      case 'Client':
        return Fault.client;
      case 'Server':
        return Fault.server;
      case 'Unknown':
        return Fault.unknown;
    }
    throw Exception('$this is not known in enum Fault');
  }
}

class GetAutomationExecutionResult {
  /// Detailed information about the current state of an automation execution.
  final AutomationExecution? automationExecution;

  GetAutomationExecutionResult({
    this.automationExecution,
  });
  factory GetAutomationExecutionResult.fromJson(Map<String, dynamic> json) {
    return GetAutomationExecutionResult(
      automationExecution: json['AutomationExecution'] != null
          ? AutomationExecution.fromJson(
              json['AutomationExecution'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetCalendarStateResponse {
  /// The time, as an <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO
  /// 8601</a> string, that you specified in your command. If you did not specify
  /// a time, <code>GetCalendarState</code> uses the current time.
  final String? atTime;

  /// The time, as an <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO
  /// 8601</a> string, that the calendar state will change. If the current
  /// calendar state is <code>OPEN</code>, <code>NextTransitionTime</code>
  /// indicates when the calendar state changes to <code>CLOSED</code>, and
  /// vice-versa.
  final String? nextTransitionTime;

  /// The state of the calendar. An <code>OPEN</code> calendar indicates that
  /// actions are allowed to proceed, and a <code>CLOSED</code> calendar indicates
  /// that actions are not allowed to proceed.
  final CalendarState? state;

  GetCalendarStateResponse({
    this.atTime,
    this.nextTransitionTime,
    this.state,
  });
  factory GetCalendarStateResponse.fromJson(Map<String, dynamic> json) {
    return GetCalendarStateResponse(
      atTime: json['AtTime'] as String?,
      nextTransitionTime: json['NextTransitionTime'] as String?,
      state: (json['State'] as String?)?.toCalendarState(),
    );
  }
}

class GetCommandInvocationResult {
  /// CloudWatch Logs information where Systems Manager sent the command output.
  final CloudWatchOutputConfig? cloudWatchOutputConfig;

  /// The parent command ID of the invocation plugin.
  final String? commandId;

  /// The comment text for the command.
  final String? comment;

  /// The name of the document that was run. For example, AWS-RunShellScript.
  final String? documentName;

  /// The SSM document version used in the request.
  final String? documentVersion;

  /// Duration since ExecutionStartDateTime.
  final String? executionElapsedTime;

  /// The date and time the plugin was finished running. Date and time are written
  /// in ISO 8601 format. For example, June 7, 2017 is represented as 2017-06-7.
  /// The following sample AWS CLI command uses the <code>InvokedAfter</code>
  /// filter.
  ///
  /// <code>aws ssm list-commands --filters
  /// key=InvokedAfter,value=2017-06-07T00:00:00Z</code>
  ///
  /// If the plugin has not started to run, the string is empty.
  final String? executionEndDateTime;

  /// The date and time the plugin started running. Date and time are written in
  /// ISO 8601 format. For example, June 7, 2017 is represented as 2017-06-7. The
  /// following sample AWS CLI command uses the <code>InvokedBefore</code> filter.
  ///
  /// <code>aws ssm list-commands --filters
  /// key=InvokedBefore,value=2017-06-07T00:00:00Z</code>
  ///
  /// If the plugin has not started to run, the string is empty.
  final String? executionStartDateTime;

  /// The ID of the managed instance targeted by the command. A managed instance
  /// can be an EC2 instance or an instance in your hybrid environment that is
  /// configured for Systems Manager.
  final String? instanceId;

  /// The name of the plugin for which you want detailed results. For example,
  /// aws:RunShellScript is a plugin.
  final String? pluginName;

  /// The error level response code for the plugin script. If the response code is
  /// -1, then the command has not started running on the instance, or it was not
  /// received by the instance.
  final int? responseCode;

  /// The first 8,000 characters written by the plugin to stderr. If the command
  /// has not finished running, then this string is empty.
  final String? standardErrorContent;

  /// The URL for the complete text written by the plugin to stderr. If the
  /// command has not finished running, then this string is empty.
  final String? standardErrorUrl;

  /// The first 24,000 characters written by the plugin to stdout. If the command
  /// has not finished running, if ExecutionStatus is neither Succeeded nor
  /// Failed, then this string is empty.
  final String? standardOutputContent;

  /// The URL for the complete text written by the plugin to stdout in Amazon S3.
  /// If an S3 bucket was not specified, then this string is empty.
  final String? standardOutputUrl;

  /// The status of this invocation plugin. This status can be different than
  /// StatusDetails.
  final CommandInvocationStatus? status;

  /// A detailed status of the command execution for an invocation. StatusDetails
  /// includes more information than Status because it includes states resulting
  /// from error and concurrency control parameters. StatusDetails can show
  /// different results than Status. For more information about these statuses,
  /// see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html">Understanding
  /// command statuses</a> in the <i>AWS Systems Manager User Guide</i>.
  /// StatusDetails can be one of the following values:
  ///
  /// <ul>
  /// <li>
  /// Pending: The command has not been sent to the instance.
  /// </li>
  /// <li>
  /// In Progress: The command has been sent to the instance but has not reached a
  /// terminal state.
  /// </li>
  /// <li>
  /// Delayed: The system attempted to send the command to the target, but the
  /// target was not available. The instance might not be available because of
  /// network issues, because the instance was stopped, or for similar reasons.
  /// The system will try to send the command again.
  /// </li>
  /// <li>
  /// Success: The command or plugin ran successfully. This is a terminal state.
  /// </li>
  /// <li>
  /// Delivery Timed Out: The command was not delivered to the instance before the
  /// delivery timeout expired. Delivery timeouts do not count against the parent
  /// command's MaxErrors limit, but they do contribute to whether the parent
  /// command status is Success or Incomplete. This is a terminal state.
  /// </li>
  /// <li>
  /// Execution Timed Out: The command started to run on the instance, but the
  /// execution was not complete before the timeout expired. Execution timeouts
  /// count against the MaxErrors limit of the parent command. This is a terminal
  /// state.
  /// </li>
  /// <li>
  /// Failed: The command wasn't run successfully on the instance. For a plugin,
  /// this indicates that the result code was not zero. For a command invocation,
  /// this indicates that the result code for one or more plugins was not zero.
  /// Invocation failures count against the MaxErrors limit of the parent command.
  /// This is a terminal state.
  /// </li>
  /// <li>
  /// Canceled: The command was terminated before it was completed. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Undeliverable: The command can't be delivered to the instance. The instance
  /// might not exist or might not be responding. Undeliverable invocations don't
  /// count against the parent command's MaxErrors limit and don't contribute to
  /// whether the parent command status is Success or Incomplete. This is a
  /// terminal state.
  /// </li>
  /// <li>
  /// Terminated: The parent command exceeded its MaxErrors limit and subsequent
  /// command invocations were canceled by the system. This is a terminal state.
  /// </li>
  /// </ul>
  final String? statusDetails;

  GetCommandInvocationResult({
    this.cloudWatchOutputConfig,
    this.commandId,
    this.comment,
    this.documentName,
    this.documentVersion,
    this.executionElapsedTime,
    this.executionEndDateTime,
    this.executionStartDateTime,
    this.instanceId,
    this.pluginName,
    this.responseCode,
    this.standardErrorContent,
    this.standardErrorUrl,
    this.standardOutputContent,
    this.standardOutputUrl,
    this.status,
    this.statusDetails,
  });
  factory GetCommandInvocationResult.fromJson(Map<String, dynamic> json) {
    return GetCommandInvocationResult(
      cloudWatchOutputConfig: json['CloudWatchOutputConfig'] != null
          ? CloudWatchOutputConfig.fromJson(
              json['CloudWatchOutputConfig'] as Map<String, dynamic>)
          : null,
      commandId: json['CommandId'] as String?,
      comment: json['Comment'] as String?,
      documentName: json['DocumentName'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      executionElapsedTime: json['ExecutionElapsedTime'] as String?,
      executionEndDateTime: json['ExecutionEndDateTime'] as String?,
      executionStartDateTime: json['ExecutionStartDateTime'] as String?,
      instanceId: json['InstanceId'] as String?,
      pluginName: json['PluginName'] as String?,
      responseCode: json['ResponseCode'] as int?,
      standardErrorContent: json['StandardErrorContent'] as String?,
      standardErrorUrl: json['StandardErrorUrl'] as String?,
      standardOutputContent: json['StandardOutputContent'] as String?,
      standardOutputUrl: json['StandardOutputUrl'] as String?,
      status: (json['Status'] as String?)?.toCommandInvocationStatus(),
      statusDetails: json['StatusDetails'] as String?,
    );
  }
}

class GetConnectionStatusResponse {
  /// The status of the connection to the instance. For example, 'Connected' or
  /// 'Not Connected'.
  final ConnectionStatus? status;

  /// The ID of the instance to check connection status.
  final String? target;

  GetConnectionStatusResponse({
    this.status,
    this.target,
  });
  factory GetConnectionStatusResponse.fromJson(Map<String, dynamic> json) {
    return GetConnectionStatusResponse(
      status: (json['Status'] as String?)?.toConnectionStatus(),
      target: json['Target'] as String?,
    );
  }
}

class GetDefaultPatchBaselineResult {
  /// The ID of the default patch baseline.
  final String? baselineId;

  /// The operating system for the returned patch baseline.
  final OperatingSystem? operatingSystem;

  GetDefaultPatchBaselineResult({
    this.baselineId,
    this.operatingSystem,
  });
  factory GetDefaultPatchBaselineResult.fromJson(Map<String, dynamic> json) {
    return GetDefaultPatchBaselineResult(
      baselineId: json['BaselineId'] as String?,
      operatingSystem:
          (json['OperatingSystem'] as String?)?.toOperatingSystem(),
    );
  }
}

class GetDeployablePatchSnapshotForInstanceResult {
  /// The ID of the instance.
  final String? instanceId;

  /// Returns the specific operating system (for example Windows Server 2012 or
  /// Amazon Linux 2015.09) on the instance for the specified patch snapshot.
  final String? product;

  /// A pre-signed Amazon S3 URL that can be used to download the patch snapshot.
  final String? snapshotDownloadUrl;

  /// The user-defined snapshot ID.
  final String? snapshotId;

  GetDeployablePatchSnapshotForInstanceResult({
    this.instanceId,
    this.product,
    this.snapshotDownloadUrl,
    this.snapshotId,
  });
  factory GetDeployablePatchSnapshotForInstanceResult.fromJson(
      Map<String, dynamic> json) {
    return GetDeployablePatchSnapshotForInstanceResult(
      instanceId: json['InstanceId'] as String?,
      product: json['Product'] as String?,
      snapshotDownloadUrl: json['SnapshotDownloadUrl'] as String?,
      snapshotId: json['SnapshotId'] as String?,
    );
  }
}

class GetDocumentResult {
  /// A description of the document attachments, including names, locations,
  /// sizes, and so on.
  final List<AttachmentContent>? attachmentsContent;

  /// The contents of the Systems Manager document.
  final String? content;

  /// The document format, either JSON or YAML.
  final DocumentFormat? documentFormat;

  /// The document type.
  final DocumentType? documentType;

  /// The document version.
  final String? documentVersion;

  /// The name of the Systems Manager document.
  final String? name;

  /// A list of SSM documents required by a document. For example, an
  /// <code>ApplicationConfiguration</code> document requires an
  /// <code>ApplicationConfigurationSchema</code> document.
  final List<DocumentRequires>? requires;

  /// The current review status of a new custom Systems Manager document (SSM
  /// document) created by a member of your organization, or of the latest version
  /// of an existing SSM document.
  ///
  /// Only one version of an SSM document can be in the APPROVED state at a time.
  /// When a new version is approved, the status of the previous version changes
  /// to REJECTED.
  ///
  /// Only one version of an SSM document can be in review, or PENDING, at a time.
  final ReviewStatus? reviewStatus;

  /// The status of the Systems Manager document, such as <code>Creating</code>,
  /// <code>Active</code>, <code>Updating</code>, <code>Failed</code>, and
  /// <code>Deleting</code>.
  final DocumentStatus? status;

  /// A message returned by AWS Systems Manager that explains the
  /// <code>Status</code> value. For example, a <code>Failed</code> status might
  /// be explained by the <code>StatusInformation</code> message, "The specified
  /// S3 bucket does not exist. Verify that the URL of the S3 bucket is correct."
  final String? statusInformation;

  /// The version of the artifact associated with the document. For example,
  /// "Release 12, Update 6". This value is unique across all versions of a
  /// document, and cannot be changed.
  final String? versionName;

  GetDocumentResult({
    this.attachmentsContent,
    this.content,
    this.documentFormat,
    this.documentType,
    this.documentVersion,
    this.name,
    this.requires,
    this.reviewStatus,
    this.status,
    this.statusInformation,
    this.versionName,
  });
  factory GetDocumentResult.fromJson(Map<String, dynamic> json) {
    return GetDocumentResult(
      attachmentsContent: (json['AttachmentsContent'] as List?)
          ?.whereNotNull()
          .map((e) => AttachmentContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['Content'] as String?,
      documentFormat: (json['DocumentFormat'] as String?)?.toDocumentFormat(),
      documentType: (json['DocumentType'] as String?)?.toDocumentType(),
      documentVersion: json['DocumentVersion'] as String?,
      name: json['Name'] as String?,
      requires: (json['Requires'] as List?)
          ?.whereNotNull()
          .map((e) => DocumentRequires.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewStatus: (json['ReviewStatus'] as String?)?.toReviewStatus(),
      status: (json['Status'] as String?)?.toDocumentStatus(),
      statusInformation: json['StatusInformation'] as String?,
      versionName: json['VersionName'] as String?,
    );
  }
}

class GetInventoryResult {
  /// Collection of inventory entities such as a collection of instance inventory.
  final List<InventoryResultEntity>? entities;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  GetInventoryResult({
    this.entities,
    this.nextToken,
  });
  factory GetInventoryResult.fromJson(Map<String, dynamic> json) {
    return GetInventoryResult(
      entities: (json['Entities'] as List?)
          ?.whereNotNull()
          .map((e) => InventoryResultEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class GetInventorySchemaResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// Inventory schemas returned by the request.
  final List<InventoryItemSchema>? schemas;

  GetInventorySchemaResult({
    this.nextToken,
    this.schemas,
  });
  factory GetInventorySchemaResult.fromJson(Map<String, dynamic> json) {
    return GetInventorySchemaResult(
      nextToken: json['NextToken'] as String?,
      schemas: (json['Schemas'] as List?)
          ?.whereNotNull()
          .map((e) => InventoryItemSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetMaintenanceWindowExecutionResult {
  /// The time the maintenance window finished running.
  final DateTime? endTime;

  /// The time the maintenance window started running.
  final DateTime? startTime;

  /// The status of the maintenance window execution.
  final MaintenanceWindowExecutionStatus? status;

  /// The details explaining the Status. Only available for certain status values.
  final String? statusDetails;

  /// The ID of the task executions from the maintenance window execution.
  final List<String>? taskIds;

  /// The ID of the maintenance window execution.
  final String? windowExecutionId;

  GetMaintenanceWindowExecutionResult({
    this.endTime,
    this.startTime,
    this.status,
    this.statusDetails,
    this.taskIds,
    this.windowExecutionId,
  });
  factory GetMaintenanceWindowExecutionResult.fromJson(
      Map<String, dynamic> json) {
    return GetMaintenanceWindowExecutionResult(
      endTime: timeStampFromJson(json['EndTime']),
      startTime: timeStampFromJson(json['StartTime']),
      status: (json['Status'] as String?)?.toMaintenanceWindowExecutionStatus(),
      statusDetails: json['StatusDetails'] as String?,
      taskIds: (json['TaskIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      windowExecutionId: json['WindowExecutionId'] as String?,
    );
  }
}

class GetMaintenanceWindowExecutionTaskInvocationResult {
  /// The time that the task finished running on the target.
  final DateTime? endTime;

  /// The execution ID.
  final String? executionId;

  /// The invocation ID.
  final String? invocationId;

  /// User-provided value to be included in any CloudWatch events raised while
  /// running tasks for these targets in this maintenance window.
  final String? ownerInformation;

  /// The parameters used at the time that the task ran.
  final String? parameters;

  /// The time that the task started running on the target.
  final DateTime? startTime;

  /// The task status for an invocation.
  final MaintenanceWindowExecutionStatus? status;

  /// The details explaining the status. Details are only available for certain
  /// status values.
  final String? statusDetails;

  /// The task execution ID.
  final String? taskExecutionId;

  /// Retrieves the task type for a maintenance window. Task types include the
  /// following: LAMBDA, STEP_FUNCTIONS, AUTOMATION, RUN_COMMAND.
  final MaintenanceWindowTaskType? taskType;

  /// The maintenance window execution ID.
  final String? windowExecutionId;

  /// The maintenance window target ID.
  final String? windowTargetId;

  GetMaintenanceWindowExecutionTaskInvocationResult({
    this.endTime,
    this.executionId,
    this.invocationId,
    this.ownerInformation,
    this.parameters,
    this.startTime,
    this.status,
    this.statusDetails,
    this.taskExecutionId,
    this.taskType,
    this.windowExecutionId,
    this.windowTargetId,
  });
  factory GetMaintenanceWindowExecutionTaskInvocationResult.fromJson(
      Map<String, dynamic> json) {
    return GetMaintenanceWindowExecutionTaskInvocationResult(
      endTime: timeStampFromJson(json['EndTime']),
      executionId: json['ExecutionId'] as String?,
      invocationId: json['InvocationId'] as String?,
      ownerInformation: json['OwnerInformation'] as String?,
      parameters: json['Parameters'] as String?,
      startTime: timeStampFromJson(json['StartTime']),
      status: (json['Status'] as String?)?.toMaintenanceWindowExecutionStatus(),
      statusDetails: json['StatusDetails'] as String?,
      taskExecutionId: json['TaskExecutionId'] as String?,
      taskType: (json['TaskType'] as String?)?.toMaintenanceWindowTaskType(),
      windowExecutionId: json['WindowExecutionId'] as String?,
      windowTargetId: json['WindowTargetId'] as String?,
    );
  }
}

class GetMaintenanceWindowExecutionTaskResult {
  /// The time the task execution completed.
  final DateTime? endTime;

  /// The defined maximum number of task executions that could be run in parallel.
  final String? maxConcurrency;

  /// The defined maximum number of task execution errors allowed before
  /// scheduling of the task execution would have been stopped.
  final String? maxErrors;

  /// The priority of the task.
  final int? priority;

  /// The role that was assumed when running the task.
  final String? serviceRole;

  /// The time the task execution started.
  final DateTime? startTime;

  /// The status of the task.
  final MaintenanceWindowExecutionStatus? status;

  /// The details explaining the Status. Only available for certain status values.
  final String? statusDetails;

  /// The ARN of the task that ran.
  final String? taskArn;

  /// The ID of the specific task execution in the maintenance window task that
  /// was retrieved.
  final String? taskExecutionId;

  /// The parameters passed to the task when it was run.
  /// <note>
  /// <code>TaskParameters</code> has been deprecated. To specify parameters to
  /// pass to a task when it runs, instead use the <code>Parameters</code> option
  /// in the <code>TaskInvocationParameters</code> structure. For information
  /// about how Systems Manager handles these options for the supported
  /// maintenance window task types, see
  /// <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  /// The map has the following format:
  ///
  /// Key: string, between 1 and 255 characters
  ///
  /// Value: an array of strings, each string is between 1 and 255 characters
  final List<Map<String, MaintenanceWindowTaskParameterValueExpression>>?
      taskParameters;

  /// The type of task that was run.
  final MaintenanceWindowTaskType? type;

  /// The ID of the maintenance window execution that includes the task.
  final String? windowExecutionId;

  GetMaintenanceWindowExecutionTaskResult({
    this.endTime,
    this.maxConcurrency,
    this.maxErrors,
    this.priority,
    this.serviceRole,
    this.startTime,
    this.status,
    this.statusDetails,
    this.taskArn,
    this.taskExecutionId,
    this.taskParameters,
    this.type,
    this.windowExecutionId,
  });
  factory GetMaintenanceWindowExecutionTaskResult.fromJson(
      Map<String, dynamic> json) {
    return GetMaintenanceWindowExecutionTaskResult(
      endTime: timeStampFromJson(json['EndTime']),
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      priority: json['Priority'] as int?,
      serviceRole: json['ServiceRole'] as String?,
      startTime: timeStampFromJson(json['StartTime']),
      status: (json['Status'] as String?)?.toMaintenanceWindowExecutionStatus(),
      statusDetails: json['StatusDetails'] as String?,
      taskArn: json['TaskArn'] as String?,
      taskExecutionId: json['TaskExecutionId'] as String?,
      taskParameters: (json['TaskParameters'] as List?)
          ?.whereNotNull()
          .map((e) => (e as Map<String, dynamic>).map((k, e) => MapEntry(
              k,
              MaintenanceWindowTaskParameterValueExpression.fromJson(
                  e as Map<String, dynamic>))))
          .toList(),
      type: (json['Type'] as String?)?.toMaintenanceWindowTaskType(),
      windowExecutionId: json['WindowExecutionId'] as String?,
    );
  }
}

class GetMaintenanceWindowResult {
  /// Whether targets must be registered with the maintenance window before tasks
  /// can be defined for those targets.
  final bool? allowUnassociatedTargets;

  /// The date the maintenance window was created.
  final DateTime? createdDate;

  /// The number of hours before the end of the maintenance window that Systems
  /// Manager stops scheduling new tasks for execution.
  final int? cutoff;

  /// The description of the maintenance window.
  final String? description;

  /// The duration of the maintenance window in hours.
  final int? duration;

  /// Indicates whether the maintenance window is enabled.
  final bool? enabled;

  /// The date and time, in ISO-8601 Extended format, for when the maintenance
  /// window is scheduled to become inactive. The maintenance window will not run
  /// after this specified time.
  final String? endDate;

  /// The date the maintenance window was last modified.
  final DateTime? modifiedDate;

  /// The name of the maintenance window.
  final String? name;

  /// The next time the maintenance window will actually run, taking into account
  /// any specified times for the maintenance window to become active or inactive.
  final String? nextExecutionTime;

  /// The schedule of the maintenance window in the form of a cron or rate
  /// expression.
  final String? schedule;

  /// The number of days to wait to run a maintenance window after the scheduled
  /// CRON expression date and time.
  final int? scheduleOffset;

  /// The time zone that the scheduled maintenance window executions are based on,
  /// in Internet Assigned Numbers Authority (IANA) format. For example:
  /// "America/Los_Angeles", "UTC", or "Asia/Seoul". For more information, see the
  /// <a href="https://www.iana.org/time-zones">Time Zone Database</a> on the IANA
  /// website.
  final String? scheduleTimezone;

  /// The date and time, in ISO-8601 Extended format, for when the maintenance
  /// window is scheduled to become active. The maintenance window will not run
  /// before this specified time.
  final String? startDate;

  /// The ID of the created maintenance window.
  final String? windowId;

  GetMaintenanceWindowResult({
    this.allowUnassociatedTargets,
    this.createdDate,
    this.cutoff,
    this.description,
    this.duration,
    this.enabled,
    this.endDate,
    this.modifiedDate,
    this.name,
    this.nextExecutionTime,
    this.schedule,
    this.scheduleOffset,
    this.scheduleTimezone,
    this.startDate,
    this.windowId,
  });
  factory GetMaintenanceWindowResult.fromJson(Map<String, dynamic> json) {
    return GetMaintenanceWindowResult(
      allowUnassociatedTargets: json['AllowUnassociatedTargets'] as bool?,
      createdDate: timeStampFromJson(json['CreatedDate']),
      cutoff: json['Cutoff'] as int?,
      description: json['Description'] as String?,
      duration: json['Duration'] as int?,
      enabled: json['Enabled'] as bool?,
      endDate: json['EndDate'] as String?,
      modifiedDate: timeStampFromJson(json['ModifiedDate']),
      name: json['Name'] as String?,
      nextExecutionTime: json['NextExecutionTime'] as String?,
      schedule: json['Schedule'] as String?,
      scheduleOffset: json['ScheduleOffset'] as int?,
      scheduleTimezone: json['ScheduleTimezone'] as String?,
      startDate: json['StartDate'] as String?,
      windowId: json['WindowId'] as String?,
    );
  }
}

class GetMaintenanceWindowTaskResult {
  /// The retrieved task description.
  final String? description;

  /// The location in Amazon S3 where the task results are logged.
  /// <note>
  /// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
  /// contain logs, instead use the <code>OutputS3BucketName</code> and
  /// <code>OutputS3KeyPrefix</code> options in the
  /// <code>TaskInvocationParameters</code> structure. For information about how
  /// Systems Manager handles these options for the supported maintenance window
  /// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  final LoggingInfo? loggingInfo;

  /// The maximum number of targets allowed to run this task in parallel.
  /// <note>
  /// For maintenance window tasks without a target specified, you cannot supply a
  /// value for this option. Instead, the system inserts a placeholder value of
  /// <code>1</code>, which may be reported in the response to this command. This
  /// value does not affect the running of your task and can be ignored.
  /// </note>
  final String? maxConcurrency;

  /// The maximum number of errors allowed before the task stops being scheduled.
  /// <note>
  /// For maintenance window tasks without a target specified, you cannot supply a
  /// value for this option. Instead, the system inserts a placeholder value of
  /// <code>1</code>, which may be reported in the response to this command. This
  /// value does not affect the running of your task and can be ignored.
  /// </note>
  final String? maxErrors;

  /// The retrieved task name.
  final String? name;

  /// The priority of the task when it runs. The lower the number, the higher the
  /// priority. Tasks that have the same priority are scheduled in parallel.
  final int? priority;

  /// The ARN of the IAM service role to use to publish Amazon Simple Notification
  /// Service (Amazon SNS) notifications for maintenance window Run Command tasks.
  final String? serviceRoleArn;

  /// The targets where the task should run.
  final List<Target>? targets;

  /// The resource that the task used during execution. For RUN_COMMAND and
  /// AUTOMATION task types, the TaskArn is the Systems Manager Document name/ARN.
  /// For LAMBDA tasks, the value is the function name/ARN. For STEP_FUNCTIONS
  /// tasks, the value is the state machine ARN.
  final String? taskArn;

  /// The parameters to pass to the task when it runs.
  final MaintenanceWindowTaskInvocationParameters? taskInvocationParameters;

  /// The parameters to pass to the task when it runs.
  /// <note>
  /// <code>TaskParameters</code> has been deprecated. To specify parameters to
  /// pass to a task when it runs, instead use the <code>Parameters</code> option
  /// in the <code>TaskInvocationParameters</code> structure. For information
  /// about how Systems Manager handles these options for the supported
  /// maintenance window task types, see
  /// <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  final Map<String, MaintenanceWindowTaskParameterValueExpression>?
      taskParameters;

  /// The type of task to run.
  final MaintenanceWindowTaskType? taskType;

  /// The retrieved maintenance window ID.
  final String? windowId;

  /// The retrieved maintenance window task ID.
  final String? windowTaskId;

  GetMaintenanceWindowTaskResult({
    this.description,
    this.loggingInfo,
    this.maxConcurrency,
    this.maxErrors,
    this.name,
    this.priority,
    this.serviceRoleArn,
    this.targets,
    this.taskArn,
    this.taskInvocationParameters,
    this.taskParameters,
    this.taskType,
    this.windowId,
    this.windowTaskId,
  });
  factory GetMaintenanceWindowTaskResult.fromJson(Map<String, dynamic> json) {
    return GetMaintenanceWindowTaskResult(
      description: json['Description'] as String?,
      loggingInfo: json['LoggingInfo'] != null
          ? LoggingInfo.fromJson(json['LoggingInfo'] as Map<String, dynamic>)
          : null,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      name: json['Name'] as String?,
      priority: json['Priority'] as int?,
      serviceRoleArn: json['ServiceRoleArn'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskArn: json['TaskArn'] as String?,
      taskInvocationParameters: json['TaskInvocationParameters'] != null
          ? MaintenanceWindowTaskInvocationParameters.fromJson(
              json['TaskInvocationParameters'] as Map<String, dynamic>)
          : null,
      taskParameters: (json['TaskParameters'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k,
              MaintenanceWindowTaskParameterValueExpression.fromJson(
                  e as Map<String, dynamic>))),
      taskType: (json['TaskType'] as String?)?.toMaintenanceWindowTaskType(),
      windowId: json['WindowId'] as String?,
      windowTaskId: json['WindowTaskId'] as String?,
    );
  }
}

class GetOpsItemResponse {
  /// The OpsItem.
  final OpsItem? opsItem;

  GetOpsItemResponse({
    this.opsItem,
  });
  factory GetOpsItemResponse.fromJson(Map<String, dynamic> json) {
    return GetOpsItemResponse(
      opsItem: json['OpsItem'] != null
          ? OpsItem.fromJson(json['OpsItem'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetOpsMetadataResult {
  /// OpsMetadata for an Application Manager application.
  final Map<String, MetadataValue>? metadata;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  /// The resource ID of the Application Manager application.
  final String? resourceId;

  GetOpsMetadataResult({
    this.metadata,
    this.nextToken,
    this.resourceId,
  });
  factory GetOpsMetadataResult.fromJson(Map<String, dynamic> json) {
    return GetOpsMetadataResult(
      metadata: (json['Metadata'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(k, MetadataValue.fromJson(e as Map<String, dynamic>))),
      nextToken: json['NextToken'] as String?,
      resourceId: json['ResourceId'] as String?,
    );
  }
}

class GetOpsSummaryResult {
  /// The list of aggregated and filtered OpsItems.
  final List<OpsEntity>? entities;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  GetOpsSummaryResult({
    this.entities,
    this.nextToken,
  });
  factory GetOpsSummaryResult.fromJson(Map<String, dynamic> json) {
    return GetOpsSummaryResult(
      entities: (json['Entities'] as List?)
          ?.whereNotNull()
          .map((e) => OpsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class GetParameterHistoryResult {
  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// A list of parameters returned by the request.
  final List<ParameterHistory>? parameters;

  GetParameterHistoryResult({
    this.nextToken,
    this.parameters,
  });
  factory GetParameterHistoryResult.fromJson(Map<String, dynamic> json) {
    return GetParameterHistoryResult(
      nextToken: json['NextToken'] as String?,
      parameters: (json['Parameters'] as List?)
          ?.whereNotNull()
          .map((e) => ParameterHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetParameterResult {
  /// Information about a parameter.
  final Parameter? parameter;

  GetParameterResult({
    this.parameter,
  });
  factory GetParameterResult.fromJson(Map<String, dynamic> json) {
    return GetParameterResult(
      parameter: json['Parameter'] != null
          ? Parameter.fromJson(json['Parameter'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetParametersByPathResult {
  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  /// A list of parameters found in the specified hierarchy.
  final List<Parameter>? parameters;

  GetParametersByPathResult({
    this.nextToken,
    this.parameters,
  });
  factory GetParametersByPathResult.fromJson(Map<String, dynamic> json) {
    return GetParametersByPathResult(
      nextToken: json['NextToken'] as String?,
      parameters: (json['Parameters'] as List?)
          ?.whereNotNull()
          .map((e) => Parameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetParametersResult {
  /// A list of parameters that are not formatted correctly or do not run during
  /// an execution.
  final List<String>? invalidParameters;

  /// A list of details for a parameter.
  final List<Parameter>? parameters;

  GetParametersResult({
    this.invalidParameters,
    this.parameters,
  });
  factory GetParametersResult.fromJson(Map<String, dynamic> json) {
    return GetParametersResult(
      invalidParameters: (json['InvalidParameters'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      parameters: (json['Parameters'] as List?)
          ?.whereNotNull()
          .map((e) => Parameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetPatchBaselineForPatchGroupResult {
  /// The ID of the patch baseline that should be used for the patch group.
  final String? baselineId;

  /// The operating system rule specified for patch groups using the patch
  /// baseline.
  final OperatingSystem? operatingSystem;

  /// The name of the patch group.
  final String? patchGroup;

  GetPatchBaselineForPatchGroupResult({
    this.baselineId,
    this.operatingSystem,
    this.patchGroup,
  });
  factory GetPatchBaselineForPatchGroupResult.fromJson(
      Map<String, dynamic> json) {
    return GetPatchBaselineForPatchGroupResult(
      baselineId: json['BaselineId'] as String?,
      operatingSystem:
          (json['OperatingSystem'] as String?)?.toOperatingSystem(),
      patchGroup: json['PatchGroup'] as String?,
    );
  }
}

class GetPatchBaselineResult {
  /// A set of rules used to include patches in the baseline.
  final PatchRuleGroup? approvalRules;

  /// A list of explicitly approved patches for the baseline.
  final List<String>? approvedPatches;

  /// Returns the specified compliance severity level for approved patches in the
  /// patch baseline.
  final PatchComplianceLevel? approvedPatchesComplianceLevel;

  /// Indicates whether the list of approved patches includes non-security updates
  /// that should be applied to the instances. The default value is 'false'.
  /// Applies to Linux instances only.
  final bool? approvedPatchesEnableNonSecurity;

  /// The ID of the retrieved patch baseline.
  final String? baselineId;

  /// The date the patch baseline was created.
  final DateTime? createdDate;

  /// A description of the patch baseline.
  final String? description;

  /// A set of global filters used to exclude patches from the baseline.
  final PatchFilterGroup? globalFilters;

  /// The date the patch baseline was last modified.
  final DateTime? modifiedDate;

  /// The name of the patch baseline.
  final String? name;

  /// Returns the operating system specified for the patch baseline.
  final OperatingSystem? operatingSystem;

  /// Patch groups included in the patch baseline.
  final List<String>? patchGroups;

  /// A list of explicitly rejected patches for the baseline.
  final List<String>? rejectedPatches;

  /// The action specified to take on patches included in the RejectedPatches
  /// list. A patch can be allowed only if it is a dependency of another package,
  /// or blocked entirely along with packages that include it as a dependency.
  final PatchAction? rejectedPatchesAction;

  /// Information about the patches to use to update the instances, including
  /// target operating systems and source repositories. Applies to Linux instances
  /// only.
  final List<PatchSource>? sources;

  GetPatchBaselineResult({
    this.approvalRules,
    this.approvedPatches,
    this.approvedPatchesComplianceLevel,
    this.approvedPatchesEnableNonSecurity,
    this.baselineId,
    this.createdDate,
    this.description,
    this.globalFilters,
    this.modifiedDate,
    this.name,
    this.operatingSystem,
    this.patchGroups,
    this.rejectedPatches,
    this.rejectedPatchesAction,
    this.sources,
  });
  factory GetPatchBaselineResult.fromJson(Map<String, dynamic> json) {
    return GetPatchBaselineResult(
      approvalRules: json['ApprovalRules'] != null
          ? PatchRuleGroup.fromJson(
              json['ApprovalRules'] as Map<String, dynamic>)
          : null,
      approvedPatches: (json['ApprovedPatches'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      approvedPatchesComplianceLevel:
          (json['ApprovedPatchesComplianceLevel'] as String?)
              ?.toPatchComplianceLevel(),
      approvedPatchesEnableNonSecurity:
          json['ApprovedPatchesEnableNonSecurity'] as bool?,
      baselineId: json['BaselineId'] as String?,
      createdDate: timeStampFromJson(json['CreatedDate']),
      description: json['Description'] as String?,
      globalFilters: json['GlobalFilters'] != null
          ? PatchFilterGroup.fromJson(
              json['GlobalFilters'] as Map<String, dynamic>)
          : null,
      modifiedDate: timeStampFromJson(json['ModifiedDate']),
      name: json['Name'] as String?,
      operatingSystem:
          (json['OperatingSystem'] as String?)?.toOperatingSystem(),
      patchGroups: (json['PatchGroups'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      rejectedPatches: (json['RejectedPatches'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      rejectedPatchesAction:
          (json['RejectedPatchesAction'] as String?)?.toPatchAction(),
      sources: (json['Sources'] as List?)
          ?.whereNotNull()
          .map((e) => PatchSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// The query result body of the GetServiceSetting API action.
class GetServiceSettingResult {
  /// The query result of the current service setting.
  final ServiceSetting? serviceSetting;

  GetServiceSettingResult({
    this.serviceSetting,
  });
  factory GetServiceSettingResult.fromJson(Map<String, dynamic> json) {
    return GetServiceSettingResult(
      serviceSetting: json['ServiceSetting'] != null
          ? ServiceSetting.fromJson(
              json['ServiceSetting'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Status information about the aggregated associations.
class InstanceAggregatedAssociationOverview {
  /// Detailed status information about the aggregated associations.
  final String? detailedStatus;

  /// The number of associations for the instance(s).
  final Map<String, int>? instanceAssociationStatusAggregatedCount;

  InstanceAggregatedAssociationOverview({
    this.detailedStatus,
    this.instanceAssociationStatusAggregatedCount,
  });
  factory InstanceAggregatedAssociationOverview.fromJson(
      Map<String, dynamic> json) {
    return InstanceAggregatedAssociationOverview(
      detailedStatus: json['DetailedStatus'] as String?,
      instanceAssociationStatusAggregatedCount:
          (json['InstanceAssociationStatusAggregatedCount']
                  as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as int)),
    );
  }
}

/// One or more association documents on the instance.
class InstanceAssociation {
  /// The association ID.
  final String? associationId;

  /// Version information for the association on the instance.
  final String? associationVersion;

  /// The content of the association document for the instance(s).
  final String? content;

  /// The instance ID.
  final String? instanceId;

  InstanceAssociation({
    this.associationId,
    this.associationVersion,
    this.content,
    this.instanceId,
  });
  factory InstanceAssociation.fromJson(Map<String, dynamic> json) {
    return InstanceAssociation(
      associationId: json['AssociationId'] as String?,
      associationVersion: json['AssociationVersion'] as String?,
      content: json['Content'] as String?,
      instanceId: json['InstanceId'] as String?,
    );
  }
}

/// An S3 bucket where you want to store the results of this request.
class InstanceAssociationOutputLocation {
  /// An S3 bucket where you want to store the results of this request.
  final S3OutputLocation? s3Location;

  InstanceAssociationOutputLocation({
    this.s3Location,
  });
  factory InstanceAssociationOutputLocation.fromJson(
      Map<String, dynamic> json) {
    return InstanceAssociationOutputLocation(
      s3Location: json['S3Location'] != null
          ? S3OutputLocation.fromJson(
              json['S3Location'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final s3Location = this.s3Location;
    return {
      if (s3Location != null) 'S3Location': s3Location,
    };
  }
}

/// The URL of S3 bucket where you want to store the results of this request.
class InstanceAssociationOutputUrl {
  /// The URL of S3 bucket where you want to store the results of this request.
  final S3OutputUrl? s3OutputUrl;

  InstanceAssociationOutputUrl({
    this.s3OutputUrl,
  });
  factory InstanceAssociationOutputUrl.fromJson(Map<String, dynamic> json) {
    return InstanceAssociationOutputUrl(
      s3OutputUrl: json['S3OutputUrl'] != null
          ? S3OutputUrl.fromJson(json['S3OutputUrl'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Status information about the instance association.
class InstanceAssociationStatusInfo {
  /// The association ID.
  final String? associationId;

  /// The name of the association applied to the instance.
  final String? associationName;

  /// The version of the association applied to the instance.
  final String? associationVersion;

  /// Detailed status information about the instance association.
  final String? detailedStatus;

  /// The association document versions.
  final String? documentVersion;

  /// An error code returned by the request to create the association.
  final String? errorCode;

  /// The date the instance association ran.
  final DateTime? executionDate;

  /// Summary information about association execution.
  final String? executionSummary;

  /// The instance ID where the association was created.
  final String? instanceId;

  /// The name of the association.
  final String? name;

  /// A URL for an S3 bucket where you want to store the results of this request.
  final InstanceAssociationOutputUrl? outputUrl;

  /// Status information about the instance association.
  final String? status;

  InstanceAssociationStatusInfo({
    this.associationId,
    this.associationName,
    this.associationVersion,
    this.detailedStatus,
    this.documentVersion,
    this.errorCode,
    this.executionDate,
    this.executionSummary,
    this.instanceId,
    this.name,
    this.outputUrl,
    this.status,
  });
  factory InstanceAssociationStatusInfo.fromJson(Map<String, dynamic> json) {
    return InstanceAssociationStatusInfo(
      associationId: json['AssociationId'] as String?,
      associationName: json['AssociationName'] as String?,
      associationVersion: json['AssociationVersion'] as String?,
      detailedStatus: json['DetailedStatus'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      errorCode: json['ErrorCode'] as String?,
      executionDate: timeStampFromJson(json['ExecutionDate']),
      executionSummary: json['ExecutionSummary'] as String?,
      instanceId: json['InstanceId'] as String?,
      name: json['Name'] as String?,
      outputUrl: json['OutputUrl'] != null
          ? InstanceAssociationOutputUrl.fromJson(
              json['OutputUrl'] as Map<String, dynamic>)
          : null,
      status: json['Status'] as String?,
    );
  }
}

/// Describes a filter for a specific list of instances.
class InstanceInformation {
  /// The activation ID created by Systems Manager when the server or VM was
  /// registered.
  final String? activationId;

  /// The version of SSM Agent running on your Linux instance.
  final String? agentVersion;

  /// Information about the association.
  final InstanceAggregatedAssociationOverview? associationOverview;

  /// The status of the association.
  final String? associationStatus;

  /// The fully qualified host name of the managed instance.
  final String? computerName;

  /// The IP address of the managed instance.
  final String? iPAddress;

  /// The Amazon Identity and Access Management (IAM) role assigned to the
  /// on-premises Systems Manager managed instance. This call does not return the
  /// IAM role for EC2 instances. To retrieve the IAM role for an EC2 instance,
  /// use the Amazon EC2 <code>DescribeInstances</code> action. For information,
  /// see <a
  /// href="http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html">DescribeInstances</a>
  /// in the <i>Amazon EC2 API Reference</i> or <a
  /// href="http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html">describe-instances</a>
  /// in the <i>AWS CLI Command Reference</i>.
  final String? iamRole;

  /// The instance ID.
  final String? instanceId;

  /// Indicates whether the latest version of SSM Agent is running on your Linux
  /// Managed Instance. This field does not indicate whether or not the latest
  /// version is installed on Windows managed instances, because some older
  /// versions of Windows Server use the EC2Config service to process SSM
  /// requests.
  final bool? isLatestVersion;

  /// The date the association was last run.
  final DateTime? lastAssociationExecutionDate;

  /// The date and time when the agent last pinged the Systems Manager service.
  final DateTime? lastPingDateTime;

  /// The last date the association was successfully run.
  final DateTime? lastSuccessfulAssociationExecutionDate;

  /// The name assigned to an on-premises server or virtual machine (VM) when it
  /// is activated as a Systems Manager managed instance. The name is specified as
  /// the <code>DefaultInstanceName</code> property using the
  /// <a>CreateActivation</a> command. It is applied to the managed instance by
  /// specifying the Activation Code and Activation ID when you install SSM Agent
  /// on the instance, as explained in <a
  /// href="http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-managed-linux.html">Install
  /// SSM Agent for a hybrid environment (Linux)</a> and <a
  /// href="http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-managed-win.html">Install
  /// SSM Agent for a hybrid environment (Windows)</a>. To retrieve the Name tag
  /// of an EC2 instance, use the Amazon EC2 <code>DescribeInstances</code>
  /// action. For information, see <a
  /// href="http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html">DescribeInstances</a>
  /// in the <i>Amazon EC2 API Reference</i> or <a
  /// href="http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html">describe-instances</a>
  /// in the <i>AWS CLI Command Reference</i>.
  final String? name;

  /// Connection status of SSM Agent.
  /// <note>
  /// The status <code>Inactive</code> has been deprecated and is no longer in
  /// use.
  /// </note>
  final PingStatus? pingStatus;

  /// The name of the operating system platform running on your instance.
  final String? platformName;

  /// The operating system platform type.
  final PlatformType? platformType;

  /// The version of the OS platform running on your instance.
  final String? platformVersion;

  /// The date the server or VM was registered with AWS as a managed instance.
  final DateTime? registrationDate;

  /// The type of instance. Instances are either EC2 instances or managed
  /// instances.
  final ResourceType? resourceType;

  InstanceInformation({
    this.activationId,
    this.agentVersion,
    this.associationOverview,
    this.associationStatus,
    this.computerName,
    this.iPAddress,
    this.iamRole,
    this.instanceId,
    this.isLatestVersion,
    this.lastAssociationExecutionDate,
    this.lastPingDateTime,
    this.lastSuccessfulAssociationExecutionDate,
    this.name,
    this.pingStatus,
    this.platformName,
    this.platformType,
    this.platformVersion,
    this.registrationDate,
    this.resourceType,
  });
  factory InstanceInformation.fromJson(Map<String, dynamic> json) {
    return InstanceInformation(
      activationId: json['ActivationId'] as String?,
      agentVersion: json['AgentVersion'] as String?,
      associationOverview: json['AssociationOverview'] != null
          ? InstanceAggregatedAssociationOverview.fromJson(
              json['AssociationOverview'] as Map<String, dynamic>)
          : null,
      associationStatus: json['AssociationStatus'] as String?,
      computerName: json['ComputerName'] as String?,
      iPAddress: json['IPAddress'] as String?,
      iamRole: json['IamRole'] as String?,
      instanceId: json['InstanceId'] as String?,
      isLatestVersion: json['IsLatestVersion'] as bool?,
      lastAssociationExecutionDate:
          timeStampFromJson(json['LastAssociationExecutionDate']),
      lastPingDateTime: timeStampFromJson(json['LastPingDateTime']),
      lastSuccessfulAssociationExecutionDate:
          timeStampFromJson(json['LastSuccessfulAssociationExecutionDate']),
      name: json['Name'] as String?,
      pingStatus: (json['PingStatus'] as String?)?.toPingStatus(),
      platformName: json['PlatformName'] as String?,
      platformType: (json['PlatformType'] as String?)?.toPlatformType(),
      platformVersion: json['PlatformVersion'] as String?,
      registrationDate: timeStampFromJson(json['RegistrationDate']),
      resourceType: (json['ResourceType'] as String?)?.toResourceType(),
    );
  }
}

/// Describes a filter for a specific list of instances. You can filter
/// instances information by using tags. You specify tags by using a key-value
/// mapping.
///
/// Use this action instead of the
/// <a>DescribeInstanceInformationRequest$InstanceInformationFilterList</a>
/// method. The <code>InstanceInformationFilterList</code> method is a legacy
/// method and does not support tags.
class InstanceInformationFilter {
  /// The name of the filter.
  final InstanceInformationFilterKey key;

  /// The filter values.
  final List<String> valueSet;

  InstanceInformationFilter({
    required this.key,
    required this.valueSet,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final valueSet = this.valueSet;
    return {
      'key': key.toValue(),
      'valueSet': valueSet,
    };
  }
}

enum InstanceInformationFilterKey {
  instanceIds,
  agentVersion,
  pingStatus,
  platformTypes,
  activationIds,
  iamRole,
  resourceType,
  associationStatus,
}

extension on InstanceInformationFilterKey {
  String toValue() {
    switch (this) {
      case InstanceInformationFilterKey.instanceIds:
        return 'InstanceIds';
      case InstanceInformationFilterKey.agentVersion:
        return 'AgentVersion';
      case InstanceInformationFilterKey.pingStatus:
        return 'PingStatus';
      case InstanceInformationFilterKey.platformTypes:
        return 'PlatformTypes';
      case InstanceInformationFilterKey.activationIds:
        return 'ActivationIds';
      case InstanceInformationFilterKey.iamRole:
        return 'IamRole';
      case InstanceInformationFilterKey.resourceType:
        return 'ResourceType';
      case InstanceInformationFilterKey.associationStatus:
        return 'AssociationStatus';
    }
  }
}

extension on String {
  InstanceInformationFilterKey toInstanceInformationFilterKey() {
    switch (this) {
      case 'InstanceIds':
        return InstanceInformationFilterKey.instanceIds;
      case 'AgentVersion':
        return InstanceInformationFilterKey.agentVersion;
      case 'PingStatus':
        return InstanceInformationFilterKey.pingStatus;
      case 'PlatformTypes':
        return InstanceInformationFilterKey.platformTypes;
      case 'ActivationIds':
        return InstanceInformationFilterKey.activationIds;
      case 'IamRole':
        return InstanceInformationFilterKey.iamRole;
      case 'ResourceType':
        return InstanceInformationFilterKey.resourceType;
      case 'AssociationStatus':
        return InstanceInformationFilterKey.associationStatus;
    }
    throw Exception('$this is not known in enum InstanceInformationFilterKey');
  }
}

/// The filters to describe or get information about your managed instances.
class InstanceInformationStringFilter {
  /// The filter key name to describe your instances. For example:
  ///
  /// "InstanceIds"|"AgentVersion"|"PingStatus"|"PlatformTypes"|"ActivationIds"|"IamRole"|"ResourceType"|"AssociationStatus"|"Tag
  /// Key"
  final String key;

  /// The filter values.
  final List<String> values;

  InstanceInformationStringFilter({
    required this.key,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      'Key': key,
      'Values': values,
    };
  }
}

/// Defines the high-level patch compliance state for a managed instance,
/// providing information about the number of installed, missing, not
/// applicable, and failed patches along with metadata about the operation when
/// this information was gathered for the instance.
class InstancePatchState {
  /// The ID of the patch baseline used to patch the instance.
  final String baselineId;

  /// The ID of the managed instance the high-level patch compliance information
  /// was collected for.
  final String instanceId;

  /// The type of patching operation that was performed: <code>SCAN</code> (assess
  /// patch compliance state) or <code>INSTALL</code> (install missing patches).
  final PatchOperationType operation;

  /// The time the most recent patching operation completed on the instance.
  final DateTime operationEndTime;

  /// The time the most recent patching operation was started on the instance.
  final DateTime operationStartTime;

  /// The name of the patch group the managed instance belongs to.
  final String patchGroup;

  /// The number of patches from the patch baseline that were attempted to be
  /// installed during the last patching operation, but failed to install.
  final int? failedCount;

  /// An https URL or an Amazon S3 path-style URL to a list of patches to be
  /// installed. This patch installation list, which you maintain in an S3 bucket
  /// in YAML format and specify in the SSM document
  /// <code>AWS-RunPatchBaseline</code>, overrides the patches specified by the
  /// default patch baseline.
  ///
  /// For more information about the <code>InstallOverrideList</code> parameter,
  /// see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-about-aws-runpatchbaseline.html">About
  /// the SSM document AWS-RunPatchBaseline</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  final String? installOverrideList;

  /// The number of patches from the patch baseline that are installed on the
  /// instance.
  final int? installedCount;

  /// The number of patches not specified in the patch baseline that are installed
  /// on the instance.
  final int? installedOtherCount;

  /// The number of patches installed by Patch Manager since the last time the
  /// instance was rebooted.
  final int? installedPendingRebootCount;

  /// The number of patches installed on an instance that are specified in a
  /// <code>RejectedPatches</code> list. Patches with a status of
  /// <i>InstalledRejected</i> were typically installed before they were added to
  /// a <code>RejectedPatches</code> list.
  /// <note>
  /// If <code>ALLOW_AS_DEPENDENCY</code> is the specified option for
  /// <code>RejectedPatchesAction</code>, the value of
  /// <code>InstalledRejectedCount</code> will always be <code>0</code> (zero).
  /// </note>
  final int? installedRejectedCount;

  /// The time of the last attempt to patch the instance with
  /// <code>NoReboot</code> specified as the reboot option.
  final DateTime? lastNoRebootInstallOperationTime;

  /// The number of patches from the patch baseline that are applicable for the
  /// instance but aren't currently installed.
  final int? missingCount;

  /// The number of patches from the patch baseline that aren't applicable for the
  /// instance and therefore aren't installed on the instance. This number may be
  /// truncated if the list of patch names is very large. The number of patches
  /// beyond this limit are reported in <code>UnreportedNotApplicableCount</code>.
  final int? notApplicableCount;

  /// Placeholder information. This field will always be empty in the current
  /// release of the service.
  final String? ownerInformation;

  /// Indicates the reboot option specified in the patch baseline.
  /// <note>
  /// Reboot options apply to <code>Install</code> operations only. Reboots are
  /// not attempted for Patch Manager <code>Scan</code> operations.
  /// </note>
  /// <ul>
  /// <li>
  /// <b>RebootIfNeeded</b>: Patch Manager tries to reboot the instance if it
  /// installed any patches, or if any patches are detected with a status of
  /// <code>InstalledPendingReboot</code>.
  /// </li>
  /// <li>
  /// <b>NoReboot</b>: Patch Manager attempts to install missing packages without
  /// trying to reboot the system. Patches installed with this option are assigned
  /// a status of <code>InstalledPendingReboot</code>. These patches might not be
  /// in effect until a reboot is performed.
  /// </li>
  /// </ul>
  final RebootOption? rebootOption;

  /// The ID of the patch baseline snapshot used during the patching operation
  /// when this compliance data was collected.
  final String? snapshotId;

  /// The number of patches beyond the supported limit of
  /// <code>NotApplicableCount</code> that are not reported by name to Systems
  /// Manager Inventory.
  final int? unreportedNotApplicableCount;

  InstancePatchState({
    required this.baselineId,
    required this.instanceId,
    required this.operation,
    required this.operationEndTime,
    required this.operationStartTime,
    required this.patchGroup,
    this.failedCount,
    this.installOverrideList,
    this.installedCount,
    this.installedOtherCount,
    this.installedPendingRebootCount,
    this.installedRejectedCount,
    this.lastNoRebootInstallOperationTime,
    this.missingCount,
    this.notApplicableCount,
    this.ownerInformation,
    this.rebootOption,
    this.snapshotId,
    this.unreportedNotApplicableCount,
  });
  factory InstancePatchState.fromJson(Map<String, dynamic> json) {
    return InstancePatchState(
      baselineId: json['BaselineId'] as String,
      instanceId: json['InstanceId'] as String,
      operation: (json['Operation'] as String).toPatchOperationType(),
      operationEndTime:
          nonNullableTimeStampFromJson(json['OperationEndTime'] as Object),
      operationStartTime:
          nonNullableTimeStampFromJson(json['OperationStartTime'] as Object),
      patchGroup: json['PatchGroup'] as String,
      failedCount: json['FailedCount'] as int?,
      installOverrideList: json['InstallOverrideList'] as String?,
      installedCount: json['InstalledCount'] as int?,
      installedOtherCount: json['InstalledOtherCount'] as int?,
      installedPendingRebootCount: json['InstalledPendingRebootCount'] as int?,
      installedRejectedCount: json['InstalledRejectedCount'] as int?,
      lastNoRebootInstallOperationTime:
          timeStampFromJson(json['LastNoRebootInstallOperationTime']),
      missingCount: json['MissingCount'] as int?,
      notApplicableCount: json['NotApplicableCount'] as int?,
      ownerInformation: json['OwnerInformation'] as String?,
      rebootOption: (json['RebootOption'] as String?)?.toRebootOption(),
      snapshotId: json['SnapshotId'] as String?,
      unreportedNotApplicableCount:
          json['UnreportedNotApplicableCount'] as int?,
    );
  }
}

/// Defines a filter used in <a>DescribeInstancePatchStatesForPatchGroup</a>
/// used to scope down the information returned by the API.
class InstancePatchStateFilter {
  /// The key for the filter. Supported values are FailedCount, InstalledCount,
  /// InstalledOtherCount, MissingCount and NotApplicableCount.
  final String key;

  /// The type of comparison that should be performed for the value: Equal,
  /// NotEqual, LessThan or GreaterThan.
  final InstancePatchStateOperatorType type;

  /// The value for the filter, must be an integer greater than or equal to 0.
  final List<String> values;

  InstancePatchStateFilter({
    required this.key,
    required this.type,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final type = this.type;
    final values = this.values;
    return {
      'Key': key,
      'Type': type.toValue(),
      'Values': values,
    };
  }
}

enum InstancePatchStateOperatorType {
  equal,
  notEqual,
  lessThan,
  greaterThan,
}

extension on InstancePatchStateOperatorType {
  String toValue() {
    switch (this) {
      case InstancePatchStateOperatorType.equal:
        return 'Equal';
      case InstancePatchStateOperatorType.notEqual:
        return 'NotEqual';
      case InstancePatchStateOperatorType.lessThan:
        return 'LessThan';
      case InstancePatchStateOperatorType.greaterThan:
        return 'GreaterThan';
    }
  }
}

extension on String {
  InstancePatchStateOperatorType toInstancePatchStateOperatorType() {
    switch (this) {
      case 'Equal':
        return InstancePatchStateOperatorType.equal;
      case 'NotEqual':
        return InstancePatchStateOperatorType.notEqual;
      case 'LessThan':
        return InstancePatchStateOperatorType.lessThan;
      case 'GreaterThan':
        return InstancePatchStateOperatorType.greaterThan;
    }
    throw Exception(
        '$this is not known in enum InstancePatchStateOperatorType');
  }
}

/// Specifies the inventory type and attribute for the aggregation execution.
class InventoryAggregator {
  /// Nested aggregators to further refine aggregation for an inventory type.
  final List<InventoryAggregator>? aggregators;

  /// The inventory type and attribute name for aggregation.
  final String? expression;

  /// A user-defined set of one or more filters on which to aggregate inventory
  /// data. Groups return a count of resources that match and don't match the
  /// specified criteria.
  final List<InventoryGroup>? groups;

  InventoryAggregator({
    this.aggregators,
    this.expression,
    this.groups,
  });
  Map<String, dynamic> toJson() {
    final aggregators = this.aggregators;
    final expression = this.expression;
    final groups = this.groups;
    return {
      if (aggregators != null) 'Aggregators': aggregators,
      if (expression != null) 'Expression': expression,
      if (groups != null) 'Groups': groups,
    };
  }
}

enum InventoryAttributeDataType {
  string,
  number,
}

extension on InventoryAttributeDataType {
  String toValue() {
    switch (this) {
      case InventoryAttributeDataType.string:
        return 'string';
      case InventoryAttributeDataType.number:
        return 'number';
    }
  }
}

extension on String {
  InventoryAttributeDataType toInventoryAttributeDataType() {
    switch (this) {
      case 'string':
        return InventoryAttributeDataType.string;
      case 'number':
        return InventoryAttributeDataType.number;
    }
    throw Exception('$this is not known in enum InventoryAttributeDataType');
  }
}

enum InventoryDeletionStatus {
  inProgress,
  complete,
}

extension on InventoryDeletionStatus {
  String toValue() {
    switch (this) {
      case InventoryDeletionStatus.inProgress:
        return 'InProgress';
      case InventoryDeletionStatus.complete:
        return 'Complete';
    }
  }
}

extension on String {
  InventoryDeletionStatus toInventoryDeletionStatus() {
    switch (this) {
      case 'InProgress':
        return InventoryDeletionStatus.inProgress;
      case 'Complete':
        return InventoryDeletionStatus.complete;
    }
    throw Exception('$this is not known in enum InventoryDeletionStatus');
  }
}

/// Status information returned by the <code>DeleteInventory</code> action.
class InventoryDeletionStatusItem {
  /// The deletion ID returned by the <code>DeleteInventory</code> action.
  final String? deletionId;

  /// The UTC timestamp when the delete operation started.
  final DateTime? deletionStartTime;

  /// Information about the delete operation. For more information about this
  /// summary, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-inventory-custom.html#sysman-inventory-delete">Understanding
  /// the delete inventory summary</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  final InventoryDeletionSummary? deletionSummary;

  /// The status of the operation. Possible values are InProgress and Complete.
  final InventoryDeletionStatus? lastStatus;

  /// Information about the status.
  final String? lastStatusMessage;

  /// The UTC timestamp of when the last status report.
  final DateTime? lastStatusUpdateTime;

  /// The name of the inventory data type.
  final String? typeName;

  InventoryDeletionStatusItem({
    this.deletionId,
    this.deletionStartTime,
    this.deletionSummary,
    this.lastStatus,
    this.lastStatusMessage,
    this.lastStatusUpdateTime,
    this.typeName,
  });
  factory InventoryDeletionStatusItem.fromJson(Map<String, dynamic> json) {
    return InventoryDeletionStatusItem(
      deletionId: json['DeletionId'] as String?,
      deletionStartTime: timeStampFromJson(json['DeletionStartTime']),
      deletionSummary: json['DeletionSummary'] != null
          ? InventoryDeletionSummary.fromJson(
              json['DeletionSummary'] as Map<String, dynamic>)
          : null,
      lastStatus: (json['LastStatus'] as String?)?.toInventoryDeletionStatus(),
      lastStatusMessage: json['LastStatusMessage'] as String?,
      lastStatusUpdateTime: timeStampFromJson(json['LastStatusUpdateTime']),
      typeName: json['TypeName'] as String?,
    );
  }
}

/// Information about the delete operation.
class InventoryDeletionSummary {
  /// Remaining number of items to delete.
  final int? remainingCount;

  /// A list of counts and versions for deleted items.
  final List<InventoryDeletionSummaryItem>? summaryItems;

  /// The total number of items to delete. This count does not change during the
  /// delete operation.
  final int? totalCount;

  InventoryDeletionSummary({
    this.remainingCount,
    this.summaryItems,
    this.totalCount,
  });
  factory InventoryDeletionSummary.fromJson(Map<String, dynamic> json) {
    return InventoryDeletionSummary(
      remainingCount: json['RemainingCount'] as int?,
      summaryItems: (json['SummaryItems'] as List?)
          ?.whereNotNull()
          .map((e) =>
              InventoryDeletionSummaryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['TotalCount'] as int?,
    );
  }
}

/// Either a count, remaining count, or a version number in a delete inventory
/// summary.
class InventoryDeletionSummaryItem {
  /// A count of the number of deleted items.
  final int? count;

  /// The remaining number of items to delete.
  final int? remainingCount;

  /// The inventory type version.
  final String? version;

  InventoryDeletionSummaryItem({
    this.count,
    this.remainingCount,
    this.version,
  });
  factory InventoryDeletionSummaryItem.fromJson(Map<String, dynamic> json) {
    return InventoryDeletionSummaryItem(
      count: json['Count'] as int?,
      remainingCount: json['RemainingCount'] as int?,
      version: json['Version'] as String?,
    );
  }
}

/// One or more filters. Use a filter to return a more specific list of results.
class InventoryFilter {
  /// The name of the filter key.
  final String key;

  /// Inventory filter values. Example: inventory filter where instance IDs are
  /// specified as values Key=AWS:InstanceInformation.InstanceId,Values=
  /// i-a12b3c4d5e6g, i-1a2b3c4d5e6,Type=Equal
  final List<String> values;

  /// The type of filter.
  /// <note>
  /// The <code>Exists</code> filter must be used with aggregators. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-inventory-aggregate.html">Aggregating
  /// inventory data</a> in the <i>AWS Systems Manager User Guide</i>.
  /// </note>
  final InventoryQueryOperatorType? type;

  InventoryFilter({
    required this.key,
    required this.values,
    this.type,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    final type = this.type;
    return {
      'Key': key,
      'Values': values,
      if (type != null) 'Type': type.toValue(),
    };
  }
}

/// A user-defined set of one or more filters on which to aggregate inventory
/// data. Groups return a count of resources that match and don't match the
/// specified criteria.
class InventoryGroup {
  /// Filters define the criteria for the group. The <code>matchingCount</code>
  /// field displays the number of resources that match the criteria. The
  /// <code>notMatchingCount</code> field displays the number of resources that
  /// don't match the criteria.
  final List<InventoryFilter> filters;

  /// The name of the group.
  final String name;

  InventoryGroup({
    required this.filters,
    required this.name,
  });
  Map<String, dynamic> toJson() {
    final filters = this.filters;
    final name = this.name;
    return {
      'Filters': filters,
      'Name': name,
    };
  }
}

/// Information collected from managed instances based on your inventory policy
/// document
class InventoryItem {
  /// The time the inventory information was collected.
  final String captureTime;

  /// The schema version for the inventory item.
  final String schemaVersion;

  /// The name of the inventory type. Default inventory item type names start with
  /// AWS. Custom inventory type names will start with Custom. Default inventory
  /// item types include the following: AWS:AWSComponent, AWS:Application,
  /// AWS:InstanceInformation, AWS:Network, and AWS:WindowsUpdate.
  final String typeName;

  /// The inventory data of the inventory type.
  final List<Map<String, String>>? content;

  /// MD5 hash of the inventory item type contents. The content hash is used to
  /// determine whether to update inventory information. The PutInventory API does
  /// not update the inventory item type contents if the MD5 hash has not changed
  /// since last update.
  final String? contentHash;

  /// A map of associated properties for a specified inventory type. For example,
  /// with this attribute, you can specify the <code>ExecutionId</code>,
  /// <code>ExecutionType</code>, <code>ComplianceType</code> properties of the
  /// <code>AWS:ComplianceItem</code> type.
  final Map<String, String>? context;

  InventoryItem({
    required this.captureTime,
    required this.schemaVersion,
    required this.typeName,
    this.content,
    this.contentHash,
    this.context,
  });
  Map<String, dynamic> toJson() {
    final captureTime = this.captureTime;
    final schemaVersion = this.schemaVersion;
    final typeName = this.typeName;
    final content = this.content;
    final contentHash = this.contentHash;
    final context = this.context;
    return {
      'CaptureTime': captureTime,
      'SchemaVersion': schemaVersion,
      'TypeName': typeName,
      if (content != null) 'Content': content,
      if (contentHash != null) 'ContentHash': contentHash,
      if (context != null) 'Context': context,
    };
  }
}

/// Attributes are the entries within the inventory item content. It contains
/// name and value.
class InventoryItemAttribute {
  /// The data type of the inventory item attribute.
  final InventoryAttributeDataType dataType;

  /// Name of the inventory item attribute.
  final String name;

  InventoryItemAttribute({
    required this.dataType,
    required this.name,
  });
  factory InventoryItemAttribute.fromJson(Map<String, dynamic> json) {
    return InventoryItemAttribute(
      dataType: (json['DataType'] as String).toInventoryAttributeDataType(),
      name: json['Name'] as String,
    );
  }
}

/// The inventory item schema definition. Users can use this to compose
/// inventory query filters.
class InventoryItemSchema {
  /// The schema attributes for inventory. This contains data type and attribute
  /// name.
  final List<InventoryItemAttribute> attributes;

  /// The name of the inventory type. Default inventory item type names start with
  /// AWS. Custom inventory type names will start with Custom. Default inventory
  /// item types include the following: AWS:AWSComponent, AWS:Application,
  /// AWS:InstanceInformation, AWS:Network, and AWS:WindowsUpdate.
  final String typeName;

  /// The alias name of the inventory type. The alias name is used for display
  /// purposes.
  final String? displayName;

  /// The schema version for the inventory item.
  final String? version;

  InventoryItemSchema({
    required this.attributes,
    required this.typeName,
    this.displayName,
    this.version,
  });
  factory InventoryItemSchema.fromJson(Map<String, dynamic> json) {
    return InventoryItemSchema(
      attributes: (json['Attributes'] as List)
          .whereNotNull()
          .map(
              (e) => InventoryItemAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeName: json['TypeName'] as String,
      displayName: json['DisplayName'] as String?,
      version: json['Version'] as String?,
    );
  }
}

enum InventoryQueryOperatorType {
  equal,
  notEqual,
  beginWith,
  lessThan,
  greaterThan,
  exists,
}

extension on InventoryQueryOperatorType {
  String toValue() {
    switch (this) {
      case InventoryQueryOperatorType.equal:
        return 'Equal';
      case InventoryQueryOperatorType.notEqual:
        return 'NotEqual';
      case InventoryQueryOperatorType.beginWith:
        return 'BeginWith';
      case InventoryQueryOperatorType.lessThan:
        return 'LessThan';
      case InventoryQueryOperatorType.greaterThan:
        return 'GreaterThan';
      case InventoryQueryOperatorType.exists:
        return 'Exists';
    }
  }
}

extension on String {
  InventoryQueryOperatorType toInventoryQueryOperatorType() {
    switch (this) {
      case 'Equal':
        return InventoryQueryOperatorType.equal;
      case 'NotEqual':
        return InventoryQueryOperatorType.notEqual;
      case 'BeginWith':
        return InventoryQueryOperatorType.beginWith;
      case 'LessThan':
        return InventoryQueryOperatorType.lessThan;
      case 'GreaterThan':
        return InventoryQueryOperatorType.greaterThan;
      case 'Exists':
        return InventoryQueryOperatorType.exists;
    }
    throw Exception('$this is not known in enum InventoryQueryOperatorType');
  }
}

/// Inventory query results.
class InventoryResultEntity {
  /// The data section in the inventory result entity JSON.
  final Map<String, InventoryResultItem>? data;

  /// ID of the inventory result entity. For example, for managed instance
  /// inventory the result will be the managed instance ID. For EC2 instance
  /// inventory, the result will be the instance ID.
  final String? id;

  InventoryResultEntity({
    this.data,
    this.id,
  });
  factory InventoryResultEntity.fromJson(Map<String, dynamic> json) {
    return InventoryResultEntity(
      data: (json['Data'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(k, InventoryResultItem.fromJson(e as Map<String, dynamic>))),
      id: json['Id'] as String?,
    );
  }
}

/// The inventory result item.
class InventoryResultItem {
  /// Contains all the inventory data of the item type. Results include attribute
  /// names and values.
  final List<Map<String, String>> content;

  /// The schema version for the inventory result item/
  final String schemaVersion;

  /// The name of the inventory result item type.
  final String typeName;

  /// The time inventory item data was captured.
  final String? captureTime;

  /// MD5 hash of the inventory item type contents. The content hash is used to
  /// determine whether to update inventory information. The PutInventory API does
  /// not update the inventory item type contents if the MD5 hash has not changed
  /// since last update.
  final String? contentHash;

  InventoryResultItem({
    required this.content,
    required this.schemaVersion,
    required this.typeName,
    this.captureTime,
    this.contentHash,
  });
  factory InventoryResultItem.fromJson(Map<String, dynamic> json) {
    return InventoryResultItem(
      content: (json['Content'] as List)
          .whereNotNull()
          .map((e) => (e as Map<String, dynamic>)
              .map((k, e) => MapEntry(k, e as String)))
          .toList(),
      schemaVersion: json['SchemaVersion'] as String,
      typeName: json['TypeName'] as String,
      captureTime: json['CaptureTime'] as String?,
      contentHash: json['ContentHash'] as String?,
    );
  }
}

enum InventorySchemaDeleteOption {
  disableSchema,
  deleteSchema,
}

extension on InventorySchemaDeleteOption {
  String toValue() {
    switch (this) {
      case InventorySchemaDeleteOption.disableSchema:
        return 'DisableSchema';
      case InventorySchemaDeleteOption.deleteSchema:
        return 'DeleteSchema';
    }
  }
}

extension on String {
  InventorySchemaDeleteOption toInventorySchemaDeleteOption() {
    switch (this) {
      case 'DisableSchema':
        return InventorySchemaDeleteOption.disableSchema;
      case 'DeleteSchema':
        return InventorySchemaDeleteOption.deleteSchema;
    }
    throw Exception('$this is not known in enum InventorySchemaDeleteOption');
  }
}

class LabelParameterVersionResult {
  /// The label does not meet the requirements. For information about parameter
  /// label requirements, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-labels.html">Labeling
  /// parameters</a> in the <i>AWS Systems Manager User Guide</i>.
  final List<String>? invalidLabels;

  /// The version of the parameter that has been labeled.
  final int? parameterVersion;

  LabelParameterVersionResult({
    this.invalidLabels,
    this.parameterVersion,
  });
  factory LabelParameterVersionResult.fromJson(Map<String, dynamic> json) {
    return LabelParameterVersionResult(
      invalidLabels: (json['InvalidLabels'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      parameterVersion: json['ParameterVersion'] as int?,
    );
  }
}

enum LastResourceDataSyncStatus {
  successful,
  failed,
  inProgress,
}

extension on LastResourceDataSyncStatus {
  String toValue() {
    switch (this) {
      case LastResourceDataSyncStatus.successful:
        return 'Successful';
      case LastResourceDataSyncStatus.failed:
        return 'Failed';
      case LastResourceDataSyncStatus.inProgress:
        return 'InProgress';
    }
  }
}

extension on String {
  LastResourceDataSyncStatus toLastResourceDataSyncStatus() {
    switch (this) {
      case 'Successful':
        return LastResourceDataSyncStatus.successful;
      case 'Failed':
        return LastResourceDataSyncStatus.failed;
      case 'InProgress':
        return LastResourceDataSyncStatus.inProgress;
    }
    throw Exception('$this is not known in enum LastResourceDataSyncStatus');
  }
}

class ListAssociationVersionsResult {
  /// Information about all versions of the association for the specified
  /// association ID.
  final List<AssociationVersionInfo>? associationVersions;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  ListAssociationVersionsResult({
    this.associationVersions,
    this.nextToken,
  });
  factory ListAssociationVersionsResult.fromJson(Map<String, dynamic> json) {
    return ListAssociationVersionsResult(
      associationVersions: (json['AssociationVersions'] as List?)
          ?.whereNotNull()
          .map(
              (e) => AssociationVersionInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListAssociationsResult {
  /// The associations.
  final List<Association>? associations;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  ListAssociationsResult({
    this.associations,
    this.nextToken,
  });
  factory ListAssociationsResult.fromJson(Map<String, dynamic> json) {
    return ListAssociationsResult(
      associations: (json['Associations'] as List?)
          ?.whereNotNull()
          .map((e) => Association.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListCommandInvocationsResult {
  /// (Optional) A list of all invocations.
  final List<CommandInvocation>? commandInvocations;

  /// (Optional) The token for the next set of items to return. (You received this
  /// token from a previous call.)
  final String? nextToken;

  ListCommandInvocationsResult({
    this.commandInvocations,
    this.nextToken,
  });
  factory ListCommandInvocationsResult.fromJson(Map<String, dynamic> json) {
    return ListCommandInvocationsResult(
      commandInvocations: (json['CommandInvocations'] as List?)
          ?.whereNotNull()
          .map((e) => CommandInvocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListCommandsResult {
  /// (Optional) The list of commands requested by the user.
  final List<Command>? commands;

  /// (Optional) The token for the next set of items to return. (You received this
  /// token from a previous call.)
  final String? nextToken;

  ListCommandsResult({
    this.commands,
    this.nextToken,
  });
  factory ListCommandsResult.fromJson(Map<String, dynamic> json) {
    return ListCommandsResult(
      commands: (json['Commands'] as List?)
          ?.whereNotNull()
          .map((e) => Command.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListComplianceItemsResult {
  /// A list of compliance information for the specified resource ID.
  final List<ComplianceItem>? complianceItems;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  ListComplianceItemsResult({
    this.complianceItems,
    this.nextToken,
  });
  factory ListComplianceItemsResult.fromJson(Map<String, dynamic> json) {
    return ListComplianceItemsResult(
      complianceItems: (json['ComplianceItems'] as List?)
          ?.whereNotNull()
          .map((e) => ComplianceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListComplianceSummariesResult {
  /// A list of compliant and non-compliant summary counts based on compliance
  /// types. For example, this call returns State Manager associations, patches,
  /// or custom compliance types according to the filter criteria that you
  /// specified.
  final List<ComplianceSummaryItem>? complianceSummaryItems;

  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  ListComplianceSummariesResult({
    this.complianceSummaryItems,
    this.nextToken,
  });
  factory ListComplianceSummariesResult.fromJson(Map<String, dynamic> json) {
    return ListComplianceSummariesResult(
      complianceSummaryItems: (json['ComplianceSummaryItems'] as List?)
          ?.whereNotNull()
          .map((e) => ComplianceSummaryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListDocumentMetadataHistoryResponse {
  /// The user ID of the person in the organization who requested the document
  /// review.
  final String? author;

  /// The version of the document.
  final String? documentVersion;

  /// Information about the response to the document approval request.
  final DocumentMetadataResponseInfo? metadata;

  /// The name of the document.
  final String? name;

  /// The maximum number of items to return for this call. The call also returns a
  /// token that you can specify in a subsequent call to get the next set of
  /// results.
  final String? nextToken;

  ListDocumentMetadataHistoryResponse({
    this.author,
    this.documentVersion,
    this.metadata,
    this.name,
    this.nextToken,
  });
  factory ListDocumentMetadataHistoryResponse.fromJson(
      Map<String, dynamic> json) {
    return ListDocumentMetadataHistoryResponse(
      author: json['Author'] as String?,
      documentVersion: json['DocumentVersion'] as String?,
      metadata: json['Metadata'] != null
          ? DocumentMetadataResponseInfo.fromJson(
              json['Metadata'] as Map<String, dynamic>)
          : null,
      name: json['Name'] as String?,
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListDocumentVersionsResult {
  /// The document versions.
  final List<DocumentVersionInfo>? documentVersions;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  ListDocumentVersionsResult({
    this.documentVersions,
    this.nextToken,
  });
  factory ListDocumentVersionsResult.fromJson(Map<String, dynamic> json) {
    return ListDocumentVersionsResult(
      documentVersions: (json['DocumentVersions'] as List?)
          ?.whereNotNull()
          .map((e) => DocumentVersionInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListDocumentsResult {
  /// The names of the Systems Manager documents.
  final List<DocumentIdentifier>? documentIdentifiers;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  ListDocumentsResult({
    this.documentIdentifiers,
    this.nextToken,
  });
  factory ListDocumentsResult.fromJson(Map<String, dynamic> json) {
    return ListDocumentsResult(
      documentIdentifiers: (json['DocumentIdentifiers'] as List?)
          ?.whereNotNull()
          .map((e) => DocumentIdentifier.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListInventoryEntriesResult {
  /// The time that inventory information was collected for the instance(s).
  final String? captureTime;

  /// A list of inventory items on the instance(s).
  final List<Map<String, String>>? entries;

  /// The instance ID targeted by the request to query inventory information.
  final String? instanceId;

  /// The token to use when requesting the next set of items. If there are no
  /// additional items to return, the string is empty.
  final String? nextToken;

  /// The inventory schema version used by the instance(s).
  final String? schemaVersion;

  /// The type of inventory item returned by the request.
  final String? typeName;

  ListInventoryEntriesResult({
    this.captureTime,
    this.entries,
    this.instanceId,
    this.nextToken,
    this.schemaVersion,
    this.typeName,
  });
  factory ListInventoryEntriesResult.fromJson(Map<String, dynamic> json) {
    return ListInventoryEntriesResult(
      captureTime: json['CaptureTime'] as String?,
      entries: (json['Entries'] as List?)
          ?.whereNotNull()
          .map((e) => (e as Map<String, dynamic>)
              .map((k, e) => MapEntry(k, e as String)))
          .toList(),
      instanceId: json['InstanceId'] as String?,
      nextToken: json['NextToken'] as String?,
      schemaVersion: json['SchemaVersion'] as String?,
      typeName: json['TypeName'] as String?,
    );
  }
}

class ListOpsItemEventsResponse {
  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  /// A list of event information for the specified OpsItems.
  final List<OpsItemEventSummary>? summaries;

  ListOpsItemEventsResponse({
    this.nextToken,
    this.summaries,
  });
  factory ListOpsItemEventsResponse.fromJson(Map<String, dynamic> json) {
    return ListOpsItemEventsResponse(
      nextToken: json['NextToken'] as String?,
      summaries: (json['Summaries'] as List?)
          ?.whereNotNull()
          .map((e) => OpsItemEventSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListOpsMetadataResult {
  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  /// Returns a list of OpsMetadata objects.
  final List<OpsMetadata>? opsMetadataList;

  ListOpsMetadataResult({
    this.nextToken,
    this.opsMetadataList,
  });
  factory ListOpsMetadataResult.fromJson(Map<String, dynamic> json) {
    return ListOpsMetadataResult(
      nextToken: json['NextToken'] as String?,
      opsMetadataList: (json['OpsMetadataList'] as List?)
          ?.whereNotNull()
          .map((e) => OpsMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListResourceComplianceSummariesResult {
  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  /// A summary count for specified or targeted managed instances. Summary count
  /// includes information about compliant and non-compliant State Manager
  /// associations, patch status, or custom items according to the filter criteria
  /// that you specify.
  final List<ResourceComplianceSummaryItem>? resourceComplianceSummaryItems;

  ListResourceComplianceSummariesResult({
    this.nextToken,
    this.resourceComplianceSummaryItems,
  });
  factory ListResourceComplianceSummariesResult.fromJson(
      Map<String, dynamic> json) {
    return ListResourceComplianceSummariesResult(
      nextToken: json['NextToken'] as String?,
      resourceComplianceSummaryItems: (json['ResourceComplianceSummaryItems']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              ResourceComplianceSummaryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListResourceDataSyncResult {
  /// The token for the next set of items to return. Use this token to get the
  /// next set of results.
  final String? nextToken;

  /// A list of your current Resource Data Sync configurations and their statuses.
  final List<ResourceDataSyncItem>? resourceDataSyncItems;

  ListResourceDataSyncResult({
    this.nextToken,
    this.resourceDataSyncItems,
  });
  factory ListResourceDataSyncResult.fromJson(Map<String, dynamic> json) {
    return ListResourceDataSyncResult(
      nextToken: json['NextToken'] as String?,
      resourceDataSyncItems: (json['ResourceDataSyncItems'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceDataSyncItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListTagsForResourceResult {
  /// A list of tags.
  final List<Tag>? tagList;

  ListTagsForResourceResult({
    this.tagList,
  });
  factory ListTagsForResourceResult.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResult(
      tagList: (json['TagList'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Information about an S3 bucket to write instance-level logs to.
/// <note>
/// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
/// contain logs, instead use the <code>OutputS3BucketName</code> and
/// <code>OutputS3KeyPrefix</code> options in the
/// <code>TaskInvocationParameters</code> structure. For information about how
/// Systems Manager handles these options for the supported maintenance window
/// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
/// </note>
class LoggingInfo {
  /// The name of an S3 bucket where execution logs are stored .
  final String s3BucketName;

  /// The Region where the S3 bucket is located.
  final String s3Region;

  /// (Optional) The S3 bucket subfolder.
  final String? s3KeyPrefix;

  LoggingInfo({
    required this.s3BucketName,
    required this.s3Region,
    this.s3KeyPrefix,
  });
  factory LoggingInfo.fromJson(Map<String, dynamic> json) {
    return LoggingInfo(
      s3BucketName: json['S3BucketName'] as String,
      s3Region: json['S3Region'] as String,
      s3KeyPrefix: json['S3KeyPrefix'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final s3BucketName = this.s3BucketName;
    final s3Region = this.s3Region;
    final s3KeyPrefix = this.s3KeyPrefix;
    return {
      'S3BucketName': s3BucketName,
      'S3Region': s3Region,
      if (s3KeyPrefix != null) 'S3KeyPrefix': s3KeyPrefix,
    };
  }
}

/// The parameters for an AUTOMATION task type.
class MaintenanceWindowAutomationParameters {
  /// The version of an Automation document to use during task execution.
  final String? documentVersion;

  /// The parameters for the AUTOMATION task.
  ///
  /// For information about specifying and updating task parameters, see
  /// <a>RegisterTaskWithMaintenanceWindow</a> and
  /// <a>UpdateMaintenanceWindowTask</a>.
  /// <note>
  /// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
  /// contain logs, instead use the <code>OutputS3BucketName</code> and
  /// <code>OutputS3KeyPrefix</code> options in the
  /// <code>TaskInvocationParameters</code> structure. For information about how
  /// Systems Manager handles these options for the supported maintenance window
  /// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
  ///
  /// <code>TaskParameters</code> has been deprecated. To specify parameters to
  /// pass to a task when it runs, instead use the <code>Parameters</code> option
  /// in the <code>TaskInvocationParameters</code> structure. For information
  /// about how Systems Manager handles these options for the supported
  /// maintenance window task types, see
  /// <a>MaintenanceWindowTaskInvocationParameters</a>.
  ///
  /// For AUTOMATION task types, Systems Manager ignores any values specified for
  /// these parameters.
  /// </note>
  final Map<String, List<String>>? parameters;

  MaintenanceWindowAutomationParameters({
    this.documentVersion,
    this.parameters,
  });
  factory MaintenanceWindowAutomationParameters.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowAutomationParameters(
      documentVersion: json['DocumentVersion'] as String?,
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
    );
  }

  Map<String, dynamic> toJson() {
    final documentVersion = this.documentVersion;
    final parameters = this.parameters;
    return {
      if (documentVersion != null) 'DocumentVersion': documentVersion,
      if (parameters != null) 'Parameters': parameters,
    };
  }
}

/// Describes the information about an execution of a maintenance window.
class MaintenanceWindowExecution {
  /// The time the execution finished.
  final DateTime? endTime;

  /// The time the execution started.
  final DateTime? startTime;

  /// The status of the execution.
  final MaintenanceWindowExecutionStatus? status;

  /// The details explaining the Status. Only available for certain status values.
  final String? statusDetails;

  /// The ID of the maintenance window execution.
  final String? windowExecutionId;

  /// The ID of the maintenance window.
  final String? windowId;

  MaintenanceWindowExecution({
    this.endTime,
    this.startTime,
    this.status,
    this.statusDetails,
    this.windowExecutionId,
    this.windowId,
  });
  factory MaintenanceWindowExecution.fromJson(Map<String, dynamic> json) {
    return MaintenanceWindowExecution(
      endTime: timeStampFromJson(json['EndTime']),
      startTime: timeStampFromJson(json['StartTime']),
      status: (json['Status'] as String?)?.toMaintenanceWindowExecutionStatus(),
      statusDetails: json['StatusDetails'] as String?,
      windowExecutionId: json['WindowExecutionId'] as String?,
      windowId: json['WindowId'] as String?,
    );
  }
}

enum MaintenanceWindowExecutionStatus {
  pending,
  inProgress,
  success,
  failed,
  timedOut,
  cancelling,
  cancelled,
  skippedOverlapping,
}

extension on MaintenanceWindowExecutionStatus {
  String toValue() {
    switch (this) {
      case MaintenanceWindowExecutionStatus.pending:
        return 'PENDING';
      case MaintenanceWindowExecutionStatus.inProgress:
        return 'IN_PROGRESS';
      case MaintenanceWindowExecutionStatus.success:
        return 'SUCCESS';
      case MaintenanceWindowExecutionStatus.failed:
        return 'FAILED';
      case MaintenanceWindowExecutionStatus.timedOut:
        return 'TIMED_OUT';
      case MaintenanceWindowExecutionStatus.cancelling:
        return 'CANCELLING';
      case MaintenanceWindowExecutionStatus.cancelled:
        return 'CANCELLED';
      case MaintenanceWindowExecutionStatus.skippedOverlapping:
        return 'SKIPPED_OVERLAPPING';
    }
  }
}

extension on String {
  MaintenanceWindowExecutionStatus toMaintenanceWindowExecutionStatus() {
    switch (this) {
      case 'PENDING':
        return MaintenanceWindowExecutionStatus.pending;
      case 'IN_PROGRESS':
        return MaintenanceWindowExecutionStatus.inProgress;
      case 'SUCCESS':
        return MaintenanceWindowExecutionStatus.success;
      case 'FAILED':
        return MaintenanceWindowExecutionStatus.failed;
      case 'TIMED_OUT':
        return MaintenanceWindowExecutionStatus.timedOut;
      case 'CANCELLING':
        return MaintenanceWindowExecutionStatus.cancelling;
      case 'CANCELLED':
        return MaintenanceWindowExecutionStatus.cancelled;
      case 'SKIPPED_OVERLAPPING':
        return MaintenanceWindowExecutionStatus.skippedOverlapping;
    }
    throw Exception(
        '$this is not known in enum MaintenanceWindowExecutionStatus');
  }
}

/// Information about a task execution performed as part of a maintenance window
/// execution.
class MaintenanceWindowExecutionTaskIdentity {
  /// The time the task execution finished.
  final DateTime? endTime;

  /// The time the task execution started.
  final DateTime? startTime;

  /// The status of the task execution.
  final MaintenanceWindowExecutionStatus? status;

  /// The details explaining the status of the task execution. Only available for
  /// certain status values.
  final String? statusDetails;

  /// The ARN of the task that ran.
  final String? taskArn;

  /// The ID of the specific task execution in the maintenance window execution.
  final String? taskExecutionId;

  /// The type of task that ran.
  final MaintenanceWindowTaskType? taskType;

  /// The ID of the maintenance window execution that ran the task.
  final String? windowExecutionId;

  MaintenanceWindowExecutionTaskIdentity({
    this.endTime,
    this.startTime,
    this.status,
    this.statusDetails,
    this.taskArn,
    this.taskExecutionId,
    this.taskType,
    this.windowExecutionId,
  });
  factory MaintenanceWindowExecutionTaskIdentity.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowExecutionTaskIdentity(
      endTime: timeStampFromJson(json['EndTime']),
      startTime: timeStampFromJson(json['StartTime']),
      status: (json['Status'] as String?)?.toMaintenanceWindowExecutionStatus(),
      statusDetails: json['StatusDetails'] as String?,
      taskArn: json['TaskArn'] as String?,
      taskExecutionId: json['TaskExecutionId'] as String?,
      taskType: (json['TaskType'] as String?)?.toMaintenanceWindowTaskType(),
      windowExecutionId: json['WindowExecutionId'] as String?,
    );
  }
}

/// Describes the information about a task invocation for a particular target as
/// part of a task execution performed as part of a maintenance window
/// execution.
class MaintenanceWindowExecutionTaskInvocationIdentity {
  /// The time the invocation finished.
  final DateTime? endTime;

  /// The ID of the action performed in the service that actually handled the task
  /// invocation. If the task type is RUN_COMMAND, this value is the command ID.
  final String? executionId;

  /// The ID of the task invocation.
  final String? invocationId;

  /// User-provided value that was specified when the target was registered with
  /// the maintenance window. This was also included in any CloudWatch events
  /// raised during the task invocation.
  final String? ownerInformation;

  /// The parameters that were provided for the invocation when it was run.
  final String? parameters;

  /// The time the invocation started.
  final DateTime? startTime;

  /// The status of the task invocation.
  final MaintenanceWindowExecutionStatus? status;

  /// The details explaining the status of the task invocation. Only available for
  /// certain Status values.
  final String? statusDetails;

  /// The ID of the specific task execution in the maintenance window execution.
  final String? taskExecutionId;

  /// The task type.
  final MaintenanceWindowTaskType? taskType;

  /// The ID of the maintenance window execution that ran the task.
  final String? windowExecutionId;

  /// The ID of the target definition in this maintenance window the invocation
  /// was performed for.
  final String? windowTargetId;

  MaintenanceWindowExecutionTaskInvocationIdentity({
    this.endTime,
    this.executionId,
    this.invocationId,
    this.ownerInformation,
    this.parameters,
    this.startTime,
    this.status,
    this.statusDetails,
    this.taskExecutionId,
    this.taskType,
    this.windowExecutionId,
    this.windowTargetId,
  });
  factory MaintenanceWindowExecutionTaskInvocationIdentity.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowExecutionTaskInvocationIdentity(
      endTime: timeStampFromJson(json['EndTime']),
      executionId: json['ExecutionId'] as String?,
      invocationId: json['InvocationId'] as String?,
      ownerInformation: json['OwnerInformation'] as String?,
      parameters: json['Parameters'] as String?,
      startTime: timeStampFromJson(json['StartTime']),
      status: (json['Status'] as String?)?.toMaintenanceWindowExecutionStatus(),
      statusDetails: json['StatusDetails'] as String?,
      taskExecutionId: json['TaskExecutionId'] as String?,
      taskType: (json['TaskType'] as String?)?.toMaintenanceWindowTaskType(),
      windowExecutionId: json['WindowExecutionId'] as String?,
      windowTargetId: json['WindowTargetId'] as String?,
    );
  }
}

/// Filter used in the request. Supported filter keys are Name and Enabled.
class MaintenanceWindowFilter {
  /// The name of the filter.
  final String? key;

  /// The filter values.
  final List<String>? values;

  MaintenanceWindowFilter({
    this.key,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      if (key != null) 'Key': key,
      if (values != null) 'Values': values,
    };
  }
}

/// Information about the maintenance window.
class MaintenanceWindowIdentity {
  /// The number of hours before the end of the maintenance window that Systems
  /// Manager stops scheduling new tasks for execution.
  final int? cutoff;

  /// A description of the maintenance window.
  final String? description;

  /// The duration of the maintenance window in hours.
  final int? duration;

  /// Indicates whether the maintenance window is enabled.
  final bool? enabled;

  /// The date and time, in ISO-8601 Extended format, for when the maintenance
  /// window is scheduled to become inactive.
  final String? endDate;

  /// The name of the maintenance window.
  final String? name;

  /// The next time the maintenance window will actually run, taking into account
  /// any specified times for the maintenance window to become active or inactive.
  final String? nextExecutionTime;

  /// The schedule of the maintenance window in the form of a cron or rate
  /// expression.
  final String? schedule;

  /// The number of days to wait to run a maintenance window after the scheduled
  /// CRON expression date and time.
  final int? scheduleOffset;

  /// The time zone that the scheduled maintenance window executions are based on,
  /// in Internet Assigned Numbers Authority (IANA) format.
  final String? scheduleTimezone;

  /// The date and time, in ISO-8601 Extended format, for when the maintenance
  /// window is scheduled to become active.
  final String? startDate;

  /// The ID of the maintenance window.
  final String? windowId;

  MaintenanceWindowIdentity({
    this.cutoff,
    this.description,
    this.duration,
    this.enabled,
    this.endDate,
    this.name,
    this.nextExecutionTime,
    this.schedule,
    this.scheduleOffset,
    this.scheduleTimezone,
    this.startDate,
    this.windowId,
  });
  factory MaintenanceWindowIdentity.fromJson(Map<String, dynamic> json) {
    return MaintenanceWindowIdentity(
      cutoff: json['Cutoff'] as int?,
      description: json['Description'] as String?,
      duration: json['Duration'] as int?,
      enabled: json['Enabled'] as bool?,
      endDate: json['EndDate'] as String?,
      name: json['Name'] as String?,
      nextExecutionTime: json['NextExecutionTime'] as String?,
      schedule: json['Schedule'] as String?,
      scheduleOffset: json['ScheduleOffset'] as int?,
      scheduleTimezone: json['ScheduleTimezone'] as String?,
      startDate: json['StartDate'] as String?,
      windowId: json['WindowId'] as String?,
    );
  }
}

/// The maintenance window to which the specified target belongs.
class MaintenanceWindowIdentityForTarget {
  /// The name of the maintenance window.
  final String? name;

  /// The ID of the maintenance window.
  final String? windowId;

  MaintenanceWindowIdentityForTarget({
    this.name,
    this.windowId,
  });
  factory MaintenanceWindowIdentityForTarget.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowIdentityForTarget(
      name: json['Name'] as String?,
      windowId: json['WindowId'] as String?,
    );
  }
}

/// The parameters for a LAMBDA task type.
///
/// For information about specifying and updating task parameters, see
/// <a>RegisterTaskWithMaintenanceWindow</a> and
/// <a>UpdateMaintenanceWindowTask</a>.
/// <note>
/// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
/// contain logs, instead use the <code>OutputS3BucketName</code> and
/// <code>OutputS3KeyPrefix</code> options in the
/// <code>TaskInvocationParameters</code> structure. For information about how
/// Systems Manager handles these options for the supported maintenance window
/// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
///
/// <code>TaskParameters</code> has been deprecated. To specify parameters to
/// pass to a task when it runs, instead use the <code>Parameters</code> option
/// in the <code>TaskInvocationParameters</code> structure. For information
/// about how Systems Manager handles these options for the supported
/// maintenance window task types, see
/// <a>MaintenanceWindowTaskInvocationParameters</a>.
///
/// For Lambda tasks, Systems Manager ignores any values specified for
/// TaskParameters and LoggingInfo.
/// </note>
class MaintenanceWindowLambdaParameters {
  /// Pass client-specific information to the Lambda function that you are
  /// invoking. You can then process the client information in your Lambda
  /// function as you choose through the context variable.
  final String? clientContext;

  /// JSON to provide to your Lambda function as input.
  final Uint8List? payload;

  /// (Optional) Specify a Lambda function version or alias name. If you specify a
  /// function version, the action uses the qualified function ARN to invoke a
  /// specific Lambda function. If you specify an alias name, the action uses the
  /// alias ARN to invoke the Lambda function version to which the alias points.
  final String? qualifier;

  MaintenanceWindowLambdaParameters({
    this.clientContext,
    this.payload,
    this.qualifier,
  });
  factory MaintenanceWindowLambdaParameters.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowLambdaParameters(
      clientContext: json['ClientContext'] as String?,
      payload: _s.decodeNullableUint8List(json['Payload'] as String?),
      qualifier: json['Qualifier'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final clientContext = this.clientContext;
    final payload = this.payload;
    final qualifier = this.qualifier;
    return {
      if (clientContext != null) 'ClientContext': clientContext,
      if (payload != null) 'Payload': base64Encode(payload),
      if (qualifier != null) 'Qualifier': qualifier,
    };
  }
}

enum MaintenanceWindowResourceType {
  instance,
  resourceGroup,
}

extension on MaintenanceWindowResourceType {
  String toValue() {
    switch (this) {
      case MaintenanceWindowResourceType.instance:
        return 'INSTANCE';
      case MaintenanceWindowResourceType.resourceGroup:
        return 'RESOURCE_GROUP';
    }
  }
}

extension on String {
  MaintenanceWindowResourceType toMaintenanceWindowResourceType() {
    switch (this) {
      case 'INSTANCE':
        return MaintenanceWindowResourceType.instance;
      case 'RESOURCE_GROUP':
        return MaintenanceWindowResourceType.resourceGroup;
    }
    throw Exception('$this is not known in enum MaintenanceWindowResourceType');
  }
}

/// The parameters for a RUN_COMMAND task type.
///
/// For information about specifying and updating task parameters, see
/// <a>RegisterTaskWithMaintenanceWindow</a> and
/// <a>UpdateMaintenanceWindowTask</a>.
/// <note>
/// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
/// contain logs, instead use the <code>OutputS3BucketName</code> and
/// <code>OutputS3KeyPrefix</code> options in the
/// <code>TaskInvocationParameters</code> structure. For information about how
/// Systems Manager handles these options for the supported maintenance window
/// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
///
/// <code>TaskParameters</code> has been deprecated. To specify parameters to
/// pass to a task when it runs, instead use the <code>Parameters</code> option
/// in the <code>TaskInvocationParameters</code> structure. For information
/// about how Systems Manager handles these options for the supported
/// maintenance window task types, see
/// <a>MaintenanceWindowTaskInvocationParameters</a>.
///
/// For Run Command tasks, Systems Manager uses specified values for
/// <code>TaskParameters</code> and <code>LoggingInfo</code> only if no values
/// are specified for <code>TaskInvocationParameters</code>.
/// </note>
class MaintenanceWindowRunCommandParameters {
  final CloudWatchOutputConfig? cloudWatchOutputConfig;

  /// Information about the commands to run.
  final String? comment;

  /// The SHA-256 or SHA-1 hash created by the system when the document was
  /// created. SHA-1 hashes have been deprecated.
  final String? documentHash;

  /// SHA-256 or SHA-1. SHA-1 hashes have been deprecated.
  final DocumentHashType? documentHashType;

  /// The SSM document version to use in the request. You can specify $DEFAULT,
  /// $LATEST, or a specific version number. If you run commands by using the AWS
  /// CLI, then you must escape the first two options by using a backslash. If you
  /// specify a version number, then you don't need to use the backslash. For
  /// example:
  ///
  /// --document-version "\$DEFAULT"
  ///
  /// --document-version "\$LATEST"
  ///
  /// --document-version "3"
  final String? documentVersion;

  /// Configurations for sending notifications about command status changes on a
  /// per-instance basis.
  final NotificationConfig? notificationConfig;

  /// The name of the S3 bucket.
  final String? outputS3BucketName;

  /// The S3 bucket subfolder.
  final String? outputS3KeyPrefix;

  /// The parameters for the RUN_COMMAND task execution.
  final Map<String, List<String>>? parameters;

  /// The ARN of the IAM service role to use to publish Amazon Simple Notification
  /// Service (Amazon SNS) notifications for maintenance window Run Command tasks.
  final String? serviceRoleArn;

  /// If this time is reached and the command has not already started running, it
  /// doesn't run.
  final int? timeoutSeconds;

  MaintenanceWindowRunCommandParameters({
    this.cloudWatchOutputConfig,
    this.comment,
    this.documentHash,
    this.documentHashType,
    this.documentVersion,
    this.notificationConfig,
    this.outputS3BucketName,
    this.outputS3KeyPrefix,
    this.parameters,
    this.serviceRoleArn,
    this.timeoutSeconds,
  });
  factory MaintenanceWindowRunCommandParameters.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowRunCommandParameters(
      cloudWatchOutputConfig: json['CloudWatchOutputConfig'] != null
          ? CloudWatchOutputConfig.fromJson(
              json['CloudWatchOutputConfig'] as Map<String, dynamic>)
          : null,
      comment: json['Comment'] as String?,
      documentHash: json['DocumentHash'] as String?,
      documentHashType:
          (json['DocumentHashType'] as String?)?.toDocumentHashType(),
      documentVersion: json['DocumentVersion'] as String?,
      notificationConfig: json['NotificationConfig'] != null
          ? NotificationConfig.fromJson(
              json['NotificationConfig'] as Map<String, dynamic>)
          : null,
      outputS3BucketName: json['OutputS3BucketName'] as String?,
      outputS3KeyPrefix: json['OutputS3KeyPrefix'] as String?,
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      serviceRoleArn: json['ServiceRoleArn'] as String?,
      timeoutSeconds: json['TimeoutSeconds'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final cloudWatchOutputConfig = this.cloudWatchOutputConfig;
    final comment = this.comment;
    final documentHash = this.documentHash;
    final documentHashType = this.documentHashType;
    final documentVersion = this.documentVersion;
    final notificationConfig = this.notificationConfig;
    final outputS3BucketName = this.outputS3BucketName;
    final outputS3KeyPrefix = this.outputS3KeyPrefix;
    final parameters = this.parameters;
    final serviceRoleArn = this.serviceRoleArn;
    final timeoutSeconds = this.timeoutSeconds;
    return {
      if (cloudWatchOutputConfig != null)
        'CloudWatchOutputConfig': cloudWatchOutputConfig,
      if (comment != null) 'Comment': comment,
      if (documentHash != null) 'DocumentHash': documentHash,
      if (documentHashType != null)
        'DocumentHashType': documentHashType.toValue(),
      if (documentVersion != null) 'DocumentVersion': documentVersion,
      if (notificationConfig != null) 'NotificationConfig': notificationConfig,
      if (outputS3BucketName != null) 'OutputS3BucketName': outputS3BucketName,
      if (outputS3KeyPrefix != null) 'OutputS3KeyPrefix': outputS3KeyPrefix,
      if (parameters != null) 'Parameters': parameters,
      if (serviceRoleArn != null) 'ServiceRoleArn': serviceRoleArn,
      if (timeoutSeconds != null) 'TimeoutSeconds': timeoutSeconds,
    };
  }
}

/// The parameters for a STEP_FUNCTIONS task.
///
/// For information about specifying and updating task parameters, see
/// <a>RegisterTaskWithMaintenanceWindow</a> and
/// <a>UpdateMaintenanceWindowTask</a>.
/// <note>
/// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
/// contain logs, instead use the <code>OutputS3BucketName</code> and
/// <code>OutputS3KeyPrefix</code> options in the
/// <code>TaskInvocationParameters</code> structure. For information about how
/// Systems Manager handles these options for the supported maintenance window
/// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
///
/// <code>TaskParameters</code> has been deprecated. To specify parameters to
/// pass to a task when it runs, instead use the <code>Parameters</code> option
/// in the <code>TaskInvocationParameters</code> structure. For information
/// about how Systems Manager handles these options for the supported
/// maintenance window task types, see
/// <a>MaintenanceWindowTaskInvocationParameters</a>.
///
/// For Step Functions tasks, Systems Manager ignores any values specified for
/// <code>TaskParameters</code> and <code>LoggingInfo</code>.
/// </note>
class MaintenanceWindowStepFunctionsParameters {
  /// The inputs for the STEP_FUNCTIONS task.
  final String? input;

  /// The name of the STEP_FUNCTIONS task.
  final String? name;

  MaintenanceWindowStepFunctionsParameters({
    this.input,
    this.name,
  });
  factory MaintenanceWindowStepFunctionsParameters.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowStepFunctionsParameters(
      input: json['Input'] as String?,
      name: json['Name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final input = this.input;
    final name = this.name;
    return {
      if (input != null) 'Input': input,
      if (name != null) 'Name': name,
    };
  }
}

/// The target registered with the maintenance window.
class MaintenanceWindowTarget {
  /// A description for the target.
  final String? description;

  /// The name for the maintenance window target.
  final String? name;

  /// A user-provided value that will be included in any CloudWatch events that
  /// are raised while running tasks for these targets in this maintenance window.
  final String? ownerInformation;

  /// The type of target that is being registered with the maintenance window.
  final MaintenanceWindowResourceType? resourceType;

  /// The targets, either instances or tags.
  ///
  /// Specify instances using the following format:
  ///
  /// <code>Key=instanceids,Values=&lt;instanceid1&gt;,&lt;instanceid2&gt;</code>
  ///
  /// Tags are specified using the following format:
  ///
  /// <code>Key=&lt;tag name&gt;,Values=&lt;tag value&gt;</code>.
  final List<Target>? targets;

  /// The ID of the maintenance window to register the target with.
  final String? windowId;

  /// The ID of the target.
  final String? windowTargetId;

  MaintenanceWindowTarget({
    this.description,
    this.name,
    this.ownerInformation,
    this.resourceType,
    this.targets,
    this.windowId,
    this.windowTargetId,
  });
  factory MaintenanceWindowTarget.fromJson(Map<String, dynamic> json) {
    return MaintenanceWindowTarget(
      description: json['Description'] as String?,
      name: json['Name'] as String?,
      ownerInformation: json['OwnerInformation'] as String?,
      resourceType:
          (json['ResourceType'] as String?)?.toMaintenanceWindowResourceType(),
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
      windowId: json['WindowId'] as String?,
      windowTargetId: json['WindowTargetId'] as String?,
    );
  }
}

/// Information about a task defined for a maintenance window.
class MaintenanceWindowTask {
  /// A description of the task.
  final String? description;

  /// Information about an S3 bucket to write task-level logs to.
  /// <note>
  /// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
  /// contain logs, instead use the <code>OutputS3BucketName</code> and
  /// <code>OutputS3KeyPrefix</code> options in the
  /// <code>TaskInvocationParameters</code> structure. For information about how
  /// Systems Manager handles these options for the supported maintenance window
  /// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  final LoggingInfo? loggingInfo;

  /// The maximum number of targets this task can be run for, in parallel.
  final String? maxConcurrency;

  /// The maximum number of errors allowed before this task stops being scheduled.
  final String? maxErrors;

  /// The task name.
  final String? name;

  /// The priority of the task in the maintenance window. The lower the number,
  /// the higher the priority. Tasks that have the same priority are scheduled in
  /// parallel.
  final int? priority;

  /// The ARN of the IAM service role to use to publish Amazon Simple Notification
  /// Service (Amazon SNS) notifications for maintenance window Run Command tasks.
  final String? serviceRoleArn;

  /// The targets (either instances or tags). Instances are specified using
  /// Key=instanceids,Values=&lt;instanceid1&gt;,&lt;instanceid2&gt;. Tags are
  /// specified using Key=&lt;tag name&gt;,Values=&lt;tag value&gt;.
  final List<Target>? targets;

  /// The resource that the task uses during execution. For RUN_COMMAND and
  /// AUTOMATION task types, <code>TaskArn</code> is the Systems Manager document
  /// name or ARN. For LAMBDA tasks, it's the function name or ARN. For
  /// STEP_FUNCTIONS tasks, it's the state machine ARN.
  final String? taskArn;

  /// The parameters that should be passed to the task when it is run.
  /// <note>
  /// <code>TaskParameters</code> has been deprecated. To specify parameters to
  /// pass to a task when it runs, instead use the <code>Parameters</code> option
  /// in the <code>TaskInvocationParameters</code> structure. For information
  /// about how Systems Manager handles these options for the supported
  /// maintenance window task types, see
  /// <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  final Map<String, MaintenanceWindowTaskParameterValueExpression>?
      taskParameters;

  /// The type of task. The type can be one of the following: RUN_COMMAND,
  /// AUTOMATION, LAMBDA, or STEP_FUNCTIONS.
  final MaintenanceWindowTaskType? type;

  /// The ID of the maintenance window where the task is registered.
  final String? windowId;

  /// The task ID.
  final String? windowTaskId;

  MaintenanceWindowTask({
    this.description,
    this.loggingInfo,
    this.maxConcurrency,
    this.maxErrors,
    this.name,
    this.priority,
    this.serviceRoleArn,
    this.targets,
    this.taskArn,
    this.taskParameters,
    this.type,
    this.windowId,
    this.windowTaskId,
  });
  factory MaintenanceWindowTask.fromJson(Map<String, dynamic> json) {
    return MaintenanceWindowTask(
      description: json['Description'] as String?,
      loggingInfo: json['LoggingInfo'] != null
          ? LoggingInfo.fromJson(json['LoggingInfo'] as Map<String, dynamic>)
          : null,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      name: json['Name'] as String?,
      priority: json['Priority'] as int?,
      serviceRoleArn: json['ServiceRoleArn'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskArn: json['TaskArn'] as String?,
      taskParameters: (json['TaskParameters'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k,
              MaintenanceWindowTaskParameterValueExpression.fromJson(
                  e as Map<String, dynamic>))),
      type: (json['Type'] as String?)?.toMaintenanceWindowTaskType(),
      windowId: json['WindowId'] as String?,
      windowTaskId: json['WindowTaskId'] as String?,
    );
  }
}

/// The parameters for task execution.
class MaintenanceWindowTaskInvocationParameters {
  /// The parameters for an AUTOMATION task type.
  final MaintenanceWindowAutomationParameters? automation;

  /// The parameters for a LAMBDA task type.
  final MaintenanceWindowLambdaParameters? lambda;

  /// The parameters for a RUN_COMMAND task type.
  final MaintenanceWindowRunCommandParameters? runCommand;

  /// The parameters for a STEP_FUNCTIONS task type.
  final MaintenanceWindowStepFunctionsParameters? stepFunctions;

  MaintenanceWindowTaskInvocationParameters({
    this.automation,
    this.lambda,
    this.runCommand,
    this.stepFunctions,
  });
  factory MaintenanceWindowTaskInvocationParameters.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowTaskInvocationParameters(
      automation: json['Automation'] != null
          ? MaintenanceWindowAutomationParameters.fromJson(
              json['Automation'] as Map<String, dynamic>)
          : null,
      lambda: json['Lambda'] != null
          ? MaintenanceWindowLambdaParameters.fromJson(
              json['Lambda'] as Map<String, dynamic>)
          : null,
      runCommand: json['RunCommand'] != null
          ? MaintenanceWindowRunCommandParameters.fromJson(
              json['RunCommand'] as Map<String, dynamic>)
          : null,
      stepFunctions: json['StepFunctions'] != null
          ? MaintenanceWindowStepFunctionsParameters.fromJson(
              json['StepFunctions'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final automation = this.automation;
    final lambda = this.lambda;
    final runCommand = this.runCommand;
    final stepFunctions = this.stepFunctions;
    return {
      if (automation != null) 'Automation': automation,
      if (lambda != null) 'Lambda': lambda,
      if (runCommand != null) 'RunCommand': runCommand,
      if (stepFunctions != null) 'StepFunctions': stepFunctions,
    };
  }
}

/// Defines the values for a task parameter.
class MaintenanceWindowTaskParameterValueExpression {
  /// This field contains an array of 0 or more strings, each 1 to 255 characters
  /// in length.
  final List<String>? values;

  MaintenanceWindowTaskParameterValueExpression({
    this.values,
  });
  factory MaintenanceWindowTaskParameterValueExpression.fromJson(
      Map<String, dynamic> json) {
    return MaintenanceWindowTaskParameterValueExpression(
      values: (json['Values'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final values = this.values;
    return {
      if (values != null) 'Values': values,
    };
  }
}

enum MaintenanceWindowTaskType {
  runCommand,
  automation,
  stepFunctions,
  lambda,
}

extension on MaintenanceWindowTaskType {
  String toValue() {
    switch (this) {
      case MaintenanceWindowTaskType.runCommand:
        return 'RUN_COMMAND';
      case MaintenanceWindowTaskType.automation:
        return 'AUTOMATION';
      case MaintenanceWindowTaskType.stepFunctions:
        return 'STEP_FUNCTIONS';
      case MaintenanceWindowTaskType.lambda:
        return 'LAMBDA';
    }
  }
}

extension on String {
  MaintenanceWindowTaskType toMaintenanceWindowTaskType() {
    switch (this) {
      case 'RUN_COMMAND':
        return MaintenanceWindowTaskType.runCommand;
      case 'AUTOMATION':
        return MaintenanceWindowTaskType.automation;
      case 'STEP_FUNCTIONS':
        return MaintenanceWindowTaskType.stepFunctions;
      case 'LAMBDA':
        return MaintenanceWindowTaskType.lambda;
    }
    throw Exception('$this is not known in enum MaintenanceWindowTaskType');
  }
}

/// Metadata to assign to an Application Manager application.
class MetadataValue {
  /// Metadata value to assign to an Application Manager application.
  final String? value;

  MetadataValue({
    this.value,
  });
  factory MetadataValue.fromJson(Map<String, dynamic> json) {
    return MetadataValue(
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final value = this.value;
    return {
      if (value != null) 'Value': value,
    };
  }
}

class ModifyDocumentPermissionResponse {
  ModifyDocumentPermissionResponse();
  factory ModifyDocumentPermissionResponse.fromJson(Map<String, dynamic> _) {
    return ModifyDocumentPermissionResponse();
  }
}

/// A summary of resources that are not compliant. The summary is organized
/// according to resource type.
class NonCompliantSummary {
  /// The total number of compliance items that are not compliant.
  final int? nonCompliantCount;

  /// A summary of the non-compliance severity by compliance type
  final SeveritySummary? severitySummary;

  NonCompliantSummary({
    this.nonCompliantCount,
    this.severitySummary,
  });
  factory NonCompliantSummary.fromJson(Map<String, dynamic> json) {
    return NonCompliantSummary(
      nonCompliantCount: json['NonCompliantCount'] as int?,
      severitySummary: json['SeveritySummary'] != null
          ? SeveritySummary.fromJson(
              json['SeveritySummary'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Configurations for sending notifications.
class NotificationConfig {
  /// An Amazon Resource Name (ARN) for an Amazon Simple Notification Service
  /// (Amazon SNS) topic. Run Command pushes notifications about command status
  /// changes to this topic.
  final String? notificationArn;

  /// The different events for which you can receive notifications. These events
  /// include the following: All (events), InProgress, Success, TimedOut,
  /// Cancelled, Failed. To learn more about these events, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/monitoring-sns-notifications.html">Monitoring
  /// Systems Manager status changes using Amazon SNS notifications</a> in the
  /// <i>AWS Systems Manager User Guide</i>.
  final List<NotificationEvent>? notificationEvents;

  /// Command: Receive notification when the status of a command changes.
  /// Invocation: For commands sent to multiple instances, receive notification on
  /// a per-instance basis when the status of a command changes.
  final NotificationType? notificationType;

  NotificationConfig({
    this.notificationArn,
    this.notificationEvents,
    this.notificationType,
  });
  factory NotificationConfig.fromJson(Map<String, dynamic> json) {
    return NotificationConfig(
      notificationArn: json['NotificationArn'] as String?,
      notificationEvents: (json['NotificationEvents'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toNotificationEvent())
          .toList(),
      notificationType:
          (json['NotificationType'] as String?)?.toNotificationType(),
    );
  }

  Map<String, dynamic> toJson() {
    final notificationArn = this.notificationArn;
    final notificationEvents = this.notificationEvents;
    final notificationType = this.notificationType;
    return {
      if (notificationArn != null) 'NotificationArn': notificationArn,
      if (notificationEvents != null)
        'NotificationEvents':
            notificationEvents.map((e) => e.toValue()).toList(),
      if (notificationType != null)
        'NotificationType': notificationType.toValue(),
    };
  }
}

enum NotificationEvent {
  all,
  inProgress,
  success,
  timedOut,
  cancelled,
  failed,
}

extension on NotificationEvent {
  String toValue() {
    switch (this) {
      case NotificationEvent.all:
        return 'All';
      case NotificationEvent.inProgress:
        return 'InProgress';
      case NotificationEvent.success:
        return 'Success';
      case NotificationEvent.timedOut:
        return 'TimedOut';
      case NotificationEvent.cancelled:
        return 'Cancelled';
      case NotificationEvent.failed:
        return 'Failed';
    }
  }
}

extension on String {
  NotificationEvent toNotificationEvent() {
    switch (this) {
      case 'All':
        return NotificationEvent.all;
      case 'InProgress':
        return NotificationEvent.inProgress;
      case 'Success':
        return NotificationEvent.success;
      case 'TimedOut':
        return NotificationEvent.timedOut;
      case 'Cancelled':
        return NotificationEvent.cancelled;
      case 'Failed':
        return NotificationEvent.failed;
    }
    throw Exception('$this is not known in enum NotificationEvent');
  }
}

enum NotificationType {
  command,
  invocation,
}

extension on NotificationType {
  String toValue() {
    switch (this) {
      case NotificationType.command:
        return 'Command';
      case NotificationType.invocation:
        return 'Invocation';
    }
  }
}

extension on String {
  NotificationType toNotificationType() {
    switch (this) {
      case 'Command':
        return NotificationType.command;
      case 'Invocation':
        return NotificationType.invocation;
    }
    throw Exception('$this is not known in enum NotificationType');
  }
}

enum OperatingSystem {
  windows,
  amazonLinux,
  amazonLinux_2,
  ubuntu,
  redhatEnterpriseLinux,
  suse,
  centos,
  oracleLinux,
  debian,
  macos,
}

extension on OperatingSystem {
  String toValue() {
    switch (this) {
      case OperatingSystem.windows:
        return 'WINDOWS';
      case OperatingSystem.amazonLinux:
        return 'AMAZON_LINUX';
      case OperatingSystem.amazonLinux_2:
        return 'AMAZON_LINUX_2';
      case OperatingSystem.ubuntu:
        return 'UBUNTU';
      case OperatingSystem.redhatEnterpriseLinux:
        return 'REDHAT_ENTERPRISE_LINUX';
      case OperatingSystem.suse:
        return 'SUSE';
      case OperatingSystem.centos:
        return 'CENTOS';
      case OperatingSystem.oracleLinux:
        return 'ORACLE_LINUX';
      case OperatingSystem.debian:
        return 'DEBIAN';
      case OperatingSystem.macos:
        return 'MACOS';
    }
  }
}

extension on String {
  OperatingSystem toOperatingSystem() {
    switch (this) {
      case 'WINDOWS':
        return OperatingSystem.windows;
      case 'AMAZON_LINUX':
        return OperatingSystem.amazonLinux;
      case 'AMAZON_LINUX_2':
        return OperatingSystem.amazonLinux_2;
      case 'UBUNTU':
        return OperatingSystem.ubuntu;
      case 'REDHAT_ENTERPRISE_LINUX':
        return OperatingSystem.redhatEnterpriseLinux;
      case 'SUSE':
        return OperatingSystem.suse;
      case 'CENTOS':
        return OperatingSystem.centos;
      case 'ORACLE_LINUX':
        return OperatingSystem.oracleLinux;
      case 'DEBIAN':
        return OperatingSystem.debian;
      case 'MACOS':
        return OperatingSystem.macos;
    }
    throw Exception('$this is not known in enum OperatingSystem');
  }
}

/// One or more aggregators for viewing counts of OpsItems using different
/// dimensions such as <code>Source</code>, <code>CreatedTime</code>, or
/// <code>Source and CreatedTime</code>, to name a few.
class OpsAggregator {
  /// Either a Range or Count aggregator for limiting an OpsItem summary.
  final String? aggregatorType;

  /// A nested aggregator for viewing counts of OpsItems.
  final List<OpsAggregator>? aggregators;

  /// The name of an OpsItem attribute on which to limit the count of OpsItems.
  final String? attributeName;

  /// The aggregator filters.
  final List<OpsFilter>? filters;

  /// The data type name to use for viewing counts of OpsItems.
  final String? typeName;

  /// The aggregator value.
  final Map<String, String>? values;

  OpsAggregator({
    this.aggregatorType,
    this.aggregators,
    this.attributeName,
    this.filters,
    this.typeName,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final aggregatorType = this.aggregatorType;
    final aggregators = this.aggregators;
    final attributeName = this.attributeName;
    final filters = this.filters;
    final typeName = this.typeName;
    final values = this.values;
    return {
      if (aggregatorType != null) 'AggregatorType': aggregatorType,
      if (aggregators != null) 'Aggregators': aggregators,
      if (attributeName != null) 'AttributeName': attributeName,
      if (filters != null) 'Filters': filters,
      if (typeName != null) 'TypeName': typeName,
      if (values != null) 'Values': values,
    };
  }
}

/// The result of the query.
class OpsEntity {
  /// The data returned by the query.
  final Map<String, OpsEntityItem>? data;

  /// The query ID.
  final String? id;

  OpsEntity({
    this.data,
    this.id,
  });
  factory OpsEntity.fromJson(Map<String, dynamic> json) {
    return OpsEntity(
      data: (json['Data'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(k, OpsEntityItem.fromJson(e as Map<String, dynamic>))),
      id: json['Id'] as String?,
    );
  }
}

/// The OpsItem summaries result item.
class OpsEntityItem {
  /// The time OpsItem data was captured.
  final String? captureTime;

  /// The detailed data content for an OpsItem summaries result item.
  final List<Map<String, String>>? content;

  OpsEntityItem({
    this.captureTime,
    this.content,
  });
  factory OpsEntityItem.fromJson(Map<String, dynamic> json) {
    return OpsEntityItem(
      captureTime: json['CaptureTime'] as String?,
      content: (json['Content'] as List?)
          ?.whereNotNull()
          .map((e) => (e as Map<String, dynamic>)
              .map((k, e) => MapEntry(k, e as String)))
          .toList(),
    );
  }
}

/// A filter for viewing OpsItem summaries.
class OpsFilter {
  /// The name of the filter.
  final String key;

  /// The filter value.
  final List<String> values;

  /// The type of filter.
  final OpsFilterOperatorType? type;

  OpsFilter({
    required this.key,
    required this.values,
    this.type,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    final type = this.type;
    return {
      'Key': key,
      'Values': values,
      if (type != null) 'Type': type.toValue(),
    };
  }
}

enum OpsFilterOperatorType {
  equal,
  notEqual,
  beginWith,
  lessThan,
  greaterThan,
  exists,
}

extension on OpsFilterOperatorType {
  String toValue() {
    switch (this) {
      case OpsFilterOperatorType.equal:
        return 'Equal';
      case OpsFilterOperatorType.notEqual:
        return 'NotEqual';
      case OpsFilterOperatorType.beginWith:
        return 'BeginWith';
      case OpsFilterOperatorType.lessThan:
        return 'LessThan';
      case OpsFilterOperatorType.greaterThan:
        return 'GreaterThan';
      case OpsFilterOperatorType.exists:
        return 'Exists';
    }
  }
}

extension on String {
  OpsFilterOperatorType toOpsFilterOperatorType() {
    switch (this) {
      case 'Equal':
        return OpsFilterOperatorType.equal;
      case 'NotEqual':
        return OpsFilterOperatorType.notEqual;
      case 'BeginWith':
        return OpsFilterOperatorType.beginWith;
      case 'LessThan':
        return OpsFilterOperatorType.lessThan;
      case 'GreaterThan':
        return OpsFilterOperatorType.greaterThan;
      case 'Exists':
        return OpsFilterOperatorType.exists;
    }
    throw Exception('$this is not known in enum OpsFilterOperatorType');
  }
}

/// Operations engineers and IT professionals use OpsCenter to view,
/// investigate, and remediate operational issues impacting the performance and
/// health of their AWS resources. For more information, see <a
/// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html">AWS
/// Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>.
class OpsItem {
  /// The time a runbook workflow ended. Currently reported only for the OpsItem
  /// type <code>/aws/changerequest</code>.
  final DateTime? actualEndTime;

  /// The time a runbook workflow started. Currently reported only for the OpsItem
  /// type <code>/aws/changerequest</code>.
  final DateTime? actualStartTime;

  /// An OpsItem category. Category options include: Availability, Cost,
  /// Performance, Recovery, Security.
  final String? category;

  /// The ARN of the AWS account that created the OpsItem.
  final String? createdBy;

  /// The date and time the OpsItem was created.
  final DateTime? createdTime;

  /// The OpsItem description.
  final String? description;

  /// The ARN of the AWS account that last updated the OpsItem.
  final String? lastModifiedBy;

  /// The date and time the OpsItem was last updated.
  final DateTime? lastModifiedTime;

  /// The Amazon Resource Name (ARN) of an SNS topic where notifications are sent
  /// when this OpsItem is edited or changed.
  final List<OpsItemNotification>? notifications;

  /// Operational data is custom data that provides useful reference details about
  /// the OpsItem. For example, you can specify log files, error strings, license
  /// keys, troubleshooting tips, or other relevant data. You enter operational
  /// data as key-value pairs. The key has a maximum length of 128 characters. The
  /// value has a maximum size of 20 KB.
  /// <important>
  /// Operational data keys <i>can't</i> begin with the following: amazon, aws,
  /// amzn, ssm, /amazon, /aws, /amzn, /ssm.
  /// </important>
  /// You can choose to make the data searchable by other users in the account or
  /// you can restrict search access. Searchable data means that all users with
  /// access to the OpsItem Overview page (as provided by the
  /// <a>DescribeOpsItems</a> API action) can view and search on the specified
  /// data. Operational data that is not searchable is only viewable by users who
  /// have access to the OpsItem (as provided by the <a>GetOpsItem</a> API
  /// action).
  ///
  /// Use the <code>/aws/resources</code> key in OperationalData to specify a
  /// related resource in the request. Use the <code>/aws/automations</code> key
  /// in OperationalData to associate an Automation runbook with the OpsItem. To
  /// view AWS CLI example commands that use these keys, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-creating-OpsItems.html#OpsCenter-manually-create-OpsItems">Creating
  /// OpsItems manually</a> in the <i>AWS Systems Manager User Guide</i>.
  final Map<String, OpsItemDataValue>? operationalData;

  /// The ID of the OpsItem.
  final String? opsItemId;

  /// The type of OpsItem. Currently, the only valid values are
  /// <code>/aws/changerequest</code> and <code>/aws/issue</code>.
  final String? opsItemType;

  /// The time specified in a change request for a runbook workflow to end.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  final DateTime? plannedEndTime;

  /// The time specified in a change request for a runbook workflow to start.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  final DateTime? plannedStartTime;

  /// The importance of this OpsItem in relation to other OpsItems in the system.
  final int? priority;

  /// One or more OpsItems that share something in common with the current
  /// OpsItem. For example, related OpsItems can include OpsItems with similar
  /// error messages, impacted resources, or statuses for the impacted resource.
  final List<RelatedOpsItem>? relatedOpsItems;

  /// The severity of the OpsItem. Severity options range from 1 to 4.
  final String? severity;

  /// The origin of the OpsItem, such as Amazon EC2 or Systems Manager. The
  /// impacted resource is a subset of source.
  final String? source;

  /// The OpsItem status. Status can be <code>Open</code>, <code>In
  /// Progress</code>, or <code>Resolved</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-working-with-OpsItems-editing-details.html">Editing
  /// OpsItem details</a> in the <i>AWS Systems Manager User Guide</i>.
  final OpsItemStatus? status;

  /// A short heading that describes the nature of the OpsItem and the impacted
  /// resource.
  final String? title;

  /// The version of this OpsItem. Each time the OpsItem is edited the version
  /// number increments by one.
  final String? version;

  OpsItem({
    this.actualEndTime,
    this.actualStartTime,
    this.category,
    this.createdBy,
    this.createdTime,
    this.description,
    this.lastModifiedBy,
    this.lastModifiedTime,
    this.notifications,
    this.operationalData,
    this.opsItemId,
    this.opsItemType,
    this.plannedEndTime,
    this.plannedStartTime,
    this.priority,
    this.relatedOpsItems,
    this.severity,
    this.source,
    this.status,
    this.title,
    this.version,
  });
  factory OpsItem.fromJson(Map<String, dynamic> json) {
    return OpsItem(
      actualEndTime: timeStampFromJson(json['ActualEndTime']),
      actualStartTime: timeStampFromJson(json['ActualStartTime']),
      category: json['Category'] as String?,
      createdBy: json['CreatedBy'] as String?,
      createdTime: timeStampFromJson(json['CreatedTime']),
      description: json['Description'] as String?,
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      notifications: (json['Notifications'] as List?)
          ?.whereNotNull()
          .map((e) => OpsItemNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
      operationalData: (json['OperationalData'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k, OpsItemDataValue.fromJson(e as Map<String, dynamic>))),
      opsItemId: json['OpsItemId'] as String?,
      opsItemType: json['OpsItemType'] as String?,
      plannedEndTime: timeStampFromJson(json['PlannedEndTime']),
      plannedStartTime: timeStampFromJson(json['PlannedStartTime']),
      priority: json['Priority'] as int?,
      relatedOpsItems: (json['RelatedOpsItems'] as List?)
          ?.whereNotNull()
          .map((e) => RelatedOpsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      severity: json['Severity'] as String?,
      source: json['Source'] as String?,
      status: (json['Status'] as String?)?.toOpsItemStatus(),
      title: json['Title'] as String?,
      version: json['Version'] as String?,
    );
  }
}

enum OpsItemDataType {
  searchableString,
  string,
}

extension on OpsItemDataType {
  String toValue() {
    switch (this) {
      case OpsItemDataType.searchableString:
        return 'SearchableString';
      case OpsItemDataType.string:
        return 'String';
    }
  }
}

extension on String {
  OpsItemDataType toOpsItemDataType() {
    switch (this) {
      case 'SearchableString':
        return OpsItemDataType.searchableString;
      case 'String':
        return OpsItemDataType.string;
    }
    throw Exception('$this is not known in enum OpsItemDataType');
  }
}

/// An object that defines the value of the key and its type in the
/// OperationalData map.
class OpsItemDataValue {
  /// The type of key-value pair. Valid types include
  /// <code>SearchableString</code> and <code>String</code>.
  final OpsItemDataType? type;

  /// The value of the OperationalData key.
  final String? value;

  OpsItemDataValue({
    this.type,
    this.value,
  });
  factory OpsItemDataValue.fromJson(Map<String, dynamic> json) {
    return OpsItemDataValue(
      type: (json['Type'] as String?)?.toOpsItemDataType(),
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final type = this.type;
    final value = this.value;
    return {
      if (type != null) 'Type': type.toValue(),
      if (value != null) 'Value': value,
    };
  }
}

/// Describes a filter for a specific list of OpsItem events. You can filter
/// event information by using tags. You specify tags by using a key-value pair
/// mapping.
class OpsItemEventFilter {
  /// The name of the filter key. Currently, the only supported value is
  /// <code>OpsItemId</code>.
  final OpsItemEventFilterKey key;

  /// The operator used by the filter call. Currently, the only supported value is
  /// <code>Equal</code>.
  final OpsItemEventFilterOperator operator;

  /// The values for the filter, consisting of one or more OpsItem IDs.
  final List<String> values;

  OpsItemEventFilter({
    required this.key,
    required this.operator,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final operator = this.operator;
    final values = this.values;
    return {
      'Key': key.toValue(),
      'Operator': operator.toValue(),
      'Values': values,
    };
  }
}

enum OpsItemEventFilterKey {
  opsItemId,
}

extension on OpsItemEventFilterKey {
  String toValue() {
    switch (this) {
      case OpsItemEventFilterKey.opsItemId:
        return 'OpsItemId';
    }
  }
}

extension on String {
  OpsItemEventFilterKey toOpsItemEventFilterKey() {
    switch (this) {
      case 'OpsItemId':
        return OpsItemEventFilterKey.opsItemId;
    }
    throw Exception('$this is not known in enum OpsItemEventFilterKey');
  }
}

enum OpsItemEventFilterOperator {
  equal,
}

extension on OpsItemEventFilterOperator {
  String toValue() {
    switch (this) {
      case OpsItemEventFilterOperator.equal:
        return 'Equal';
    }
  }
}

extension on String {
  OpsItemEventFilterOperator toOpsItemEventFilterOperator() {
    switch (this) {
      case 'Equal':
        return OpsItemEventFilterOperator.equal;
    }
    throw Exception('$this is not known in enum OpsItemEventFilterOperator');
  }
}

/// Summary information about an OpsItem event.
class OpsItemEventSummary {
  /// Information about the user or resource that created the OpsItem event.
  final OpsItemIdentity? createdBy;

  /// The date and time the OpsItem event was created.
  final DateTime? createdTime;

  /// Specific information about the OpsItem event.
  final String? detail;

  /// The type of information provided as a detail.
  final String? detailType;

  /// The ID of the OpsItem event.
  final String? eventId;

  /// The ID of the OpsItem.
  final String? opsItemId;

  /// The source of the OpsItem event.
  final String? source;

  OpsItemEventSummary({
    this.createdBy,
    this.createdTime,
    this.detail,
    this.detailType,
    this.eventId,
    this.opsItemId,
    this.source,
  });
  factory OpsItemEventSummary.fromJson(Map<String, dynamic> json) {
    return OpsItemEventSummary(
      createdBy: json['CreatedBy'] != null
          ? OpsItemIdentity.fromJson(json['CreatedBy'] as Map<String, dynamic>)
          : null,
      createdTime: timeStampFromJson(json['CreatedTime']),
      detail: json['Detail'] as String?,
      detailType: json['DetailType'] as String?,
      eventId: json['EventId'] as String?,
      opsItemId: json['OpsItemId'] as String?,
      source: json['Source'] as String?,
    );
  }
}

/// Describes an OpsItem filter.
class OpsItemFilter {
  /// The name of the filter.
  final OpsItemFilterKey key;

  /// The operator used by the filter call.
  final OpsItemFilterOperator operator;

  /// The filter value.
  final List<String> values;

  OpsItemFilter({
    required this.key,
    required this.operator,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final operator = this.operator;
    final values = this.values;
    return {
      'Key': key.toValue(),
      'Operator': operator.toValue(),
      'Values': values,
    };
  }
}

enum OpsItemFilterKey {
  status,
  createdBy,
  source,
  priority,
  title,
  opsItemId,
  createdTime,
  lastModifiedTime,
  actualStartTime,
  actualEndTime,
  plannedStartTime,
  plannedEndTime,
  operationalData,
  operationalDataKey,
  operationalDataValue,
  resourceId,
  automationId,
  category,
  severity,
  opsItemType,
  changeRequestByRequesterArn,
  changeRequestByRequesterName,
  changeRequestByApproverArn,
  changeRequestByApproverName,
  changeRequestByTemplate,
  changeRequestByTargetsResourceGroup,
}

extension on OpsItemFilterKey {
  String toValue() {
    switch (this) {
      case OpsItemFilterKey.status:
        return 'Status';
      case OpsItemFilterKey.createdBy:
        return 'CreatedBy';
      case OpsItemFilterKey.source:
        return 'Source';
      case OpsItemFilterKey.priority:
        return 'Priority';
      case OpsItemFilterKey.title:
        return 'Title';
      case OpsItemFilterKey.opsItemId:
        return 'OpsItemId';
      case OpsItemFilterKey.createdTime:
        return 'CreatedTime';
      case OpsItemFilterKey.lastModifiedTime:
        return 'LastModifiedTime';
      case OpsItemFilterKey.actualStartTime:
        return 'ActualStartTime';
      case OpsItemFilterKey.actualEndTime:
        return 'ActualEndTime';
      case OpsItemFilterKey.plannedStartTime:
        return 'PlannedStartTime';
      case OpsItemFilterKey.plannedEndTime:
        return 'PlannedEndTime';
      case OpsItemFilterKey.operationalData:
        return 'OperationalData';
      case OpsItemFilterKey.operationalDataKey:
        return 'OperationalDataKey';
      case OpsItemFilterKey.operationalDataValue:
        return 'OperationalDataValue';
      case OpsItemFilterKey.resourceId:
        return 'ResourceId';
      case OpsItemFilterKey.automationId:
        return 'AutomationId';
      case OpsItemFilterKey.category:
        return 'Category';
      case OpsItemFilterKey.severity:
        return 'Severity';
      case OpsItemFilterKey.opsItemType:
        return 'OpsItemType';
      case OpsItemFilterKey.changeRequestByRequesterArn:
        return 'ChangeRequestByRequesterArn';
      case OpsItemFilterKey.changeRequestByRequesterName:
        return 'ChangeRequestByRequesterName';
      case OpsItemFilterKey.changeRequestByApproverArn:
        return 'ChangeRequestByApproverArn';
      case OpsItemFilterKey.changeRequestByApproverName:
        return 'ChangeRequestByApproverName';
      case OpsItemFilterKey.changeRequestByTemplate:
        return 'ChangeRequestByTemplate';
      case OpsItemFilterKey.changeRequestByTargetsResourceGroup:
        return 'ChangeRequestByTargetsResourceGroup';
    }
  }
}

extension on String {
  OpsItemFilterKey toOpsItemFilterKey() {
    switch (this) {
      case 'Status':
        return OpsItemFilterKey.status;
      case 'CreatedBy':
        return OpsItemFilterKey.createdBy;
      case 'Source':
        return OpsItemFilterKey.source;
      case 'Priority':
        return OpsItemFilterKey.priority;
      case 'Title':
        return OpsItemFilterKey.title;
      case 'OpsItemId':
        return OpsItemFilterKey.opsItemId;
      case 'CreatedTime':
        return OpsItemFilterKey.createdTime;
      case 'LastModifiedTime':
        return OpsItemFilterKey.lastModifiedTime;
      case 'ActualStartTime':
        return OpsItemFilterKey.actualStartTime;
      case 'ActualEndTime':
        return OpsItemFilterKey.actualEndTime;
      case 'PlannedStartTime':
        return OpsItemFilterKey.plannedStartTime;
      case 'PlannedEndTime':
        return OpsItemFilterKey.plannedEndTime;
      case 'OperationalData':
        return OpsItemFilterKey.operationalData;
      case 'OperationalDataKey':
        return OpsItemFilterKey.operationalDataKey;
      case 'OperationalDataValue':
        return OpsItemFilterKey.operationalDataValue;
      case 'ResourceId':
        return OpsItemFilterKey.resourceId;
      case 'AutomationId':
        return OpsItemFilterKey.automationId;
      case 'Category':
        return OpsItemFilterKey.category;
      case 'Severity':
        return OpsItemFilterKey.severity;
      case 'OpsItemType':
        return OpsItemFilterKey.opsItemType;
      case 'ChangeRequestByRequesterArn':
        return OpsItemFilterKey.changeRequestByRequesterArn;
      case 'ChangeRequestByRequesterName':
        return OpsItemFilterKey.changeRequestByRequesterName;
      case 'ChangeRequestByApproverArn':
        return OpsItemFilterKey.changeRequestByApproverArn;
      case 'ChangeRequestByApproverName':
        return OpsItemFilterKey.changeRequestByApproverName;
      case 'ChangeRequestByTemplate':
        return OpsItemFilterKey.changeRequestByTemplate;
      case 'ChangeRequestByTargetsResourceGroup':
        return OpsItemFilterKey.changeRequestByTargetsResourceGroup;
    }
    throw Exception('$this is not known in enum OpsItemFilterKey');
  }
}

enum OpsItemFilterOperator {
  equal,
  contains,
  greaterThan,
  lessThan,
}

extension on OpsItemFilterOperator {
  String toValue() {
    switch (this) {
      case OpsItemFilterOperator.equal:
        return 'Equal';
      case OpsItemFilterOperator.contains:
        return 'Contains';
      case OpsItemFilterOperator.greaterThan:
        return 'GreaterThan';
      case OpsItemFilterOperator.lessThan:
        return 'LessThan';
    }
  }
}

extension on String {
  OpsItemFilterOperator toOpsItemFilterOperator() {
    switch (this) {
      case 'Equal':
        return OpsItemFilterOperator.equal;
      case 'Contains':
        return OpsItemFilterOperator.contains;
      case 'GreaterThan':
        return OpsItemFilterOperator.greaterThan;
      case 'LessThan':
        return OpsItemFilterOperator.lessThan;
    }
    throw Exception('$this is not known in enum OpsItemFilterOperator');
  }
}

/// Information about the user or resource that created an OpsItem event.
class OpsItemIdentity {
  /// The Amazon Resource Name (ARN) of the IAM entity that created the OpsItem
  /// event.
  final String? arn;

  OpsItemIdentity({
    this.arn,
  });
  factory OpsItemIdentity.fromJson(Map<String, dynamic> json) {
    return OpsItemIdentity(
      arn: json['Arn'] as String?,
    );
  }
}

/// A notification about the OpsItem.
class OpsItemNotification {
  /// The Amazon Resource Name (ARN) of an SNS topic where notifications are sent
  /// when this OpsItem is edited or changed.
  final String? arn;

  OpsItemNotification({
    this.arn,
  });
  factory OpsItemNotification.fromJson(Map<String, dynamic> json) {
    return OpsItemNotification(
      arn: json['Arn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final arn = this.arn;
    return {
      if (arn != null) 'Arn': arn,
    };
  }
}

enum OpsItemStatus {
  open,
  inProgress,
  resolved,
  pending,
  timedOut,
  cancelling,
  cancelled,
  failed,
  completedWithSuccess,
  completedWithFailure,
  scheduled,
  runbookInProgress,
  pendingChangeCalendarOverride,
  changeCalendarOverrideApproved,
  changeCalendarOverrideRejected,
  pendingApproval,
  approved,
  rejected,
}

extension on OpsItemStatus {
  String toValue() {
    switch (this) {
      case OpsItemStatus.open:
        return 'Open';
      case OpsItemStatus.inProgress:
        return 'InProgress';
      case OpsItemStatus.resolved:
        return 'Resolved';
      case OpsItemStatus.pending:
        return 'Pending';
      case OpsItemStatus.timedOut:
        return 'TimedOut';
      case OpsItemStatus.cancelling:
        return 'Cancelling';
      case OpsItemStatus.cancelled:
        return 'Cancelled';
      case OpsItemStatus.failed:
        return 'Failed';
      case OpsItemStatus.completedWithSuccess:
        return 'CompletedWithSuccess';
      case OpsItemStatus.completedWithFailure:
        return 'CompletedWithFailure';
      case OpsItemStatus.scheduled:
        return 'Scheduled';
      case OpsItemStatus.runbookInProgress:
        return 'RunbookInProgress';
      case OpsItemStatus.pendingChangeCalendarOverride:
        return 'PendingChangeCalendarOverride';
      case OpsItemStatus.changeCalendarOverrideApproved:
        return 'ChangeCalendarOverrideApproved';
      case OpsItemStatus.changeCalendarOverrideRejected:
        return 'ChangeCalendarOverrideRejected';
      case OpsItemStatus.pendingApproval:
        return 'PendingApproval';
      case OpsItemStatus.approved:
        return 'Approved';
      case OpsItemStatus.rejected:
        return 'Rejected';
    }
  }
}

extension on String {
  OpsItemStatus toOpsItemStatus() {
    switch (this) {
      case 'Open':
        return OpsItemStatus.open;
      case 'InProgress':
        return OpsItemStatus.inProgress;
      case 'Resolved':
        return OpsItemStatus.resolved;
      case 'Pending':
        return OpsItemStatus.pending;
      case 'TimedOut':
        return OpsItemStatus.timedOut;
      case 'Cancelling':
        return OpsItemStatus.cancelling;
      case 'Cancelled':
        return OpsItemStatus.cancelled;
      case 'Failed':
        return OpsItemStatus.failed;
      case 'CompletedWithSuccess':
        return OpsItemStatus.completedWithSuccess;
      case 'CompletedWithFailure':
        return OpsItemStatus.completedWithFailure;
      case 'Scheduled':
        return OpsItemStatus.scheduled;
      case 'RunbookInProgress':
        return OpsItemStatus.runbookInProgress;
      case 'PendingChangeCalendarOverride':
        return OpsItemStatus.pendingChangeCalendarOverride;
      case 'ChangeCalendarOverrideApproved':
        return OpsItemStatus.changeCalendarOverrideApproved;
      case 'ChangeCalendarOverrideRejected':
        return OpsItemStatus.changeCalendarOverrideRejected;
      case 'PendingApproval':
        return OpsItemStatus.pendingApproval;
      case 'Approved':
        return OpsItemStatus.approved;
      case 'Rejected':
        return OpsItemStatus.rejected;
    }
    throw Exception('$this is not known in enum OpsItemStatus');
  }
}

/// A count of OpsItems.
class OpsItemSummary {
  /// The time a runbook workflow ended. Currently reported only for the OpsItem
  /// type <code>/aws/changerequest</code>.
  final DateTime? actualEndTime;

  /// The time a runbook workflow started. Currently reported only for the OpsItem
  /// type <code>/aws/changerequest</code>.
  final DateTime? actualStartTime;

  /// A list of OpsItems by category.
  final String? category;

  /// The Amazon Resource Name (ARN) of the IAM entity that created the OpsItem.
  final String? createdBy;

  /// The date and time the OpsItem was created.
  final DateTime? createdTime;

  /// The Amazon Resource Name (ARN) of the IAM entity that created the OpsItem.
  final String? lastModifiedBy;

  /// The date and time the OpsItem was last updated.
  final DateTime? lastModifiedTime;

  /// Operational data is custom data that provides useful reference details about
  /// the OpsItem.
  final Map<String, OpsItemDataValue>? operationalData;

  /// The ID of the OpsItem.
  final String? opsItemId;

  /// The type of OpsItem. Currently, the only valid values are
  /// <code>/aws/changerequest</code> and <code>/aws/issue</code>.
  final String? opsItemType;

  /// The time specified in a change request for a runbook workflow to end.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  final DateTime? plannedEndTime;

  /// The time specified in a change request for a runbook workflow to start.
  /// Currently supported only for the OpsItem type
  /// <code>/aws/changerequest</code>.
  final DateTime? plannedStartTime;

  /// The importance of this OpsItem in relation to other OpsItems in the system.
  final int? priority;

  /// A list of OpsItems by severity.
  final String? severity;

  /// The impacted AWS resource.
  final String? source;

  /// The OpsItem status. Status can be <code>Open</code>, <code>In
  /// Progress</code>, or <code>Resolved</code>.
  final OpsItemStatus? status;

  /// A short heading that describes the nature of the OpsItem and the impacted
  /// resource.
  final String? title;

  OpsItemSummary({
    this.actualEndTime,
    this.actualStartTime,
    this.category,
    this.createdBy,
    this.createdTime,
    this.lastModifiedBy,
    this.lastModifiedTime,
    this.operationalData,
    this.opsItemId,
    this.opsItemType,
    this.plannedEndTime,
    this.plannedStartTime,
    this.priority,
    this.severity,
    this.source,
    this.status,
    this.title,
  });
  factory OpsItemSummary.fromJson(Map<String, dynamic> json) {
    return OpsItemSummary(
      actualEndTime: timeStampFromJson(json['ActualEndTime']),
      actualStartTime: timeStampFromJson(json['ActualStartTime']),
      category: json['Category'] as String?,
      createdBy: json['CreatedBy'] as String?,
      createdTime: timeStampFromJson(json['CreatedTime']),
      lastModifiedBy: json['LastModifiedBy'] as String?,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      operationalData: (json['OperationalData'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k, OpsItemDataValue.fromJson(e as Map<String, dynamic>))),
      opsItemId: json['OpsItemId'] as String?,
      opsItemType: json['OpsItemType'] as String?,
      plannedEndTime: timeStampFromJson(json['PlannedEndTime']),
      plannedStartTime: timeStampFromJson(json['PlannedStartTime']),
      priority: json['Priority'] as int?,
      severity: json['Severity'] as String?,
      source: json['Source'] as String?,
      status: (json['Status'] as String?)?.toOpsItemStatus(),
      title: json['Title'] as String?,
    );
  }
}

/// Operational metadata for an application in Application Manager.
class OpsMetadata {
  /// The date the OpsMetadata objects was created.
  final DateTime? creationDate;

  /// The date the OpsMetadata object was last updated.
  final DateTime? lastModifiedDate;

  /// The user name who last updated the OpsMetadata object.
  final String? lastModifiedUser;

  /// The Amazon Resource Name (ARN) of the OpsMetadata Object or blob.
  final String? opsMetadataArn;

  /// The ID of the Application Manager application.
  final String? resourceId;

  OpsMetadata({
    this.creationDate,
    this.lastModifiedDate,
    this.lastModifiedUser,
    this.opsMetadataArn,
    this.resourceId,
  });
  factory OpsMetadata.fromJson(Map<String, dynamic> json) {
    return OpsMetadata(
      creationDate: timeStampFromJson(json['CreationDate']),
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      lastModifiedUser: json['LastModifiedUser'] as String?,
      opsMetadataArn: json['OpsMetadataArn'] as String?,
      resourceId: json['ResourceId'] as String?,
    );
  }
}

/// A filter to limit the number of OpsMetadata objects displayed.
class OpsMetadataFilter {
  /// A filter key.
  final String key;

  /// A filter value.
  final List<String> values;

  OpsMetadataFilter({
    required this.key,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      'Key': key,
      'Values': values,
    };
  }
}

/// The OpsItem data type to return.
class OpsResultAttribute {
  /// Name of the data type. Valid value: AWS:OpsItem, AWS:EC2InstanceInformation,
  /// AWS:OpsItemTrendline, or AWS:ComplianceSummary.
  final String typeName;

  OpsResultAttribute({
    required this.typeName,
  });
  Map<String, dynamic> toJson() {
    final typeName = this.typeName;
    return {
      'TypeName': typeName,
    };
  }
}

/// Information about the source where the association execution details are
/// stored.
class OutputSource {
  /// The ID of the output source, for example the URL of an S3 bucket.
  final String? outputSourceId;

  /// The type of source where the association execution details are stored, for
  /// example, Amazon S3.
  final String? outputSourceType;

  OutputSource({
    this.outputSourceId,
    this.outputSourceType,
  });
  factory OutputSource.fromJson(Map<String, dynamic> json) {
    return OutputSource(
      outputSourceId: json['OutputSourceId'] as String?,
      outputSourceType: json['OutputSourceType'] as String?,
    );
  }
}

/// An Systems Manager parameter in Parameter Store.
class Parameter {
  /// The Amazon Resource Name (ARN) of the parameter.
  final String? arn;

  /// The data type of the parameter, such as <code>text</code> or
  /// <code>aws:ec2:image</code>. The default is <code>text</code>.
  final String? dataType;

  /// Date the parameter was last changed or updated and the parameter version was
  /// created.
  final DateTime? lastModifiedDate;

  /// The name of the parameter.
  final String? name;

  /// Either the version number or the label used to retrieve the parameter value.
  /// Specify selectors by using one of the following formats:
  ///
  /// parameter_name:version
  ///
  /// parameter_name:label
  final String? selector;

  /// Applies to parameters that reference information in other AWS services.
  /// SourceResult is the raw result or response from the source.
  final String? sourceResult;

  /// The type of parameter. Valid values include the following:
  /// <code>String</code>, <code>StringList</code>, and <code>SecureString</code>.
  final ParameterType? type;

  /// The parameter value.
  final String? value;

  /// The parameter version.
  final int? version;

  Parameter({
    this.arn,
    this.dataType,
    this.lastModifiedDate,
    this.name,
    this.selector,
    this.sourceResult,
    this.type,
    this.value,
    this.version,
  });
  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      arn: json['ARN'] as String?,
      dataType: json['DataType'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      name: json['Name'] as String?,
      selector: json['Selector'] as String?,
      sourceResult: json['SourceResult'] as String?,
      type: (json['Type'] as String?)?.toParameterType(),
      value: json['Value'] as String?,
      version: json['Version'] as int?,
    );
  }
}

/// Information about parameter usage.
class ParameterHistory {
  /// Parameter names can include the following letters and symbols.
  ///
  /// a-zA-Z0-9_.-
  final String? allowedPattern;

  /// The data type of the parameter, such as <code>text</code> or
  /// <code>aws:ec2:image</code>. The default is <code>text</code>.
  final String? dataType;

  /// Information about the parameter.
  final String? description;

  /// The ID of the query key used for this parameter.
  final String? keyId;

  /// Labels assigned to the parameter version.
  final List<String>? labels;

  /// Date the parameter was last changed or updated.
  final DateTime? lastModifiedDate;

  /// Amazon Resource Name (ARN) of the AWS user who last changed the parameter.
  final String? lastModifiedUser;

  /// The name of the parameter.
  final String? name;

  /// Information about the policies assigned to a parameter.
  ///
  /// <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-policies.html">Assigning
  /// parameter policies</a> in the <i>AWS Systems Manager User Guide</i>.
  final List<ParameterInlinePolicy>? policies;

  /// The parameter tier.
  final ParameterTier? tier;

  /// The type of parameter used.
  final ParameterType? type;

  /// The parameter value.
  final String? value;

  /// The parameter version.
  final int? version;

  ParameterHistory({
    this.allowedPattern,
    this.dataType,
    this.description,
    this.keyId,
    this.labels,
    this.lastModifiedDate,
    this.lastModifiedUser,
    this.name,
    this.policies,
    this.tier,
    this.type,
    this.value,
    this.version,
  });
  factory ParameterHistory.fromJson(Map<String, dynamic> json) {
    return ParameterHistory(
      allowedPattern: json['AllowedPattern'] as String?,
      dataType: json['DataType'] as String?,
      description: json['Description'] as String?,
      keyId: json['KeyId'] as String?,
      labels: (json['Labels'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      lastModifiedUser: json['LastModifiedUser'] as String?,
      name: json['Name'] as String?,
      policies: (json['Policies'] as List?)
          ?.whereNotNull()
          .map((e) => ParameterInlinePolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      tier: (json['Tier'] as String?)?.toParameterTier(),
      type: (json['Type'] as String?)?.toParameterType(),
      value: json['Value'] as String?,
      version: json['Version'] as int?,
    );
  }
}

/// One or more policies assigned to a parameter.
class ParameterInlinePolicy {
  /// The status of the policy. Policies report the following statuses: Pending
  /// (the policy has not been enforced or applied yet), Finished (the policy was
  /// applied), Failed (the policy was not applied), or InProgress (the policy is
  /// being applied now).
  final String? policyStatus;

  /// The JSON text of the policy.
  final String? policyText;

  /// The type of policy. Parameter Store supports the following policy types:
  /// Expiration, ExpirationNotification, and NoChangeNotification.
  final String? policyType;

  ParameterInlinePolicy({
    this.policyStatus,
    this.policyText,
    this.policyType,
  });
  factory ParameterInlinePolicy.fromJson(Map<String, dynamic> json) {
    return ParameterInlinePolicy(
      policyStatus: json['PolicyStatus'] as String?,
      policyText: json['PolicyText'] as String?,
      policyType: json['PolicyType'] as String?,
    );
  }
}

/// Metadata includes information like the ARN of the last user and the
/// date/time the parameter was last used.
class ParameterMetadata {
  /// A parameter name can include only the following letters and symbols.
  ///
  /// a-zA-Z0-9_.-
  final String? allowedPattern;

  /// The data type of the parameter, such as <code>text</code> or
  /// <code>aws:ec2:image</code>. The default is <code>text</code>.
  final String? dataType;

  /// Description of the parameter actions.
  final String? description;

  /// The ID of the query key used for this parameter.
  final String? keyId;

  /// Date the parameter was last changed or updated.
  final DateTime? lastModifiedDate;

  /// Amazon Resource Name (ARN) of the AWS user who last changed the parameter.
  final String? lastModifiedUser;

  /// The parameter name.
  final String? name;

  /// A list of policies associated with a parameter.
  final List<ParameterInlinePolicy>? policies;

  /// The parameter tier.
  final ParameterTier? tier;

  /// The type of parameter. Valid parameter types include the following:
  /// <code>String</code>, <code>StringList</code>, and <code>SecureString</code>.
  final ParameterType? type;

  /// The parameter version.
  final int? version;

  ParameterMetadata({
    this.allowedPattern,
    this.dataType,
    this.description,
    this.keyId,
    this.lastModifiedDate,
    this.lastModifiedUser,
    this.name,
    this.policies,
    this.tier,
    this.type,
    this.version,
  });
  factory ParameterMetadata.fromJson(Map<String, dynamic> json) {
    return ParameterMetadata(
      allowedPattern: json['AllowedPattern'] as String?,
      dataType: json['DataType'] as String?,
      description: json['Description'] as String?,
      keyId: json['KeyId'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      lastModifiedUser: json['LastModifiedUser'] as String?,
      name: json['Name'] as String?,
      policies: (json['Policies'] as List?)
          ?.whereNotNull()
          .map((e) => ParameterInlinePolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      tier: (json['Tier'] as String?)?.toParameterTier(),
      type: (json['Type'] as String?)?.toParameterType(),
      version: json['Version'] as int?,
    );
  }
}

/// One or more filters. Use a filter to return a more specific list of results.
class ParameterStringFilter {
  /// The name of the filter.
  /// <note>
  /// The <code>ParameterStringFilter</code> object is used by the
  /// <a>DescribeParameters</a> and <a>GetParametersByPath</a> API actions.
  /// However, not all of the pattern values listed for <code>Key</code> can be
  /// used with both actions.
  ///
  /// For <code>DescribeActions</code>, all of the listed patterns are valid, with
  /// the exception of <code>Label</code>.
  ///
  /// For <code>GetParametersByPath</code>, the following patterns listed for
  /// <code>Key</code> are not valid: <code>tag</code>, <code>Name</code>,
  /// <code>Path</code>, and <code>Tier</code>.
  ///
  /// For examples of CLI commands demonstrating valid parameter filter
  /// constructions, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-search.html">Searching
  /// for Systems Manager parameters</a> in the <i>AWS Systems Manager User
  /// Guide</i>.
  /// </note>
  final String key;

  /// For all filters used with <a>DescribeParameters</a>, valid options include
  /// <code>Equals</code> and <code>BeginsWith</code>. The <code>Name</code>
  /// filter additionally supports the <code>Contains</code> option. (Exception:
  /// For filters using the key <code>Path</code>, valid options include
  /// <code>Recursive</code> and <code>OneLevel</code>.)
  ///
  /// For filters used with <a>GetParametersByPath</a>, valid options include
  /// <code>Equals</code> and <code>BeginsWith</code>. (Exception: For filters
  /// using <code>Label</code> as the Key name, the only valid option is
  /// <code>Equals</code>.)
  final String? option;

  /// The value you want to search for.
  final List<String>? values;

  ParameterStringFilter({
    required this.key,
    this.option,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final option = this.option;
    final values = this.values;
    return {
      'Key': key,
      if (option != null) 'Option': option,
      if (values != null) 'Values': values,
    };
  }
}

enum ParameterTier {
  standard,
  advanced,
  intelligentTiering,
}

extension on ParameterTier {
  String toValue() {
    switch (this) {
      case ParameterTier.standard:
        return 'Standard';
      case ParameterTier.advanced:
        return 'Advanced';
      case ParameterTier.intelligentTiering:
        return 'Intelligent-Tiering';
    }
  }
}

extension on String {
  ParameterTier toParameterTier() {
    switch (this) {
      case 'Standard':
        return ParameterTier.standard;
      case 'Advanced':
        return ParameterTier.advanced;
      case 'Intelligent-Tiering':
        return ParameterTier.intelligentTiering;
    }
    throw Exception('$this is not known in enum ParameterTier');
  }
}

enum ParameterType {
  string,
  stringList,
  secureString,
}

extension on ParameterType {
  String toValue() {
    switch (this) {
      case ParameterType.string:
        return 'String';
      case ParameterType.stringList:
        return 'StringList';
      case ParameterType.secureString:
        return 'SecureString';
    }
  }
}

extension on String {
  ParameterType toParameterType() {
    switch (this) {
      case 'String':
        return ParameterType.string;
      case 'StringList':
        return ParameterType.stringList;
      case 'SecureString':
        return ParameterType.secureString;
    }
    throw Exception('$this is not known in enum ParameterType');
  }
}

/// This data type is deprecated. Instead, use <a>ParameterStringFilter</a>.
class ParametersFilter {
  /// The name of the filter.
  final ParametersFilterKey key;

  /// The filter values.
  final List<String> values;

  ParametersFilter({
    required this.key,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      'Key': key.toValue(),
      'Values': values,
    };
  }
}

enum ParametersFilterKey {
  name,
  type,
  keyId,
}

extension on ParametersFilterKey {
  String toValue() {
    switch (this) {
      case ParametersFilterKey.name:
        return 'Name';
      case ParametersFilterKey.type:
        return 'Type';
      case ParametersFilterKey.keyId:
        return 'KeyId';
    }
  }
}

extension on String {
  ParametersFilterKey toParametersFilterKey() {
    switch (this) {
      case 'Name':
        return ParametersFilterKey.name;
      case 'Type':
        return ParametersFilterKey.type;
      case 'KeyId':
        return ParametersFilterKey.keyId;
    }
    throw Exception('$this is not known in enum ParametersFilterKey');
  }
}

/// Represents metadata about a patch.
class Patch {
  /// The Advisory ID of the patch. For example, <code>RHSA-2020:3779</code>.
  /// Applies to Linux-based instances only.
  final List<String>? advisoryIds;

  /// The architecture of the patch. For example, in
  /// <code>example-pkg-0.710.10-2.7.abcd.x86_64</code>, the architecture is
  /// indicated by <code>x86_64</code>. Applies to Linux-based instances only.
  final String? arch;

  /// The Bugzilla ID of the patch. For example, <code>1600646</code>. Applies to
  /// Linux-based instances only.
  final List<String>? bugzillaIds;

  /// The Common Vulnerabilities and Exposures (CVE) ID of the patch. For example,
  /// <code>CVE-2011-3192</code>. Applies to Linux-based instances only.
  final List<String>? cVEIds;

  /// The classification of the patch. For example, <code>SecurityUpdates</code>,
  /// <code>Updates</code>, or <code>CriticalUpdates</code>.
  final String? classification;

  /// The URL where more information can be obtained about the patch.
  final String? contentUrl;

  /// The description of the patch.
  final String? description;

  /// The epoch of the patch. For example in
  /// <code>pkg-example-EE-20180914-2.2.amzn1.noarch</code>, the epoch value is
  /// <code>20180914-2</code>. Applies to Linux-based instances only.
  final int? epoch;

  /// The ID of the patch. Applies to Windows patches only.
  /// <note>
  /// This ID is not the same as the Microsoft Knowledge Base ID.
  /// </note>
  final String? id;

  /// The Microsoft Knowledge Base ID of the patch. Applies to Windows patches
  /// only.
  final String? kbNumber;

  /// The language of the patch if it's language-specific.
  final String? language;

  /// The ID of the Microsoft Security Response Center (MSRC) bulletin the patch
  /// is related to. For example, <code>MS14-045</code>. Applies to Windows
  /// patches only.
  final String? msrcNumber;

  /// The severity of the patch, such as <code>Critical</code>,
  /// <code>Important</code>, or <code>Moderate</code>. Applies to Windows patches
  /// only.
  final String? msrcSeverity;

  /// The name of the patch. Applies to Linux-based instances only.
  final String? name;

  /// The specific product the patch is applicable for. For example,
  /// <code>WindowsServer2016</code> or <code>AmazonLinux2018.03</code>.
  final String? product;

  /// The product family the patch is applicable for. For example,
  /// <code>Windows</code> or <code>Amazon Linux 2</code>.
  final String? productFamily;

  /// The particular release of a patch. For example, in
  /// <code>pkg-example-EE-20180914-2.2.amzn1.noarch</code>, the release is
  /// <code>2.amaz1</code>. Applies to Linux-based instances only.
  final String? release;

  /// The date the patch was released.
  final DateTime? releaseDate;

  /// The source patch repository for the operating system and version, such as
  /// <code>trusty-security</code> for Ubuntu Server 14.04 LTE and
  /// <code>focal-security</code> for Ubuntu Server 20.04 LTE. Applies to
  /// Linux-based instances only.
  final String? repository;

  /// The severity level of the patch. For example, <code>CRITICAL</code> or
  /// <code>MODERATE</code>.
  final String? severity;

  /// The title of the patch.
  final String? title;

  /// The name of the vendor providing the patch.
  final String? vendor;

  /// The version number of the patch. For example, in
  /// <code>example-pkg-1.710.10-2.7.abcd.x86_64</code>, the version number is
  /// indicated by <code>-1</code>. Applies to Linux-based instances only.
  final String? version;

  Patch({
    this.advisoryIds,
    this.arch,
    this.bugzillaIds,
    this.cVEIds,
    this.classification,
    this.contentUrl,
    this.description,
    this.epoch,
    this.id,
    this.kbNumber,
    this.language,
    this.msrcNumber,
    this.msrcSeverity,
    this.name,
    this.product,
    this.productFamily,
    this.release,
    this.releaseDate,
    this.repository,
    this.severity,
    this.title,
    this.vendor,
    this.version,
  });
  factory Patch.fromJson(Map<String, dynamic> json) {
    return Patch(
      advisoryIds: (json['AdvisoryIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      arch: json['Arch'] as String?,
      bugzillaIds: (json['BugzillaIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      cVEIds: (json['CVEIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      classification: json['Classification'] as String?,
      contentUrl: json['ContentUrl'] as String?,
      description: json['Description'] as String?,
      epoch: json['Epoch'] as int?,
      id: json['Id'] as String?,
      kbNumber: json['KbNumber'] as String?,
      language: json['Language'] as String?,
      msrcNumber: json['MsrcNumber'] as String?,
      msrcSeverity: json['MsrcSeverity'] as String?,
      name: json['Name'] as String?,
      product: json['Product'] as String?,
      productFamily: json['ProductFamily'] as String?,
      release: json['Release'] as String?,
      releaseDate: timeStampFromJson(json['ReleaseDate']),
      repository: json['Repository'] as String?,
      severity: json['Severity'] as String?,
      title: json['Title'] as String?,
      vendor: json['Vendor'] as String?,
      version: json['Version'] as String?,
    );
  }
}

enum PatchAction {
  allowAsDependency,
  block,
}

extension on PatchAction {
  String toValue() {
    switch (this) {
      case PatchAction.allowAsDependency:
        return 'ALLOW_AS_DEPENDENCY';
      case PatchAction.block:
        return 'BLOCK';
    }
  }
}

extension on String {
  PatchAction toPatchAction() {
    switch (this) {
      case 'ALLOW_AS_DEPENDENCY':
        return PatchAction.allowAsDependency;
      case 'BLOCK':
        return PatchAction.block;
    }
    throw Exception('$this is not known in enum PatchAction');
  }
}

/// Defines the basic information about a patch baseline.
class PatchBaselineIdentity {
  /// The description of the patch baseline.
  final String? baselineDescription;

  /// The ID of the patch baseline.
  final String? baselineId;

  /// The name of the patch baseline.
  final String? baselineName;

  /// Whether this is the default baseline. Note that Systems Manager supports
  /// creating multiple default patch baselines. For example, you can create a
  /// default patch baseline for each operating system.
  final bool? defaultBaseline;

  /// Defines the operating system the patch baseline applies to. The Default
  /// value is WINDOWS.
  final OperatingSystem? operatingSystem;

  PatchBaselineIdentity({
    this.baselineDescription,
    this.baselineId,
    this.baselineName,
    this.defaultBaseline,
    this.operatingSystem,
  });
  factory PatchBaselineIdentity.fromJson(Map<String, dynamic> json) {
    return PatchBaselineIdentity(
      baselineDescription: json['BaselineDescription'] as String?,
      baselineId: json['BaselineId'] as String?,
      baselineName: json['BaselineName'] as String?,
      defaultBaseline: json['DefaultBaseline'] as bool?,
      operatingSystem:
          (json['OperatingSystem'] as String?)?.toOperatingSystem(),
    );
  }
}

/// Information about the state of a patch on a particular instance as it
/// relates to the patch baseline used to patch the instance.
class PatchComplianceData {
  /// The classification of the patch (for example, SecurityUpdates, Updates,
  /// CriticalUpdates).
  final String classification;

  /// The date/time the patch was installed on the instance. Note that not all
  /// operating systems provide this level of information.
  final DateTime installedTime;

  /// The operating system-specific ID of the patch.
  final String kBId;

  /// The severity of the patch (for example, Critical, Important, Moderate).
  final String severity;

  /// The state of the patch on the instance, such as INSTALLED or FAILED.
  ///
  /// For descriptions of each patch state, see <a
  /// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-compliance-about.html#sysman-compliance-monitor-patch">About
  /// patch compliance</a> in the <i>AWS Systems Manager User Guide</i>.
  final PatchComplianceDataState state;

  /// The title of the patch.
  final String title;

  /// The IDs of one or more Common Vulnerabilities and Exposure (CVE) issues that
  /// are resolved by the patch.
  final String? cVEIds;

  PatchComplianceData({
    required this.classification,
    required this.installedTime,
    required this.kBId,
    required this.severity,
    required this.state,
    required this.title,
    this.cVEIds,
  });
  factory PatchComplianceData.fromJson(Map<String, dynamic> json) {
    return PatchComplianceData(
      classification: json['Classification'] as String,
      installedTime:
          nonNullableTimeStampFromJson(json['InstalledTime'] as Object),
      kBId: json['KBId'] as String,
      severity: json['Severity'] as String,
      state: (json['State'] as String).toPatchComplianceDataState(),
      title: json['Title'] as String,
      cVEIds: json['CVEIds'] as String?,
    );
  }
}

enum PatchComplianceDataState {
  installed,
  installedOther,
  installedPendingReboot,
  installedRejected,
  missing,
  notApplicable,
  failed,
}

extension on PatchComplianceDataState {
  String toValue() {
    switch (this) {
      case PatchComplianceDataState.installed:
        return 'INSTALLED';
      case PatchComplianceDataState.installedOther:
        return 'INSTALLED_OTHER';
      case PatchComplianceDataState.installedPendingReboot:
        return 'INSTALLED_PENDING_REBOOT';
      case PatchComplianceDataState.installedRejected:
        return 'INSTALLED_REJECTED';
      case PatchComplianceDataState.missing:
        return 'MISSING';
      case PatchComplianceDataState.notApplicable:
        return 'NOT_APPLICABLE';
      case PatchComplianceDataState.failed:
        return 'FAILED';
    }
  }
}

extension on String {
  PatchComplianceDataState toPatchComplianceDataState() {
    switch (this) {
      case 'INSTALLED':
        return PatchComplianceDataState.installed;
      case 'INSTALLED_OTHER':
        return PatchComplianceDataState.installedOther;
      case 'INSTALLED_PENDING_REBOOT':
        return PatchComplianceDataState.installedPendingReboot;
      case 'INSTALLED_REJECTED':
        return PatchComplianceDataState.installedRejected;
      case 'MISSING':
        return PatchComplianceDataState.missing;
      case 'NOT_APPLICABLE':
        return PatchComplianceDataState.notApplicable;
      case 'FAILED':
        return PatchComplianceDataState.failed;
    }
    throw Exception('$this is not known in enum PatchComplianceDataState');
  }
}

enum PatchComplianceLevel {
  critical,
  high,
  medium,
  low,
  informational,
  unspecified,
}

extension on PatchComplianceLevel {
  String toValue() {
    switch (this) {
      case PatchComplianceLevel.critical:
        return 'CRITICAL';
      case PatchComplianceLevel.high:
        return 'HIGH';
      case PatchComplianceLevel.medium:
        return 'MEDIUM';
      case PatchComplianceLevel.low:
        return 'LOW';
      case PatchComplianceLevel.informational:
        return 'INFORMATIONAL';
      case PatchComplianceLevel.unspecified:
        return 'UNSPECIFIED';
    }
  }
}

extension on String {
  PatchComplianceLevel toPatchComplianceLevel() {
    switch (this) {
      case 'CRITICAL':
        return PatchComplianceLevel.critical;
      case 'HIGH':
        return PatchComplianceLevel.high;
      case 'MEDIUM':
        return PatchComplianceLevel.medium;
      case 'LOW':
        return PatchComplianceLevel.low;
      case 'INFORMATIONAL':
        return PatchComplianceLevel.informational;
      case 'UNSPECIFIED':
        return PatchComplianceLevel.unspecified;
    }
    throw Exception('$this is not known in enum PatchComplianceLevel');
  }
}

enum PatchDeploymentStatus {
  approved,
  pendingApproval,
  explicitApproved,
  explicitRejected,
}

extension on PatchDeploymentStatus {
  String toValue() {
    switch (this) {
      case PatchDeploymentStatus.approved:
        return 'APPROVED';
      case PatchDeploymentStatus.pendingApproval:
        return 'PENDING_APPROVAL';
      case PatchDeploymentStatus.explicitApproved:
        return 'EXPLICIT_APPROVED';
      case PatchDeploymentStatus.explicitRejected:
        return 'EXPLICIT_REJECTED';
    }
  }
}

extension on String {
  PatchDeploymentStatus toPatchDeploymentStatus() {
    switch (this) {
      case 'APPROVED':
        return PatchDeploymentStatus.approved;
      case 'PENDING_APPROVAL':
        return PatchDeploymentStatus.pendingApproval;
      case 'EXPLICIT_APPROVED':
        return PatchDeploymentStatus.explicitApproved;
      case 'EXPLICIT_REJECTED':
        return PatchDeploymentStatus.explicitRejected;
    }
    throw Exception('$this is not known in enum PatchDeploymentStatus');
  }
}

/// Defines which patches should be included in a patch baseline.
///
/// A patch filter consists of a key and a set of values. The filter key is a
/// patch property. For example, the available filter keys for WINDOWS are
/// PATCH_SET, PRODUCT, PRODUCT_FAMILY, CLASSIFICATION, and MSRC_SEVERITY. The
/// filter values define a matching criterion for the patch property indicated
/// by the key. For example, if the filter key is PRODUCT and the filter values
/// are ["Office 2013", "Office 2016"], then the filter accepts all patches
/// where product name is either "Office 2013" or "Office 2016". The filter
/// values can be exact values for the patch property given as a key, or a
/// wildcard (*), which matches all values.
///
/// You can view lists of valid values for the patch properties by running the
/// <code>DescribePatchProperties</code> command. For information about which
/// patch properties can be used with each major operating system, see
/// <a>DescribePatchProperties</a>.
class PatchFilter {
  /// The key for the filter.
  ///
  /// Run the <a>DescribePatchProperties</a> command to view lists of valid keys
  /// for each operating system type.
  final PatchFilterKey key;

  /// The value for the filter key.
  ///
  /// Run the <a>DescribePatchProperties</a> command to view lists of valid values
  /// for each key based on operating system type.
  final List<String> values;

  PatchFilter({
    required this.key,
    required this.values,
  });
  factory PatchFilter.fromJson(Map<String, dynamic> json) {
    return PatchFilter(
      key: (json['Key'] as String).toPatchFilterKey(),
      values: (json['Values'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      'Key': key.toValue(),
      'Values': values,
    };
  }
}

/// A set of patch filters, typically used for approval rules.
class PatchFilterGroup {
  /// The set of patch filters that make up the group.
  final List<PatchFilter> patchFilters;

  PatchFilterGroup({
    required this.patchFilters,
  });
  factory PatchFilterGroup.fromJson(Map<String, dynamic> json) {
    return PatchFilterGroup(
      patchFilters: (json['PatchFilters'] as List)
          .whereNotNull()
          .map((e) => PatchFilter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final patchFilters = this.patchFilters;
    return {
      'PatchFilters': patchFilters,
    };
  }
}

enum PatchFilterKey {
  arch,
  advisoryId,
  bugzillaId,
  patchSet,
  product,
  productFamily,
  classification,
  cveId,
  epoch,
  msrcSeverity,
  name,
  patchId,
  section,
  priority,
  repository,
  release,
  severity,
  security,
  version,
}

extension on PatchFilterKey {
  String toValue() {
    switch (this) {
      case PatchFilterKey.arch:
        return 'ARCH';
      case PatchFilterKey.advisoryId:
        return 'ADVISORY_ID';
      case PatchFilterKey.bugzillaId:
        return 'BUGZILLA_ID';
      case PatchFilterKey.patchSet:
        return 'PATCH_SET';
      case PatchFilterKey.product:
        return 'PRODUCT';
      case PatchFilterKey.productFamily:
        return 'PRODUCT_FAMILY';
      case PatchFilterKey.classification:
        return 'CLASSIFICATION';
      case PatchFilterKey.cveId:
        return 'CVE_ID';
      case PatchFilterKey.epoch:
        return 'EPOCH';
      case PatchFilterKey.msrcSeverity:
        return 'MSRC_SEVERITY';
      case PatchFilterKey.name:
        return 'NAME';
      case PatchFilterKey.patchId:
        return 'PATCH_ID';
      case PatchFilterKey.section:
        return 'SECTION';
      case PatchFilterKey.priority:
        return 'PRIORITY';
      case PatchFilterKey.repository:
        return 'REPOSITORY';
      case PatchFilterKey.release:
        return 'RELEASE';
      case PatchFilterKey.severity:
        return 'SEVERITY';
      case PatchFilterKey.security:
        return 'SECURITY';
      case PatchFilterKey.version:
        return 'VERSION';
    }
  }
}

extension on String {
  PatchFilterKey toPatchFilterKey() {
    switch (this) {
      case 'ARCH':
        return PatchFilterKey.arch;
      case 'ADVISORY_ID':
        return PatchFilterKey.advisoryId;
      case 'BUGZILLA_ID':
        return PatchFilterKey.bugzillaId;
      case 'PATCH_SET':
        return PatchFilterKey.patchSet;
      case 'PRODUCT':
        return PatchFilterKey.product;
      case 'PRODUCT_FAMILY':
        return PatchFilterKey.productFamily;
      case 'CLASSIFICATION':
        return PatchFilterKey.classification;
      case 'CVE_ID':
        return PatchFilterKey.cveId;
      case 'EPOCH':
        return PatchFilterKey.epoch;
      case 'MSRC_SEVERITY':
        return PatchFilterKey.msrcSeverity;
      case 'NAME':
        return PatchFilterKey.name;
      case 'PATCH_ID':
        return PatchFilterKey.patchId;
      case 'SECTION':
        return PatchFilterKey.section;
      case 'PRIORITY':
        return PatchFilterKey.priority;
      case 'REPOSITORY':
        return PatchFilterKey.repository;
      case 'RELEASE':
        return PatchFilterKey.release;
      case 'SEVERITY':
        return PatchFilterKey.severity;
      case 'SECURITY':
        return PatchFilterKey.security;
      case 'VERSION':
        return PatchFilterKey.version;
    }
    throw Exception('$this is not known in enum PatchFilterKey');
  }
}

/// The mapping between a patch group and the patch baseline the patch group is
/// registered with.
class PatchGroupPatchBaselineMapping {
  /// The patch baseline the patch group is registered with.
  final PatchBaselineIdentity? baselineIdentity;

  /// The name of the patch group registered with the patch baseline.
  final String? patchGroup;

  PatchGroupPatchBaselineMapping({
    this.baselineIdentity,
    this.patchGroup,
  });
  factory PatchGroupPatchBaselineMapping.fromJson(Map<String, dynamic> json) {
    return PatchGroupPatchBaselineMapping(
      baselineIdentity: json['BaselineIdentity'] != null
          ? PatchBaselineIdentity.fromJson(
              json['BaselineIdentity'] as Map<String, dynamic>)
          : null,
      patchGroup: json['PatchGroup'] as String?,
    );
  }
}

enum PatchOperationType {
  scan,
  install,
}

extension on PatchOperationType {
  String toValue() {
    switch (this) {
      case PatchOperationType.scan:
        return 'Scan';
      case PatchOperationType.install:
        return 'Install';
    }
  }
}

extension on String {
  PatchOperationType toPatchOperationType() {
    switch (this) {
      case 'Scan':
        return PatchOperationType.scan;
      case 'Install':
        return PatchOperationType.install;
    }
    throw Exception('$this is not known in enum PatchOperationType');
  }
}

/// Defines a filter used in Patch Manager APIs.
class PatchOrchestratorFilter {
  /// The key for the filter.
  final String? key;

  /// The value for the filter.
  final List<String>? values;

  PatchOrchestratorFilter({
    this.key,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      if (key != null) 'Key': key,
      if (values != null) 'Values': values,
    };
  }
}

enum PatchProperty {
  product,
  productFamily,
  classification,
  msrcSeverity,
  priority,
  severity,
}

extension on PatchProperty {
  String toValue() {
    switch (this) {
      case PatchProperty.product:
        return 'PRODUCT';
      case PatchProperty.productFamily:
        return 'PRODUCT_FAMILY';
      case PatchProperty.classification:
        return 'CLASSIFICATION';
      case PatchProperty.msrcSeverity:
        return 'MSRC_SEVERITY';
      case PatchProperty.priority:
        return 'PRIORITY';
      case PatchProperty.severity:
        return 'SEVERITY';
    }
  }
}

extension on String {
  PatchProperty toPatchProperty() {
    switch (this) {
      case 'PRODUCT':
        return PatchProperty.product;
      case 'PRODUCT_FAMILY':
        return PatchProperty.productFamily;
      case 'CLASSIFICATION':
        return PatchProperty.classification;
      case 'MSRC_SEVERITY':
        return PatchProperty.msrcSeverity;
      case 'PRIORITY':
        return PatchProperty.priority;
      case 'SEVERITY':
        return PatchProperty.severity;
    }
    throw Exception('$this is not known in enum PatchProperty');
  }
}

/// Defines an approval rule for a patch baseline.
class PatchRule {
  /// The patch filter group that defines the criteria for the rule.
  final PatchFilterGroup patchFilterGroup;

  /// The number of days after the release date of each patch matched by the rule
  /// that the patch is marked as approved in the patch baseline. For example, a
  /// value of <code>7</code> means that patches are approved seven days after
  /// they are released. Not supported on Ubuntu Server.
  final int? approveAfterDays;

  /// The cutoff date for auto approval of released patches. Any patches released
  /// on or before this date are installed automatically. Not supported on Ubuntu
  /// Server.
  ///
  /// Enter dates in the format <code>YYYY-MM-DD</code>. For example,
  /// <code>2020-12-31</code>.
  final String? approveUntilDate;

  /// A compliance severity level for all approved patches in a patch baseline.
  final PatchComplianceLevel? complianceLevel;

  /// For instances identified by the approval rule filters, enables a patch
  /// baseline to apply non-security updates available in the specified
  /// repository. The default value is 'false'. Applies to Linux instances only.
  final bool? enableNonSecurity;

  PatchRule({
    required this.patchFilterGroup,
    this.approveAfterDays,
    this.approveUntilDate,
    this.complianceLevel,
    this.enableNonSecurity,
  });
  factory PatchRule.fromJson(Map<String, dynamic> json) {
    return PatchRule(
      patchFilterGroup: PatchFilterGroup.fromJson(
          json['PatchFilterGroup'] as Map<String, dynamic>),
      approveAfterDays: json['ApproveAfterDays'] as int?,
      approveUntilDate: json['ApproveUntilDate'] as String?,
      complianceLevel:
          (json['ComplianceLevel'] as String?)?.toPatchComplianceLevel(),
      enableNonSecurity: json['EnableNonSecurity'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final patchFilterGroup = this.patchFilterGroup;
    final approveAfterDays = this.approveAfterDays;
    final approveUntilDate = this.approveUntilDate;
    final complianceLevel = this.complianceLevel;
    final enableNonSecurity = this.enableNonSecurity;
    return {
      'PatchFilterGroup': patchFilterGroup,
      if (approveAfterDays != null) 'ApproveAfterDays': approveAfterDays,
      if (approveUntilDate != null) 'ApproveUntilDate': approveUntilDate,
      if (complianceLevel != null) 'ComplianceLevel': complianceLevel.toValue(),
      if (enableNonSecurity != null) 'EnableNonSecurity': enableNonSecurity,
    };
  }
}

/// A set of rules defining the approval rules for a patch baseline.
class PatchRuleGroup {
  /// The rules that make up the rule group.
  final List<PatchRule> patchRules;

  PatchRuleGroup({
    required this.patchRules,
  });
  factory PatchRuleGroup.fromJson(Map<String, dynamic> json) {
    return PatchRuleGroup(
      patchRules: (json['PatchRules'] as List)
          .whereNotNull()
          .map((e) => PatchRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final patchRules = this.patchRules;
    return {
      'PatchRules': patchRules,
    };
  }
}

enum PatchSet {
  os,
  application,
}

extension on PatchSet {
  String toValue() {
    switch (this) {
      case PatchSet.os:
        return 'OS';
      case PatchSet.application:
        return 'APPLICATION';
    }
  }
}

extension on String {
  PatchSet toPatchSet() {
    switch (this) {
      case 'OS':
        return PatchSet.os;
      case 'APPLICATION':
        return PatchSet.application;
    }
    throw Exception('$this is not known in enum PatchSet');
  }
}

/// Information about the patches to use to update the instances, including
/// target operating systems and source repository. Applies to Linux instances
/// only.
class PatchSource {
  /// The value of the yum repo configuration. For example:
  ///
  /// <code>[main]</code>
  ///
  /// <code>cachedir=/var/cache/yum/$basesearch$releasever</code>
  ///
  /// <code>keepcache=0</code>
  ///
  /// <code>debuglevel=2</code>
  final String configuration;

  /// The name specified to identify the patch source.
  final String name;

  /// The specific operating system versions a patch repository applies to, such
  /// as "Ubuntu16.04", "AmazonLinux2016.09", "RedhatEnterpriseLinux7.2" or
  /// "Suse12.7". For lists of supported product values, see <a>PatchFilter</a>.
  final List<String> products;

  PatchSource({
    required this.configuration,
    required this.name,
    required this.products,
  });
  factory PatchSource.fromJson(Map<String, dynamic> json) {
    return PatchSource(
      configuration: json['Configuration'] as String,
      name: json['Name'] as String,
      products: (json['Products'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final configuration = this.configuration;
    final name = this.name;
    final products = this.products;
    return {
      'Configuration': configuration,
      'Name': name,
      'Products': products,
    };
  }
}

/// Information about the approval status of a patch.
class PatchStatus {
  /// The date the patch was approved (or will be approved if the status is
  /// PENDING_APPROVAL).
  final DateTime? approvalDate;

  /// The compliance severity level for a patch.
  final PatchComplianceLevel? complianceLevel;

  /// The approval status of a patch (APPROVED, PENDING_APPROVAL,
  /// EXPLICIT_APPROVED, EXPLICIT_REJECTED).
  final PatchDeploymentStatus? deploymentStatus;

  PatchStatus({
    this.approvalDate,
    this.complianceLevel,
    this.deploymentStatus,
  });
  factory PatchStatus.fromJson(Map<String, dynamic> json) {
    return PatchStatus(
      approvalDate: timeStampFromJson(json['ApprovalDate']),
      complianceLevel:
          (json['ComplianceLevel'] as String?)?.toPatchComplianceLevel(),
      deploymentStatus:
          (json['DeploymentStatus'] as String?)?.toPatchDeploymentStatus(),
    );
  }
}

enum PingStatus {
  online,
  connectionLost,
  inactive,
}

extension on PingStatus {
  String toValue() {
    switch (this) {
      case PingStatus.online:
        return 'Online';
      case PingStatus.connectionLost:
        return 'ConnectionLost';
      case PingStatus.inactive:
        return 'Inactive';
    }
  }
}

extension on String {
  PingStatus toPingStatus() {
    switch (this) {
      case 'Online':
        return PingStatus.online;
      case 'ConnectionLost':
        return PingStatus.connectionLost;
      case 'Inactive':
        return PingStatus.inactive;
    }
    throw Exception('$this is not known in enum PingStatus');
  }
}

enum PlatformType {
  windows,
  linux,
}

extension on PlatformType {
  String toValue() {
    switch (this) {
      case PlatformType.windows:
        return 'Windows';
      case PlatformType.linux:
        return 'Linux';
    }
  }
}

extension on String {
  PlatformType toPlatformType() {
    switch (this) {
      case 'Windows':
        return PlatformType.windows;
      case 'Linux':
        return PlatformType.linux;
    }
    throw Exception('$this is not known in enum PlatformType');
  }
}

/// An aggregate of step execution statuses displayed in the AWS Console for a
/// multi-Region and multi-account Automation execution.
class ProgressCounters {
  /// The total number of steps that the system cancelled in all specified AWS
  /// Regions and accounts for the current Automation execution.
  final int? cancelledSteps;

  /// The total number of steps that failed to run in all specified AWS Regions
  /// and accounts for the current Automation execution.
  final int? failedSteps;

  /// The total number of steps that successfully completed in all specified AWS
  /// Regions and accounts for the current Automation execution.
  final int? successSteps;

  /// The total number of steps that timed out in all specified AWS Regions and
  /// accounts for the current Automation execution.
  final int? timedOutSteps;

  /// The total number of steps run in all specified AWS Regions and accounts for
  /// the current Automation execution.
  final int? totalSteps;

  ProgressCounters({
    this.cancelledSteps,
    this.failedSteps,
    this.successSteps,
    this.timedOutSteps,
    this.totalSteps,
  });
  factory ProgressCounters.fromJson(Map<String, dynamic> json) {
    return ProgressCounters(
      cancelledSteps: json['CancelledSteps'] as int?,
      failedSteps: json['FailedSteps'] as int?,
      successSteps: json['SuccessSteps'] as int?,
      timedOutSteps: json['TimedOutSteps'] as int?,
      totalSteps: json['TotalSteps'] as int?,
    );
  }
}

class PutComplianceItemsResult {
  PutComplianceItemsResult();
  factory PutComplianceItemsResult.fromJson(Map<String, dynamic> _) {
    return PutComplianceItemsResult();
  }
}

class PutInventoryResult {
  /// Information about the request.
  final String? message;

  PutInventoryResult({
    this.message,
  });
  factory PutInventoryResult.fromJson(Map<String, dynamic> json) {
    return PutInventoryResult(
      message: json['Message'] as String?,
    );
  }
}

class PutParameterResult {
  /// The tier assigned to the parameter.
  final ParameterTier? tier;

  /// The new version number of a parameter. If you edit a parameter value,
  /// Parameter Store automatically creates a new version and assigns this new
  /// version a unique ID. You can reference a parameter version ID in API actions
  /// or in Systems Manager documents (SSM documents). By default, if you don't
  /// specify a specific version, the system returns the latest parameter value
  /// when a parameter is called.
  final int? version;

  PutParameterResult({
    this.tier,
    this.version,
  });
  factory PutParameterResult.fromJson(Map<String, dynamic> json) {
    return PutParameterResult(
      tier: (json['Tier'] as String?)?.toParameterTier(),
      version: json['Version'] as int?,
    );
  }
}

enum RebootOption {
  rebootIfNeeded,
  noReboot,
}

extension on RebootOption {
  String toValue() {
    switch (this) {
      case RebootOption.rebootIfNeeded:
        return 'RebootIfNeeded';
      case RebootOption.noReboot:
        return 'NoReboot';
    }
  }
}

extension on String {
  RebootOption toRebootOption() {
    switch (this) {
      case 'RebootIfNeeded':
        return RebootOption.rebootIfNeeded;
      case 'NoReboot':
        return RebootOption.noReboot;
    }
    throw Exception('$this is not known in enum RebootOption');
  }
}

class RegisterDefaultPatchBaselineResult {
  /// The ID of the default patch baseline.
  final String? baselineId;

  RegisterDefaultPatchBaselineResult({
    this.baselineId,
  });
  factory RegisterDefaultPatchBaselineResult.fromJson(
      Map<String, dynamic> json) {
    return RegisterDefaultPatchBaselineResult(
      baselineId: json['BaselineId'] as String?,
    );
  }
}

class RegisterPatchBaselineForPatchGroupResult {
  /// The ID of the patch baseline the patch group was registered with.
  final String? baselineId;

  /// The name of the patch group registered with the patch baseline.
  final String? patchGroup;

  RegisterPatchBaselineForPatchGroupResult({
    this.baselineId,
    this.patchGroup,
  });
  factory RegisterPatchBaselineForPatchGroupResult.fromJson(
      Map<String, dynamic> json) {
    return RegisterPatchBaselineForPatchGroupResult(
      baselineId: json['BaselineId'] as String?,
      patchGroup: json['PatchGroup'] as String?,
    );
  }
}

class RegisterTargetWithMaintenanceWindowResult {
  /// The ID of the target definition in this maintenance window.
  final String? windowTargetId;

  RegisterTargetWithMaintenanceWindowResult({
    this.windowTargetId,
  });
  factory RegisterTargetWithMaintenanceWindowResult.fromJson(
      Map<String, dynamic> json) {
    return RegisterTargetWithMaintenanceWindowResult(
      windowTargetId: json['WindowTargetId'] as String?,
    );
  }
}

class RegisterTaskWithMaintenanceWindowResult {
  /// The ID of the task in the maintenance window.
  final String? windowTaskId;

  RegisterTaskWithMaintenanceWindowResult({
    this.windowTaskId,
  });
  factory RegisterTaskWithMaintenanceWindowResult.fromJson(
      Map<String, dynamic> json) {
    return RegisterTaskWithMaintenanceWindowResult(
      windowTaskId: json['WindowTaskId'] as String?,
    );
  }
}

/// An OpsItems that shares something in common with the current OpsItem. For
/// example, related OpsItems can include OpsItems with similar error messages,
/// impacted resources, or statuses for the impacted resource.
class RelatedOpsItem {
  /// The ID of an OpsItem related to the current OpsItem.
  final String opsItemId;

  RelatedOpsItem({
    required this.opsItemId,
  });
  factory RelatedOpsItem.fromJson(Map<String, dynamic> json) {
    return RelatedOpsItem(
      opsItemId: json['OpsItemId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final opsItemId = this.opsItemId;
    return {
      'OpsItemId': opsItemId,
    };
  }
}

class RemoveTagsFromResourceResult {
  RemoveTagsFromResourceResult();
  factory RemoveTagsFromResourceResult.fromJson(Map<String, dynamic> _) {
    return RemoveTagsFromResourceResult();
  }
}

/// The result body of the ResetServiceSetting API action.
class ResetServiceSettingResult {
  /// The current, effective service setting after calling the ResetServiceSetting
  /// API action.
  final ServiceSetting? serviceSetting;

  ResetServiceSettingResult({
    this.serviceSetting,
  });
  factory ResetServiceSettingResult.fromJson(Map<String, dynamic> json) {
    return ResetServiceSettingResult(
      serviceSetting: json['ServiceSetting'] != null
          ? ServiceSetting.fromJson(
              json['ServiceSetting'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Information about targets that resolved during the Automation execution.
class ResolvedTargets {
  /// A list of parameter values sent to targets that resolved during the
  /// Automation execution.
  final List<String>? parameterValues;

  /// A boolean value indicating whether the resolved target list is truncated.
  final bool? truncated;

  ResolvedTargets({
    this.parameterValues,
    this.truncated,
  });
  factory ResolvedTargets.fromJson(Map<String, dynamic> json) {
    return ResolvedTargets(
      parameterValues: (json['ParameterValues'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      truncated: json['Truncated'] as bool?,
    );
  }
}

/// Compliance summary information for a specific resource.
class ResourceComplianceSummaryItem {
  /// The compliance type.
  final String? complianceType;

  /// A list of items that are compliant for the resource.
  final CompliantSummary? compliantSummary;

  /// Information about the execution.
  final ComplianceExecutionSummary? executionSummary;

  /// A list of items that aren't compliant for the resource.
  final NonCompliantSummary? nonCompliantSummary;

  /// The highest severity item found for the resource. The resource is compliant
  /// for this item.
  final ComplianceSeverity? overallSeverity;

  /// The resource ID.
  final String? resourceId;

  /// The resource type.
  final String? resourceType;

  /// The compliance status for the resource.
  final ComplianceStatus? status;

  ResourceComplianceSummaryItem({
    this.complianceType,
    this.compliantSummary,
    this.executionSummary,
    this.nonCompliantSummary,
    this.overallSeverity,
    this.resourceId,
    this.resourceType,
    this.status,
  });
  factory ResourceComplianceSummaryItem.fromJson(Map<String, dynamic> json) {
    return ResourceComplianceSummaryItem(
      complianceType: json['ComplianceType'] as String?,
      compliantSummary: json['CompliantSummary'] != null
          ? CompliantSummary.fromJson(
              json['CompliantSummary'] as Map<String, dynamic>)
          : null,
      executionSummary: json['ExecutionSummary'] != null
          ? ComplianceExecutionSummary.fromJson(
              json['ExecutionSummary'] as Map<String, dynamic>)
          : null,
      nonCompliantSummary: json['NonCompliantSummary'] != null
          ? NonCompliantSummary.fromJson(
              json['NonCompliantSummary'] as Map<String, dynamic>)
          : null,
      overallSeverity:
          (json['OverallSeverity'] as String?)?.toComplianceSeverity(),
      resourceId: json['ResourceId'] as String?,
      resourceType: json['ResourceType'] as String?,
      status: (json['Status'] as String?)?.toComplianceStatus(),
    );
  }
}

/// Information about the AwsOrganizationsSource resource data sync source. A
/// sync source of this type can synchronize data from AWS Organizations or, if
/// an AWS Organization is not present, from multiple AWS Regions.
class ResourceDataSyncAwsOrganizationsSource {
  /// If an AWS Organization is present, this is either
  /// <code>OrganizationalUnits</code> or <code>EntireOrganization</code>. For
  /// <code>OrganizationalUnits</code>, the data is aggregated from a set of
  /// organization units. For <code>EntireOrganization</code>, the data is
  /// aggregated from the entire AWS Organization.
  final String organizationSourceType;

  /// The AWS Organizations organization units included in the sync.
  final List<ResourceDataSyncOrganizationalUnit>? organizationalUnits;

  ResourceDataSyncAwsOrganizationsSource({
    required this.organizationSourceType,
    this.organizationalUnits,
  });
  factory ResourceDataSyncAwsOrganizationsSource.fromJson(
      Map<String, dynamic> json) {
    return ResourceDataSyncAwsOrganizationsSource(
      organizationSourceType: json['OrganizationSourceType'] as String,
      organizationalUnits: (json['OrganizationalUnits'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceDataSyncOrganizationalUnit.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final organizationSourceType = this.organizationSourceType;
    final organizationalUnits = this.organizationalUnits;
    return {
      'OrganizationSourceType': organizationSourceType,
      if (organizationalUnits != null)
        'OrganizationalUnits': organizationalUnits,
    };
  }
}

/// Synchronize Systems Manager Inventory data from multiple AWS accounts
/// defined in AWS Organizations to a centralized S3 bucket. Data is
/// synchronized to individual key prefixes in the central bucket. Each key
/// prefix represents a different AWS account ID.
class ResourceDataSyncDestinationDataSharing {
  /// The sharing data type. Only <code>Organization</code> is supported.
  final String? destinationDataSharingType;

  ResourceDataSyncDestinationDataSharing({
    this.destinationDataSharingType,
  });
  factory ResourceDataSyncDestinationDataSharing.fromJson(
      Map<String, dynamic> json) {
    return ResourceDataSyncDestinationDataSharing(
      destinationDataSharingType: json['DestinationDataSharingType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final destinationDataSharingType = this.destinationDataSharingType;
    return {
      if (destinationDataSharingType != null)
        'DestinationDataSharingType': destinationDataSharingType,
    };
  }
}

/// Information about a Resource Data Sync configuration, including its current
/// status and last successful sync.
class ResourceDataSyncItem {
  /// The status reported by the last sync.
  final LastResourceDataSyncStatus? lastStatus;

  /// The last time the sync operations returned a status of
  /// <code>SUCCESSFUL</code> (UTC).
  final DateTime? lastSuccessfulSyncTime;

  /// The status message details reported by the last sync.
  final String? lastSyncStatusMessage;

  /// The last time the configuration attempted to sync (UTC).
  final DateTime? lastSyncTime;

  /// Configuration information for the target S3 bucket.
  final ResourceDataSyncS3Destination? s3Destination;

  /// The date and time the configuration was created (UTC).
  final DateTime? syncCreatedTime;

  /// The date and time the resource data sync was changed.
  final DateTime? syncLastModifiedTime;

  /// The name of the Resource Data Sync.
  final String? syncName;

  /// Information about the source where the data was synchronized.
  final ResourceDataSyncSourceWithState? syncSource;

  /// The type of resource data sync. If <code>SyncType</code> is
  /// <code>SyncToDestination</code>, then the resource data sync synchronizes
  /// data to an S3 bucket. If the <code>SyncType</code> is
  /// <code>SyncFromSource</code> then the resource data sync synchronizes data
  /// from AWS Organizations or from multiple AWS Regions.
  final String? syncType;

  ResourceDataSyncItem({
    this.lastStatus,
    this.lastSuccessfulSyncTime,
    this.lastSyncStatusMessage,
    this.lastSyncTime,
    this.s3Destination,
    this.syncCreatedTime,
    this.syncLastModifiedTime,
    this.syncName,
    this.syncSource,
    this.syncType,
  });
  factory ResourceDataSyncItem.fromJson(Map<String, dynamic> json) {
    return ResourceDataSyncItem(
      lastStatus:
          (json['LastStatus'] as String?)?.toLastResourceDataSyncStatus(),
      lastSuccessfulSyncTime: timeStampFromJson(json['LastSuccessfulSyncTime']),
      lastSyncStatusMessage: json['LastSyncStatusMessage'] as String?,
      lastSyncTime: timeStampFromJson(json['LastSyncTime']),
      s3Destination: json['S3Destination'] != null
          ? ResourceDataSyncS3Destination.fromJson(
              json['S3Destination'] as Map<String, dynamic>)
          : null,
      syncCreatedTime: timeStampFromJson(json['SyncCreatedTime']),
      syncLastModifiedTime: timeStampFromJson(json['SyncLastModifiedTime']),
      syncName: json['SyncName'] as String?,
      syncSource: json['SyncSource'] != null
          ? ResourceDataSyncSourceWithState.fromJson(
              json['SyncSource'] as Map<String, dynamic>)
          : null,
      syncType: json['SyncType'] as String?,
    );
  }
}

/// The AWS Organizations organizational unit data source for the sync.
class ResourceDataSyncOrganizationalUnit {
  /// The AWS Organization unit ID data source for the sync.
  final String? organizationalUnitId;

  ResourceDataSyncOrganizationalUnit({
    this.organizationalUnitId,
  });
  factory ResourceDataSyncOrganizationalUnit.fromJson(
      Map<String, dynamic> json) {
    return ResourceDataSyncOrganizationalUnit(
      organizationalUnitId: json['OrganizationalUnitId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final organizationalUnitId = this.organizationalUnitId;
    return {
      if (organizationalUnitId != null)
        'OrganizationalUnitId': organizationalUnitId,
    };
  }
}

/// Information about the target S3 bucket for the Resource Data Sync.
class ResourceDataSyncS3Destination {
  /// The name of the S3 bucket where the aggregated data is stored.
  final String bucketName;

  /// The AWS Region with the S3 bucket targeted by the Resource Data Sync.
  final String region;

  /// A supported sync format. The following format is currently supported:
  /// JsonSerDe
  final ResourceDataSyncS3Format syncFormat;

  /// The ARN of an encryption key for a destination in Amazon S3. Must belong to
  /// the same Region as the destination S3 bucket.
  final String? awsKMSKeyARN;

  /// Enables destination data sharing. By default, this field is
  /// <code>null</code>.
  final ResourceDataSyncDestinationDataSharing? destinationDataSharing;

  /// An Amazon S3 prefix for the bucket.
  final String? prefix;

  ResourceDataSyncS3Destination({
    required this.bucketName,
    required this.region,
    required this.syncFormat,
    this.awsKMSKeyARN,
    this.destinationDataSharing,
    this.prefix,
  });
  factory ResourceDataSyncS3Destination.fromJson(Map<String, dynamic> json) {
    return ResourceDataSyncS3Destination(
      bucketName: json['BucketName'] as String,
      region: json['Region'] as String,
      syncFormat: (json['SyncFormat'] as String).toResourceDataSyncS3Format(),
      awsKMSKeyARN: json['AWSKMSKeyARN'] as String?,
      destinationDataSharing: json['DestinationDataSharing'] != null
          ? ResourceDataSyncDestinationDataSharing.fromJson(
              json['DestinationDataSharing'] as Map<String, dynamic>)
          : null,
      prefix: json['Prefix'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final bucketName = this.bucketName;
    final region = this.region;
    final syncFormat = this.syncFormat;
    final awsKMSKeyARN = this.awsKMSKeyARN;
    final destinationDataSharing = this.destinationDataSharing;
    final prefix = this.prefix;
    return {
      'BucketName': bucketName,
      'Region': region,
      'SyncFormat': syncFormat.toValue(),
      if (awsKMSKeyARN != null) 'AWSKMSKeyARN': awsKMSKeyARN,
      if (destinationDataSharing != null)
        'DestinationDataSharing': destinationDataSharing,
      if (prefix != null) 'Prefix': prefix,
    };
  }
}

enum ResourceDataSyncS3Format {
  jsonSerDe,
}

extension on ResourceDataSyncS3Format {
  String toValue() {
    switch (this) {
      case ResourceDataSyncS3Format.jsonSerDe:
        return 'JsonSerDe';
    }
  }
}

extension on String {
  ResourceDataSyncS3Format toResourceDataSyncS3Format() {
    switch (this) {
      case 'JsonSerDe':
        return ResourceDataSyncS3Format.jsonSerDe;
    }
    throw Exception('$this is not known in enum ResourceDataSyncS3Format');
  }
}

/// Information about the source of the data included in the resource data sync.
class ResourceDataSyncSource {
  /// The <code>SyncSource</code> AWS Regions included in the resource data sync.
  final List<String> sourceRegions;

  /// The type of data source for the resource data sync. <code>SourceType</code>
  /// is either <code>AwsOrganizations</code> (if an organization is present in
  /// AWS Organizations) or <code>singleAccountMultiRegions</code>.
  final String sourceType;

  /// Information about the AwsOrganizationsSource resource data sync source. A
  /// sync source of this type can synchronize data from AWS Organizations.
  final ResourceDataSyncAwsOrganizationsSource? awsOrganizationsSource;

  /// Whether to automatically synchronize and aggregate data from new AWS Regions
  /// when those Regions come online.
  final bool? includeFutureRegions;

  ResourceDataSyncSource({
    required this.sourceRegions,
    required this.sourceType,
    this.awsOrganizationsSource,
    this.includeFutureRegions,
  });
  Map<String, dynamic> toJson() {
    final sourceRegions = this.sourceRegions;
    final sourceType = this.sourceType;
    final awsOrganizationsSource = this.awsOrganizationsSource;
    final includeFutureRegions = this.includeFutureRegions;
    return {
      'SourceRegions': sourceRegions,
      'SourceType': sourceType,
      if (awsOrganizationsSource != null)
        'AwsOrganizationsSource': awsOrganizationsSource,
      if (includeFutureRegions != null)
        'IncludeFutureRegions': includeFutureRegions,
    };
  }
}

/// The data type name for including resource data sync state. There are four
/// sync states:
///
/// <code>OrganizationNotExists</code> (Your organization doesn't exist)
///
/// <code>NoPermissions</code> (The system can't locate the service-linked role.
/// This role is automatically created when a user creates a resource data sync
/// in Explorer.)
///
/// <code>InvalidOrganizationalUnit</code> (You specified or selected an invalid
/// unit in the resource data sync configuration.)
///
/// <code>TrustedAccessDisabled</code> (You disabled Systems Manager access in
/// the organization in AWS Organizations.)
class ResourceDataSyncSourceWithState {
  /// The field name in <code>SyncSource</code> for the
  /// <code>ResourceDataSyncAwsOrganizationsSource</code> type.
  final ResourceDataSyncAwsOrganizationsSource? awsOrganizationsSource;

  /// Whether to automatically synchronize and aggregate data from new AWS Regions
  /// when those Regions come online.
  final bool? includeFutureRegions;

  /// The <code>SyncSource</code> AWS Regions included in the resource data sync.
  final List<String>? sourceRegions;

  /// The type of data source for the resource data sync. <code>SourceType</code>
  /// is either <code>AwsOrganizations</code> (if an organization is present in
  /// AWS Organizations) or <code>singleAccountMultiRegions</code>.
  final String? sourceType;

  /// The data type name for including resource data sync state. There are four
  /// sync states:
  ///
  /// <code>OrganizationNotExists</code>: Your organization doesn't exist.
  ///
  /// <code>NoPermissions</code>: The system can't locate the service-linked role.
  /// This role is automatically created when a user creates a resource data sync
  /// in Explorer.
  ///
  /// <code>InvalidOrganizationalUnit</code>: You specified or selected an invalid
  /// unit in the resource data sync configuration.
  ///
  /// <code>TrustedAccessDisabled</code>: You disabled Systems Manager access in
  /// the organization in AWS Organizations.
  final String? state;

  ResourceDataSyncSourceWithState({
    this.awsOrganizationsSource,
    this.includeFutureRegions,
    this.sourceRegions,
    this.sourceType,
    this.state,
  });
  factory ResourceDataSyncSourceWithState.fromJson(Map<String, dynamic> json) {
    return ResourceDataSyncSourceWithState(
      awsOrganizationsSource: json['AwsOrganizationsSource'] != null
          ? ResourceDataSyncAwsOrganizationsSource.fromJson(
              json['AwsOrganizationsSource'] as Map<String, dynamic>)
          : null,
      includeFutureRegions: json['IncludeFutureRegions'] as bool?,
      sourceRegions: (json['SourceRegions'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      sourceType: json['SourceType'] as String?,
      state: json['State'] as String?,
    );
  }
}

enum ResourceType {
  managedInstance,
  document,
  eC2Instance,
}

extension on ResourceType {
  String toValue() {
    switch (this) {
      case ResourceType.managedInstance:
        return 'ManagedInstance';
      case ResourceType.document:
        return 'Document';
      case ResourceType.eC2Instance:
        return 'EC2Instance';
    }
  }
}

extension on String {
  ResourceType toResourceType() {
    switch (this) {
      case 'ManagedInstance':
        return ResourceType.managedInstance;
      case 'Document':
        return ResourceType.document;
      case 'EC2Instance':
        return ResourceType.eC2Instance;
    }
    throw Exception('$this is not known in enum ResourceType');
  }
}

enum ResourceTypeForTagging {
  document,
  managedInstance,
  maintenanceWindow,
  parameter,
  patchBaseline,
  opsItem,
}

extension on ResourceTypeForTagging {
  String toValue() {
    switch (this) {
      case ResourceTypeForTagging.document:
        return 'Document';
      case ResourceTypeForTagging.managedInstance:
        return 'ManagedInstance';
      case ResourceTypeForTagging.maintenanceWindow:
        return 'MaintenanceWindow';
      case ResourceTypeForTagging.parameter:
        return 'Parameter';
      case ResourceTypeForTagging.patchBaseline:
        return 'PatchBaseline';
      case ResourceTypeForTagging.opsItem:
        return 'OpsItem';
    }
  }
}

extension on String {
  ResourceTypeForTagging toResourceTypeForTagging() {
    switch (this) {
      case 'Document':
        return ResourceTypeForTagging.document;
      case 'ManagedInstance':
        return ResourceTypeForTagging.managedInstance;
      case 'MaintenanceWindow':
        return ResourceTypeForTagging.maintenanceWindow;
      case 'Parameter':
        return ResourceTypeForTagging.parameter;
      case 'PatchBaseline':
        return ResourceTypeForTagging.patchBaseline;
      case 'OpsItem':
        return ResourceTypeForTagging.opsItem;
    }
    throw Exception('$this is not known in enum ResourceTypeForTagging');
  }
}

/// The inventory item result attribute.
class ResultAttribute {
  /// Name of the inventory item type. Valid value: AWS:InstanceInformation.
  /// Default Value: AWS:InstanceInformation.
  final String typeName;

  ResultAttribute({
    required this.typeName,
  });
  Map<String, dynamic> toJson() {
    final typeName = this.typeName;
    return {
      'TypeName': typeName,
    };
  }
}

class ResumeSessionResponse {
  /// The ID of the session.
  final String? sessionId;

  /// A URL back to SSM Agent on the instance that the Session Manager client uses
  /// to send commands and receive output from the instance. Format:
  /// <code>wss://ssmmessages.<b>region</b>.amazonaws.com/v1/data-channel/<b>session-id</b>?stream=(input|output)</code>.
  ///
  /// <b>region</b> represents the Region identifier for an AWS Region supported
  /// by AWS Systems Manager, such as <code>us-east-2</code> for the US East
  /// (Ohio) Region. For a list of supported <b>region</b> values, see the
  /// <b>Region</b> column in <a
  /// href="http://docs.aws.amazon.com/general/latest/gr/ssm.html#ssm_region">Systems
  /// Manager service endpoints</a> in the <i>AWS General Reference</i>.
  ///
  /// <b>session-id</b> represents the ID of a Session Manager session, such as
  /// <code>1a2b3c4dEXAMPLE</code>.
  final String? streamUrl;

  /// An encrypted token value containing session and caller information. Used to
  /// authenticate the connection to the instance.
  final String? tokenValue;

  ResumeSessionResponse({
    this.sessionId,
    this.streamUrl,
    this.tokenValue,
  });
  factory ResumeSessionResponse.fromJson(Map<String, dynamic> json) {
    return ResumeSessionResponse(
      sessionId: json['SessionId'] as String?,
      streamUrl: json['StreamUrl'] as String?,
      tokenValue: json['TokenValue'] as String?,
    );
  }
}

/// Information about the result of a document review request.
class ReviewInformation {
  /// The time that the reviewer took action on the document review request.
  final DateTime? reviewedTime;

  /// The reviewer assigned to take action on the document review request.
  final String? reviewer;

  /// The current status of the document review request.
  final ReviewStatus? status;

  ReviewInformation({
    this.reviewedTime,
    this.reviewer,
    this.status,
  });
  factory ReviewInformation.fromJson(Map<String, dynamic> json) {
    return ReviewInformation(
      reviewedTime: timeStampFromJson(json['ReviewedTime']),
      reviewer: json['Reviewer'] as String?,
      status: (json['Status'] as String?)?.toReviewStatus(),
    );
  }
}

enum ReviewStatus {
  approved,
  notReviewed,
  pending,
  rejected,
}

extension on ReviewStatus {
  String toValue() {
    switch (this) {
      case ReviewStatus.approved:
        return 'APPROVED';
      case ReviewStatus.notReviewed:
        return 'NOT_REVIEWED';
      case ReviewStatus.pending:
        return 'PENDING';
      case ReviewStatus.rejected:
        return 'REJECTED';
    }
  }
}

extension on String {
  ReviewStatus toReviewStatus() {
    switch (this) {
      case 'APPROVED':
        return ReviewStatus.approved;
      case 'NOT_REVIEWED':
        return ReviewStatus.notReviewed;
      case 'PENDING':
        return ReviewStatus.pending;
      case 'REJECTED':
        return ReviewStatus.rejected;
    }
    throw Exception('$this is not known in enum ReviewStatus');
  }
}

/// Information about an Automation runbook (Automation document) used in a
/// runbook workflow in Change Manager.
/// <note>
/// The Automation runbooks specified for the runbook workflow can't run until
/// all required approvals for the change request have been received.
/// </note>
class Runbook {
  /// The name of the Automation runbook (Automation document) used in a runbook
  /// workflow.
  final String documentName;

  /// The version of the Automation runbook (Automation document) used in a
  /// runbook workflow.
  final String? documentVersion;

  /// The <code>MaxConcurrency</code> value specified by the user when the
  /// operation started, indicating the maximum number of resources that the
  /// runbook operation can run on at the same time.
  final String? maxConcurrency;

  /// The <code>MaxErrors</code> value specified by the user when the execution
  /// started, indicating the maximum number of errors that can occur during the
  /// operation before the updates are stopped or rolled back.
  final String? maxErrors;

  /// The key-value map of execution parameters, which were supplied when calling
  /// <code>StartChangeRequestExecution</code>.
  final Map<String, List<String>>? parameters;

  /// Information about the AWS Regions and accounts targeted by the current
  /// Runbook operation.
  final List<TargetLocation>? targetLocations;

  /// The name of the parameter used as the target resource for the
  /// rate-controlled runbook workflow. Required if you specify
  /// <code>Targets</code>.
  final String? targetParameterName;

  /// A key-value mapping to target resources that the Runbook operation performs
  /// tasks on. Required if you specify <code>TargetParameterName</code>.
  final List<Target>? targets;

  Runbook({
    required this.documentName,
    this.documentVersion,
    this.maxConcurrency,
    this.maxErrors,
    this.parameters,
    this.targetLocations,
    this.targetParameterName,
    this.targets,
  });
  factory Runbook.fromJson(Map<String, dynamic> json) {
    return Runbook(
      documentName: json['DocumentName'] as String,
      documentVersion: json['DocumentVersion'] as String?,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      parameters: (json['Parameters'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      targetLocations: (json['TargetLocations'] as List?)
          ?.whereNotNull()
          .map((e) => TargetLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetParameterName: json['TargetParameterName'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final documentName = this.documentName;
    final documentVersion = this.documentVersion;
    final maxConcurrency = this.maxConcurrency;
    final maxErrors = this.maxErrors;
    final parameters = this.parameters;
    final targetLocations = this.targetLocations;
    final targetParameterName = this.targetParameterName;
    final targets = this.targets;
    return {
      'DocumentName': documentName,
      if (documentVersion != null) 'DocumentVersion': documentVersion,
      if (maxConcurrency != null) 'MaxConcurrency': maxConcurrency,
      if (maxErrors != null) 'MaxErrors': maxErrors,
      if (parameters != null) 'Parameters': parameters,
      if (targetLocations != null) 'TargetLocations': targetLocations,
      if (targetParameterName != null)
        'TargetParameterName': targetParameterName,
      if (targets != null) 'Targets': targets,
    };
  }
}

/// An S3 bucket where you want to store the results of this request.
class S3OutputLocation {
  /// The name of the S3 bucket.
  final String? outputS3BucketName;

  /// The S3 bucket subfolder.
  final String? outputS3KeyPrefix;

  /// (Deprecated) You can no longer specify this parameter. The system ignores
  /// it. Instead, Systems Manager automatically determines the Region of the S3
  /// bucket.
  final String? outputS3Region;

  S3OutputLocation({
    this.outputS3BucketName,
    this.outputS3KeyPrefix,
    this.outputS3Region,
  });
  factory S3OutputLocation.fromJson(Map<String, dynamic> json) {
    return S3OutputLocation(
      outputS3BucketName: json['OutputS3BucketName'] as String?,
      outputS3KeyPrefix: json['OutputS3KeyPrefix'] as String?,
      outputS3Region: json['OutputS3Region'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final outputS3BucketName = this.outputS3BucketName;
    final outputS3KeyPrefix = this.outputS3KeyPrefix;
    final outputS3Region = this.outputS3Region;
    return {
      if (outputS3BucketName != null) 'OutputS3BucketName': outputS3BucketName,
      if (outputS3KeyPrefix != null) 'OutputS3KeyPrefix': outputS3KeyPrefix,
      if (outputS3Region != null) 'OutputS3Region': outputS3Region,
    };
  }
}

/// A URL for the S3 bucket where you want to store the results of this request.
class S3OutputUrl {
  /// A URL for an S3 bucket where you want to store the results of this request.
  final String? outputUrl;

  S3OutputUrl({
    this.outputUrl,
  });
  factory S3OutputUrl.fromJson(Map<String, dynamic> json) {
    return S3OutputUrl(
      outputUrl: json['OutputUrl'] as String?,
    );
  }
}

/// Information about a scheduled execution for a maintenance window.
class ScheduledWindowExecution {
  /// The time, in ISO-8601 Extended format, that the maintenance window is
  /// scheduled to be run.
  final String? executionTime;

  /// The name of the maintenance window to be run.
  final String? name;

  /// The ID of the maintenance window to be run.
  final String? windowId;

  ScheduledWindowExecution({
    this.executionTime,
    this.name,
    this.windowId,
  });
  factory ScheduledWindowExecution.fromJson(Map<String, dynamic> json) {
    return ScheduledWindowExecution(
      executionTime: json['ExecutionTime'] as String?,
      name: json['Name'] as String?,
      windowId: json['WindowId'] as String?,
    );
  }
}

class SendAutomationSignalResult {
  SendAutomationSignalResult();
  factory SendAutomationSignalResult.fromJson(Map<String, dynamic> _) {
    return SendAutomationSignalResult();
  }
}

class SendCommandResult {
  /// The request as it was received by Systems Manager. Also provides the command
  /// ID which can be used future references to this request.
  final Command? command;

  SendCommandResult({
    this.command,
  });
  factory SendCommandResult.fromJson(Map<String, dynamic> json) {
    return SendCommandResult(
      command: json['Command'] != null
          ? Command.fromJson(json['Command'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The service setting data structure.
///
/// <code>ServiceSetting</code> is an account-level setting for an AWS service.
/// This setting defines how a user interacts with or uses a service or a
/// feature of a service. For example, if an AWS service charges money to the
/// account based on feature or service usage, then the AWS service team might
/// create a default setting of "false". This means the user can't use this
/// feature unless they change the setting to "true" and intentionally opt in
/// for a paid feature.
///
/// Services map a <code>SettingId</code> object to a setting value. AWS
/// services teams define the default value for a <code>SettingId</code>. You
/// can't create a new <code>SettingId</code>, but you can overwrite the default
/// value if you have the <code>ssm:UpdateServiceSetting</code> permission for
/// the setting. Use the <a>UpdateServiceSetting</a> API action to change the
/// default setting. Or, use the <a>ResetServiceSetting</a> to change the value
/// back to the original value defined by the AWS service team.
class ServiceSetting {
  /// The ARN of the service setting.
  final String? arn;

  /// The last time the service setting was modified.
  final DateTime? lastModifiedDate;

  /// The ARN of the last modified user. This field is populated only if the
  /// setting value was overwritten.
  final String? lastModifiedUser;

  /// The ID of the service setting.
  final String? settingId;

  /// The value of the service setting.
  final String? settingValue;

  /// The status of the service setting. The value can be Default, Customized or
  /// PendingUpdate.
  ///
  /// <ul>
  /// <li>
  /// Default: The current setting uses a default value provisioned by the AWS
  /// service team.
  /// </li>
  /// <li>
  /// Customized: The current setting use a custom value specified by the
  /// customer.
  /// </li>
  /// <li>
  /// PendingUpdate: The current setting uses a default or custom value, but a
  /// setting change request is pending approval.
  /// </li>
  /// </ul>
  final String? status;

  ServiceSetting({
    this.arn,
    this.lastModifiedDate,
    this.lastModifiedUser,
    this.settingId,
    this.settingValue,
    this.status,
  });
  factory ServiceSetting.fromJson(Map<String, dynamic> json) {
    return ServiceSetting(
      arn: json['ARN'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      lastModifiedUser: json['LastModifiedUser'] as String?,
      settingId: json['SettingId'] as String?,
      settingValue: json['SettingValue'] as String?,
      status: json['Status'] as String?,
    );
  }
}

/// Information about a Session Manager connection to an instance.
class Session {
  /// Reserved for future use.
  final String? details;

  /// The name of the Session Manager SSM document used to define the parameters
  /// and plugin settings for the session. For example,
  /// <code>SSM-SessionManagerRunShell</code>.
  final String? documentName;

  /// The date and time, in ISO-8601 Extended format, when the session was
  /// terminated.
  final DateTime? endDate;

  /// Reserved for future use.
  final SessionManagerOutputUrl? outputUrl;

  /// The ID of the AWS user account that started the session.
  final String? owner;

  /// The ID of the session.
  final String? sessionId;

  /// The date and time, in ISO-8601 Extended format, when the session began.
  final DateTime? startDate;

  /// The status of the session. For example, "Connected" or "Terminated".
  final SessionStatus? status;

  /// The instance that the Session Manager session connected to.
  final String? target;

  Session({
    this.details,
    this.documentName,
    this.endDate,
    this.outputUrl,
    this.owner,
    this.sessionId,
    this.startDate,
    this.status,
    this.target,
  });
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      details: json['Details'] as String?,
      documentName: json['DocumentName'] as String?,
      endDate: timeStampFromJson(json['EndDate']),
      outputUrl: json['OutputUrl'] != null
          ? SessionManagerOutputUrl.fromJson(
              json['OutputUrl'] as Map<String, dynamic>)
          : null,
      owner: json['Owner'] as String?,
      sessionId: json['SessionId'] as String?,
      startDate: timeStampFromJson(json['StartDate']),
      status: (json['Status'] as String?)?.toSessionStatus(),
      target: json['Target'] as String?,
    );
  }
}

/// Describes a filter for Session Manager information.
class SessionFilter {
  /// The name of the filter.
  final SessionFilterKey key;

  /// The filter value. Valid values for each filter key are as follows:
  ///
  /// <ul>
  /// <li>
  /// InvokedAfter: Specify a timestamp to limit your results. For example,
  /// specify 2018-08-29T00:00:00Z to see sessions that started August 29, 2018,
  /// and later.
  /// </li>
  /// <li>
  /// InvokedBefore: Specify a timestamp to limit your results. For example,
  /// specify 2018-08-29T00:00:00Z to see sessions that started before August 29,
  /// 2018.
  /// </li>
  /// <li>
  /// Target: Specify an instance to which session connections have been made.
  /// </li>
  /// <li>
  /// Owner: Specify an AWS user account to see a list of sessions started by that
  /// user.
  /// </li>
  /// <li>
  /// Status: Specify a valid session status to see a list of all sessions with
  /// that status. Status values you can specify include:
  ///
  /// <ul>
  /// <li>
  /// Connected
  /// </li>
  /// <li>
  /// Connecting
  /// </li>
  /// <li>
  /// Disconnected
  /// </li>
  /// <li>
  /// Terminated
  /// </li>
  /// <li>
  /// Terminating
  /// </li>
  /// <li>
  /// Failed
  /// </li>
  /// </ul> </li>
  /// <li>
  /// SessionId: Specify a session ID to return details about the session.
  /// </li>
  /// </ul>
  final String value;

  SessionFilter({
    required this.key,
    required this.value,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'key': key.toValue(),
      'value': value,
    };
  }
}

enum SessionFilterKey {
  invokedAfter,
  invokedBefore,
  target,
  owner,
  status,
  sessionId,
}

extension on SessionFilterKey {
  String toValue() {
    switch (this) {
      case SessionFilterKey.invokedAfter:
        return 'InvokedAfter';
      case SessionFilterKey.invokedBefore:
        return 'InvokedBefore';
      case SessionFilterKey.target:
        return 'Target';
      case SessionFilterKey.owner:
        return 'Owner';
      case SessionFilterKey.status:
        return 'Status';
      case SessionFilterKey.sessionId:
        return 'SessionId';
    }
  }
}

extension on String {
  SessionFilterKey toSessionFilterKey() {
    switch (this) {
      case 'InvokedAfter':
        return SessionFilterKey.invokedAfter;
      case 'InvokedBefore':
        return SessionFilterKey.invokedBefore;
      case 'Target':
        return SessionFilterKey.target;
      case 'Owner':
        return SessionFilterKey.owner;
      case 'Status':
        return SessionFilterKey.status;
      case 'SessionId':
        return SessionFilterKey.sessionId;
    }
    throw Exception('$this is not known in enum SessionFilterKey');
  }
}

/// Reserved for future use.
class SessionManagerOutputUrl {
  /// Reserved for future use.
  final String? cloudWatchOutputUrl;

  /// Reserved for future use.
  final String? s3OutputUrl;

  SessionManagerOutputUrl({
    this.cloudWatchOutputUrl,
    this.s3OutputUrl,
  });
  factory SessionManagerOutputUrl.fromJson(Map<String, dynamic> json) {
    return SessionManagerOutputUrl(
      cloudWatchOutputUrl: json['CloudWatchOutputUrl'] as String?,
      s3OutputUrl: json['S3OutputUrl'] as String?,
    );
  }
}

enum SessionState {
  active,
  history,
}

extension on SessionState {
  String toValue() {
    switch (this) {
      case SessionState.active:
        return 'Active';
      case SessionState.history:
        return 'History';
    }
  }
}

extension on String {
  SessionState toSessionState() {
    switch (this) {
      case 'Active':
        return SessionState.active;
      case 'History':
        return SessionState.history;
    }
    throw Exception('$this is not known in enum SessionState');
  }
}

enum SessionStatus {
  connected,
  connecting,
  disconnected,
  terminated,
  terminating,
  failed,
}

extension on SessionStatus {
  String toValue() {
    switch (this) {
      case SessionStatus.connected:
        return 'Connected';
      case SessionStatus.connecting:
        return 'Connecting';
      case SessionStatus.disconnected:
        return 'Disconnected';
      case SessionStatus.terminated:
        return 'Terminated';
      case SessionStatus.terminating:
        return 'Terminating';
      case SessionStatus.failed:
        return 'Failed';
    }
  }
}

extension on String {
  SessionStatus toSessionStatus() {
    switch (this) {
      case 'Connected':
        return SessionStatus.connected;
      case 'Connecting':
        return SessionStatus.connecting;
      case 'Disconnected':
        return SessionStatus.disconnected;
      case 'Terminated':
        return SessionStatus.terminated;
      case 'Terminating':
        return SessionStatus.terminating;
      case 'Failed':
        return SessionStatus.failed;
    }
    throw Exception('$this is not known in enum SessionStatus');
  }
}

/// The number of managed instances found for each patch severity level defined
/// in the request filter.
class SeveritySummary {
  /// The total number of resources or compliance items that have a severity level
  /// of critical. Critical severity is determined by the organization that
  /// published the compliance items.
  final int? criticalCount;

  /// The total number of resources or compliance items that have a severity level
  /// of high. High severity is determined by the organization that published the
  /// compliance items.
  final int? highCount;

  /// The total number of resources or compliance items that have a severity level
  /// of informational. Informational severity is determined by the organization
  /// that published the compliance items.
  final int? informationalCount;

  /// The total number of resources or compliance items that have a severity level
  /// of low. Low severity is determined by the organization that published the
  /// compliance items.
  final int? lowCount;

  /// The total number of resources or compliance items that have a severity level
  /// of medium. Medium severity is determined by the organization that published
  /// the compliance items.
  final int? mediumCount;

  /// The total number of resources or compliance items that have a severity level
  /// of unspecified. Unspecified severity is determined by the organization that
  /// published the compliance items.
  final int? unspecifiedCount;

  SeveritySummary({
    this.criticalCount,
    this.highCount,
    this.informationalCount,
    this.lowCount,
    this.mediumCount,
    this.unspecifiedCount,
  });
  factory SeveritySummary.fromJson(Map<String, dynamic> json) {
    return SeveritySummary(
      criticalCount: json['CriticalCount'] as int?,
      highCount: json['HighCount'] as int?,
      informationalCount: json['InformationalCount'] as int?,
      lowCount: json['LowCount'] as int?,
      mediumCount: json['MediumCount'] as int?,
      unspecifiedCount: json['UnspecifiedCount'] as int?,
    );
  }
}

enum SignalType {
  approve,
  reject,
  startStep,
  stopStep,
  resume,
}

extension on SignalType {
  String toValue() {
    switch (this) {
      case SignalType.approve:
        return 'Approve';
      case SignalType.reject:
        return 'Reject';
      case SignalType.startStep:
        return 'StartStep';
      case SignalType.stopStep:
        return 'StopStep';
      case SignalType.resume:
        return 'Resume';
    }
  }
}

extension on String {
  SignalType toSignalType() {
    switch (this) {
      case 'Approve':
        return SignalType.approve;
      case 'Reject':
        return SignalType.reject;
      case 'StartStep':
        return SignalType.startStep;
      case 'StopStep':
        return SignalType.stopStep;
      case 'Resume':
        return SignalType.resume;
    }
    throw Exception('$this is not known in enum SignalType');
  }
}

class StartAssociationsOnceResult {
  StartAssociationsOnceResult();
  factory StartAssociationsOnceResult.fromJson(Map<String, dynamic> _) {
    return StartAssociationsOnceResult();
  }
}

class StartAutomationExecutionResult {
  /// The unique ID of a newly scheduled automation execution.
  final String? automationExecutionId;

  StartAutomationExecutionResult({
    this.automationExecutionId,
  });
  factory StartAutomationExecutionResult.fromJson(Map<String, dynamic> json) {
    return StartAutomationExecutionResult(
      automationExecutionId: json['AutomationExecutionId'] as String?,
    );
  }
}

class StartChangeRequestExecutionResult {
  /// The unique ID of a runbook workflow operation. (A runbook workflow is a type
  /// of Automation operation.)
  final String? automationExecutionId;

  StartChangeRequestExecutionResult({
    this.automationExecutionId,
  });
  factory StartChangeRequestExecutionResult.fromJson(
      Map<String, dynamic> json) {
    return StartChangeRequestExecutionResult(
      automationExecutionId: json['AutomationExecutionId'] as String?,
    );
  }
}

class StartSessionResponse {
  /// The ID of the session.
  final String? sessionId;

  /// A URL back to SSM Agent on the instance that the Session Manager client uses
  /// to send commands and receive output from the instance. Format:
  /// <code>wss://ssmmessages.<b>region</b>.amazonaws.com/v1/data-channel/<b>session-id</b>?stream=(input|output)</code>
  ///
  /// <b>region</b> represents the Region identifier for an AWS Region supported
  /// by AWS Systems Manager, such as <code>us-east-2</code> for the US East
  /// (Ohio) Region. For a list of supported <b>region</b> values, see the
  /// <b>Region</b> column in <a
  /// href="http://docs.aws.amazon.com/general/latest/gr/ssm.html#ssm_region">Systems
  /// Manager service endpoints</a> in the <i>AWS General Reference</i>.
  ///
  /// <b>session-id</b> represents the ID of a Session Manager session, such as
  /// <code>1a2b3c4dEXAMPLE</code>.
  final String? streamUrl;

  /// An encrypted token value containing session and caller information. Used to
  /// authenticate the connection to the instance.
  final String? tokenValue;

  StartSessionResponse({
    this.sessionId,
    this.streamUrl,
    this.tokenValue,
  });
  factory StartSessionResponse.fromJson(Map<String, dynamic> json) {
    return StartSessionResponse(
      sessionId: json['SessionId'] as String?,
      streamUrl: json['StreamUrl'] as String?,
      tokenValue: json['TokenValue'] as String?,
    );
  }
}

/// Detailed information about an the execution state of an Automation step.
class StepExecution {
  /// The action this step performs. The action determines the behavior of the
  /// step.
  final String? action;

  /// If a step has finished execution, this contains the time the execution
  /// ended. If the step has not yet concluded, this field is not populated.
  final DateTime? executionEndTime;

  /// If a step has begun execution, this contains the time the step started. If
  /// the step is in Pending status, this field is not populated.
  final DateTime? executionStartTime;

  /// Information about the Automation failure.
  final FailureDetails? failureDetails;

  /// If a step failed, this message explains why the execution failed.
  final String? failureMessage;

  /// Fully-resolved values passed into the step before execution.
  final Map<String, String>? inputs;

  /// The flag which can be used to help decide whether the failure of current
  /// step leads to the Automation failure.
  final bool? isCritical;

  /// The flag which can be used to end automation no matter whether the step
  /// succeeds or fails.
  final bool? isEnd;

  /// The maximum number of tries to run the action of the step. The default value
  /// is 1.
  final int? maxAttempts;

  /// The next step after the step succeeds.
  final String? nextStep;

  /// The action to take if the step fails. The default value is Abort.
  final String? onFailure;

  /// Returned values from the execution of the step.
  final Map<String, List<String>>? outputs;

  /// A user-specified list of parameters to override when running a step.
  final Map<String, List<String>>? overriddenParameters;

  /// A message associated with the response code for an execution.
  final String? response;

  /// The response code returned by the execution of the step.
  final String? responseCode;

  /// The unique ID of a step execution.
  final String? stepExecutionId;

  /// The name of this execution step.
  final String? stepName;

  /// The execution status for this step.
  final AutomationExecutionStatus? stepStatus;

  /// The combination of AWS Regions and accounts targeted by the current
  /// Automation execution.
  final TargetLocation? targetLocation;

  /// The targets for the step execution.
  final List<Target>? targets;

  /// The timeout seconds of the step.
  final int? timeoutSeconds;

  /// Strategies used when step fails, we support Continue and Abort. Abort will
  /// fail the automation when the step fails. Continue will ignore the failure of
  /// current step and allow automation to run the next step. With conditional
  /// branching, we add step:stepName to support the automation to go to another
  /// specific step.
  final List<String>? validNextSteps;

  StepExecution({
    this.action,
    this.executionEndTime,
    this.executionStartTime,
    this.failureDetails,
    this.failureMessage,
    this.inputs,
    this.isCritical,
    this.isEnd,
    this.maxAttempts,
    this.nextStep,
    this.onFailure,
    this.outputs,
    this.overriddenParameters,
    this.response,
    this.responseCode,
    this.stepExecutionId,
    this.stepName,
    this.stepStatus,
    this.targetLocation,
    this.targets,
    this.timeoutSeconds,
    this.validNextSteps,
  });
  factory StepExecution.fromJson(Map<String, dynamic> json) {
    return StepExecution(
      action: json['Action'] as String?,
      executionEndTime: timeStampFromJson(json['ExecutionEndTime']),
      executionStartTime: timeStampFromJson(json['ExecutionStartTime']),
      failureDetails: json['FailureDetails'] != null
          ? FailureDetails.fromJson(
              json['FailureDetails'] as Map<String, dynamic>)
          : null,
      failureMessage: json['FailureMessage'] as String?,
      inputs: (json['Inputs'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      isCritical: json['IsCritical'] as bool?,
      isEnd: json['IsEnd'] as bool?,
      maxAttempts: json['MaxAttempts'] as int?,
      nextStep: json['NextStep'] as String?,
      onFailure: json['OnFailure'] as String?,
      outputs: (json['Outputs'] as Map<String, dynamic>?)?.map((k, e) =>
          MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      overriddenParameters: (json['OverriddenParameters']
              as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(
              k, (e as List).whereNotNull().map((e) => e as String).toList())),
      response: json['Response'] as String?,
      responseCode: json['ResponseCode'] as String?,
      stepExecutionId: json['StepExecutionId'] as String?,
      stepName: json['StepName'] as String?,
      stepStatus:
          (json['StepStatus'] as String?)?.toAutomationExecutionStatus(),
      targetLocation: json['TargetLocation'] != null
          ? TargetLocation.fromJson(
              json['TargetLocation'] as Map<String, dynamic>)
          : null,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeoutSeconds: json['TimeoutSeconds'] as int?,
      validNextSteps: (json['ValidNextSteps'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

/// A filter to limit the amount of step execution information returned by the
/// call.
class StepExecutionFilter {
  /// One or more keys to limit the results. Valid filter keys include the
  /// following: StepName, Action, StepExecutionId, StepExecutionStatus,
  /// StartTimeBefore, StartTimeAfter.
  final StepExecutionFilterKey key;

  /// The values of the filter key.
  final List<String> values;

  StepExecutionFilter({
    required this.key,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      'Key': key.toValue(),
      'Values': values,
    };
  }
}

enum StepExecutionFilterKey {
  startTimeBefore,
  startTimeAfter,
  stepExecutionStatus,
  stepExecutionId,
  stepName,
  action,
}

extension on StepExecutionFilterKey {
  String toValue() {
    switch (this) {
      case StepExecutionFilterKey.startTimeBefore:
        return 'StartTimeBefore';
      case StepExecutionFilterKey.startTimeAfter:
        return 'StartTimeAfter';
      case StepExecutionFilterKey.stepExecutionStatus:
        return 'StepExecutionStatus';
      case StepExecutionFilterKey.stepExecutionId:
        return 'StepExecutionId';
      case StepExecutionFilterKey.stepName:
        return 'StepName';
      case StepExecutionFilterKey.action:
        return 'Action';
    }
  }
}

extension on String {
  StepExecutionFilterKey toStepExecutionFilterKey() {
    switch (this) {
      case 'StartTimeBefore':
        return StepExecutionFilterKey.startTimeBefore;
      case 'StartTimeAfter':
        return StepExecutionFilterKey.startTimeAfter;
      case 'StepExecutionStatus':
        return StepExecutionFilterKey.stepExecutionStatus;
      case 'StepExecutionId':
        return StepExecutionFilterKey.stepExecutionId;
      case 'StepName':
        return StepExecutionFilterKey.stepName;
      case 'Action':
        return StepExecutionFilterKey.action;
    }
    throw Exception('$this is not known in enum StepExecutionFilterKey');
  }
}

class StopAutomationExecutionResult {
  StopAutomationExecutionResult();
  factory StopAutomationExecutionResult.fromJson(Map<String, dynamic> _) {
    return StopAutomationExecutionResult();
  }
}

enum StopType {
  complete,
  cancel,
}

extension on StopType {
  String toValue() {
    switch (this) {
      case StopType.complete:
        return 'Complete';
      case StopType.cancel:
        return 'Cancel';
    }
  }
}

extension on String {
  StopType toStopType() {
    switch (this) {
      case 'Complete':
        return StopType.complete;
      case 'Cancel':
        return StopType.cancel;
    }
    throw Exception('$this is not known in enum StopType');
  }
}

/// Metadata that you assign to your AWS resources. Tags enable you to
/// categorize your resources in different ways, for example, by purpose, owner,
/// or environment. In Systems Manager, you can apply tags to documents, managed
/// instances, maintenance windows, Parameter Store parameters, and patch
/// baselines.
class Tag {
  /// The name of the tag.
  final String key;

  /// The value of the tag.
  final String value;

  Tag({
    required this.key,
    required this.value,
  });
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      key: json['Key'] as String,
      value: json['Value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'Key': key,
      'Value': value,
    };
  }
}

/// An array of search criteria that targets instances using a Key,Value
/// combination that you specify.
/// <note>
/// One or more targets must be specified for maintenance window Run
/// Command-type tasks. Depending on the task, targets are optional for other
/// maintenance window task types (Automation, AWS Lambda, and AWS Step
/// Functions). For more information about running tasks that do not specify
/// targets, see see <a
/// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html">Registering
/// maintenance window tasks without targets</a> in the <i>AWS Systems Manager
/// User Guide</i>.
/// </note>
/// Supported formats include the following.
///
/// <ul>
/// <li>
/// <code>Key=InstanceIds,Values=<i>instance-id-1</i>,<i>instance-id-2</i>,<i>instance-id-3</i>
/// </code>
/// </li>
/// <li>
/// <code>Key=tag:<i>my-tag-key</i>,Values=<i>my-tag-value-1</i>,<i>my-tag-value-2</i>
/// </code>
/// </li>
/// <li>
/// <code>Key=tag-key,Values=<i>my-tag-key-1</i>,<i>my-tag-key-2</i> </code>
/// </li>
/// <li>
/// <b>Run Command and Maintenance window targets only</b>:
/// <code>Key=resource-groups:Name,Values=<i>resource-group-name</i> </code>
/// </li>
/// <li>
/// <b>Maintenance window targets only</b>:
/// <code>Key=resource-groups:ResourceTypeFilters,Values=<i>resource-type-1</i>,<i>resource-type-2</i>
/// </code>
/// </li>
/// <li>
/// <b>Automation targets only</b>:
/// <code>Key=ResourceGroup;Values=<i>resource-group-name</i> </code>
/// </li>
/// </ul>
/// For example:
///
/// <ul>
/// <li>
/// <code>Key=InstanceIds,Values=i-02573cafcfEXAMPLE,i-0471e04240EXAMPLE,i-07782c72faEXAMPLE</code>
/// </li>
/// <li>
/// <code>Key=tag:CostCenter,Values=CostCenter1,CostCenter2,CostCenter3</code>
/// </li>
/// <li>
/// <code>Key=tag-key,Values=Name,Instance-Type,CostCenter</code>
/// </li>
/// <li>
/// <b>Run Command and Maintenance window targets only</b>:
/// <code>Key=resource-groups:Name,Values=ProductionResourceGroup</code>
///
/// This example demonstrates how to target all resources in the resource group
/// <b>ProductionResourceGroup</b> in your maintenance window.
/// </li>
/// <li>
/// <b>Maintenance window targets only</b>:
/// <code>Key=resource-groups:ResourceTypeFilters,Values=<i>AWS::EC2::INSTANCE</i>,<i>AWS::EC2::VPC</i>
/// </code>
///
/// This example demonstrates how to target only EC2 instances and VPCs in your
/// maintenance window.
/// </li>
/// <li>
/// <b>Automation targets only</b>:
/// <code>Key=ResourceGroup,Values=MyResourceGroup</code>
/// </li>
/// <li>
/// <b>State Manager association targets only</b>:
/// <code>Key=InstanceIds,Values=<i>*</i> </code>
///
/// This example demonstrates how to target all managed instances in the AWS
/// Region where the association was created.
/// </li>
/// </ul>
/// For more information about how to send commands that target instances using
/// <code>Key,Value</code> parameters, see <a
/// href="https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-targeting">Targeting
/// multiple instances</a> in the <i>AWS Systems Manager User Guide</i>.
class Target {
  /// User-defined criteria for sending commands that target instances that meet
  /// the criteria.
  final String? key;

  /// User-defined criteria that maps to <code>Key</code>. For example, if you
  /// specified <code>tag:ServerRole</code>, you could specify
  /// <code>value:WebServer</code> to run a command on instances that include EC2
  /// tags of <code>ServerRole,WebServer</code>.
  final List<String>? values;

  Target({
    this.key,
    this.values,
  });
  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(
      key: json['Key'] as String?,
      values: (json['Values'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final key = this.key;
    final values = this.values;
    return {
      if (key != null) 'Key': key,
      if (values != null) 'Values': values,
    };
  }
}

/// The combination of AWS Regions and accounts targeted by the current
/// Automation execution.
class TargetLocation {
  /// The AWS accounts targeted by the current Automation execution.
  final List<String>? accounts;

  /// The Automation execution role used by the currently running Automation. If
  /// not specified, the default value is
  /// <code>AWS-SystemsManager-AutomationExecutionRole</code>.
  final String? executionRoleName;

  /// The AWS Regions targeted by the current Automation execution.
  final List<String>? regions;

  /// The maximum number of AWS accounts and AWS regions allowed to run the
  /// Automation concurrently.
  final String? targetLocationMaxConcurrency;

  /// The maximum number of errors allowed before the system stops queueing
  /// additional Automation executions for the currently running Automation.
  final String? targetLocationMaxErrors;

  TargetLocation({
    this.accounts,
    this.executionRoleName,
    this.regions,
    this.targetLocationMaxConcurrency,
    this.targetLocationMaxErrors,
  });
  factory TargetLocation.fromJson(Map<String, dynamic> json) {
    return TargetLocation(
      accounts: (json['Accounts'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      executionRoleName: json['ExecutionRoleName'] as String?,
      regions: (json['Regions'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      targetLocationMaxConcurrency:
          json['TargetLocationMaxConcurrency'] as String?,
      targetLocationMaxErrors: json['TargetLocationMaxErrors'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final accounts = this.accounts;
    final executionRoleName = this.executionRoleName;
    final regions = this.regions;
    final targetLocationMaxConcurrency = this.targetLocationMaxConcurrency;
    final targetLocationMaxErrors = this.targetLocationMaxErrors;
    return {
      if (accounts != null) 'Accounts': accounts,
      if (executionRoleName != null) 'ExecutionRoleName': executionRoleName,
      if (regions != null) 'Regions': regions,
      if (targetLocationMaxConcurrency != null)
        'TargetLocationMaxConcurrency': targetLocationMaxConcurrency,
      if (targetLocationMaxErrors != null)
        'TargetLocationMaxErrors': targetLocationMaxErrors,
    };
  }
}

class TerminateSessionResponse {
  /// The ID of the session that has been terminated.
  final String? sessionId;

  TerminateSessionResponse({
    this.sessionId,
  });
  factory TerminateSessionResponse.fromJson(Map<String, dynamic> json) {
    return TerminateSessionResponse(
      sessionId: json['SessionId'] as String?,
    );
  }
}

class UpdateAssociationResult {
  /// The description of the association that was updated.
  final AssociationDescription? associationDescription;

  UpdateAssociationResult({
    this.associationDescription,
  });
  factory UpdateAssociationResult.fromJson(Map<String, dynamic> json) {
    return UpdateAssociationResult(
      associationDescription: json['AssociationDescription'] != null
          ? AssociationDescription.fromJson(
              json['AssociationDescription'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UpdateAssociationStatusResult {
  /// Information about the association.
  final AssociationDescription? associationDescription;

  UpdateAssociationStatusResult({
    this.associationDescription,
  });
  factory UpdateAssociationStatusResult.fromJson(Map<String, dynamic> json) {
    return UpdateAssociationStatusResult(
      associationDescription: json['AssociationDescription'] != null
          ? AssociationDescription.fromJson(
              json['AssociationDescription'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UpdateDocumentDefaultVersionResult {
  /// The description of a custom document that you want to set as the default
  /// version.
  final DocumentDefaultVersionDescription? description;

  UpdateDocumentDefaultVersionResult({
    this.description,
  });
  factory UpdateDocumentDefaultVersionResult.fromJson(
      Map<String, dynamic> json) {
    return UpdateDocumentDefaultVersionResult(
      description: json['Description'] != null
          ? DocumentDefaultVersionDescription.fromJson(
              json['Description'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UpdateDocumentMetadataResponse {
  UpdateDocumentMetadataResponse();
  factory UpdateDocumentMetadataResponse.fromJson(Map<String, dynamic> _) {
    return UpdateDocumentMetadataResponse();
  }
}

class UpdateDocumentResult {
  /// A description of the document that was updated.
  final DocumentDescription? documentDescription;

  UpdateDocumentResult({
    this.documentDescription,
  });
  factory UpdateDocumentResult.fromJson(Map<String, dynamic> json) {
    return UpdateDocumentResult(
      documentDescription: json['DocumentDescription'] != null
          ? DocumentDescription.fromJson(
              json['DocumentDescription'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UpdateMaintenanceWindowResult {
  /// Whether targets must be registered with the maintenance window before tasks
  /// can be defined for those targets.
  final bool? allowUnassociatedTargets;

  /// The number of hours before the end of the maintenance window that Systems
  /// Manager stops scheduling new tasks for execution.
  final int? cutoff;

  /// An optional description of the update.
  final String? description;

  /// The duration of the maintenance window in hours.
  final int? duration;

  /// Whether the maintenance window is enabled.
  final bool? enabled;

  /// The date and time, in ISO-8601 Extended format, for when the maintenance
  /// window is scheduled to become inactive. The maintenance window will not run
  /// after this specified time.
  final String? endDate;

  /// The name of the maintenance window.
  final String? name;

  /// The schedule of the maintenance window in the form of a cron or rate
  /// expression.
  final String? schedule;

  /// The number of days to wait to run a maintenance window after the scheduled
  /// CRON expression date and time.
  final int? scheduleOffset;

  /// The time zone that the scheduled maintenance window executions are based on,
  /// in Internet Assigned Numbers Authority (IANA) format. For example:
  /// "America/Los_Angeles", "UTC", or "Asia/Seoul". For more information, see the
  /// <a href="https://www.iana.org/time-zones">Time Zone Database</a> on the IANA
  /// website.
  final String? scheduleTimezone;

  /// The date and time, in ISO-8601 Extended format, for when the maintenance
  /// window is scheduled to become active. The maintenance window will not run
  /// before this specified time.
  final String? startDate;

  /// The ID of the created maintenance window.
  final String? windowId;

  UpdateMaintenanceWindowResult({
    this.allowUnassociatedTargets,
    this.cutoff,
    this.description,
    this.duration,
    this.enabled,
    this.endDate,
    this.name,
    this.schedule,
    this.scheduleOffset,
    this.scheduleTimezone,
    this.startDate,
    this.windowId,
  });
  factory UpdateMaintenanceWindowResult.fromJson(Map<String, dynamic> json) {
    return UpdateMaintenanceWindowResult(
      allowUnassociatedTargets: json['AllowUnassociatedTargets'] as bool?,
      cutoff: json['Cutoff'] as int?,
      description: json['Description'] as String?,
      duration: json['Duration'] as int?,
      enabled: json['Enabled'] as bool?,
      endDate: json['EndDate'] as String?,
      name: json['Name'] as String?,
      schedule: json['Schedule'] as String?,
      scheduleOffset: json['ScheduleOffset'] as int?,
      scheduleTimezone: json['ScheduleTimezone'] as String?,
      startDate: json['StartDate'] as String?,
      windowId: json['WindowId'] as String?,
    );
  }
}

class UpdateMaintenanceWindowTargetResult {
  /// The updated description.
  final String? description;

  /// The updated name.
  final String? name;

  /// The updated owner.
  final String? ownerInformation;

  /// The updated targets.
  final List<Target>? targets;

  /// The maintenance window ID specified in the update request.
  final String? windowId;

  /// The target ID specified in the update request.
  final String? windowTargetId;

  UpdateMaintenanceWindowTargetResult({
    this.description,
    this.name,
    this.ownerInformation,
    this.targets,
    this.windowId,
    this.windowTargetId,
  });
  factory UpdateMaintenanceWindowTargetResult.fromJson(
      Map<String, dynamic> json) {
    return UpdateMaintenanceWindowTargetResult(
      description: json['Description'] as String?,
      name: json['Name'] as String?,
      ownerInformation: json['OwnerInformation'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
      windowId: json['WindowId'] as String?,
      windowTargetId: json['WindowTargetId'] as String?,
    );
  }
}

class UpdateMaintenanceWindowTaskResult {
  /// The updated task description.
  final String? description;

  /// The updated logging information in Amazon S3.
  /// <note>
  /// <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to
  /// contain logs, instead use the <code>OutputS3BucketName</code> and
  /// <code>OutputS3KeyPrefix</code> options in the
  /// <code>TaskInvocationParameters</code> structure. For information about how
  /// Systems Manager handles these options for the supported maintenance window
  /// task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  final LoggingInfo? loggingInfo;

  /// The updated MaxConcurrency value.
  final String? maxConcurrency;

  /// The updated MaxErrors value.
  final String? maxErrors;

  /// The updated task name.
  final String? name;

  /// The updated priority value.
  final int? priority;

  /// The ARN of the IAM service role to use to publish Amazon Simple Notification
  /// Service (Amazon SNS) notifications for maintenance window Run Command tasks.
  final String? serviceRoleArn;

  /// The updated target values.
  final List<Target>? targets;

  /// The updated task ARN value.
  final String? taskArn;

  /// The updated parameter values.
  final MaintenanceWindowTaskInvocationParameters? taskInvocationParameters;

  /// The updated parameter values.
  /// <note>
  /// <code>TaskParameters</code> has been deprecated. To specify parameters to
  /// pass to a task when it runs, instead use the <code>Parameters</code> option
  /// in the <code>TaskInvocationParameters</code> structure. For information
  /// about how Systems Manager handles these options for the supported
  /// maintenance window task types, see
  /// <a>MaintenanceWindowTaskInvocationParameters</a>.
  /// </note>
  final Map<String, MaintenanceWindowTaskParameterValueExpression>?
      taskParameters;

  /// The ID of the maintenance window that was updated.
  final String? windowId;

  /// The task ID of the maintenance window that was updated.
  final String? windowTaskId;

  UpdateMaintenanceWindowTaskResult({
    this.description,
    this.loggingInfo,
    this.maxConcurrency,
    this.maxErrors,
    this.name,
    this.priority,
    this.serviceRoleArn,
    this.targets,
    this.taskArn,
    this.taskInvocationParameters,
    this.taskParameters,
    this.windowId,
    this.windowTaskId,
  });
  factory UpdateMaintenanceWindowTaskResult.fromJson(
      Map<String, dynamic> json) {
    return UpdateMaintenanceWindowTaskResult(
      description: json['Description'] as String?,
      loggingInfo: json['LoggingInfo'] != null
          ? LoggingInfo.fromJson(json['LoggingInfo'] as Map<String, dynamic>)
          : null,
      maxConcurrency: json['MaxConcurrency'] as String?,
      maxErrors: json['MaxErrors'] as String?,
      name: json['Name'] as String?,
      priority: json['Priority'] as int?,
      serviceRoleArn: json['ServiceRoleArn'] as String?,
      targets: (json['Targets'] as List?)
          ?.whereNotNull()
          .map((e) => Target.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskArn: json['TaskArn'] as String?,
      taskInvocationParameters: json['TaskInvocationParameters'] != null
          ? MaintenanceWindowTaskInvocationParameters.fromJson(
              json['TaskInvocationParameters'] as Map<String, dynamic>)
          : null,
      taskParameters: (json['TaskParameters'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k,
              MaintenanceWindowTaskParameterValueExpression.fromJson(
                  e as Map<String, dynamic>))),
      windowId: json['WindowId'] as String?,
      windowTaskId: json['WindowTaskId'] as String?,
    );
  }
}

class UpdateManagedInstanceRoleResult {
  UpdateManagedInstanceRoleResult();
  factory UpdateManagedInstanceRoleResult.fromJson(Map<String, dynamic> _) {
    return UpdateManagedInstanceRoleResult();
  }
}

class UpdateOpsItemResponse {
  UpdateOpsItemResponse();
  factory UpdateOpsItemResponse.fromJson(Map<String, dynamic> _) {
    return UpdateOpsItemResponse();
  }
}

class UpdateOpsMetadataResult {
  /// The Amazon Resource Name (ARN) of the OpsMetadata Object that was updated.
  final String? opsMetadataArn;

  UpdateOpsMetadataResult({
    this.opsMetadataArn,
  });
  factory UpdateOpsMetadataResult.fromJson(Map<String, dynamic> json) {
    return UpdateOpsMetadataResult(
      opsMetadataArn: json['OpsMetadataArn'] as String?,
    );
  }
}

class UpdatePatchBaselineResult {
  /// A set of rules used to include patches in the baseline.
  final PatchRuleGroup? approvalRules;

  /// A list of explicitly approved patches for the baseline.
  final List<String>? approvedPatches;

  /// The compliance severity level assigned to the patch baseline after the
  /// update completed.
  final PatchComplianceLevel? approvedPatchesComplianceLevel;

  /// Indicates whether the list of approved patches includes non-security updates
  /// that should be applied to the instances. The default value is 'false'.
  /// Applies to Linux instances only.
  final bool? approvedPatchesEnableNonSecurity;

  /// The ID of the deleted patch baseline.
  final String? baselineId;

  /// The date when the patch baseline was created.
  final DateTime? createdDate;

  /// A description of the Patch Baseline.
  final String? description;

  /// A set of global filters used to exclude patches from the baseline.
  final PatchFilterGroup? globalFilters;

  /// The date when the patch baseline was last modified.
  final DateTime? modifiedDate;

  /// The name of the patch baseline.
  final String? name;

  /// The operating system rule used by the updated patch baseline.
  final OperatingSystem? operatingSystem;

  /// A list of explicitly rejected patches for the baseline.
  final List<String>? rejectedPatches;

  /// The action specified to take on patches included in the RejectedPatches
  /// list. A patch can be allowed only if it is a dependency of another package,
  /// or blocked entirely along with packages that include it as a dependency.
  final PatchAction? rejectedPatchesAction;

  /// Information about the patches to use to update the instances, including
  /// target operating systems and source repositories. Applies to Linux instances
  /// only.
  final List<PatchSource>? sources;

  UpdatePatchBaselineResult({
    this.approvalRules,
    this.approvedPatches,
    this.approvedPatchesComplianceLevel,
    this.approvedPatchesEnableNonSecurity,
    this.baselineId,
    this.createdDate,
    this.description,
    this.globalFilters,
    this.modifiedDate,
    this.name,
    this.operatingSystem,
    this.rejectedPatches,
    this.rejectedPatchesAction,
    this.sources,
  });
  factory UpdatePatchBaselineResult.fromJson(Map<String, dynamic> json) {
    return UpdatePatchBaselineResult(
      approvalRules: json['ApprovalRules'] != null
          ? PatchRuleGroup.fromJson(
              json['ApprovalRules'] as Map<String, dynamic>)
          : null,
      approvedPatches: (json['ApprovedPatches'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      approvedPatchesComplianceLevel:
          (json['ApprovedPatchesComplianceLevel'] as String?)
              ?.toPatchComplianceLevel(),
      approvedPatchesEnableNonSecurity:
          json['ApprovedPatchesEnableNonSecurity'] as bool?,
      baselineId: json['BaselineId'] as String?,
      createdDate: timeStampFromJson(json['CreatedDate']),
      description: json['Description'] as String?,
      globalFilters: json['GlobalFilters'] != null
          ? PatchFilterGroup.fromJson(
              json['GlobalFilters'] as Map<String, dynamic>)
          : null,
      modifiedDate: timeStampFromJson(json['ModifiedDate']),
      name: json['Name'] as String?,
      operatingSystem:
          (json['OperatingSystem'] as String?)?.toOperatingSystem(),
      rejectedPatches: (json['RejectedPatches'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      rejectedPatchesAction:
          (json['RejectedPatchesAction'] as String?)?.toPatchAction(),
      sources: (json['Sources'] as List?)
          ?.whereNotNull()
          .map((e) => PatchSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class UpdateResourceDataSyncResult {
  UpdateResourceDataSyncResult();
  factory UpdateResourceDataSyncResult.fromJson(Map<String, dynamic> _) {
    return UpdateResourceDataSyncResult();
  }
}

/// The result body of the UpdateServiceSetting API action.
class UpdateServiceSettingResult {
  UpdateServiceSettingResult();
  factory UpdateServiceSettingResult.fromJson(Map<String, dynamic> _) {
    return UpdateServiceSettingResult();
  }
}

class AlreadyExistsException extends _s.GenericAwsException {
  AlreadyExistsException({String? type, String? message})
      : super(type: type, code: 'AlreadyExistsException', message: message);
}

class AssociatedInstances extends _s.GenericAwsException {
  AssociatedInstances({String? type, String? message})
      : super(type: type, code: 'AssociatedInstances', message: message);
}

class AssociationAlreadyExists extends _s.GenericAwsException {
  AssociationAlreadyExists({String? type, String? message})
      : super(type: type, code: 'AssociationAlreadyExists', message: message);
}

class AssociationDoesNotExist extends _s.GenericAwsException {
  AssociationDoesNotExist({String? type, String? message})
      : super(type: type, code: 'AssociationDoesNotExist', message: message);
}

class AssociationExecutionDoesNotExist extends _s.GenericAwsException {
  AssociationExecutionDoesNotExist({String? type, String? message})
      : super(
            type: type,
            code: 'AssociationExecutionDoesNotExist',
            message: message);
}

class AssociationLimitExceeded extends _s.GenericAwsException {
  AssociationLimitExceeded({String? type, String? message})
      : super(type: type, code: 'AssociationLimitExceeded', message: message);
}

class AssociationVersionLimitExceeded extends _s.GenericAwsException {
  AssociationVersionLimitExceeded({String? type, String? message})
      : super(
            type: type,
            code: 'AssociationVersionLimitExceeded',
            message: message);
}

class AutomationDefinitionNotApprovedException extends _s.GenericAwsException {
  AutomationDefinitionNotApprovedException({String? type, String? message})
      : super(
            type: type,
            code: 'AutomationDefinitionNotApprovedException',
            message: message);
}

class AutomationDefinitionNotFoundException extends _s.GenericAwsException {
  AutomationDefinitionNotFoundException({String? type, String? message})
      : super(
            type: type,
            code: 'AutomationDefinitionNotFoundException',
            message: message);
}

class AutomationDefinitionVersionNotFoundException
    extends _s.GenericAwsException {
  AutomationDefinitionVersionNotFoundException({String? type, String? message})
      : super(
            type: type,
            code: 'AutomationDefinitionVersionNotFoundException',
            message: message);
}

class AutomationExecutionLimitExceededException extends _s.GenericAwsException {
  AutomationExecutionLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'AutomationExecutionLimitExceededException',
            message: message);
}

class AutomationExecutionNotFoundException extends _s.GenericAwsException {
  AutomationExecutionNotFoundException({String? type, String? message})
      : super(
            type: type,
            code: 'AutomationExecutionNotFoundException',
            message: message);
}

class AutomationStepNotFoundException extends _s.GenericAwsException {
  AutomationStepNotFoundException({String? type, String? message})
      : super(
            type: type,
            code: 'AutomationStepNotFoundException',
            message: message);
}

class ComplianceTypeCountLimitExceededException extends _s.GenericAwsException {
  ComplianceTypeCountLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'ComplianceTypeCountLimitExceededException',
            message: message);
}

class CustomSchemaCountLimitExceededException extends _s.GenericAwsException {
  CustomSchemaCountLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'CustomSchemaCountLimitExceededException',
            message: message);
}

class DocumentAlreadyExists extends _s.GenericAwsException {
  DocumentAlreadyExists({String? type, String? message})
      : super(type: type, code: 'DocumentAlreadyExists', message: message);
}

class DocumentLimitExceeded extends _s.GenericAwsException {
  DocumentLimitExceeded({String? type, String? message})
      : super(type: type, code: 'DocumentLimitExceeded', message: message);
}

class DocumentPermissionLimit extends _s.GenericAwsException {
  DocumentPermissionLimit({String? type, String? message})
      : super(type: type, code: 'DocumentPermissionLimit', message: message);
}

class DocumentVersionLimitExceeded extends _s.GenericAwsException {
  DocumentVersionLimitExceeded({String? type, String? message})
      : super(
            type: type, code: 'DocumentVersionLimitExceeded', message: message);
}

class DoesNotExistException extends _s.GenericAwsException {
  DoesNotExistException({String? type, String? message})
      : super(type: type, code: 'DoesNotExistException', message: message);
}

class DuplicateDocumentContent extends _s.GenericAwsException {
  DuplicateDocumentContent({String? type, String? message})
      : super(type: type, code: 'DuplicateDocumentContent', message: message);
}

class DuplicateDocumentVersionName extends _s.GenericAwsException {
  DuplicateDocumentVersionName({String? type, String? message})
      : super(
            type: type, code: 'DuplicateDocumentVersionName', message: message);
}

class DuplicateInstanceId extends _s.GenericAwsException {
  DuplicateInstanceId({String? type, String? message})
      : super(type: type, code: 'DuplicateInstanceId', message: message);
}

class FeatureNotAvailableException extends _s.GenericAwsException {
  FeatureNotAvailableException({String? type, String? message})
      : super(
            type: type, code: 'FeatureNotAvailableException', message: message);
}

class HierarchyLevelLimitExceededException extends _s.GenericAwsException {
  HierarchyLevelLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'HierarchyLevelLimitExceededException',
            message: message);
}

class HierarchyTypeMismatchException extends _s.GenericAwsException {
  HierarchyTypeMismatchException({String? type, String? message})
      : super(
            type: type,
            code: 'HierarchyTypeMismatchException',
            message: message);
}

class IdempotentParameterMismatch extends _s.GenericAwsException {
  IdempotentParameterMismatch({String? type, String? message})
      : super(
            type: type, code: 'IdempotentParameterMismatch', message: message);
}

class IncompatiblePolicyException extends _s.GenericAwsException {
  IncompatiblePolicyException({String? type, String? message})
      : super(
            type: type, code: 'IncompatiblePolicyException', message: message);
}

class InternalServerError extends _s.GenericAwsException {
  InternalServerError({String? type, String? message})
      : super(type: type, code: 'InternalServerError', message: message);
}

class InvalidActivation extends _s.GenericAwsException {
  InvalidActivation({String? type, String? message})
      : super(type: type, code: 'InvalidActivation', message: message);
}

class InvalidActivationId extends _s.GenericAwsException {
  InvalidActivationId({String? type, String? message})
      : super(type: type, code: 'InvalidActivationId', message: message);
}

class InvalidAggregatorException extends _s.GenericAwsException {
  InvalidAggregatorException({String? type, String? message})
      : super(type: type, code: 'InvalidAggregatorException', message: message);
}

class InvalidAllowedPatternException extends _s.GenericAwsException {
  InvalidAllowedPatternException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidAllowedPatternException',
            message: message);
}

class InvalidAssociation extends _s.GenericAwsException {
  InvalidAssociation({String? type, String? message})
      : super(type: type, code: 'InvalidAssociation', message: message);
}

class InvalidAssociationVersion extends _s.GenericAwsException {
  InvalidAssociationVersion({String? type, String? message})
      : super(type: type, code: 'InvalidAssociationVersion', message: message);
}

class InvalidAutomationExecutionParametersException
    extends _s.GenericAwsException {
  InvalidAutomationExecutionParametersException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidAutomationExecutionParametersException',
            message: message);
}

class InvalidAutomationSignalException extends _s.GenericAwsException {
  InvalidAutomationSignalException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidAutomationSignalException',
            message: message);
}

class InvalidAutomationStatusUpdateException extends _s.GenericAwsException {
  InvalidAutomationStatusUpdateException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidAutomationStatusUpdateException',
            message: message);
}

class InvalidCommandId extends _s.GenericAwsException {
  InvalidCommandId({String? type, String? message})
      : super(type: type, code: 'InvalidCommandId', message: message);
}

class InvalidDeleteInventoryParametersException extends _s.GenericAwsException {
  InvalidDeleteInventoryParametersException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidDeleteInventoryParametersException',
            message: message);
}

class InvalidDeletionIdException extends _s.GenericAwsException {
  InvalidDeletionIdException({String? type, String? message})
      : super(type: type, code: 'InvalidDeletionIdException', message: message);
}

class InvalidDocument extends _s.GenericAwsException {
  InvalidDocument({String? type, String? message})
      : super(type: type, code: 'InvalidDocument', message: message);
}

class InvalidDocumentContent extends _s.GenericAwsException {
  InvalidDocumentContent({String? type, String? message})
      : super(type: type, code: 'InvalidDocumentContent', message: message);
}

class InvalidDocumentOperation extends _s.GenericAwsException {
  InvalidDocumentOperation({String? type, String? message})
      : super(type: type, code: 'InvalidDocumentOperation', message: message);
}

class InvalidDocumentSchemaVersion extends _s.GenericAwsException {
  InvalidDocumentSchemaVersion({String? type, String? message})
      : super(
            type: type, code: 'InvalidDocumentSchemaVersion', message: message);
}

class InvalidDocumentType extends _s.GenericAwsException {
  InvalidDocumentType({String? type, String? message})
      : super(type: type, code: 'InvalidDocumentType', message: message);
}

class InvalidDocumentVersion extends _s.GenericAwsException {
  InvalidDocumentVersion({String? type, String? message})
      : super(type: type, code: 'InvalidDocumentVersion', message: message);
}

class InvalidFilter extends _s.GenericAwsException {
  InvalidFilter({String? type, String? message})
      : super(type: type, code: 'InvalidFilter', message: message);
}

class InvalidFilterKey extends _s.GenericAwsException {
  InvalidFilterKey({String? type, String? message})
      : super(type: type, code: 'InvalidFilterKey', message: message);
}

class InvalidFilterOption extends _s.GenericAwsException {
  InvalidFilterOption({String? type, String? message})
      : super(type: type, code: 'InvalidFilterOption', message: message);
}

class InvalidFilterValue extends _s.GenericAwsException {
  InvalidFilterValue({String? type, String? message})
      : super(type: type, code: 'InvalidFilterValue', message: message);
}

class InvalidInstanceId extends _s.GenericAwsException {
  InvalidInstanceId({String? type, String? message})
      : super(type: type, code: 'InvalidInstanceId', message: message);
}

class InvalidInstanceInformationFilterValue extends _s.GenericAwsException {
  InvalidInstanceInformationFilterValue({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidInstanceInformationFilterValue',
            message: message);
}

class InvalidInventoryGroupException extends _s.GenericAwsException {
  InvalidInventoryGroupException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidInventoryGroupException',
            message: message);
}

class InvalidInventoryItemContextException extends _s.GenericAwsException {
  InvalidInventoryItemContextException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidInventoryItemContextException',
            message: message);
}

class InvalidInventoryRequestException extends _s.GenericAwsException {
  InvalidInventoryRequestException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidInventoryRequestException',
            message: message);
}

class InvalidItemContentException extends _s.GenericAwsException {
  InvalidItemContentException({String? type, String? message})
      : super(
            type: type, code: 'InvalidItemContentException', message: message);
}

class InvalidKeyId extends _s.GenericAwsException {
  InvalidKeyId({String? type, String? message})
      : super(type: type, code: 'InvalidKeyId', message: message);
}

class InvalidNextToken extends _s.GenericAwsException {
  InvalidNextToken({String? type, String? message})
      : super(type: type, code: 'InvalidNextToken', message: message);
}

class InvalidNotificationConfig extends _s.GenericAwsException {
  InvalidNotificationConfig({String? type, String? message})
      : super(type: type, code: 'InvalidNotificationConfig', message: message);
}

class InvalidOptionException extends _s.GenericAwsException {
  InvalidOptionException({String? type, String? message})
      : super(type: type, code: 'InvalidOptionException', message: message);
}

class InvalidOutputFolder extends _s.GenericAwsException {
  InvalidOutputFolder({String? type, String? message})
      : super(type: type, code: 'InvalidOutputFolder', message: message);
}

class InvalidOutputLocation extends _s.GenericAwsException {
  InvalidOutputLocation({String? type, String? message})
      : super(type: type, code: 'InvalidOutputLocation', message: message);
}

class InvalidParameters extends _s.GenericAwsException {
  InvalidParameters({String? type, String? message})
      : super(type: type, code: 'InvalidParameters', message: message);
}

class InvalidPermissionType extends _s.GenericAwsException {
  InvalidPermissionType({String? type, String? message})
      : super(type: type, code: 'InvalidPermissionType', message: message);
}

class InvalidPluginName extends _s.GenericAwsException {
  InvalidPluginName({String? type, String? message})
      : super(type: type, code: 'InvalidPluginName', message: message);
}

class InvalidPolicyAttributeException extends _s.GenericAwsException {
  InvalidPolicyAttributeException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidPolicyAttributeException',
            message: message);
}

class InvalidPolicyTypeException extends _s.GenericAwsException {
  InvalidPolicyTypeException({String? type, String? message})
      : super(type: type, code: 'InvalidPolicyTypeException', message: message);
}

class InvalidResourceId extends _s.GenericAwsException {
  InvalidResourceId({String? type, String? message})
      : super(type: type, code: 'InvalidResourceId', message: message);
}

class InvalidResourceType extends _s.GenericAwsException {
  InvalidResourceType({String? type, String? message})
      : super(type: type, code: 'InvalidResourceType', message: message);
}

class InvalidResultAttributeException extends _s.GenericAwsException {
  InvalidResultAttributeException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidResultAttributeException',
            message: message);
}

class InvalidRole extends _s.GenericAwsException {
  InvalidRole({String? type, String? message})
      : super(type: type, code: 'InvalidRole', message: message);
}

class InvalidSchedule extends _s.GenericAwsException {
  InvalidSchedule({String? type, String? message})
      : super(type: type, code: 'InvalidSchedule', message: message);
}

class InvalidTarget extends _s.GenericAwsException {
  InvalidTarget({String? type, String? message})
      : super(type: type, code: 'InvalidTarget', message: message);
}

class InvalidTypeNameException extends _s.GenericAwsException {
  InvalidTypeNameException({String? type, String? message})
      : super(type: type, code: 'InvalidTypeNameException', message: message);
}

class InvalidUpdate extends _s.GenericAwsException {
  InvalidUpdate({String? type, String? message})
      : super(type: type, code: 'InvalidUpdate', message: message);
}

class InvocationDoesNotExist extends _s.GenericAwsException {
  InvocationDoesNotExist({String? type, String? message})
      : super(type: type, code: 'InvocationDoesNotExist', message: message);
}

class ItemContentMismatchException extends _s.GenericAwsException {
  ItemContentMismatchException({String? type, String? message})
      : super(
            type: type, code: 'ItemContentMismatchException', message: message);
}

class ItemSizeLimitExceededException extends _s.GenericAwsException {
  ItemSizeLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'ItemSizeLimitExceededException',
            message: message);
}

class MaxDocumentSizeExceeded extends _s.GenericAwsException {
  MaxDocumentSizeExceeded({String? type, String? message})
      : super(type: type, code: 'MaxDocumentSizeExceeded', message: message);
}

class OpsItemAlreadyExistsException extends _s.GenericAwsException {
  OpsItemAlreadyExistsException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsItemAlreadyExistsException',
            message: message);
}

class OpsItemInvalidParameterException extends _s.GenericAwsException {
  OpsItemInvalidParameterException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsItemInvalidParameterException',
            message: message);
}

class OpsItemLimitExceededException extends _s.GenericAwsException {
  OpsItemLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsItemLimitExceededException',
            message: message);
}

class OpsItemNotFoundException extends _s.GenericAwsException {
  OpsItemNotFoundException({String? type, String? message})
      : super(type: type, code: 'OpsItemNotFoundException', message: message);
}

class OpsMetadataAlreadyExistsException extends _s.GenericAwsException {
  OpsMetadataAlreadyExistsException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsMetadataAlreadyExistsException',
            message: message);
}

class OpsMetadataInvalidArgumentException extends _s.GenericAwsException {
  OpsMetadataInvalidArgumentException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsMetadataInvalidArgumentException',
            message: message);
}

class OpsMetadataKeyLimitExceededException extends _s.GenericAwsException {
  OpsMetadataKeyLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsMetadataKeyLimitExceededException',
            message: message);
}

class OpsMetadataLimitExceededException extends _s.GenericAwsException {
  OpsMetadataLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsMetadataLimitExceededException',
            message: message);
}

class OpsMetadataNotFoundException extends _s.GenericAwsException {
  OpsMetadataNotFoundException({String? type, String? message})
      : super(
            type: type, code: 'OpsMetadataNotFoundException', message: message);
}

class OpsMetadataTooManyUpdatesException extends _s.GenericAwsException {
  OpsMetadataTooManyUpdatesException({String? type, String? message})
      : super(
            type: type,
            code: 'OpsMetadataTooManyUpdatesException',
            message: message);
}

class ParameterAlreadyExists extends _s.GenericAwsException {
  ParameterAlreadyExists({String? type, String? message})
      : super(type: type, code: 'ParameterAlreadyExists', message: message);
}

class ParameterLimitExceeded extends _s.GenericAwsException {
  ParameterLimitExceeded({String? type, String? message})
      : super(type: type, code: 'ParameterLimitExceeded', message: message);
}

class ParameterMaxVersionLimitExceeded extends _s.GenericAwsException {
  ParameterMaxVersionLimitExceeded({String? type, String? message})
      : super(
            type: type,
            code: 'ParameterMaxVersionLimitExceeded',
            message: message);
}

class ParameterNotFound extends _s.GenericAwsException {
  ParameterNotFound({String? type, String? message})
      : super(type: type, code: 'ParameterNotFound', message: message);
}

class ParameterPatternMismatchException extends _s.GenericAwsException {
  ParameterPatternMismatchException({String? type, String? message})
      : super(
            type: type,
            code: 'ParameterPatternMismatchException',
            message: message);
}

class ParameterVersionLabelLimitExceeded extends _s.GenericAwsException {
  ParameterVersionLabelLimitExceeded({String? type, String? message})
      : super(
            type: type,
            code: 'ParameterVersionLabelLimitExceeded',
            message: message);
}

class ParameterVersionNotFound extends _s.GenericAwsException {
  ParameterVersionNotFound({String? type, String? message})
      : super(type: type, code: 'ParameterVersionNotFound', message: message);
}

class PoliciesLimitExceededException extends _s.GenericAwsException {
  PoliciesLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'PoliciesLimitExceededException',
            message: message);
}

class ResourceDataSyncAlreadyExistsException extends _s.GenericAwsException {
  ResourceDataSyncAlreadyExistsException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceDataSyncAlreadyExistsException',
            message: message);
}

class ResourceDataSyncConflictException extends _s.GenericAwsException {
  ResourceDataSyncConflictException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceDataSyncConflictException',
            message: message);
}

class ResourceDataSyncCountExceededException extends _s.GenericAwsException {
  ResourceDataSyncCountExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceDataSyncCountExceededException',
            message: message);
}

class ResourceDataSyncInvalidConfigurationException
    extends _s.GenericAwsException {
  ResourceDataSyncInvalidConfigurationException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceDataSyncInvalidConfigurationException',
            message: message);
}

class ResourceDataSyncNotFoundException extends _s.GenericAwsException {
  ResourceDataSyncNotFoundException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceDataSyncNotFoundException',
            message: message);
}

class ResourceInUseException extends _s.GenericAwsException {
  ResourceInUseException({String? type, String? message})
      : super(type: type, code: 'ResourceInUseException', message: message);
}

class ResourceLimitExceededException extends _s.GenericAwsException {
  ResourceLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceLimitExceededException',
            message: message);
}

class ServiceSettingNotFound extends _s.GenericAwsException {
  ServiceSettingNotFound({String? type, String? message})
      : super(type: type, code: 'ServiceSettingNotFound', message: message);
}

class StatusUnchanged extends _s.GenericAwsException {
  StatusUnchanged({String? type, String? message})
      : super(type: type, code: 'StatusUnchanged', message: message);
}

class SubTypeCountLimitExceededException extends _s.GenericAwsException {
  SubTypeCountLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'SubTypeCountLimitExceededException',
            message: message);
}

class TargetInUseException extends _s.GenericAwsException {
  TargetInUseException({String? type, String? message})
      : super(type: type, code: 'TargetInUseException', message: message);
}

class TargetNotConnected extends _s.GenericAwsException {
  TargetNotConnected({String? type, String? message})
      : super(type: type, code: 'TargetNotConnected', message: message);
}

class TooManyTagsError extends _s.GenericAwsException {
  TooManyTagsError({String? type, String? message})
      : super(type: type, code: 'TooManyTagsError', message: message);
}

class TooManyUpdates extends _s.GenericAwsException {
  TooManyUpdates({String? type, String? message})
      : super(type: type, code: 'TooManyUpdates', message: message);
}

class TotalSizeLimitExceededException extends _s.GenericAwsException {
  TotalSizeLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'TotalSizeLimitExceededException',
            message: message);
}

class UnsupportedCalendarException extends _s.GenericAwsException {
  UnsupportedCalendarException({String? type, String? message})
      : super(
            type: type, code: 'UnsupportedCalendarException', message: message);
}

class UnsupportedFeatureRequiredException extends _s.GenericAwsException {
  UnsupportedFeatureRequiredException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedFeatureRequiredException',
            message: message);
}

class UnsupportedInventoryItemContextException extends _s.GenericAwsException {
  UnsupportedInventoryItemContextException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedInventoryItemContextException',
            message: message);
}

class UnsupportedInventorySchemaVersionException
    extends _s.GenericAwsException {
  UnsupportedInventorySchemaVersionException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedInventorySchemaVersionException',
            message: message);
}

class UnsupportedOperatingSystem extends _s.GenericAwsException {
  UnsupportedOperatingSystem({String? type, String? message})
      : super(type: type, code: 'UnsupportedOperatingSystem', message: message);
}

class UnsupportedParameterType extends _s.GenericAwsException {
  UnsupportedParameterType({String? type, String? message})
      : super(type: type, code: 'UnsupportedParameterType', message: message);
}

class UnsupportedPlatformType extends _s.GenericAwsException {
  UnsupportedPlatformType({String? type, String? message})
      : super(type: type, code: 'UnsupportedPlatformType', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'AlreadyExistsException': (type, message) =>
      AlreadyExistsException(type: type, message: message),
  'AssociatedInstances': (type, message) =>
      AssociatedInstances(type: type, message: message),
  'AssociationAlreadyExists': (type, message) =>
      AssociationAlreadyExists(type: type, message: message),
  'AssociationDoesNotExist': (type, message) =>
      AssociationDoesNotExist(type: type, message: message),
  'AssociationExecutionDoesNotExist': (type, message) =>
      AssociationExecutionDoesNotExist(type: type, message: message),
  'AssociationLimitExceeded': (type, message) =>
      AssociationLimitExceeded(type: type, message: message),
  'AssociationVersionLimitExceeded': (type, message) =>
      AssociationVersionLimitExceeded(type: type, message: message),
  'AutomationDefinitionNotApprovedException': (type, message) =>
      AutomationDefinitionNotApprovedException(type: type, message: message),
  'AutomationDefinitionNotFoundException': (type, message) =>
      AutomationDefinitionNotFoundException(type: type, message: message),
  'AutomationDefinitionVersionNotFoundException': (type, message) =>
      AutomationDefinitionVersionNotFoundException(
          type: type, message: message),
  'AutomationExecutionLimitExceededException': (type, message) =>
      AutomationExecutionLimitExceededException(type: type, message: message),
  'AutomationExecutionNotFoundException': (type, message) =>
      AutomationExecutionNotFoundException(type: type, message: message),
  'AutomationStepNotFoundException': (type, message) =>
      AutomationStepNotFoundException(type: type, message: message),
  'ComplianceTypeCountLimitExceededException': (type, message) =>
      ComplianceTypeCountLimitExceededException(type: type, message: message),
  'CustomSchemaCountLimitExceededException': (type, message) =>
      CustomSchemaCountLimitExceededException(type: type, message: message),
  'DocumentAlreadyExists': (type, message) =>
      DocumentAlreadyExists(type: type, message: message),
  'DocumentLimitExceeded': (type, message) =>
      DocumentLimitExceeded(type: type, message: message),
  'DocumentPermissionLimit': (type, message) =>
      DocumentPermissionLimit(type: type, message: message),
  'DocumentVersionLimitExceeded': (type, message) =>
      DocumentVersionLimitExceeded(type: type, message: message),
  'DoesNotExistException': (type, message) =>
      DoesNotExistException(type: type, message: message),
  'DuplicateDocumentContent': (type, message) =>
      DuplicateDocumentContent(type: type, message: message),
  'DuplicateDocumentVersionName': (type, message) =>
      DuplicateDocumentVersionName(type: type, message: message),
  'DuplicateInstanceId': (type, message) =>
      DuplicateInstanceId(type: type, message: message),
  'FeatureNotAvailableException': (type, message) =>
      FeatureNotAvailableException(type: type, message: message),
  'HierarchyLevelLimitExceededException': (type, message) =>
      HierarchyLevelLimitExceededException(type: type, message: message),
  'HierarchyTypeMismatchException': (type, message) =>
      HierarchyTypeMismatchException(type: type, message: message),
  'IdempotentParameterMismatch': (type, message) =>
      IdempotentParameterMismatch(type: type, message: message),
  'IncompatiblePolicyException': (type, message) =>
      IncompatiblePolicyException(type: type, message: message),
  'InternalServerError': (type, message) =>
      InternalServerError(type: type, message: message),
  'InvalidActivation': (type, message) =>
      InvalidActivation(type: type, message: message),
  'InvalidActivationId': (type, message) =>
      InvalidActivationId(type: type, message: message),
  'InvalidAggregatorException': (type, message) =>
      InvalidAggregatorException(type: type, message: message),
  'InvalidAllowedPatternException': (type, message) =>
      InvalidAllowedPatternException(type: type, message: message),
  'InvalidAssociation': (type, message) =>
      InvalidAssociation(type: type, message: message),
  'InvalidAssociationVersion': (type, message) =>
      InvalidAssociationVersion(type: type, message: message),
  'InvalidAutomationExecutionParametersException': (type, message) =>
      InvalidAutomationExecutionParametersException(
          type: type, message: message),
  'InvalidAutomationSignalException': (type, message) =>
      InvalidAutomationSignalException(type: type, message: message),
  'InvalidAutomationStatusUpdateException': (type, message) =>
      InvalidAutomationStatusUpdateException(type: type, message: message),
  'InvalidCommandId': (type, message) =>
      InvalidCommandId(type: type, message: message),
  'InvalidDeleteInventoryParametersException': (type, message) =>
      InvalidDeleteInventoryParametersException(type: type, message: message),
  'InvalidDeletionIdException': (type, message) =>
      InvalidDeletionIdException(type: type, message: message),
  'InvalidDocument': (type, message) =>
      InvalidDocument(type: type, message: message),
  'InvalidDocumentContent': (type, message) =>
      InvalidDocumentContent(type: type, message: message),
  'InvalidDocumentOperation': (type, message) =>
      InvalidDocumentOperation(type: type, message: message),
  'InvalidDocumentSchemaVersion': (type, message) =>
      InvalidDocumentSchemaVersion(type: type, message: message),
  'InvalidDocumentType': (type, message) =>
      InvalidDocumentType(type: type, message: message),
  'InvalidDocumentVersion': (type, message) =>
      InvalidDocumentVersion(type: type, message: message),
  'InvalidFilter': (type, message) =>
      InvalidFilter(type: type, message: message),
  'InvalidFilterKey': (type, message) =>
      InvalidFilterKey(type: type, message: message),
  'InvalidFilterOption': (type, message) =>
      InvalidFilterOption(type: type, message: message),
  'InvalidFilterValue': (type, message) =>
      InvalidFilterValue(type: type, message: message),
  'InvalidInstanceId': (type, message) =>
      InvalidInstanceId(type: type, message: message),
  'InvalidInstanceInformationFilterValue': (type, message) =>
      InvalidInstanceInformationFilterValue(type: type, message: message),
  'InvalidInventoryGroupException': (type, message) =>
      InvalidInventoryGroupException(type: type, message: message),
  'InvalidInventoryItemContextException': (type, message) =>
      InvalidInventoryItemContextException(type: type, message: message),
  'InvalidInventoryRequestException': (type, message) =>
      InvalidInventoryRequestException(type: type, message: message),
  'InvalidItemContentException': (type, message) =>
      InvalidItemContentException(type: type, message: message),
  'InvalidKeyId': (type, message) => InvalidKeyId(type: type, message: message),
  'InvalidNextToken': (type, message) =>
      InvalidNextToken(type: type, message: message),
  'InvalidNotificationConfig': (type, message) =>
      InvalidNotificationConfig(type: type, message: message),
  'InvalidOptionException': (type, message) =>
      InvalidOptionException(type: type, message: message),
  'InvalidOutputFolder': (type, message) =>
      InvalidOutputFolder(type: type, message: message),
  'InvalidOutputLocation': (type, message) =>
      InvalidOutputLocation(type: type, message: message),
  'InvalidParameters': (type, message) =>
      InvalidParameters(type: type, message: message),
  'InvalidPermissionType': (type, message) =>
      InvalidPermissionType(type: type, message: message),
  'InvalidPluginName': (type, message) =>
      InvalidPluginName(type: type, message: message),
  'InvalidPolicyAttributeException': (type, message) =>
      InvalidPolicyAttributeException(type: type, message: message),
  'InvalidPolicyTypeException': (type, message) =>
      InvalidPolicyTypeException(type: type, message: message),
  'InvalidResourceId': (type, message) =>
      InvalidResourceId(type: type, message: message),
  'InvalidResourceType': (type, message) =>
      InvalidResourceType(type: type, message: message),
  'InvalidResultAttributeException': (type, message) =>
      InvalidResultAttributeException(type: type, message: message),
  'InvalidRole': (type, message) => InvalidRole(type: type, message: message),
  'InvalidSchedule': (type, message) =>
      InvalidSchedule(type: type, message: message),
  'InvalidTarget': (type, message) =>
      InvalidTarget(type: type, message: message),
  'InvalidTypeNameException': (type, message) =>
      InvalidTypeNameException(type: type, message: message),
  'InvalidUpdate': (type, message) =>
      InvalidUpdate(type: type, message: message),
  'InvocationDoesNotExist': (type, message) =>
      InvocationDoesNotExist(type: type, message: message),
  'ItemContentMismatchException': (type, message) =>
      ItemContentMismatchException(type: type, message: message),
  'ItemSizeLimitExceededException': (type, message) =>
      ItemSizeLimitExceededException(type: type, message: message),
  'MaxDocumentSizeExceeded': (type, message) =>
      MaxDocumentSizeExceeded(type: type, message: message),
  'OpsItemAlreadyExistsException': (type, message) =>
      OpsItemAlreadyExistsException(type: type, message: message),
  'OpsItemInvalidParameterException': (type, message) =>
      OpsItemInvalidParameterException(type: type, message: message),
  'OpsItemLimitExceededException': (type, message) =>
      OpsItemLimitExceededException(type: type, message: message),
  'OpsItemNotFoundException': (type, message) =>
      OpsItemNotFoundException(type: type, message: message),
  'OpsMetadataAlreadyExistsException': (type, message) =>
      OpsMetadataAlreadyExistsException(type: type, message: message),
  'OpsMetadataInvalidArgumentException': (type, message) =>
      OpsMetadataInvalidArgumentException(type: type, message: message),
  'OpsMetadataKeyLimitExceededException': (type, message) =>
      OpsMetadataKeyLimitExceededException(type: type, message: message),
  'OpsMetadataLimitExceededException': (type, message) =>
      OpsMetadataLimitExceededException(type: type, message: message),
  'OpsMetadataNotFoundException': (type, message) =>
      OpsMetadataNotFoundException(type: type, message: message),
  'OpsMetadataTooManyUpdatesException': (type, message) =>
      OpsMetadataTooManyUpdatesException(type: type, message: message),
  'ParameterAlreadyExists': (type, message) =>
      ParameterAlreadyExists(type: type, message: message),
  'ParameterLimitExceeded': (type, message) =>
      ParameterLimitExceeded(type: type, message: message),
  'ParameterMaxVersionLimitExceeded': (type, message) =>
      ParameterMaxVersionLimitExceeded(type: type, message: message),
  'ParameterNotFound': (type, message) =>
      ParameterNotFound(type: type, message: message),
  'ParameterPatternMismatchException': (type, message) =>
      ParameterPatternMismatchException(type: type, message: message),
  'ParameterVersionLabelLimitExceeded': (type, message) =>
      ParameterVersionLabelLimitExceeded(type: type, message: message),
  'ParameterVersionNotFound': (type, message) =>
      ParameterVersionNotFound(type: type, message: message),
  'PoliciesLimitExceededException': (type, message) =>
      PoliciesLimitExceededException(type: type, message: message),
  'ResourceDataSyncAlreadyExistsException': (type, message) =>
      ResourceDataSyncAlreadyExistsException(type: type, message: message),
  'ResourceDataSyncConflictException': (type, message) =>
      ResourceDataSyncConflictException(type: type, message: message),
  'ResourceDataSyncCountExceededException': (type, message) =>
      ResourceDataSyncCountExceededException(type: type, message: message),
  'ResourceDataSyncInvalidConfigurationException': (type, message) =>
      ResourceDataSyncInvalidConfigurationException(
          type: type, message: message),
  'ResourceDataSyncNotFoundException': (type, message) =>
      ResourceDataSyncNotFoundException(type: type, message: message),
  'ResourceInUseException': (type, message) =>
      ResourceInUseException(type: type, message: message),
  'ResourceLimitExceededException': (type, message) =>
      ResourceLimitExceededException(type: type, message: message),
  'ServiceSettingNotFound': (type, message) =>
      ServiceSettingNotFound(type: type, message: message),
  'StatusUnchanged': (type, message) =>
      StatusUnchanged(type: type, message: message),
  'SubTypeCountLimitExceededException': (type, message) =>
      SubTypeCountLimitExceededException(type: type, message: message),
  'TargetInUseException': (type, message) =>
      TargetInUseException(type: type, message: message),
  'TargetNotConnected': (type, message) =>
      TargetNotConnected(type: type, message: message),
  'TooManyTagsError': (type, message) =>
      TooManyTagsError(type: type, message: message),
  'TooManyUpdates': (type, message) =>
      TooManyUpdates(type: type, message: message),
  'TotalSizeLimitExceededException': (type, message) =>
      TotalSizeLimitExceededException(type: type, message: message),
  'UnsupportedCalendarException': (type, message) =>
      UnsupportedCalendarException(type: type, message: message),
  'UnsupportedFeatureRequiredException': (type, message) =>
      UnsupportedFeatureRequiredException(type: type, message: message),
  'UnsupportedInventoryItemContextException': (type, message) =>
      UnsupportedInventoryItemContextException(type: type, message: message),
  'UnsupportedInventorySchemaVersionException': (type, message) =>
      UnsupportedInventorySchemaVersionException(type: type, message: message),
  'UnsupportedOperatingSystem': (type, message) =>
      UnsupportedOperatingSystem(type: type, message: message),
  'UnsupportedParameterType': (type, message) =>
      UnsupportedParameterType(type: type, message: message),
  'UnsupportedPlatformType': (type, message) =>
      UnsupportedPlatformType(type: type, message: message),
};
