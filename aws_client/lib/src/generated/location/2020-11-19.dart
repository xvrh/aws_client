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

/// Suite of geospatial services including Maps, Places, Tracking, and
/// Geofencing
class Location {
  final _s.RestJsonProtocol _protocol;
  Location({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'geo',
            signingName: 'geo',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  /// Creates an association between a geofence collection and a tracker
  /// resource. This allows the tracker resource to communicate location data to
  /// the linked geofence collection.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ConflictException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [consumerArn] :
  /// The Amazon Resource Name (ARN) for the geofence collection to be
  /// associated to tracker resource. Used when you need to specify a resource
  /// across all AWS.
  ///
  /// <ul>
  /// <li>
  /// Format example:
  /// <code>arn:partition:service:region:account-id:resource-type:resource-id</code>
  /// </li>
  /// </ul>
  ///
  /// Parameter [trackerName] :
  /// The name of the tracker resource to be associated with a geofence
  /// collection.
  Future<void> associateTrackerConsumer({
    required String consumerArn,
    required String trackerName,
  }) async {
    ArgumentError.checkNotNull(consumerArn, 'consumerArn');
    _s.validateStringLength(
      'consumerArn',
      consumerArn,
      0,
      1600,
      isRequired: true,
    );
    _s.validateStringPattern(
      'consumerArn',
      consumerArn,
      r'''^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:([^/].*)?$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'ConsumerArn': consumerArn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}/consumers',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a batch of geofences from a geofence collection.
  /// <note>
  /// This action deletes the resource permanently. You can't undo this action.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The geofence collection storing the geofences to be deleted.
  ///
  /// Parameter [geofenceIds] :
  /// The batch of geofences to be deleted.
  Future<BatchDeleteGeofenceResponse> batchDeleteGeofence({
    required String collectionName,
    required List<String> geofenceIds,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(geofenceIds, 'geofenceIds');
    final $payload = <String, dynamic>{
      'GeofenceIds': geofenceIds,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}/delete-geofences',
      exceptionFnMap: _exceptionFns,
    );
    return BatchDeleteGeofenceResponse.fromJson(response);
  }

  /// Used in geofence monitoring. Evaluates device positions against the
  /// position of geofences in a given geofence collection.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The geofence collection used in evaluating the position of devices against
  /// its geofences.
  ///
  /// Parameter [devicePositionUpdates] :
  /// Contains device details for each device to be evaluated against the given
  /// geofence collection.
  Future<BatchEvaluateGeofencesResponse> batchEvaluateGeofences({
    required String collectionName,
    required List<DevicePositionUpdate> devicePositionUpdates,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(devicePositionUpdates, 'devicePositionUpdates');
    final $payload = <String, dynamic>{
      'DevicePositionUpdates': devicePositionUpdates,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}/positions',
      exceptionFnMap: _exceptionFns,
    );
    return BatchEvaluateGeofencesResponse.fromJson(response);
  }

  /// A batch request to retrieve device positions.
  /// <note>
  /// The response will return the device positions from the last 24 hours.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [deviceIds] :
  /// Devices whose position you want to retrieve.
  ///
  /// <ul>
  /// <li>
  /// For example, for two devices:
  /// <code>device-ids=DeviceId1&amp;device-ids=DeviceId2</code>
  /// </li>
  /// </ul>
  ///
  /// Parameter [trackerName] :
  /// The tracker resource retrieving the device position.
  Future<BatchGetDevicePositionResponse> batchGetDevicePosition({
    required List<String> deviceIds,
    required String trackerName,
  }) async {
    ArgumentError.checkNotNull(deviceIds, 'deviceIds');
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      1152921504606846976,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'DeviceIds': deviceIds,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}/get-positions',
      exceptionFnMap: _exceptionFns,
    );
    return BatchGetDevicePositionResponse.fromJson(response);
  }

  /// A batch request for storing geofences into a given geofence collection.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The geofence collection storing the geofences.
  ///
  /// Parameter [entries] :
  /// The batch of geofences to be stored in a geofence collection.
  Future<BatchPutGeofenceResponse> batchPutGeofence({
    required String collectionName,
    required List<BatchPutGeofenceRequestEntry> entries,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(entries, 'entries');
    final $payload = <String, dynamic>{
      'Entries': entries,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}/put-geofences',
      exceptionFnMap: _exceptionFns,
    );
    return BatchPutGeofenceResponse.fromJson(response);
  }

  /// Uploads a position update for one or more devices to a tracker resource.
  /// The data is used for API queries requesting the device position and
  /// position history.
  /// <note>
  /// Limitation — Location data is sampled at a fixed rate of 1 position per 30
  /// second interval, and retained for 1 year before it is deleted.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [trackerName] :
  /// The name of the tracker resource to update.
  ///
  /// Parameter [updates] :
  /// Contains the position update details for each device.
  Future<BatchUpdateDevicePositionResponse> batchUpdateDevicePosition({
    required String trackerName,
    required List<DevicePositionUpdate> updates,
  }) async {
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(updates, 'updates');
    final $payload = <String, dynamic>{
      'Updates': updates,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}/positions',
      exceptionFnMap: _exceptionFns,
    );
    return BatchUpdateDevicePositionResponse.fromJson(response);
  }

  /// Creates a geofence collection, which manages and stores geofences.
  ///
  /// May throw [InternalServerException].
  /// May throw [ConflictException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// A custom name for the geofence collection.
  ///
  /// Requirements:
  ///
  /// <ul>
  /// <li>
  /// Contain only alphanumeric characters (A–Z, a–z, 0-9), hyphens (-), and
  /// underscores (_).
  /// </li>
  /// <li>
  /// Must be a unique geofence collection name.
  /// </li>
  /// <li>
  /// No spaces allowed. For example, <code>ExampleGeofenceCollection</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [pricingPlan] :
  /// Specifies the pricing plan for your geofence collection. There's three
  /// pricing plan options:
  ///
  /// <ul>
  /// <li>
  /// <code>RequestBasedUsage</code> — Selects the "Request-Based Usage" pricing
  /// plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetTracking</code> — Selects the "Mobile Asset Tracking"
  /// pricing plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetManagement</code> — Selects the "Mobile Asset Management"
  /// pricing plan.
  /// </li>
  /// </ul>
  /// For additional details and restrictions on each pricing plan option, see
  /// the <a href="https://aws.amazon.com/location/pricing/">Amazon Location
  /// Service pricing page</a>.
  ///
  /// Parameter [description] :
  /// An optional description for the geofence collection.
  Future<CreateGeofenceCollectionResponse> createGeofenceCollection({
    required String collectionName,
    required PricingPlan pricingPlan,
    String? description,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(pricingPlan, 'pricingPlan');
    _s.validateStringLength(
      'description',
      description,
      0,
      1000,
    );
    final $payload = <String, dynamic>{
      'CollectionName': collectionName,
      'PricingPlan': pricingPlan.toValue(),
      if (description != null) 'Description': description,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/geofencing/v0/collections',
      exceptionFnMap: _exceptionFns,
    );
    return CreateGeofenceCollectionResponse.fromJson(response);
  }

  /// Creates a map resource in your AWS account, which provides map tiles of
  /// different styles sourced from global location data providers.
  /// <note>
  /// By using Maps, you agree that AWS may transmit your API queries to your
  /// selected third party provider for processing, which may be outside the AWS
  /// region you are currently using. For more information, see the <a
  /// href="https://aws.amazon.com/service-terms/">AWS Service Terms</a> for
  /// Amazon Location Service.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ConflictException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [configuration] :
  /// Specifies the map style selected from an available data provider.
  ///
  /// Parameter [mapName] :
  /// The name for the map resource.
  ///
  /// Requirements:
  ///
  /// <ul>
  /// <li>
  /// Must contain only alphanumeric characters (A–Z, a–z, 0–9), hyphens (-),
  /// and underscores (_).
  /// </li>
  /// <li>
  /// Must be a unique map resource name.
  /// </li>
  /// <li>
  /// No spaces allowed. For example, <code>ExampleMap</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [pricingPlan] :
  /// Specifies the pricing plan for your map resource. There's three pricing
  /// plan options:
  ///
  /// <ul>
  /// <li>
  /// <code>RequestBasedUsage</code> — Selects the "Request-Based Usage" pricing
  /// plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetTracking</code> — Selects the "Mobile Asset Tracking"
  /// pricing plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetManagement</code> — Selects the "Mobile Asset Management"
  /// pricing plan.
  /// </li>
  /// </ul>
  /// For additional details and restrictions on each pricing plan option, see
  /// the <a href="https://aws.amazon.com/location/pricing/">Amazon Location
  /// Service pricing page</a>.
  ///
  /// Parameter [description] :
  /// An optional description for the map resource.
  Future<CreateMapResponse> createMap({
    required MapConfiguration configuration,
    required String mapName,
    required PricingPlan pricingPlan,
    String? description,
  }) async {
    ArgumentError.checkNotNull(configuration, 'configuration');
    ArgumentError.checkNotNull(mapName, 'mapName');
    _s.validateStringLength(
      'mapName',
      mapName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'mapName',
      mapName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(pricingPlan, 'pricingPlan');
    _s.validateStringLength(
      'description',
      description,
      0,
      1000,
    );
    final $payload = <String, dynamic>{
      'Configuration': configuration,
      'MapName': mapName,
      'PricingPlan': pricingPlan.toValue(),
      if (description != null) 'Description': description,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/maps/v0/maps',
      exceptionFnMap: _exceptionFns,
    );
    return CreateMapResponse.fromJson(response);
  }

  /// Creates a Place index resource in your AWS account, which supports Places
  /// functions with geospatial data sourced from your chosen data provider.
  /// <note>
  /// By using Places, you agree that AWS may transmit your API queries to your
  /// selected third party provider for processing, which may be outside the AWS
  /// region you are currently using.
  ///
  /// Because of licensing limitations, you may not use HERE to store results
  /// for locations in Japan. For more information, see the <a
  /// href="https://aws.amazon.com/service-terms/">AWS Service Terms</a> for
  /// Amazon Location Service.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ConflictException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [dataSource] :
  /// Specifies the data provider of geospatial data.
  ///
  /// Parameter [indexName] :
  /// The name of the Place index resource.
  ///
  /// Requirements:
  ///
  /// <ul>
  /// <li>
  /// Contain only alphanumeric characters (A-Z, a-z, 0-9) , hyphens (-) and
  /// underscores (_) ).
  /// </li>
  /// <li>
  /// Must be a unique Place index resource name.
  /// </li>
  /// <li>
  /// No spaces allowed. For example, <code>ExamplePlaceIndex</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [pricingPlan] :
  /// Specifies the pricing plan for your Place index resource. There's three
  /// pricing plan options:
  ///
  /// <ul>
  /// <li>
  /// <code>RequestBasedUsage</code> — Selects the "Request-Based Usage" pricing
  /// plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetTracking</code> — Selects the "Mobile Asset Tracking"
  /// pricing plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetManagement</code> — Selects the "Mobile Asset Management"
  /// pricing plan.
  /// </li>
  /// </ul>
  /// For additional details and restrictions on each pricing plan option, see
  /// the <a href="https://aws.amazon.com/location/pricing/">Amazon Location
  /// Service pricing page</a>.
  ///
  /// Parameter [dataSourceConfiguration] :
  /// Specifies the data storage option for requesting Places.
  ///
  /// Parameter [description] :
  /// The optional description for the Place index resource.
  Future<CreatePlaceIndexResponse> createPlaceIndex({
    required String dataSource,
    required String indexName,
    required PricingPlan pricingPlan,
    DataSourceConfiguration? dataSourceConfiguration,
    String? description,
  }) async {
    ArgumentError.checkNotNull(dataSource, 'dataSource');
    ArgumentError.checkNotNull(indexName, 'indexName');
    _s.validateStringLength(
      'indexName',
      indexName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'indexName',
      indexName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(pricingPlan, 'pricingPlan');
    _s.validateStringLength(
      'description',
      description,
      0,
      1000,
    );
    final $payload = <String, dynamic>{
      'DataSource': dataSource,
      'IndexName': indexName,
      'PricingPlan': pricingPlan.toValue(),
      if (dataSourceConfiguration != null)
        'DataSourceConfiguration': dataSourceConfiguration,
      if (description != null) 'Description': description,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/places/v0/indexes',
      exceptionFnMap: _exceptionFns,
    );
    return CreatePlaceIndexResponse.fromJson(response);
  }

  /// Creates a tracker resource in your AWS account, which lets you retrieve
  /// current and historical location of devices.
  ///
  /// May throw [InternalServerException].
  /// May throw [ConflictException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [pricingPlan] :
  /// Specifies the pricing plan for your tracker resource. There's three
  /// pricing plan options:
  ///
  /// <ul>
  /// <li>
  /// <code>RequestBasedUsage</code> — Selects the "Request-Based Usage" pricing
  /// plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetTracking</code> — Selects the "Mobile Asset Tracking"
  /// pricing plan.
  /// </li>
  /// <li>
  /// <code>MobileAssetManagement</code> — Selects the "Mobile Asset Management"
  /// pricing plan.
  /// </li>
  /// </ul>
  /// For additional details and restrictions on each pricing plan option, see
  /// the <a href="https://aws.amazon.com/location/pricing/">Amazon Location
  /// Service pricing page</a>.
  ///
  /// Parameter [trackerName] :
  /// The name for the tracker resource.
  ///
  /// Requirements:
  ///
  /// <ul>
  /// <li>
  /// Contain only alphanumeric characters (A-Z, a-z, 0-9) , hyphens (-) and
  /// underscores (_).
  /// </li>
  /// <li>
  /// Must be a unique tracker resource name.
  /// </li>
  /// <li>
  /// No spaces allowed. For example, <code>ExampleTracker</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [description] :
  /// An optional description for the tracker resource.
  Future<CreateTrackerResponse> createTracker({
    required PricingPlan pricingPlan,
    required String trackerName,
    String? description,
  }) async {
    ArgumentError.checkNotNull(pricingPlan, 'pricingPlan');
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      1000,
    );
    final $payload = <String, dynamic>{
      'PricingPlan': pricingPlan.toValue(),
      'TrackerName': trackerName,
      if (description != null) 'Description': description,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/tracking/v0/trackers',
      exceptionFnMap: _exceptionFns,
    );
    return CreateTrackerResponse.fromJson(response);
  }

  /// Deletes a geofence collection from your AWS account.
  /// <note>
  /// This action deletes the resource permanently. You can't undo this action.
  /// If the geofence collection is the target of a tracker resource, the
  /// devices will no longer be monitored.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The name of the geofence collection to be deleted.
  Future<void> deleteGeofenceCollection({
    required String collectionName,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a map resource from your AWS account.
  /// <note>
  /// This action deletes the resource permanently. You cannot undo this action.
  /// If the map is being used in an application, the map may not render.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [mapName] :
  /// The name of the map resource to be deleted.
  Future<void> deleteMap({
    required String mapName,
  }) async {
    ArgumentError.checkNotNull(mapName, 'mapName');
    _s.validateStringLength(
      'mapName',
      mapName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'mapName',
      mapName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/maps/v0/maps/${Uri.encodeComponent(mapName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a Place index resource from your AWS account.
  /// <note>
  /// This action deletes the resource permanently. You cannot undo this action.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [indexName] :
  /// The name of the Place index resource to be deleted.
  Future<void> deletePlaceIndex({
    required String indexName,
  }) async {
    ArgumentError.checkNotNull(indexName, 'indexName');
    _s.validateStringLength(
      'indexName',
      indexName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'indexName',
      indexName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/places/v0/indexes/${Uri.encodeComponent(indexName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a tracker resource from your AWS account.
  /// <note>
  /// This action deletes the resource permanently. You can't undo this action.
  /// If the tracker resource is in use, you may encounter an error. Make sure
  /// that the target resource is not a dependency for your applications.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [trackerName] :
  /// The name of the tracker resource to be deleted.
  Future<void> deleteTracker({
    required String trackerName,
  }) async {
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Retrieves the geofence collection details.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The name of the geofence collection.
  Future<DescribeGeofenceCollectionResponse> describeGeofenceCollection({
    required String collectionName,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeGeofenceCollectionResponse.fromJson(response);
  }

  /// Retrieves the map resource details.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [mapName] :
  /// The name of the map resource.
  Future<DescribeMapResponse> describeMap({
    required String mapName,
  }) async {
    ArgumentError.checkNotNull(mapName, 'mapName');
    _s.validateStringLength(
      'mapName',
      mapName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'mapName',
      mapName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/maps/v0/maps/${Uri.encodeComponent(mapName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeMapResponse.fromJson(response);
  }

  /// Retrieves the Place index resource details.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [indexName] :
  /// The name of the Place index resource.
  Future<DescribePlaceIndexResponse> describePlaceIndex({
    required String indexName,
  }) async {
    ArgumentError.checkNotNull(indexName, 'indexName');
    _s.validateStringLength(
      'indexName',
      indexName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'indexName',
      indexName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/places/v0/indexes/${Uri.encodeComponent(indexName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribePlaceIndexResponse.fromJson(response);
  }

  /// Retrieves the tracker resource details.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [trackerName] :
  /// The name of the tracker resource.
  Future<DescribeTrackerResponse> describeTracker({
    required String trackerName,
  }) async {
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeTrackerResponse.fromJson(response);
  }

  /// Removes the association bewteen a tracker resource and a geofence
  /// collection.
  /// <note>
  /// Once you unlink a tracker resource from a geofence collection, the tracker
  /// positions will no longer be automatically evaluated against geofences.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [consumerArn] :
  /// The Amazon Resource Name (ARN) for the geofence collection to be
  /// disassociated from the tracker resource. Used when you need to specify a
  /// resource across all AWS.
  ///
  /// <ul>
  /// <li>
  /// Format example:
  /// <code>arn:partition:service:region:account-id:resource-type:resource-id</code>
  /// </li>
  /// </ul>
  ///
  /// Parameter [trackerName] :
  /// The name of the tracker resource to be dissociated from the consumer.
  Future<void> disassociateTrackerConsumer({
    required String consumerArn,
    required String trackerName,
  }) async {
    ArgumentError.checkNotNull(consumerArn, 'consumerArn');
    _s.validateStringLength(
      'consumerArn',
      consumerArn,
      0,
      1600,
      isRequired: true,
    );
    _s.validateStringPattern(
      'consumerArn',
      consumerArn,
      r'''^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:([^/].*)?$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}/consumers/${Uri.encodeComponent(consumerArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Retrieves the latest device position.
  /// <note>
  /// Limitation — Device positions are deleted after one year.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [deviceId] :
  /// The device whose position you want to retreieve.
  ///
  /// Parameter [trackerName] :
  /// The tracker resource receiving the position update.
  Future<GetDevicePositionResponse> getDevicePosition({
    required String deviceId,
    required String trackerName,
  }) async {
    ArgumentError.checkNotNull(deviceId, 'deviceId');
    _s.validateStringLength(
      'deviceId',
      deviceId,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'deviceId',
      deviceId,
      r'''^[-._\p{L}\p{N}]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}/devices/${Uri.encodeComponent(deviceId)}/positions/latest',
      exceptionFnMap: _exceptionFns,
    );
    return GetDevicePositionResponse.fromJson(response);
  }

  /// Retrieves the device position history from a tracker resource within a
  /// specified range of time.
  /// <note>
  /// Limitation — Device positions are deleted after one year.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [deviceId] :
  /// The device whose position history you want to retrieve.
  ///
  /// Parameter [trackerName] :
  /// The tracker resource receiving the request for the device position
  /// history.
  ///
  /// Parameter [endTimeExclusive] :
  /// Specify the end time for the position history in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO
  /// 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  ///
  /// <ul>
  /// <li>
  /// The given time for <code>EndTimeExclusive</code> must be after the time
  /// for <code>StartTimeInclusive</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [nextToken] :
  /// The pagination token specifying which page of results to return in the
  /// response. If no token is provided, the default page is the first page.
  ///
  /// Default value: <code>null</code>
  ///
  /// Parameter [startTimeInclusive] :
  /// Specify the start time for the position history in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO
  /// 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  ///
  /// <ul>
  /// <li>
  /// The given time for <code>EndTimeExclusive</code> must be after the time
  /// for <code>StartTimeInclusive</code>.
  /// </li>
  /// </ul>
  Future<GetDevicePositionHistoryResponse> getDevicePositionHistory({
    required String deviceId,
    required String trackerName,
    DateTime? endTimeExclusive,
    String? nextToken,
    DateTime? startTimeInclusive,
  }) async {
    ArgumentError.checkNotNull(deviceId, 'deviceId');
    _s.validateStringLength(
      'deviceId',
      deviceId,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'deviceId',
      deviceId,
      r'''^[-._\p{L}\p{N}]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    final $payload = <String, dynamic>{
      if (endTimeExclusive != null)
        'EndTimeExclusive': iso8601ToJson(endTimeExclusive),
      if (nextToken != null) 'NextToken': nextToken,
      if (startTimeInclusive != null)
        'StartTimeInclusive': iso8601ToJson(startTimeInclusive),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}/devices/${Uri.encodeComponent(deviceId)}/list-positions',
      exceptionFnMap: _exceptionFns,
    );
    return GetDevicePositionHistoryResponse.fromJson(response);
  }

  /// Retrieves the geofence details from a geofence collection.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The geofence collection storing the target geofence.
  ///
  /// Parameter [geofenceId] :
  /// The geofence you're retrieving details for.
  Future<GetGeofenceResponse> getGeofence({
    required String collectionName,
    required String geofenceId,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(geofenceId, 'geofenceId');
    _s.validateStringLength(
      'geofenceId',
      geofenceId,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'geofenceId',
      geofenceId,
      r'''^[-._\p{L}\p{N}]+$''',
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}/geofences/${Uri.encodeComponent(geofenceId)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetGeofenceResponse.fromJson(response);
  }

  /// Retrieves glyphs used to display labels on a map.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [fontStack] :
  /// A comma-separated list of fonts to load glyphs from in order of
  /// preference.. For example, <code>Noto Sans, Arial Unicode</code>.
  ///
  /// Parameter [fontUnicodeRange] :
  /// A Unicode range of characters to download glyphs for. Each response will
  /// contain 256 characters. For example, 0-255 includes all characters from
  /// range <code>U+0000</code> to <code>00FF</code>. Must be aligned to
  /// multiples of 256.
  ///
  /// Parameter [mapName] :
  /// The map resource associated with the glyph ﬁle.
  Future<GetMapGlyphsResponse> getMapGlyphs({
    required String fontStack,
    required String fontUnicodeRange,
    required String mapName,
  }) async {
    ArgumentError.checkNotNull(fontStack, 'fontStack');
    ArgumentError.checkNotNull(fontUnicodeRange, 'fontUnicodeRange');
    _s.validateStringPattern(
      'fontUnicodeRange',
      fontUnicodeRange,
      r'''^[0-9]+-[0-9]+\.pbf$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(mapName, 'mapName');
    _s.validateStringLength(
      'mapName',
      mapName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'mapName',
      mapName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.sendRaw(
      payload: null,
      method: 'GET',
      requestUri:
          '/maps/v0/maps/${Uri.encodeComponent(mapName)}/glyphs/${Uri.encodeComponent(fontStack)}/${Uri.encodeComponent(fontUnicodeRange)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetMapGlyphsResponse(
      blob: await response.stream.toBytes(),
      contentType:
          _s.extractHeaderStringValue(response.headers, 'Content-Type'),
    );
  }

  /// Retrieves the sprite sheet corresponding to a map resource. The sprite
  /// sheet is a PNG image paired with a JSON document describing the offsets of
  /// individual icons that will be displayed on a rendered map.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [fileName] :
  /// The name of the sprite ﬁle. Use the following ﬁle names for the sprite
  /// sheet:
  ///
  /// <ul>
  /// <li>
  /// <code>sprites.png</code>
  /// </li>
  /// <li>
  /// <code>sprites@2x.png</code> for high pixel density displays
  /// </li>
  /// </ul>
  /// For the JSON document contain image offsets. Use the following ﬁle names:
  ///
  /// <ul>
  /// <li>
  /// <code>sprites.json</code>
  /// </li>
  /// <li>
  /// <code>sprites@2x.json</code> for high pixel density displays
  /// </li>
  /// </ul>
  ///
  /// Parameter [mapName] :
  /// The map resource associated with the sprite ﬁle.
  Future<GetMapSpritesResponse> getMapSprites({
    required String fileName,
    required String mapName,
  }) async {
    ArgumentError.checkNotNull(fileName, 'fileName');
    _s.validateStringPattern(
      'fileName',
      fileName,
      r'''^sprites(@2x)?\.(png|json)$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(mapName, 'mapName');
    _s.validateStringLength(
      'mapName',
      mapName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'mapName',
      mapName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.sendRaw(
      payload: null,
      method: 'GET',
      requestUri:
          '/maps/v0/maps/${Uri.encodeComponent(mapName)}/sprites/${Uri.encodeComponent(fileName)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetMapSpritesResponse(
      blob: await response.stream.toBytes(),
      contentType:
          _s.extractHeaderStringValue(response.headers, 'Content-Type'),
    );
  }

  /// Retrieves the map style descriptor from a map resource.
  ///
  /// The style descriptor contains speciﬁcations on how features render on a
  /// map. For example, what data to display, what order to display the data in,
  /// and the style for the data. Style descriptors follow the Mapbox Style
  /// Specification.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [mapName] :
  /// The map resource to retrieve the style descriptor from.
  Future<GetMapStyleDescriptorResponse> getMapStyleDescriptor({
    required String mapName,
  }) async {
    ArgumentError.checkNotNull(mapName, 'mapName');
    _s.validateStringLength(
      'mapName',
      mapName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'mapName',
      mapName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    final response = await _protocol.sendRaw(
      payload: null,
      method: 'GET',
      requestUri:
          '/maps/v0/maps/${Uri.encodeComponent(mapName)}/style-descriptor',
      exceptionFnMap: _exceptionFns,
    );
    return GetMapStyleDescriptorResponse(
      blob: await response.stream.toBytes(),
      contentType:
          _s.extractHeaderStringValue(response.headers, 'Content-Type'),
    );
  }

  /// Retrieves a vector data tile from the map resource. Map tiles are used by
  /// clients to render a map. They are addressed using a grid arrangement with
  /// an X coordinate, Y coordinate, and Z (zoom) level.
  ///
  /// The origin (0, 0) is the top left of the map. Increasing the zoom level by
  /// 1 doubles both the X and Y dimensions, so a tile containing data for the
  /// entire world at (0/0/0) will be split into 4 tiles at zoom 1 (1/0/0,
  /// 1/0/1, 1/1/0, 1/1/1).
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [mapName] :
  /// The map resource to retrieve the map tiles from.
  ///
  /// Parameter [x] :
  /// The X axis value for the map tile.
  ///
  /// Parameter [y] :
  /// The Y axis value for the map tile.
  ///
  /// Parameter [z] :
  /// The zoom value for the map tile.
  Future<GetMapTileResponse> getMapTile({
    required String mapName,
    required String x,
    required String y,
    required String z,
  }) async {
    ArgumentError.checkNotNull(mapName, 'mapName');
    _s.validateStringLength(
      'mapName',
      mapName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'mapName',
      mapName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(x, 'x');
    _s.validateStringPattern(
      'x',
      x,
      r'''\d+''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(y, 'y');
    _s.validateStringPattern(
      'y',
      y,
      r'''\d+''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(z, 'z');
    _s.validateStringPattern(
      'z',
      z,
      r'''\d+''',
      isRequired: true,
    );
    final response = await _protocol.sendRaw(
      payload: null,
      method: 'GET',
      requestUri:
          '/maps/v0/maps/${Uri.encodeComponent(mapName)}/tiles/${Uri.encodeComponent(z)}/${Uri.encodeComponent(x)}/${Uri.encodeComponent(y)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetMapTileResponse(
      blob: await response.stream.toBytes(),
      contentType:
          _s.extractHeaderStringValue(response.headers, 'Content-Type'),
    );
  }

  /// Lists geofence collections in your AWS account.
  ///
  /// May throw [InternalServerException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [maxResults] :
  /// An optional limit for the number of resources returned in a single call.
  ///
  /// Default value: <code>100</code>
  ///
  /// Parameter [nextToken] :
  /// The pagination token specifying which page of results to return in the
  /// response. If no token is provided, the default page is the first page.
  ///
  /// Default value: <code>null</code>
  Future<ListGeofenceCollectionsResponse> listGeofenceCollections({
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
    final $payload = <String, dynamic>{
      if (maxResults != null) 'MaxResults': maxResults,
      if (nextToken != null) 'NextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/geofencing/v0/list-collections',
      exceptionFnMap: _exceptionFns,
    );
    return ListGeofenceCollectionsResponse.fromJson(response);
  }

  /// Lists geofences stored in a given geofence collection.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The name of the geofence collection storing the list of geofences.
  ///
  /// Parameter [nextToken] :
  /// The pagination token specifying which page of results to return in the
  /// response. If no token is provided, the default page is the first page.
  ///
  /// Default value: <code>null</code>
  Future<ListGeofencesResponse> listGeofences({
    required String collectionName,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      2000,
    );
    final $payload = <String, dynamic>{
      if (nextToken != null) 'NextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}/list-geofences',
      exceptionFnMap: _exceptionFns,
    );
    return ListGeofencesResponse.fromJson(response);
  }

  /// Lists map resources in your AWS account.
  ///
  /// May throw [InternalServerException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [maxResults] :
  /// An optional limit for the number of resources returned in a single call.
  ///
  /// Default value: <code>100</code>
  ///
  /// Parameter [nextToken] :
  /// The pagination token specifying which page of results to return in the
  /// response. If no token is provided, the default page is the first page.
  ///
  /// Default value: <code>null</code>
  Future<ListMapsResponse> listMaps({
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
    final $payload = <String, dynamic>{
      if (maxResults != null) 'MaxResults': maxResults,
      if (nextToken != null) 'NextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/maps/v0/list-maps',
      exceptionFnMap: _exceptionFns,
    );
    return ListMapsResponse.fromJson(response);
  }

  /// Lists Place index resources in your AWS account.
  ///
  /// May throw [InternalServerException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [maxResults] :
  /// An optional limit for the maximum number of results returned in a single
  /// call.
  ///
  /// Default value: <code>100</code>
  ///
  /// Parameter [nextToken] :
  /// The pagination token specifying which page of results to return in the
  /// response. If no token is provided, the default page is the first page.
  ///
  /// Default value: <code>null</code>
  Future<ListPlaceIndexesResponse> listPlaceIndexes({
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
    final $payload = <String, dynamic>{
      if (maxResults != null) 'MaxResults': maxResults,
      if (nextToken != null) 'NextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/places/v0/list-indexes',
      exceptionFnMap: _exceptionFns,
    );
    return ListPlaceIndexesResponse.fromJson(response);
  }

  /// Lists geofence collections currently associated to the given tracker
  /// resource.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [trackerName] :
  /// The tracker resource whose associated geofence collections you want to
  /// list.
  ///
  /// Parameter [maxResults] :
  /// An optional limit for the number of resources returned in a single call.
  ///
  /// Default value: <code>100</code>
  ///
  /// Parameter [nextToken] :
  /// The pagination token specifying which page of results to return in the
  /// response. If no token is provided, the default page is the first page.
  ///
  /// Default value: <code>null</code>
  Future<ListTrackerConsumersResponse> listTrackerConsumers({
    required String trackerName,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(trackerName, 'trackerName');
    _s.validateStringLength(
      'trackerName',
      trackerName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'trackerName',
      trackerName,
      r'''^[-._\w]+$''',
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
    final $payload = <String, dynamic>{
      if (maxResults != null) 'MaxResults': maxResults,
      if (nextToken != null) 'NextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/tracking/v0/trackers/${Uri.encodeComponent(trackerName)}/list-consumers',
      exceptionFnMap: _exceptionFns,
    );
    return ListTrackerConsumersResponse.fromJson(response);
  }

  /// Lists tracker resources in your AWS account.
  ///
  /// May throw [InternalServerException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [maxResults] :
  /// An optional limit for the number of resources returned in a single call.
  ///
  /// Default value: <code>100</code>
  ///
  /// Parameter [nextToken] :
  /// The pagination token specifying which page of results to return in the
  /// response. If no token is provided, the default page is the first page.
  ///
  /// Default value: <code>null</code>
  Future<ListTrackersResponse> listTrackers({
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
    final $payload = <String, dynamic>{
      if (maxResults != null) 'MaxResults': maxResults,
      if (nextToken != null) 'NextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/tracking/v0/list-trackers',
      exceptionFnMap: _exceptionFns,
    );
    return ListTrackersResponse.fromJson(response);
  }

  /// Stores a geofence to a given geofence collection, or updates the geometry
  /// of an existing geofence if a geofence ID is included in the request.
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ConflictException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [collectionName] :
  /// The geofence collection to store the geofence in.
  ///
  /// Parameter [geofenceId] :
  /// An identifier for the geofence. For example,
  /// <code>ExampleGeofence-1</code>.
  ///
  /// Parameter [geometry] :
  /// Contains the polygon details to specify the position of the geofence.
  Future<PutGeofenceResponse> putGeofence({
    required String collectionName,
    required String geofenceId,
    required GeofenceGeometry geometry,
  }) async {
    ArgumentError.checkNotNull(collectionName, 'collectionName');
    _s.validateStringLength(
      'collectionName',
      collectionName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'collectionName',
      collectionName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(geofenceId, 'geofenceId');
    _s.validateStringLength(
      'geofenceId',
      geofenceId,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'geofenceId',
      geofenceId,
      r'''^[-._\p{L}\p{N}]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(geometry, 'geometry');
    final $payload = <String, dynamic>{
      'Geometry': geometry,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/geofencing/v0/collections/${Uri.encodeComponent(collectionName)}/geofences/${Uri.encodeComponent(geofenceId)}',
      exceptionFnMap: _exceptionFns,
    );
    return PutGeofenceResponse.fromJson(response);
  }

  /// Reverse geocodes a given coordinate and returns a legible address. Allows
  /// you to search for Places or points of interest near a given position.
  /// <note>
  /// By using Places, you agree that AWS may transmit your API queries to your
  /// selected third party provider for processing, which may be outside the AWS
  /// region you are currently using.
  ///
  /// Because of licensing limitations, you may not use HERE to store results
  /// for locations in Japan. For more information, see the <a
  /// href="https://aws.amazon.com/service-terms/">AWS Service Terms</a> for
  /// Amazon Location Service.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [indexName] :
  /// The name of the Place index resource you want to use for the search.
  ///
  /// Parameter [position] :
  /// Specifies a coordinate for the query defined by a longitude, and latitude.
  ///
  /// <ul>
  /// <li>
  /// The first position is the X coordinate, or longitude.
  /// </li>
  /// <li>
  /// The second position is the Y coordinate, or latitude.
  /// </li>
  /// </ul>
  /// For example, <code>position=xLongitude&amp;position=yLatitude</code> .
  ///
  /// Parameter [maxResults] :
  /// An optional paramer. The maximum number of results returned per request.
  ///
  /// Default value: <code>50</code>
  Future<SearchPlaceIndexForPositionResponse> searchPlaceIndexForPosition({
    required String indexName,
    required List<double> position,
    int? maxResults,
  }) async {
    ArgumentError.checkNotNull(indexName, 'indexName');
    _s.validateStringLength(
      'indexName',
      indexName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'indexName',
      indexName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(position, 'position');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final $payload = <String, dynamic>{
      'Position': position,
      if (maxResults != null) 'MaxResults': maxResults,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/places/v0/indexes/${Uri.encodeComponent(indexName)}/search/position',
      exceptionFnMap: _exceptionFns,
    );
    return SearchPlaceIndexForPositionResponse.fromJson(response);
  }

  /// Geocodes free-form text, such as an address, name, city, or region to
  /// allow you to search for Places or points of interest.
  ///
  /// Includes the option to apply additional parameters to narrow your list of
  /// results.
  /// <note>
  /// You can search for places near a given position using
  /// <code>BiasPosition</code>, or filter results within a bounding box using
  /// <code>FilterBBox</code>. Providing both parameters simultaneously returns
  /// an error.
  /// </note> <note>
  /// By using Places, you agree that AWS may transmit your API queries to your
  /// selected third party provider for processing, which may be outside the AWS
  /// region you are currently using.
  ///
  /// Also, when using HERE as your data provider, you may not (a) use HERE
  /// Places for Asset Management, or (b) select the <code>Storage</code> option
  /// for the <code>IntendedUse</code> parameter when requesting Places in
  /// Japan. For more information, see the <a
  /// href="https://aws.amazon.com/service-terms/">AWS Service Terms</a> for
  /// Amazon Location Service.
  /// </note>
  ///
  /// May throw [InternalServerException].
  /// May throw [ResourceNotFoundException].
  /// May throw [AccessDeniedException].
  /// May throw [ValidationException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [indexName] :
  /// The name of the Place index resource you want to use for the search.
  ///
  /// Parameter [text] :
  /// The address, name, city, or region to be used in the search. In free-form
  /// text format. For example, <code>123 Any Street</code>.
  ///
  /// Parameter [biasPosition] :
  /// Searches for results closest to the given position. An optional parameter
  /// defined by longitude, and latitude.
  ///
  /// <ul>
  /// <li>
  /// The first <code>bias</code> position is the X coordinate, or longitude.
  /// </li>
  /// <li>
  /// The second <code>bias</code> position is the Y coordinate, or latitude.
  /// </li>
  /// </ul>
  /// For example, <code>bias=xLongitude&amp;bias=yLatitude</code>.
  ///
  /// Parameter [filterBBox] :
  /// Filters the results by returning only Places within the provided bounding
  /// box. An optional parameter.
  ///
  /// The first 2 <code>bbox</code> parameters describe the lower southwest
  /// corner:
  ///
  /// <ul>
  /// <li>
  /// The first <code>bbox</code> position is the X coordinate or longitude of
  /// the lower southwest corner.
  /// </li>
  /// <li>
  /// The second <code>bbox</code> position is the Y coordinate or latitude of
  /// the lower southwest corner.
  /// </li>
  /// </ul>
  /// For example, <code>bbox=xLongitudeSW&amp;bbox=yLatitudeSW</code>.
  ///
  /// The next <code>bbox</code> parameters describe the upper northeast corner:
  ///
  /// <ul>
  /// <li>
  /// The third <code>bbox</code> position is the X coordinate, or longitude of
  /// the upper northeast corner.
  /// </li>
  /// <li>
  /// The fourth <code>bbox</code> position is the Y coordinate, or longitude of
  /// the upper northeast corner.
  /// </li>
  /// </ul>
  /// For example, <code>bbox=xLongitudeNE&amp;bbox=yLatitudeNE</code>
  ///
  /// Parameter [filterCountries] :
  /// Limits the search to the given a list of countries/regions. An optional
  /// parameter.
  ///
  /// <ul>
  /// <li>
  /// Use the <a href="https://www.iso.org/iso-3166-country-codes.html">ISO
  /// 3166</a> 3-digit country code. For example, Australia uses three
  /// upper-case characters: <code>AUS</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [maxResults] :
  /// An optional parameter. The maximum number of results returned per request.
  ///
  /// The default: <code>50</code>
  Future<SearchPlaceIndexForTextResponse> searchPlaceIndexForText({
    required String indexName,
    required String text,
    List<double>? biasPosition,
    List<double>? filterBBox,
    List<String>? filterCountries,
    int? maxResults,
  }) async {
    ArgumentError.checkNotNull(indexName, 'indexName');
    _s.validateStringLength(
      'indexName',
      indexName,
      1,
      100,
      isRequired: true,
    );
    _s.validateStringPattern(
      'indexName',
      indexName,
      r'''^[-._\w]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(text, 'text');
    _s.validateStringLength(
      'text',
      text,
      1,
      200,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final $payload = <String, dynamic>{
      'Text': text,
      if (biasPosition != null) 'BiasPosition': biasPosition,
      if (filterBBox != null) 'FilterBBox': filterBBox,
      if (filterCountries != null) 'FilterCountries': filterCountries,
      if (maxResults != null) 'MaxResults': maxResults,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/places/v0/indexes/${Uri.encodeComponent(indexName)}/search/text',
      exceptionFnMap: _exceptionFns,
    );
    return SearchPlaceIndexForTextResponse.fromJson(response);
  }
}

class AssociateTrackerConsumerResponse {
  AssociateTrackerConsumerResponse();
  factory AssociateTrackerConsumerResponse.fromJson(Map<String, dynamic> _) {
    return AssociateTrackerConsumerResponse();
  }
}

/// Contains error details for each geofence that failed to delete from the
/// geofence collection.
class BatchDeleteGeofenceError {
  /// Contains details associated to the batch error.
  final BatchItemError error;

  /// The geofence associated with the error message.
  final String geofenceId;

  BatchDeleteGeofenceError({
    required this.error,
    required this.geofenceId,
  });
  factory BatchDeleteGeofenceError.fromJson(Map<String, dynamic> json) {
    return BatchDeleteGeofenceError(
      error: BatchItemError.fromJson(json['Error'] as Map<String, dynamic>),
      geofenceId: json['GeofenceId'] as String,
    );
  }
}

class BatchDeleteGeofenceResponse {
  /// Contains error details for each geofence that failed to delete.
  final List<BatchDeleteGeofenceError> errors;

  BatchDeleteGeofenceResponse({
    required this.errors,
  });
  factory BatchDeleteGeofenceResponse.fromJson(Map<String, dynamic> json) {
    return BatchDeleteGeofenceResponse(
      errors: (json['Errors'] as List)
          .whereNotNull()
          .map((e) =>
              BatchDeleteGeofenceError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Contains error details for each device that failed to evaluate its position
/// against the geofences in a given geofence collection.
class BatchEvaluateGeofencesError {
  /// The device associated with the position evaluation error.
  final String deviceId;

  /// Contains details associated to the batch error.
  final BatchItemError error;

  /// Specifies a timestamp for when the error occurred in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime sampleTime;

  BatchEvaluateGeofencesError({
    required this.deviceId,
    required this.error,
    required this.sampleTime,
  });
  factory BatchEvaluateGeofencesError.fromJson(Map<String, dynamic> json) {
    return BatchEvaluateGeofencesError(
      deviceId: json['DeviceId'] as String,
      error: BatchItemError.fromJson(json['Error'] as Map<String, dynamic>),
      sampleTime: nonNullableTimeStampFromJson(json['SampleTime'] as Object),
    );
  }
}

class BatchEvaluateGeofencesResponse {
  /// Contains error details for each device that failed to evaluate its position
  /// against the given geofence collection.
  final List<BatchEvaluateGeofencesError> errors;

  BatchEvaluateGeofencesResponse({
    required this.errors,
  });
  factory BatchEvaluateGeofencesResponse.fromJson(Map<String, dynamic> json) {
    return BatchEvaluateGeofencesResponse(
      errors: (json['Errors'] as List)
          .whereNotNull()
          .map((e) =>
              BatchEvaluateGeofencesError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Contains error details for each device that didn't return a position.
class BatchGetDevicePositionError {
  /// The ID of the device that didn't return a position.
  final String deviceId;

  /// Contains details related to the error code.
  final BatchItemError error;

  BatchGetDevicePositionError({
    required this.deviceId,
    required this.error,
  });
  factory BatchGetDevicePositionError.fromJson(Map<String, dynamic> json) {
    return BatchGetDevicePositionError(
      deviceId: json['DeviceId'] as String,
      error: BatchItemError.fromJson(json['Error'] as Map<String, dynamic>),
    );
  }
}

class BatchGetDevicePositionResponse {
  /// Contains device position details such as the device ID, position, and
  /// timestamps for when the position was received and sampled.
  final List<DevicePosition> devicePositions;

  /// Contains error details for each device that failed to send its position to
  /// the tracker resource.
  final List<BatchGetDevicePositionError> errors;

  BatchGetDevicePositionResponse({
    required this.devicePositions,
    required this.errors,
  });
  factory BatchGetDevicePositionResponse.fromJson(Map<String, dynamic> json) {
    return BatchGetDevicePositionResponse(
      devicePositions: (json['DevicePositions'] as List)
          .whereNotNull()
          .map((e) => DevicePosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: (json['Errors'] as List)
          .whereNotNull()
          .map((e) =>
              BatchGetDevicePositionError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Contains the batch request error details associated with the request.
class BatchItemError {
  /// The error code associated with the batch request error.
  final BatchItemErrorCode? code;

  /// A message with the reason for the batch request error.
  final String? message;

  BatchItemError({
    this.code,
    this.message,
  });
  factory BatchItemError.fromJson(Map<String, dynamic> json) {
    return BatchItemError(
      code: (json['Code'] as String?)?.toBatchItemErrorCode(),
      message: json['Message'] as String?,
    );
  }
}

enum BatchItemErrorCode {
  accessDeniedError,
  conflictError,
  internalServerError,
  resourceNotFoundError,
  throttlingError,
  validationError,
}

extension on BatchItemErrorCode {
  String toValue() {
    switch (this) {
      case BatchItemErrorCode.accessDeniedError:
        return 'AccessDeniedError';
      case BatchItemErrorCode.conflictError:
        return 'ConflictError';
      case BatchItemErrorCode.internalServerError:
        return 'InternalServerError';
      case BatchItemErrorCode.resourceNotFoundError:
        return 'ResourceNotFoundError';
      case BatchItemErrorCode.throttlingError:
        return 'ThrottlingError';
      case BatchItemErrorCode.validationError:
        return 'ValidationError';
    }
  }
}

extension on String {
  BatchItemErrorCode toBatchItemErrorCode() {
    switch (this) {
      case 'AccessDeniedError':
        return BatchItemErrorCode.accessDeniedError;
      case 'ConflictError':
        return BatchItemErrorCode.conflictError;
      case 'InternalServerError':
        return BatchItemErrorCode.internalServerError;
      case 'ResourceNotFoundError':
        return BatchItemErrorCode.resourceNotFoundError;
      case 'ThrottlingError':
        return BatchItemErrorCode.throttlingError;
      case 'ValidationError':
        return BatchItemErrorCode.validationError;
    }
    throw Exception('$this is not known in enum BatchItemErrorCode');
  }
}

/// Contains error details for each geofence that failed to be stored in a given
/// geofence collection.
class BatchPutGeofenceError {
  /// Contains details associated to the batch error.
  final BatchItemError error;

  /// The geofence associated with the error message.
  final String geofenceId;

  BatchPutGeofenceError({
    required this.error,
    required this.geofenceId,
  });
  factory BatchPutGeofenceError.fromJson(Map<String, dynamic> json) {
    return BatchPutGeofenceError(
      error: BatchItemError.fromJson(json['Error'] as Map<String, dynamic>),
      geofenceId: json['GeofenceId'] as String,
    );
  }
}

/// Contains geofence details.
class BatchPutGeofenceRequestEntry {
  /// The identifier for the geofence to be stored in a given geofence collection.
  final String geofenceId;

  /// The geometry details for the geofence.
  final GeofenceGeometry geometry;

  BatchPutGeofenceRequestEntry({
    required this.geofenceId,
    required this.geometry,
  });
  Map<String, dynamic> toJson() {
    final geofenceId = this.geofenceId;
    final geometry = this.geometry;
    return {
      'GeofenceId': geofenceId,
      'Geometry': geometry,
    };
  }
}

class BatchPutGeofenceResponse {
  /// Contains additional error details for each geofence that failed to be stored
  /// in a geofence collection.
  final List<BatchPutGeofenceError> errors;

  /// Contains each geofence that was successfully stored in a geofence
  /// collection.
  final List<BatchPutGeofenceSuccess> successes;

  BatchPutGeofenceResponse({
    required this.errors,
    required this.successes,
  });
  factory BatchPutGeofenceResponse.fromJson(Map<String, dynamic> json) {
    return BatchPutGeofenceResponse(
      errors: (json['Errors'] as List)
          .whereNotNull()
          .map((e) => BatchPutGeofenceError.fromJson(e as Map<String, dynamic>))
          .toList(),
      successes: (json['Successes'] as List)
          .whereNotNull()
          .map((e) =>
              BatchPutGeofenceSuccess.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Contains a summary of each geofence that was successfully stored in a given
/// geofence collection.
class BatchPutGeofenceSuccess {
  /// The timestamp for when the geofence was stored in a geofence collection in
  /// <a href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO
  /// 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime createTime;

  /// The geofence successfully stored in a geofence collection.
  final String geofenceId;

  /// The timestamp for when the geofence was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime updateTime;

  BatchPutGeofenceSuccess({
    required this.createTime,
    required this.geofenceId,
    required this.updateTime,
  });
  factory BatchPutGeofenceSuccess.fromJson(Map<String, dynamic> json) {
    return BatchPutGeofenceSuccess(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      geofenceId: json['GeofenceId'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

/// Contains error details for each device that failed to update its position.
class BatchUpdateDevicePositionError {
  /// The device associated with the failed location update.
  final String deviceId;

  /// Contains details related to the error code such as the error code and error
  /// message.
  final BatchItemError error;

  /// The timestamp for when a position sample was attempted in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime sampleTime;

  BatchUpdateDevicePositionError({
    required this.deviceId,
    required this.error,
    required this.sampleTime,
  });
  factory BatchUpdateDevicePositionError.fromJson(Map<String, dynamic> json) {
    return BatchUpdateDevicePositionError(
      deviceId: json['DeviceId'] as String,
      error: BatchItemError.fromJson(json['Error'] as Map<String, dynamic>),
      sampleTime: nonNullableTimeStampFromJson(json['SampleTime'] as Object),
    );
  }
}

class BatchUpdateDevicePositionResponse {
  /// Contains error details for each device that failed to update its position.
  final List<BatchUpdateDevicePositionError> errors;

  BatchUpdateDevicePositionResponse({
    required this.errors,
  });
  factory BatchUpdateDevicePositionResponse.fromJson(
      Map<String, dynamic> json) {
    return BatchUpdateDevicePositionResponse(
      errors: (json['Errors'] as List)
          .whereNotNull()
          .map((e) => BatchUpdateDevicePositionError.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CreateGeofenceCollectionResponse {
  /// The Amazon Resource Name (ARN) for the geofence collection resource. Used
  /// when you need to specify a resource across all AWS.
  final String collectionArn;

  /// The name for the geofence collection.
  final String collectionName;

  /// The timestamp for when the geofence collection was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime createTime;

  CreateGeofenceCollectionResponse({
    required this.collectionArn,
    required this.collectionName,
    required this.createTime,
  });
  factory CreateGeofenceCollectionResponse.fromJson(Map<String, dynamic> json) {
    return CreateGeofenceCollectionResponse(
      collectionArn: json['CollectionArn'] as String,
      collectionName: json['CollectionName'] as String,
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
    );
  }
}

class CreateMapResponse {
  /// The timestamp for when the map resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// The Amazon Resource Name (ARN) for the map resource. Used when you need to
  /// specify a resource across all AWS.
  ///
  /// <ul>
  /// <li>
  /// Format example:
  /// <code>arn:partition:service:region:account-id:resource-type:resource-id</code>
  /// </li>
  /// </ul>
  final String mapArn;

  /// The name of the map resource.
  final String mapName;

  CreateMapResponse({
    required this.createTime,
    required this.mapArn,
    required this.mapName,
  });
  factory CreateMapResponse.fromJson(Map<String, dynamic> json) {
    return CreateMapResponse(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      mapArn: json['MapArn'] as String,
      mapName: json['MapName'] as String,
    );
  }
}

class CreatePlaceIndexResponse {
  /// The timestamp for when the Place index resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// The Amazon Resource Name (ARN) for the Place index resource. Used when you
  /// need to specify a resource across all AWS.
  final String indexArn;

  /// The name for the Place index resource.
  final String indexName;

  CreatePlaceIndexResponse({
    required this.createTime,
    required this.indexArn,
    required this.indexName,
  });
  factory CreatePlaceIndexResponse.fromJson(Map<String, dynamic> json) {
    return CreatePlaceIndexResponse(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      indexArn: json['IndexArn'] as String,
      indexName: json['IndexName'] as String,
    );
  }
}

class CreateTrackerResponse {
  /// The timestamp for when the tracker resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// The Amazon Resource Name (ARN) for the tracker resource. Used when you need
  /// to specify a resource across all AWS.
  final String trackerArn;

  /// The name of the tracker resource.
  final String trackerName;

  CreateTrackerResponse({
    required this.createTime,
    required this.trackerArn,
    required this.trackerName,
  });
  factory CreateTrackerResponse.fromJson(Map<String, dynamic> json) {
    return CreateTrackerResponse(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      trackerArn: json['TrackerArn'] as String,
      trackerName: json['TrackerName'] as String,
    );
  }
}

/// Specifies the data storage option chosen for requesting Places.
/// <note>
/// By using Places, you agree that AWS may transmit your API queries to your
/// selected third party provider for processing, which may be outside the AWS
/// region you are currently using.
///
/// Also, when using HERE as your data provider, you may not (a) use HERE Places
/// for Asset Management, or (b) select the <code>Storage</code> option for the
/// <code>IntendedUse</code> parameter when requesting Places in Japan. For more
/// information, see the <a href="https://aws.amazon.com/service-terms/">AWS
/// Service Terms</a> for Amazon Location Service.
/// </note>
class DataSourceConfiguration {
  /// Specifies how the results of an operation will be stored by the caller.
  ///
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>SingleUse</code> specifies that the results won't be stored.
  /// </li>
  /// <li>
  /// <code>Storage</code> specifies that the result can be cached or stored in a
  /// database.
  /// </li>
  /// </ul>
  /// Default value: <code>SingleUse</code>
  final IntendedUse? intendedUse;

  DataSourceConfiguration({
    this.intendedUse,
  });
  factory DataSourceConfiguration.fromJson(Map<String, dynamic> json) {
    return DataSourceConfiguration(
      intendedUse: (json['IntendedUse'] as String?)?.toIntendedUse(),
    );
  }

  Map<String, dynamic> toJson() {
    final intendedUse = this.intendedUse;
    return {
      if (intendedUse != null) 'IntendedUse': intendedUse.toValue(),
    };
  }
}

class DeleteGeofenceCollectionResponse {
  DeleteGeofenceCollectionResponse();
  factory DeleteGeofenceCollectionResponse.fromJson(Map<String, dynamic> _) {
    return DeleteGeofenceCollectionResponse();
  }
}

class DeleteMapResponse {
  DeleteMapResponse();
  factory DeleteMapResponse.fromJson(Map<String, dynamic> _) {
    return DeleteMapResponse();
  }
}

class DeletePlaceIndexResponse {
  DeletePlaceIndexResponse();
  factory DeletePlaceIndexResponse.fromJson(Map<String, dynamic> _) {
    return DeletePlaceIndexResponse();
  }
}

class DeleteTrackerResponse {
  DeleteTrackerResponse();
  factory DeleteTrackerResponse.fromJson(Map<String, dynamic> _) {
    return DeleteTrackerResponse();
  }
}

class DescribeGeofenceCollectionResponse {
  /// The Amazon Resource Name (ARN) for the geofence collection resource. Used
  /// when you need to specify a resource across all AWS.
  final String collectionArn;

  /// The name of the geofence collection.
  final String collectionName;

  /// The timestamp for when the geofence resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime createTime;

  /// The optional description for the geofence collection.
  final String description;

  /// The timestamp for when the geofence collection was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime updateTime;

  DescribeGeofenceCollectionResponse({
    required this.collectionArn,
    required this.collectionName,
    required this.createTime,
    required this.description,
    required this.updateTime,
  });
  factory DescribeGeofenceCollectionResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeGeofenceCollectionResponse(
      collectionArn: json['CollectionArn'] as String,
      collectionName: json['CollectionName'] as String,
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      description: json['Description'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

class DescribeMapResponse {
  /// Specifies the map tile style selected from a partner data provider.
  final MapConfiguration configuration;

  /// The timestamp for when the map resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// Specifies the data provider for the associated map tiles.
  final String dataSource;

  /// The optional description for the map resource.
  final String description;

  /// The Amazon Resource Name (ARN) for the map resource. Used when you need to
  /// specify a resource across all AWS.
  final String mapArn;

  /// The map style selected from an available provider.
  final String mapName;

  /// The timestamp for when the map resource was last update in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime updateTime;

  DescribeMapResponse({
    required this.configuration,
    required this.createTime,
    required this.dataSource,
    required this.description,
    required this.mapArn,
    required this.mapName,
    required this.updateTime,
  });
  factory DescribeMapResponse.fromJson(Map<String, dynamic> json) {
    return DescribeMapResponse(
      configuration: MapConfiguration.fromJson(
          json['Configuration'] as Map<String, dynamic>),
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      dataSource: json['DataSource'] as String,
      description: json['Description'] as String,
      mapArn: json['MapArn'] as String,
      mapName: json['MapName'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

class DescribePlaceIndexResponse {
  /// The timestamp for when the Place index resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// The data provider of geospatial data.
  final String dataSource;

  /// The specified data storage option for requesting Places.
  final DataSourceConfiguration dataSourceConfiguration;

  /// The optional description for the Place index resource.
  final String description;

  /// The Amazon Resource Name (ARN) for the Place index resource. Used when you
  /// need to specify a resource across all AWS.
  final String indexArn;

  /// The name of the Place index resource being described.
  final String indexName;

  /// The timestamp for when the Place index resource was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime updateTime;

  DescribePlaceIndexResponse({
    required this.createTime,
    required this.dataSource,
    required this.dataSourceConfiguration,
    required this.description,
    required this.indexArn,
    required this.indexName,
    required this.updateTime,
  });
  factory DescribePlaceIndexResponse.fromJson(Map<String, dynamic> json) {
    return DescribePlaceIndexResponse(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      dataSource: json['DataSource'] as String,
      dataSourceConfiguration: DataSourceConfiguration.fromJson(
          json['DataSourceConfiguration'] as Map<String, dynamic>),
      description: json['Description'] as String,
      indexArn: json['IndexArn'] as String,
      indexName: json['IndexName'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

class DescribeTrackerResponse {
  /// The timestamp for when the tracker resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// The optional description for the tracker resource.
  final String description;

  /// The Amazon Resource Name (ARN) for the tracker resource. Used when you need
  /// to specify a resource across all AWS.
  final String trackerArn;

  /// The name of the tracker resource.
  final String trackerName;

  /// The timestamp for when the tracker resource was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime updateTime;

  DescribeTrackerResponse({
    required this.createTime,
    required this.description,
    required this.trackerArn,
    required this.trackerName,
    required this.updateTime,
  });
  factory DescribeTrackerResponse.fromJson(Map<String, dynamic> json) {
    return DescribeTrackerResponse(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      description: json['Description'] as String,
      trackerArn: json['TrackerArn'] as String,
      trackerName: json['TrackerName'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

/// Contains the device position details.
class DevicePosition {
  /// The last known device position.
  final List<double> position;

  /// The timestamp for when the tracker resource recieved the position in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime receivedTime;

  /// The timestamp for when the position was detected and sampled in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime sampleTime;

  /// The device whose position you retrieved.
  final String? deviceId;

  DevicePosition({
    required this.position,
    required this.receivedTime,
    required this.sampleTime,
    this.deviceId,
  });
  factory DevicePosition.fromJson(Map<String, dynamic> json) {
    return DevicePosition(
      position: (json['Position'] as List)
          .whereNotNull()
          .map((e) => e as double)
          .toList(),
      receivedTime:
          nonNullableTimeStampFromJson(json['ReceivedTime'] as Object),
      sampleTime: nonNullableTimeStampFromJson(json['SampleTime'] as Object),
      deviceId: json['DeviceId'] as String?,
    );
  }
}

/// Contains the position update details for a device.
class DevicePositionUpdate {
  /// The device associated to the position update.
  final String deviceId;

  /// The latest device position defined in <a
  /// href="https://earth-info.nga.mil/GandG/wgs84/index.html">WGS 84</a> format:
  /// <code>[Xlongitude, Ylatitude]</code>.
  final List<double> position;

  /// The timestamp for when the position update was received in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime sampleTime;

  DevicePositionUpdate({
    required this.deviceId,
    required this.position,
    required this.sampleTime,
  });
  Map<String, dynamic> toJson() {
    final deviceId = this.deviceId;
    final position = this.position;
    final sampleTime = this.sampleTime;
    return {
      'DeviceId': deviceId,
      'Position': position,
      'SampleTime': iso8601ToJson(sampleTime),
    };
  }
}

class DisassociateTrackerConsumerResponse {
  DisassociateTrackerConsumerResponse();
  factory DisassociateTrackerConsumerResponse.fromJson(Map<String, dynamic> _) {
    return DisassociateTrackerConsumerResponse();
  }
}

/// Contains the geofence geometry details.
/// <note>
/// Limitation — Amazon Location does not currently support polygons with holes,
/// multipolygons, polygons that are wound clockwise, or that cross the
/// antimeridian.
/// </note>
class GeofenceGeometry {
  /// An array of 1 or more linear rings. A linear ring is an array of 4 or more
  /// vertices, where the first and last vertex are the same to form a closed
  /// boundary. Each vertex is a 2-dimensional point of the form:
  /// <code>[longitude, latitude]</code>.
  ///
  /// The first linear ring is an outer ring, describing the polygon's boundary.
  /// Subsequent linear rings may be inner or outer rings to describe holes and
  /// islands. Outer rings must list their vertices in counter-clockwise order
  /// around the ring's center, where the left side is the polygon's exterior.
  /// Inner rings must list their vertices in clockwise order, where the left side
  /// is the polygon's interior.
  final List<List<List<double>>>? polygon;

  GeofenceGeometry({
    this.polygon,
  });
  factory GeofenceGeometry.fromJson(Map<String, dynamic> json) {
    return GeofenceGeometry(
      polygon: (json['Polygon'] as List?)
          ?.whereNotNull()
          .map((e) => (e as List)
              .whereNotNull()
              .map((e) =>
                  (e as List).whereNotNull().map((e) => e as double).toList())
              .toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final polygon = this.polygon;
    return {
      if (polygon != null) 'Polygon': polygon,
    };
  }
}

class GetDevicePositionHistoryResponse {
  /// Contains the position history details for the requested device.
  final List<DevicePosition> devicePositions;

  /// A pagination token indicating there are additional pages available. You can
  /// use the token in a following request to fetch the next set of results.
  final String? nextToken;

  GetDevicePositionHistoryResponse({
    required this.devicePositions,
    this.nextToken,
  });
  factory GetDevicePositionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return GetDevicePositionHistoryResponse(
      devicePositions: (json['DevicePositions'] as List)
          .whereNotNull()
          .map((e) => DevicePosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class GetDevicePositionResponse {
  /// The last known device position.
  final List<double> position;

  /// The timestamp for when the tracker resource recieved the position in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601 </a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime receivedTime;

  /// The timestamp for when the position was detected and sampled in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601 </a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime sampleTime;

  /// The device whose position you retrieved.
  final String? deviceId;

  GetDevicePositionResponse({
    required this.position,
    required this.receivedTime,
    required this.sampleTime,
    this.deviceId,
  });
  factory GetDevicePositionResponse.fromJson(Map<String, dynamic> json) {
    return GetDevicePositionResponse(
      position: (json['Position'] as List)
          .whereNotNull()
          .map((e) => e as double)
          .toList(),
      receivedTime:
          nonNullableTimeStampFromJson(json['ReceivedTime'] as Object),
      sampleTime: nonNullableTimeStampFromJson(json['SampleTime'] as Object),
      deviceId: json['DeviceId'] as String?,
    );
  }
}

class GetGeofenceResponse {
  /// The timestamp for when the geofence collection was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime createTime;

  /// The geofence identifier.
  final String geofenceId;

  /// Contains the geofence geometry details describing a polygon.
  final GeofenceGeometry geometry;

  /// Identifies the state of the geofence. A geofence will hold one of the
  /// following states:
  ///
  /// <ul>
  /// <li>
  /// <code>ACTIVE</code> — The geofence has been indexed by the system.
  /// </li>
  /// <li>
  /// <code>PENDING</code> — The geofence is being processed by the system.
  /// </li>
  /// <li>
  /// <code>FAILED</code> — The geofence failed to be indexed by the system.
  /// </li>
  /// <li>
  /// <code>DELETED</code> — The geofence has been deleted from the system index.
  /// </li>
  /// <li>
  /// <code>DELETING</code> — The geofence is being deleted from the system index.
  /// </li>
  /// </ul>
  final String status;

  /// The timestamp for when the geofence collection was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime updateTime;

  GetGeofenceResponse({
    required this.createTime,
    required this.geofenceId,
    required this.geometry,
    required this.status,
    required this.updateTime,
  });
  factory GetGeofenceResponse.fromJson(Map<String, dynamic> json) {
    return GetGeofenceResponse(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      geofenceId: json['GeofenceId'] as String,
      geometry:
          GeofenceGeometry.fromJson(json['Geometry'] as Map<String, dynamic>),
      status: json['Status'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

class GetMapGlyphsResponse {
  /// The blob's content type.
  final Uint8List? blob;

  /// The map glyph content type. For example,
  /// <code>application/octet-stream</code>.
  final String? contentType;

  GetMapGlyphsResponse({
    this.blob,
    this.contentType,
  });
}

class GetMapSpritesResponse {
  /// Contains the body of the sprite sheet or JSON offset ﬁle.
  final Uint8List? blob;

  /// The content type of the sprite sheet and offsets. For example, the sprite
  /// sheet content type is <code>image/png</code>, and the sprite offset JSON
  /// document is <code>application/json</code>.
  final String? contentType;

  GetMapSpritesResponse({
    this.blob,
    this.contentType,
  });
}

class GetMapStyleDescriptorResponse {
  /// Contains the body of the style descriptor.
  final Uint8List? blob;

  /// The style descriptor's content type. For example,
  /// <code>application/json</code>.
  final String? contentType;

  GetMapStyleDescriptorResponse({
    this.blob,
    this.contentType,
  });
}

class GetMapTileResponse {
  /// Contains Mapbox Vector Tile (MVT) data.
  final Uint8List? blob;

  /// The map tile's content type. For example,
  /// <code>application/vnd.mapbox-vector-tile</code>.
  final String? contentType;

  GetMapTileResponse({
    this.blob,
    this.contentType,
  });
}

enum IntendedUse {
  singleUse,
  storage,
}

extension on IntendedUse {
  String toValue() {
    switch (this) {
      case IntendedUse.singleUse:
        return 'SingleUse';
      case IntendedUse.storage:
        return 'Storage';
    }
  }
}

extension on String {
  IntendedUse toIntendedUse() {
    switch (this) {
      case 'SingleUse':
        return IntendedUse.singleUse;
      case 'Storage':
        return IntendedUse.storage;
    }
    throw Exception('$this is not known in enum IntendedUse');
  }
}

class ListGeofenceCollectionsResponse {
  /// Lists the geofence collections that exist in your AWS account.
  final List<ListGeofenceCollectionsResponseEntry> entries;

  /// A pagination token indicating there are additional pages available. You can
  /// use the token in a following request to fetch the next set of results.
  final String? nextToken;

  ListGeofenceCollectionsResponse({
    required this.entries,
    this.nextToken,
  });
  factory ListGeofenceCollectionsResponse.fromJson(Map<String, dynamic> json) {
    return ListGeofenceCollectionsResponse(
      entries: (json['Entries'] as List)
          .whereNotNull()
          .map((e) => ListGeofenceCollectionsResponseEntry.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// Contains the geofence collection details.
class ListGeofenceCollectionsResponseEntry {
  /// The name of the geofence collection.
  final String collectionName;

  /// The timestamp for when the geofence collection was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime createTime;

  /// The description for the geofence collection
  final String description;

  /// Specifies a timestamp for when the resource was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime updateTime;

  ListGeofenceCollectionsResponseEntry({
    required this.collectionName,
    required this.createTime,
    required this.description,
    required this.updateTime,
  });
  factory ListGeofenceCollectionsResponseEntry.fromJson(
      Map<String, dynamic> json) {
    return ListGeofenceCollectionsResponseEntry(
      collectionName: json['CollectionName'] as String,
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      description: json['Description'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

/// Contains a list of geofences stored in a given geofence collection.
class ListGeofenceResponseEntry {
  /// The timestamp for when the geofence was stored in a geofence collection in
  /// <a href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO
  /// 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime createTime;

  /// The geofence identifier.
  final String geofenceId;

  /// Contains the geofence geometry details describing a polygon.
  final GeofenceGeometry geometry;

  /// Identifies the state of the geofence. A geofence will hold one of the
  /// following states:
  ///
  /// <ul>
  /// <li>
  /// <code>ACTIVE</code> — The geofence has been indexed by the system.
  /// </li>
  /// <li>
  /// <code>PENDING</code> — The geofence is being processed by the system.
  /// </li>
  /// <li>
  /// <code>FAILED</code> — The geofence failed to be indexed by the system.
  /// </li>
  /// <li>
  /// <code>DELETED</code> — The geofence has been deleted from the system index.
  /// </li>
  /// <li>
  /// <code>DELETING</code> — The geofence is being deleted from the system index.
  /// </li>
  /// </ul>
  final String status;

  /// The timestamp for when the geofence was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime updateTime;

  ListGeofenceResponseEntry({
    required this.createTime,
    required this.geofenceId,
    required this.geometry,
    required this.status,
    required this.updateTime,
  });
  factory ListGeofenceResponseEntry.fromJson(Map<String, dynamic> json) {
    return ListGeofenceResponseEntry(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      geofenceId: json['GeofenceId'] as String,
      geometry:
          GeofenceGeometry.fromJson(json['Geometry'] as Map<String, dynamic>),
      status: json['Status'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

class ListGeofencesResponse {
  /// Contains a list of geofences stored in the geofence collection.
  final List<ListGeofenceResponseEntry> entries;

  /// A pagination token indicating there are additional pages available. You can
  /// use the token in a following request to fetch the next set of results.
  final String? nextToken;

  ListGeofencesResponse({
    required this.entries,
    this.nextToken,
  });
  factory ListGeofencesResponse.fromJson(Map<String, dynamic> json) {
    return ListGeofencesResponse(
      entries: (json['Entries'] as List)
          .whereNotNull()
          .map((e) =>
              ListGeofenceResponseEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListMapsResponse {
  /// Contains a list of maps in your AWS account
  final List<ListMapsResponseEntry> entries;

  /// A pagination token indicating there are additional pages available. You can
  /// use the token in a following request to fetch the next set of results.
  final String? nextToken;

  ListMapsResponse({
    required this.entries,
    this.nextToken,
  });
  factory ListMapsResponse.fromJson(Map<String, dynamic> json) {
    return ListMapsResponse(
      entries: (json['Entries'] as List)
          .whereNotNull()
          .map((e) => ListMapsResponseEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// Contains details of an existing map resource in your AWS account.
class ListMapsResponseEntry {
  /// The timestamp for when the map resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// Specifies the data provider for the associated map tiles.
  final String dataSource;

  /// The description for the map resource.
  final String description;

  /// The name of the associated map resource.
  final String mapName;

  /// The timestamp for when the map resource was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime updateTime;

  ListMapsResponseEntry({
    required this.createTime,
    required this.dataSource,
    required this.description,
    required this.mapName,
    required this.updateTime,
  });
  factory ListMapsResponseEntry.fromJson(Map<String, dynamic> json) {
    return ListMapsResponseEntry(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      dataSource: json['DataSource'] as String,
      description: json['Description'] as String,
      mapName: json['MapName'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

class ListPlaceIndexesResponse {
  /// Lists the Place index resources that exist in your AWS account
  final List<ListPlaceIndexesResponseEntry> entries;

  /// A pagination token indicating there are additional pages available. You can
  /// use the token in a following request to fetch the next set of results.
  final String? nextToken;

  ListPlaceIndexesResponse({
    required this.entries,
    this.nextToken,
  });
  factory ListPlaceIndexesResponse.fromJson(Map<String, dynamic> json) {
    return ListPlaceIndexesResponse(
      entries: (json['Entries'] as List)
          .whereNotNull()
          .map((e) =>
              ListPlaceIndexesResponseEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// A Place index resource listed in your AWS account.
class ListPlaceIndexesResponseEntry {
  /// The timestamp for when the Place index resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// The data provider of geospatial data.
  final String dataSource;

  /// The optional description for the Place index resource.
  final String description;

  /// The name of the Place index resource.
  final String indexName;

  /// The timestamp for when the Place index resource was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime updateTime;

  ListPlaceIndexesResponseEntry({
    required this.createTime,
    required this.dataSource,
    required this.description,
    required this.indexName,
    required this.updateTime,
  });
  factory ListPlaceIndexesResponseEntry.fromJson(Map<String, dynamic> json) {
    return ListPlaceIndexesResponseEntry(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      dataSource: json['DataSource'] as String,
      description: json['Description'] as String,
      indexName: json['IndexName'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

class ListTrackerConsumersResponse {
  /// Contains the list of geofence collection ARNs associated to the tracker
  /// resource.
  final List<String> consumerArns;

  /// A pagination token indicating there are additional pages available. You can
  /// use the token in a following request to fetch the next set of results.
  final String? nextToken;

  ListTrackerConsumersResponse({
    required this.consumerArns,
    this.nextToken,
  });
  factory ListTrackerConsumersResponse.fromJson(Map<String, dynamic> json) {
    return ListTrackerConsumersResponse(
      consumerArns: (json['ConsumerArns'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListTrackersResponse {
  /// Contains tracker resources in your AWS account. Details include tracker
  /// name, description and timestamps for when the tracker was created and last
  /// updated.
  final List<ListTrackersResponseEntry> entries;

  /// A pagination token indicating there are additional pages available. You can
  /// use the token in a following request to fetch the next set of results.
  final String? nextToken;

  ListTrackersResponse({
    required this.entries,
    this.nextToken,
  });
  factory ListTrackersResponse.fromJson(Map<String, dynamic> json) {
    return ListTrackersResponse(
      entries: (json['Entries'] as List)
          .whereNotNull()
          .map((e) =>
              ListTrackersResponseEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// Contains the tracker resource details.
class ListTrackersResponseEntry {
  /// The timestamp for when the tracker resource was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime createTime;

  /// The description for the tracker resource.
  final String description;

  /// The name of the tracker resource.
  final String trackerName;

  /// The timestamp for when the position was detected and sampled in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html"> ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.
  final DateTime updateTime;

  ListTrackersResponseEntry({
    required this.createTime,
    required this.description,
    required this.trackerName,
    required this.updateTime,
  });
  factory ListTrackersResponseEntry.fromJson(Map<String, dynamic> json) {
    return ListTrackersResponseEntry(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      description: json['Description'] as String,
      trackerName: json['TrackerName'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

/// Specifies the map tile style selected from an available provider.
class MapConfiguration {
  /// Specifies the map style selected from an available data provider.
  ///
  /// Valid styles: <code>VectorEsriLightGrayCanvas</code>,
  /// <code>VectorEsriLight</code>, <code>VectorEsriStreets</code>,
  /// <code>VectorEsriNavigation</code>, <code>VectorEsriDarkGrayCanvas</code>,
  /// <code>VectorEsriLightGrayCanvas</code>, <code>VectorHereBerlin</code>
  /// <note>
  /// When using HERE as your data provider, and selecting the Style
  /// <code>VectorHereBerlin</code>, you may not use HERE Maps for Asset
  /// Management. See the <a href="https://aws.amazon.com/service-terms/">AWS
  /// Service Terms</a> for Amazon Location Service.
  /// </note>
  final String style;

  MapConfiguration({
    required this.style,
  });
  factory MapConfiguration.fromJson(Map<String, dynamic> json) {
    return MapConfiguration(
      style: json['Style'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final style = this.style;
    return {
      'Style': style,
    };
  }
}

/// Contains details about addresses or points of interest that match the search
/// criteria.
class Place {
  final PlaceGeometry geometry;

  /// The numerical portion of an address, such as a building number.
  final String? addressNumber;

  /// A country/region specified using <a
  /// href="https://www.iso.org/iso-3166-country-codes.html">ISO 3166</a> 3-digit
  /// country/region code. For example, <code>CAN</code>.
  final String? country;

  /// The full name and address of the point of interest such as a city, region,
  /// or country. For example, <code>123 Any Street, Any Town, USA</code>.
  final String? label;

  /// A name for a local area, such as a city or town name. For example,
  /// <code>Toronto</code>.
  final String? municipality;

  /// The name of a community district. For example, <code>Downtown</code>.
  final String? neighborhood;

  /// A group of numbers and letters in a country-specific format, which
  /// accompanies the address for the purpose of identifying a location.
  final String? postalCode;

  /// A name for an area or geographical division, such as a province or state
  /// name. For example, <code>British Columbia</code>.
  final String? region;

  /// The name for a street or a road to identify a location. For example,
  /// <code>Main Street</code>.
  final String? street;

  /// A country, or an area that's part of a larger region . For example,
  /// <code>Metro Vancouver</code>.
  final String? subRegion;

  Place({
    required this.geometry,
    this.addressNumber,
    this.country,
    this.label,
    this.municipality,
    this.neighborhood,
    this.postalCode,
    this.region,
    this.street,
    this.subRegion,
  });
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry:
          PlaceGeometry.fromJson(json['Geometry'] as Map<String, dynamic>),
      addressNumber: json['AddressNumber'] as String?,
      country: json['Country'] as String?,
      label: json['Label'] as String?,
      municipality: json['Municipality'] as String?,
      neighborhood: json['Neighborhood'] as String?,
      postalCode: json['PostalCode'] as String?,
      region: json['Region'] as String?,
      street: json['Street'] as String?,
      subRegion: json['SubRegion'] as String?,
    );
  }
}

/// Places uses a point geometry to specify a location or a Place.
class PlaceGeometry {
  /// A single point geometry specifies a location for a Place using <a
  /// href="https://gisgeography.com/wgs84-world-geodetic-system/">WGS 84</a>
  /// coordinates:
  ///
  /// <ul>
  /// <li>
  /// <i>x</i> — Specifies the x coordinate or longitude.
  /// </li>
  /// <li>
  /// <i>y</i> — Specifies the y coordinate or latitude.
  /// </li>
  /// </ul>
  final List<double>? point;

  PlaceGeometry({
    this.point,
  });
  factory PlaceGeometry.fromJson(Map<String, dynamic> json) {
    return PlaceGeometry(
      point: (json['Point'] as List?)
          ?.whereNotNull()
          .map((e) => e as double)
          .toList(),
    );
  }
}

enum PricingPlan {
  requestBasedUsage,
  mobileAssetTracking,
  mobileAssetManagement,
}

extension on PricingPlan {
  String toValue() {
    switch (this) {
      case PricingPlan.requestBasedUsage:
        return 'RequestBasedUsage';
      case PricingPlan.mobileAssetTracking:
        return 'MobileAssetTracking';
      case PricingPlan.mobileAssetManagement:
        return 'MobileAssetManagement';
    }
  }
}

extension on String {
  PricingPlan toPricingPlan() {
    switch (this) {
      case 'RequestBasedUsage':
        return PricingPlan.requestBasedUsage;
      case 'MobileAssetTracking':
        return PricingPlan.mobileAssetTracking;
      case 'MobileAssetManagement':
        return PricingPlan.mobileAssetManagement;
    }
    throw Exception('$this is not known in enum PricingPlan');
  }
}

class PutGeofenceResponse {
  /// The timestamp for when the geofence was created in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime createTime;

  /// The geofence identifier entered in the request.
  final String geofenceId;

  /// The timestamp for when the geofence was last updated in <a
  /// href="https://www.iso.org/iso-8601-date-and-time-format.html">ISO 8601</a>
  /// format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>
  final DateTime updateTime;

  PutGeofenceResponse({
    required this.createTime,
    required this.geofenceId,
    required this.updateTime,
  });
  factory PutGeofenceResponse.fromJson(Map<String, dynamic> json) {
    return PutGeofenceResponse(
      createTime: nonNullableTimeStampFromJson(json['CreateTime'] as Object),
      geofenceId: json['GeofenceId'] as String,
      updateTime: nonNullableTimeStampFromJson(json['UpdateTime'] as Object),
    );
  }
}

/// Specifies a single point of interest, or Place as a result of a search query
/// obtained from a dataset configured in the Place index Resource.
class SearchForPositionResult {
  /// Contains details about the relevant point of interest.
  final Place place;

  SearchForPositionResult({
    required this.place,
  });
  factory SearchForPositionResult.fromJson(Map<String, dynamic> json) {
    return SearchForPositionResult(
      place: Place.fromJson(json['Place'] as Map<String, dynamic>),
    );
  }
}

/// Contains relevant Places returned by calling
/// <code>SearchPlaceIndexForText</code>.
class SearchForTextResult {
  /// Contains details about the relevant point of interest.
  final Place place;

  SearchForTextResult({
    required this.place,
  });
  factory SearchForTextResult.fromJson(Map<String, dynamic> json) {
    return SearchForTextResult(
      place: Place.fromJson(json['Place'] as Map<String, dynamic>),
    );
  }
}

class SearchPlaceIndexForPositionResponse {
  /// Returns a list of Places closest to the specified position. Each result
  /// contains additional information about the Places returned.
  final List<SearchForPositionResult> results;

  /// Contains a summary of the request.
  final SearchPlaceIndexForPositionSummary summary;

  SearchPlaceIndexForPositionResponse({
    required this.results,
    required this.summary,
  });
  factory SearchPlaceIndexForPositionResponse.fromJson(
      Map<String, dynamic> json) {
    return SearchPlaceIndexForPositionResponse(
      results: (json['Results'] as List)
          .whereNotNull()
          .map((e) =>
              SearchForPositionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: SearchPlaceIndexForPositionSummary.fromJson(
          json['Summary'] as Map<String, dynamic>),
    );
  }
}

/// A summary of the reverse geocoding request sent using
/// <code>SearchPlaceIndexForPosition</code>.
class SearchPlaceIndexForPositionSummary {
  /// The data provider of geospatial data for the Place index resource.
  final String dataSource;

  /// The position given in the reverse geocoding request.
  final List<double> position;

  /// An optional parameter. The maximum number of results returned per request.
  ///
  /// Default value: <code>50</code>
  final int? maxResults;

  SearchPlaceIndexForPositionSummary({
    required this.dataSource,
    required this.position,
    this.maxResults,
  });
  factory SearchPlaceIndexForPositionSummary.fromJson(
      Map<String, dynamic> json) {
    return SearchPlaceIndexForPositionSummary(
      dataSource: json['DataSource'] as String,
      position: (json['Position'] as List)
          .whereNotNull()
          .map((e) => e as double)
          .toList(),
      maxResults: json['MaxResults'] as int?,
    );
  }
}

class SearchPlaceIndexForTextResponse {
  /// A list of Places closest to the specified position. Each result contains
  /// additional information about the specific point of interest.
  final List<SearchForTextResult> results;

  /// Contains a summary of the request. Contains the <code>BiasPosition</code>,
  /// <code>DataSource</code>, <code>FilterBBox</code>,
  /// <code>FilterCountries</code>, <code>MaxResults</code>,
  /// <code>ResultBBox</code>, and <code>Text</code>.
  final SearchPlaceIndexForTextSummary summary;

  SearchPlaceIndexForTextResponse({
    required this.results,
    required this.summary,
  });
  factory SearchPlaceIndexForTextResponse.fromJson(Map<String, dynamic> json) {
    return SearchPlaceIndexForTextResponse(
      results: (json['Results'] as List)
          .whereNotNull()
          .map((e) => SearchForTextResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: SearchPlaceIndexForTextSummary.fromJson(
          json['Summary'] as Map<String, dynamic>),
    );
  }
}

/// A summary of the geocoding request sent using
/// <code>SearchPlaceIndexForText</code>.
class SearchPlaceIndexForTextSummary {
  /// The data provider of geospatial data for the Place index resource.
  final String dataSource;

  /// The address, name, city or region to be used in the geocoding request. In
  /// free-form text format. For example, <code>Vancouver</code>.
  final String text;

  /// Contains the coordinates for the bias position entered in the geocoding
  /// request.
  final List<double>? biasPosition;

  /// Contains the coordinates for the optional bounding box coordinated entered
  /// in the geocoding request.
  final List<double>? filterBBox;

  /// Contains the country filter entered in the geocoding request.
  final List<String>? filterCountries;

  /// Contains the maximum number of results indicated for the request.
  final int? maxResults;

  /// A bounding box that contains the search results within the specified area
  /// indicated by <code>FilterBBox</code>. A subset of bounding box specified
  /// using <code>FilterBBox</code>.
  final List<double>? resultBBox;

  SearchPlaceIndexForTextSummary({
    required this.dataSource,
    required this.text,
    this.biasPosition,
    this.filterBBox,
    this.filterCountries,
    this.maxResults,
    this.resultBBox,
  });
  factory SearchPlaceIndexForTextSummary.fromJson(Map<String, dynamic> json) {
    return SearchPlaceIndexForTextSummary(
      dataSource: json['DataSource'] as String,
      text: json['Text'] as String,
      biasPosition: (json['BiasPosition'] as List?)
          ?.whereNotNull()
          .map((e) => e as double)
          .toList(),
      filterBBox: (json['FilterBBox'] as List?)
          ?.whereNotNull()
          .map((e) => e as double)
          .toList(),
      filterCountries: (json['FilterCountries'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      maxResults: json['MaxResults'] as int?,
      resultBBox: (json['ResultBBox'] as List?)
          ?.whereNotNull()
          .map((e) => e as double)
          .toList(),
    );
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

class ThrottlingException extends _s.GenericAwsException {
  ThrottlingException({String? type, String? message})
      : super(type: type, code: 'ThrottlingException', message: message);
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
  'ThrottlingException': (type, message) =>
      ThrottlingException(type: type, message: message),
  'ValidationException': (type, message) =>
      ValidationException(type: type, message: message),
};
