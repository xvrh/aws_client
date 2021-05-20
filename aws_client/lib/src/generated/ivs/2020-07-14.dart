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

/// <b>Introduction</b>
///
/// The Amazon Interactive Video Service (IVS) API is REST compatible, using a
/// standard HTTP API and an <a href="http://aws.amazon.com/sns">AWS SNS</a>
/// event stream for responses. JSON is used for both requests and responses,
/// including errors.
///
/// The API is an AWS regional service, currently in these regions: us-west-2,
/// us-east-1, and eu-west-1.
///
/// <i> <b>All API request parameters and URLs are case sensitive. </b> </i>
///
/// For a summary of notable documentation changes in each release, see <a
/// href="https://docs.aws.amazon.com/ivs/latest/userguide/doc-history.html">
/// Document History</a>.
///
/// <b>Service Endpoints</b>
///
/// The following are the Amazon IVS service endpoints (all HTTPS):
///
/// Region name: US West (Oregon)
///
/// <ul>
/// <li>
/// Region: <code>us-west-2</code>
/// </li>
/// <li>
/// Endpoint: <code>ivs.us-west-2.amazonaws.com</code>
/// </li>
/// </ul>
/// Region name: US East (Virginia)
///
/// <ul>
/// <li>
/// Region: <code>us-east-1</code>
/// </li>
/// <li>
/// Endpoint: <code>ivs.us-east-1.amazonaws.com</code>
/// </li>
/// </ul>
/// Region name: EU West (Dublin)
///
/// <ul>
/// <li>
/// Region: <code>eu-west-1</code>
/// </li>
/// <li>
/// Endpoint: <code>ivs.eu-west-1.amazonaws.com</code>
/// </li>
/// </ul>
/// <b>Allowed Header Values</b>
///
/// <ul>
/// <li>
/// <code> <b>Accept:</b> </code> application/json
/// </li>
/// <li>
/// <code> <b>Accept-Encoding:</b> </code> gzip, deflate
/// </li>
/// <li>
/// <code> <b>Content-Type:</b> </code>application/json
/// </li>
/// </ul>
/// <b>Resources</b>
///
/// The following resources contain information about your IVS live stream (see
/// <a href="https://docs.aws.amazon.com/ivs/latest/userguide/GSIVS.html">
/// Getting Started with Amazon IVS</a>):
///
/// <ul>
/// <li>
/// Channel — Stores configuration data related to your live stream. You first
/// create a channel and then use the channel’s stream key to start your live
/// stream. See the Channel endpoints for more information.
/// </li>
/// <li>
/// Stream key — An identifier assigned by Amazon IVS when you create a channel,
/// which is then used to authorize streaming. See the StreamKey endpoints for
/// more information. <i> <b>Treat the stream key like a secret, since it allows
/// anyone to stream to the channel.</b> </i>
/// </li>
/// <li>
/// Playback key pair — Video playback may be restricted using
/// playback-authorization tokens, which use public-key encryption. A playback
/// key pair is the public-private pair of keys used to sign and validate the
/// playback-authorization token. See the PlaybackKeyPair endpoints for more
/// information.
/// </li>
/// </ul>
/// <b>Tagging</b>
///
/// A <i>tag</i> is a metadata label that you assign to an AWS resource. A tag
/// comprises a <i>key</i> and a <i>value</i>, both set by you. For example, you
/// might set a tag as <code>topic:nature</code> to label a particular video
/// category. See <a
/// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
/// AWS Resources</a> for more information, including restrictions that apply to
/// tags.
///
/// Tags can help you identify and organize your AWS resources. For example, you
/// can use the same tag for different resources to indicate that they are
/// related. You can also use tags to manage access (see <a
/// href="https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html">
/// Access Tags</a>).
///
/// The Amazon IVS API has these tag-related endpoints: <a>TagResource</a>,
/// <a>UntagResource</a>, and <a>ListTagsForResource</a>. The following
/// resources support tagging: Channels, Stream Keys, and Playback Key Pairs.
///
/// <b>Channel Endpoints</b>
///
/// <ul>
/// <li>
/// <a>CreateChannel</a> — Creates a new channel and an associated stream key to
/// start streaming.
/// </li>
/// <li>
/// <a>GetChannel</a> — Gets the channel configuration for the specified channel
/// ARN (Amazon Resource Name).
/// </li>
/// <li>
/// <a>BatchGetChannel</a> — Performs <a>GetChannel</a> on multiple ARNs
/// simultaneously.
/// </li>
/// <li>
/// <a>ListChannels</a> — Gets summary information about all channels in your
/// account, in the AWS region where the API request is processed. This list can
/// be filtered to match a specified string.
/// </li>
/// <li>
/// <a>UpdateChannel</a> — Updates a channel's configuration. This does not
/// affect an ongoing stream of this channel. You must stop and restart the
/// stream for the changes to take effect.
/// </li>
/// <li>
/// <a>DeleteChannel</a> — Deletes the specified channel.
/// </li>
/// </ul>
/// <b>StreamKey Endpoints</b>
///
/// <ul>
/// <li>
/// <a>CreateStreamKey</a> — Creates a stream key, used to initiate a stream,
/// for the specified channel ARN.
/// </li>
/// <li>
/// <a>GetStreamKey</a> — Gets stream key information for the specified ARN.
/// </li>
/// <li>
/// <a>BatchGetStreamKey</a> — Performs <a>GetStreamKey</a> on multiple ARNs
/// simultaneously.
/// </li>
/// <li>
/// <a>ListStreamKeys</a> — Gets summary information about stream keys for the
/// specified channel.
/// </li>
/// <li>
/// <a>DeleteStreamKey</a> — Deletes the stream key for the specified ARN, so it
/// can no longer be used to stream.
/// </li>
/// </ul>
/// <b>Stream Endpoints</b>
///
/// <ul>
/// <li>
/// <a>GetStream</a> — Gets information about the active (live) stream on a
/// specified channel.
/// </li>
/// <li>
/// <a>ListStreams</a> — Gets summary information about live streams in your
/// account, in the AWS region where the API request is processed.
/// </li>
/// <li>
/// <a>StopStream</a> — Disconnects the incoming RTMPS stream for the specified
/// channel. Can be used in conjunction with <a>DeleteStreamKey</a> to prevent
/// further streaming to a channel.
/// </li>
/// <li>
/// <a>PutMetadata</a> — Inserts metadata into an RTMPS stream for the specified
/// channel. A maximum of 5 requests per second per channel is allowed, each
/// with a maximum 1KB payload.
/// </li>
/// </ul>
/// <b>PlaybackKeyPair Endpoints</b>
///
/// <ul>
/// <li>
/// <a>ImportPlaybackKeyPair</a> — Imports the public portion of a new key pair
/// and returns its <code>arn</code> and <code>fingerprint</code>. The
/// <code>privateKey</code> can then be used to generate viewer authorization
/// tokens, to grant viewers access to authorized channels.
/// </li>
/// <li>
/// <a>GetPlaybackKeyPair</a> — Gets a specified playback authorization key pair
/// and returns the <code>arn</code> and <code>fingerprint</code>. The
/// <code>privateKey</code> held by the caller can be used to generate viewer
/// authorization tokens, to grant viewers access to authorized channels.
/// </li>
/// <li>
/// <a>ListPlaybackKeyPairs</a> — Gets summary information about playback key
/// pairs.
/// </li>
/// <li>
/// <a>DeletePlaybackKeyPair</a> — Deletes a specified authorization key pair.
/// This invalidates future viewer tokens generated using the key pair’s
/// <code>privateKey</code>.
/// </li>
/// </ul>
/// <b>AWS Tags Endpoints</b>
///
/// <ul>
/// <li>
/// <a>TagResource</a> — Adds or updates tags for the AWS resource with the
/// specified ARN.
/// </li>
/// <li>
/// <a>UntagResource</a> — Removes tags from the resource with the specified
/// ARN.
/// </li>
/// <li>
/// <a>ListTagsForResource</a> — Gets information about AWS tags for the
/// specified ARN.
/// </li>
/// </ul>
class Ivs {
  final _s.RestJsonProtocol _protocol;
  Ivs({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'ivs',
            signingName: 'ivs',
          ),
          region: region,
          credentials: credentials,
          endpointUrl: endpointUrl,
        );

  /// Performs <a>GetChannel</a> on multiple ARNs simultaneously.
  ///
  /// Parameter [arns] :
  /// Array of ARNs, one per channel.
  Future<BatchGetChannelResponse> batchGetChannel({
    required List<String> arns,
  }) async {
    ArgumentError.checkNotNull(arns, 'arns');
    final $payload = <String, dynamic>{
      'arns': arns,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/BatchGetChannel',
      exceptionFnMap: _exceptionFns,
    );
    return BatchGetChannelResponse.fromJson(response);
  }

  /// Performs <a>GetStreamKey</a> on multiple ARNs simultaneously.
  ///
  /// Parameter [arns] :
  /// Array of ARNs, one per channel.
  Future<BatchGetStreamKeyResponse> batchGetStreamKey({
    required List<String> arns,
  }) async {
    ArgumentError.checkNotNull(arns, 'arns');
    final $payload = <String, dynamic>{
      'arns': arns,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/BatchGetStreamKey',
      exceptionFnMap: _exceptionFns,
    );
    return BatchGetStreamKeyResponse.fromJson(response);
  }

  /// Creates a new channel and an associated stream key to start streaming.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ServiceQuotaExceededException].
  /// May throw [PendingVerification].
  ///
  /// Parameter [authorized] :
  /// Whether the channel is authorized. Default: <code>false</code>.
  ///
  /// Parameter [latencyMode] :
  /// Channel latency mode. Default: <code>LOW</code>.
  ///
  /// Parameter [name] :
  /// Channel name.
  ///
  /// Parameter [tags] :
  /// See <a>Channel$tags</a>.
  ///
  /// Parameter [type] :
  /// Channel type, which determines the allowable resolution and bitrate. <i>If
  /// you exceed the allowable resolution or bitrate, the stream probably will
  /// disconnect immediately.</i> Valid values:
  ///
  /// <ul>
  /// <li>
  /// <code>STANDARD</code>: Multiple qualities are generated from the original
  /// input, to automatically give viewers the best experience for their devices
  /// and network conditions. Vertical resolution can be up to 1080 and bitrate
  /// can be up to 8.5 Mbps.
  /// </li>
  /// <li>
  /// <code>BASIC</code>: Amazon IVS delivers the original input to viewers. The
  /// viewer’s video-quality choice is limited to the original input. Vertical
  /// resolution can be up to 480 and bitrate can be up to 1.5 Mbps.
  /// </li>
  /// </ul>
  /// Default: <code>STANDARD</code>.
  Future<CreateChannelResponse> createChannel({
    bool? authorized,
    ChannelLatencyMode? latencyMode,
    String? name,
    Map<String, String>? tags,
    ChannelType? type,
  }) async {
    _s.validateStringLength(
      'name',
      name,
      0,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9-_]*$''',
    );
    final $payload = <String, dynamic>{
      if (authorized != null) 'authorized': authorized,
      if (latencyMode != null) 'latencyMode': latencyMode.toValue(),
      if (name != null) 'name': name,
      if (tags != null) 'tags': tags,
      if (type != null) 'type': type.toValue(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/CreateChannel',
      exceptionFnMap: _exceptionFns,
    );
    return CreateChannelResponse.fromJson(response);
  }

  /// Creates a stream key, used to initiate a stream, for the specified channel
  /// ARN.
  ///
  /// Note that <a>CreateChannel</a> creates a stream key. If you subsequently
  /// use CreateStreamKey on the same channel, it will fail because a stream key
  /// already exists and there is a limit of 1 stream key per channel. To reset
  /// the stream key on a channel, use <a>DeleteStreamKey</a> and then
  /// CreateStreamKey.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ServiceQuotaExceededException].
  /// May throw [PendingVerification].
  ///
  /// Parameter [channelArn] :
  /// ARN of the channel for which to create the stream key.
  ///
  /// Parameter [tags] :
  /// See <a>Channel$tags</a>.
  Future<CreateStreamKeyResponse> createStreamKey({
    required String channelArn,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(channelArn, 'channelArn');
    _s.validateStringLength(
      'channelArn',
      channelArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'channelArn',
      channelArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'channelArn': channelArn,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/CreateStreamKey',
      exceptionFnMap: _exceptionFns,
    );
    return CreateStreamKeyResponse.fromJson(response);
  }

  /// Deletes the specified channel and its associated stream keys.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ConflictException].
  /// May throw [PendingVerification].
  ///
  /// Parameter [arn] :
  /// ARN of the channel to be deleted.
  Future<void> deleteChannel({
    required String arn,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    _s.validateStringLength(
      'arn',
      arn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'arn',
      arn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'arn': arn,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/DeleteChannel',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a specified authorization key pair. This invalidates future viewer
  /// tokens generated using the key pair’s <code>privateKey</code>.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [PendingVerification].
  ///
  /// Parameter [arn] :
  /// ARN of the key pair to be deleted.
  Future<void> deletePlaybackKeyPair({
    required String arn,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    _s.validateStringLength(
      'arn',
      arn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'arn',
      arn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:playback-key/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'arn': arn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/DeletePlaybackKeyPair',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the stream key for the specified ARN, so it can no longer be used
  /// to stream.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [PendingVerification].
  ///
  /// Parameter [arn] :
  /// ARN of the stream key to be deleted.
  Future<void> deleteStreamKey({
    required String arn,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    _s.validateStringLength(
      'arn',
      arn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'arn',
      arn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:stream-key/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'arn': arn,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/DeleteStreamKey',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Gets the channel configuration for the specified channel ARN. See also
  /// <a>BatchGetChannel</a>.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [arn] :
  /// ARN of the channel for which the configuration is to be retrieved.
  Future<GetChannelResponse> getChannel({
    required String arn,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    _s.validateStringLength(
      'arn',
      arn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'arn',
      arn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'arn': arn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/GetChannel',
      exceptionFnMap: _exceptionFns,
    );
    return GetChannelResponse.fromJson(response);
  }

  /// Gets a specified playback authorization key pair and returns the
  /// <code>arn</code> and <code>fingerprint</code>. The <code>privateKey</code>
  /// held by the caller can be used to generate viewer authorization tokens, to
  /// grant viewers access to authorized channels.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [arn] :
  /// ARN of the key pair to be returned.
  Future<GetPlaybackKeyPairResponse> getPlaybackKeyPair({
    required String arn,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    _s.validateStringLength(
      'arn',
      arn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'arn',
      arn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:playback-key/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'arn': arn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/GetPlaybackKeyPair',
      exceptionFnMap: _exceptionFns,
    );
    return GetPlaybackKeyPairResponse.fromJson(response);
  }

  /// Gets information about the active (live) stream on a specified channel.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ChannelNotBroadcasting].
  ///
  /// Parameter [channelArn] :
  /// Channel ARN for stream to be accessed.
  Future<GetStreamResponse> getStream({
    required String channelArn,
  }) async {
    ArgumentError.checkNotNull(channelArn, 'channelArn');
    _s.validateStringLength(
      'channelArn',
      channelArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'channelArn',
      channelArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'channelArn': channelArn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/GetStream',
      exceptionFnMap: _exceptionFns,
    );
    return GetStreamResponse.fromJson(response);
  }

  /// Gets stream-key information for a specified ARN.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [arn] :
  /// ARN for the stream key to be retrieved.
  Future<GetStreamKeyResponse> getStreamKey({
    required String arn,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    _s.validateStringLength(
      'arn',
      arn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'arn',
      arn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:stream-key/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'arn': arn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/GetStreamKey',
      exceptionFnMap: _exceptionFns,
    );
    return GetStreamKeyResponse.fromJson(response);
  }

  /// Imports the public portion of a new key pair and returns its
  /// <code>arn</code> and <code>fingerprint</code>. The <code>privateKey</code>
  /// can then be used to generate viewer authorization tokens, to grant viewers
  /// access to authorized channels.
  ///
  /// May throw [ValidationException].
  /// May throw [ConflictException].
  /// May throw [AccessDeniedException].
  /// May throw [ServiceQuotaExceededException].
  /// May throw [PendingVerification].
  ///
  /// Parameter [publicKeyMaterial] :
  /// The public portion of a customer-generated key pair.
  ///
  /// Parameter [name] :
  /// An arbitrary string (a nickname) assigned to a playback key pair that
  /// helps the customer identify that resource. The value does not need to be
  /// unique.
  ///
  /// Parameter [tags] :
  /// Any tags provided with the request are added to the playback key pair
  /// tags.
  Future<ImportPlaybackKeyPairResponse> importPlaybackKeyPair({
    required String publicKeyMaterial,
    String? name,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(publicKeyMaterial, 'publicKeyMaterial');
    _s.validateStringLength(
      'name',
      name,
      0,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9-_]*$''',
    );
    final $payload = <String, dynamic>{
      'publicKeyMaterial': publicKeyMaterial,
      if (name != null) 'name': name,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/ImportPlaybackKeyPair',
      exceptionFnMap: _exceptionFns,
    );
    return ImportPlaybackKeyPairResponse.fromJson(response);
  }

  /// Gets summary information about all channels in your account, in the AWS
  /// region where the API request is processed. This list can be filtered to
  /// match a specified string.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  ///
  /// Parameter [filterByName] :
  /// Filters the channel list to match the specified name.
  ///
  /// Parameter [maxResults] :
  /// Maximum number of channels to return.
  ///
  /// Parameter [nextToken] :
  /// The first channel to retrieve. This is used for pagination; see the
  /// <code>nextToken</code> response field.
  Future<ListChannelsResponse> listChannels({
    String? filterByName,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateStringLength(
      'filterByName',
      filterByName,
      0,
      128,
    );
    _s.validateStringPattern(
      'filterByName',
      filterByName,
      r'''^[a-zA-Z0-9-_]*$''',
    );
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
      500,
    );
    final $payload = <String, dynamic>{
      if (filterByName != null) 'filterByName': filterByName,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/ListChannels',
      exceptionFnMap: _exceptionFns,
    );
    return ListChannelsResponse.fromJson(response);
  }

  /// Gets summary information about playback key pairs.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  ///
  /// Parameter [maxResults] :
  /// The first key pair to retrieve. This is used for pagination; see the
  /// <code>nextToken</code> response field.
  ///
  /// Parameter [nextToken] :
  /// Maximum number of key pairs to return.
  Future<ListPlaybackKeyPairsResponse> listPlaybackKeyPairs({
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
      500,
    );
    final $payload = <String, dynamic>{
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/ListPlaybackKeyPairs',
      exceptionFnMap: _exceptionFns,
    );
    return ListPlaybackKeyPairsResponse.fromJson(response);
  }

  /// Gets summary information about stream keys for the specified channel.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [channelArn] :
  /// Channel ARN used to filter the list.
  ///
  /// Parameter [maxResults] :
  /// Maximum number of streamKeys to return.
  ///
  /// Parameter [nextToken] :
  /// The first stream key to retrieve. This is used for pagination; see the
  /// <code>nextToken</code> response field.
  Future<ListStreamKeysResponse> listStreamKeys({
    required String channelArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(channelArn, 'channelArn');
    _s.validateStringLength(
      'channelArn',
      channelArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'channelArn',
      channelArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
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
      500,
    );
    final $payload = <String, dynamic>{
      'channelArn': channelArn,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/ListStreamKeys',
      exceptionFnMap: _exceptionFns,
    );
    return ListStreamKeysResponse.fromJson(response);
  }

  /// Gets summary information about live streams in your account, in the AWS
  /// region where the API request is processed.
  ///
  /// May throw [AccessDeniedException].
  ///
  /// Parameter [maxResults] :
  /// Maximum number of streams to return.
  ///
  /// Parameter [nextToken] :
  /// The first stream to retrieve. This is used for pagination; see the
  /// <code>nextToken</code> response field.
  Future<ListStreamsResponse> listStreams({
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
      500,
    );
    final $payload = <String, dynamic>{
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/ListStreams',
      exceptionFnMap: _exceptionFns,
    );
    return ListStreamsResponse.fromJson(response);
  }

  /// Gets information about AWS tags for the specified ARN.
  ///
  /// May throw [InternalServerException].
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [resourceArn] :
  /// The ARN of the resource to be retrieved.
  ///
  /// Parameter [maxResults] :
  /// Maximum number of tags to return.
  ///
  /// Parameter [nextToken] :
  /// The first tag to retrieve. This is used for pagination; see the
  /// <code>nextToken</code> response field.
  Future<ListTagsForResourceResponse> listTagsForResource({
    required String resourceArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'resourceArn',
      resourceArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:[a-z-]/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return ListTagsForResourceResponse.fromJson(response);
  }

  /// Inserts metadata into an RTMPS stream for the specified channel. A maximum
  /// of 5 requests per second per channel is allowed, each with a maximum 1KB
  /// payload.
  ///
  /// May throw [ThrottlingException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ChannelNotBroadcasting].
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  ///
  /// Parameter [channelArn] :
  /// ARN of the channel into which metadata is inserted. This channel must have
  /// an active stream.
  ///
  /// Parameter [metadata] :
  /// Metadata to insert into the stream. Maximum: 1 KB per request.
  Future<void> putMetadata({
    required String channelArn,
    required String metadata,
  }) async {
    ArgumentError.checkNotNull(channelArn, 'channelArn');
    _s.validateStringLength(
      'channelArn',
      channelArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'channelArn',
      channelArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    ArgumentError.checkNotNull(metadata, 'metadata');
    final $payload = <String, dynamic>{
      'channelArn': channelArn,
      'metadata': metadata,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/PutMetadata',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Disconnects the incoming RTMPS stream for the specified channel. Can be
  /// used in conjunction with <a>DeleteStreamKey</a> to prevent further
  /// streaming to a channel.
  /// <note>
  /// Many streaming client-software libraries automatically reconnect a dropped
  /// RTMPS session, so to stop the stream permanently, you may want to first
  /// revoke the <code>streamKey</code> attached to the channel.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [ChannelNotBroadcasting].
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [StreamUnavailable].
  ///
  /// Parameter [channelArn] :
  /// ARN of the channel for which the stream is to be stopped.
  Future<void> stopStream({
    required String channelArn,
  }) async {
    ArgumentError.checkNotNull(channelArn, 'channelArn');
    _s.validateStringLength(
      'channelArn',
      channelArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'channelArn',
      channelArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'channelArn': channelArn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/StopStream',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Adds or updates tags for the AWS resource with the specified ARN.
  ///
  /// May throw [InternalServerException].
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [resourceArn] :
  /// ARN of the resource for which tags are to be added or updated.
  ///
  /// Parameter [tags] :
  /// Array of tags to be added or updated.
  Future<void> tagResource({
    required String resourceArn,
    required Map<String, String> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'resourceArn',
      resourceArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:[a-z-]/[a-zA-Z0-9-]+$''',
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

  /// Removes tags from the resource with the specified ARN.
  ///
  /// May throw [InternalServerException].
  /// May throw [ValidationException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [resourceArn] :
  /// ARN of the resource for which tags are to be removed.
  ///
  /// Parameter [tagKeys] :
  /// Array of tags to be removed.
  Future<void> untagResource({
    required String resourceArn,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'resourceArn',
      resourceArn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:[a-z-]/[a-zA-Z0-9-]+$''',
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

  /// Updates a channel's configuration. This does not affect an ongoing stream
  /// of this channel. You must stop and restart the stream for the changes to
  /// take effect.
  ///
  /// May throw [ValidationException].
  /// May throw [AccessDeniedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ConflictException].
  /// May throw [PendingVerification].
  ///
  /// Parameter [arn] :
  /// ARN of the channel to be updated.
  ///
  /// Parameter [authorized] :
  /// Whether the channel is authorized. Default: <code>false</code>.
  ///
  /// Parameter [latencyMode] :
  /// Channel latency mode. Default: <code>LOW</code>.
  ///
  /// Parameter [name] :
  /// Channel name.
  ///
  /// Parameter [type] :
  /// Channel type, which determines the allowable resolution and bitrate. <i>If
  /// you exceed the allowable resolution or bitrate, the stream probably will
  /// disconnect immediately.</i> Valid values:
  ///
  /// <ul>
  /// <li>
  /// <code>STANDARD</code>: Multiple qualities are generated from the original
  /// input, to automatically give viewers the best experience for their devices
  /// and network conditions. Vertical resolution can be up to 1080 and bitrate
  /// can be up to 8.5 Mbps.
  /// </li>
  /// <li>
  /// <code>BASIC</code>: Amazon IVS delivers the original input to viewers. The
  /// viewer’s video-quality choice is limited to the original input. Vertical
  /// resolution can be up to 480 and bitrate can be up to 1.5 Mbps.
  /// </li>
  /// </ul>
  /// Default: <code>STANDARD</code>.
  Future<UpdateChannelResponse> updateChannel({
    required String arn,
    bool? authorized,
    ChannelLatencyMode? latencyMode,
    String? name,
    ChannelType? type,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    _s.validateStringLength(
      'arn',
      arn,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringPattern(
      'arn',
      arn,
      r'''^arn:aws:[is]vs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$''',
      isRequired: true,
    );
    _s.validateStringLength(
      'name',
      name,
      0,
      128,
    );
    _s.validateStringPattern(
      'name',
      name,
      r'''^[a-zA-Z0-9-_]*$''',
    );
    final $payload = <String, dynamic>{
      'arn': arn,
      if (authorized != null) 'authorized': authorized,
      if (latencyMode != null) 'latencyMode': latencyMode.toValue(),
      if (name != null) 'name': name,
      if (type != null) 'type': type.toValue(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/UpdateChannel',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateChannelResponse.fromJson(response);
  }
}

/// Error related to a specific channel, specified by its ARN.
class BatchError {
  /// Channel ARN.
  final String? arn;

  /// Error code.
  final String? code;

  /// Error message, determined by the application.
  final String? message;

  BatchError({
    this.arn,
    this.code,
    this.message,
  });
  factory BatchError.fromJson(Map<String, dynamic> json) {
    return BatchError(
      arn: json['arn'] as String?,
      code: json['code'] as String?,
      message: json['message'] as String?,
    );
  }
}

class BatchGetChannelResponse {
  final List<Channel>? channels;

  /// Each error object is related to a specific ARN in the request.
  final List<BatchError>? errors;

  BatchGetChannelResponse({
    this.channels,
    this.errors,
  });
  factory BatchGetChannelResponse.fromJson(Map<String, dynamic> json) {
    return BatchGetChannelResponse(
      channels: (json['channels'] as List?)
          ?.whereNotNull()
          .map((e) => Channel.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: (json['errors'] as List?)
          ?.whereNotNull()
          .map((e) => BatchError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BatchGetStreamKeyResponse {
  final List<BatchError>? errors;
  final List<StreamKey>? streamKeys;

  BatchGetStreamKeyResponse({
    this.errors,
    this.streamKeys,
  });
  factory BatchGetStreamKeyResponse.fromJson(Map<String, dynamic> json) {
    return BatchGetStreamKeyResponse(
      errors: (json['errors'] as List?)
          ?.whereNotNull()
          .map((e) => BatchError.fromJson(e as Map<String, dynamic>))
          .toList(),
      streamKeys: (json['streamKeys'] as List?)
          ?.whereNotNull()
          .map((e) => StreamKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Object specifying a channel.
class Channel {
  /// Channel ARN.
  final String? arn;

  /// Whether the channel is authorized.
  final bool? authorized;

  /// Channel ingest endpoint, part of the definition of an ingest server, used
  /// when you set up streaming software.
  final String? ingestEndpoint;

  /// Channel latency mode. Default: <code>LOW</code>.
  final ChannelLatencyMode? latencyMode;

  /// Channel name.
  final String? name;

  /// Channel playback URL.
  final String? playbackUrl;

  /// Array of 1-50 maps, each of the form <code>string:string (key:value)</code>.
  final Map<String, String>? tags;

  /// Channel type, which determines the allowable resolution and bitrate. <i>If
  /// you exceed the allowable resolution or bitrate, the stream probably will
  /// disconnect immediately.</i> Valid values:
  ///
  /// <ul>
  /// <li>
  /// <code>STANDARD</code>: Multiple qualities are generated from the original
  /// input, to automatically give viewers the best experience for their devices
  /// and network conditions. Vertical resolution can be up to 1080 and bitrate
  /// can be up to 8.5 Mbps.
  /// </li>
  /// <li>
  /// <code>BASIC</code>: Amazon IVS delivers the original input to viewers. The
  /// viewer’s video-quality choice is limited to the original input. Vertical
  /// resolution can be up to 480 and bitrate can be up to 1.5 Mbps.
  /// </li>
  /// </ul>
  /// Default: <code>STANDARD</code>.
  final ChannelType? type;

  Channel({
    this.arn,
    this.authorized,
    this.ingestEndpoint,
    this.latencyMode,
    this.name,
    this.playbackUrl,
    this.tags,
    this.type,
  });
  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      arn: json['arn'] as String?,
      authorized: json['authorized'] as bool?,
      ingestEndpoint: json['ingestEndpoint'] as String?,
      latencyMode: (json['latencyMode'] as String?)?.toChannelLatencyMode(),
      name: json['name'] as String?,
      playbackUrl: json['playbackUrl'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      type: (json['type'] as String?)?.toChannelType(),
    );
  }
}

enum ChannelLatencyMode {
  normal,
  low,
}

extension on ChannelLatencyMode {
  String toValue() {
    switch (this) {
      case ChannelLatencyMode.normal:
        return 'NORMAL';
      case ChannelLatencyMode.low:
        return 'LOW';
    }
  }
}

extension on String {
  ChannelLatencyMode toChannelLatencyMode() {
    switch (this) {
      case 'NORMAL':
        return ChannelLatencyMode.normal;
      case 'LOW':
        return ChannelLatencyMode.low;
    }
    throw Exception('$this is not known in enum ChannelLatencyMode');
  }
}

/// Summary information about a channel.
class ChannelSummary {
  /// Channel ARN.
  final String? arn;

  /// Whether the channel is authorized.
  final bool? authorized;

  /// Channel latency mode. Default: <code>LOW</code>.
  final ChannelLatencyMode? latencyMode;

  /// Channel name.
  final String? name;

  /// Array of 1-50 maps, each of the form <code>string:string (key:value)</code>.
  final Map<String, String>? tags;

  ChannelSummary({
    this.arn,
    this.authorized,
    this.latencyMode,
    this.name,
    this.tags,
  });
  factory ChannelSummary.fromJson(Map<String, dynamic> json) {
    return ChannelSummary(
      arn: json['arn'] as String?,
      authorized: json['authorized'] as bool?,
      latencyMode: (json['latencyMode'] as String?)?.toChannelLatencyMode(),
      name: json['name'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

enum ChannelType {
  basic,
  standard,
}

extension on ChannelType {
  String toValue() {
    switch (this) {
      case ChannelType.basic:
        return 'BASIC';
      case ChannelType.standard:
        return 'STANDARD';
    }
  }
}

extension on String {
  ChannelType toChannelType() {
    switch (this) {
      case 'BASIC':
        return ChannelType.basic;
      case 'STANDARD':
        return ChannelType.standard;
    }
    throw Exception('$this is not known in enum ChannelType');
  }
}

class CreateChannelResponse {
  final Channel? channel;
  final StreamKey? streamKey;

  CreateChannelResponse({
    this.channel,
    this.streamKey,
  });
  factory CreateChannelResponse.fromJson(Map<String, dynamic> json) {
    return CreateChannelResponse(
      channel: json['channel'] != null
          ? Channel.fromJson(json['channel'] as Map<String, dynamic>)
          : null,
      streamKey: json['streamKey'] != null
          ? StreamKey.fromJson(json['streamKey'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateStreamKeyResponse {
  /// Stream key used to authenticate an RTMPS stream for ingestion.
  final StreamKey? streamKey;

  CreateStreamKeyResponse({
    this.streamKey,
  });
  factory CreateStreamKeyResponse.fromJson(Map<String, dynamic> json) {
    return CreateStreamKeyResponse(
      streamKey: json['streamKey'] != null
          ? StreamKey.fromJson(json['streamKey'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DeletePlaybackKeyPairResponse {
  DeletePlaybackKeyPairResponse();
  factory DeletePlaybackKeyPairResponse.fromJson(Map<String, dynamic> _) {
    return DeletePlaybackKeyPairResponse();
  }
}

class GetChannelResponse {
  final Channel? channel;

  GetChannelResponse({
    this.channel,
  });
  factory GetChannelResponse.fromJson(Map<String, dynamic> json) {
    return GetChannelResponse(
      channel: json['channel'] != null
          ? Channel.fromJson(json['channel'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetPlaybackKeyPairResponse {
  final PlaybackKeyPair? keyPair;

  GetPlaybackKeyPairResponse({
    this.keyPair,
  });
  factory GetPlaybackKeyPairResponse.fromJson(Map<String, dynamic> json) {
    return GetPlaybackKeyPairResponse(
      keyPair: json['keyPair'] != null
          ? PlaybackKeyPair.fromJson(json['keyPair'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetStreamKeyResponse {
  final StreamKey? streamKey;

  GetStreamKeyResponse({
    this.streamKey,
  });
  factory GetStreamKeyResponse.fromJson(Map<String, dynamic> json) {
    return GetStreamKeyResponse(
      streamKey: json['streamKey'] != null
          ? StreamKey.fromJson(json['streamKey'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetStreamResponse {
  final Stream? stream;

  GetStreamResponse({
    this.stream,
  });
  factory GetStreamResponse.fromJson(Map<String, dynamic> json) {
    return GetStreamResponse(
      stream: json['stream'] != null
          ? Stream.fromJson(json['stream'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ImportPlaybackKeyPairResponse {
  final PlaybackKeyPair? keyPair;

  ImportPlaybackKeyPairResponse({
    this.keyPair,
  });
  factory ImportPlaybackKeyPairResponse.fromJson(Map<String, dynamic> json) {
    return ImportPlaybackKeyPairResponse(
      keyPair: json['keyPair'] != null
          ? PlaybackKeyPair.fromJson(json['keyPair'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ListChannelsResponse {
  /// List of the matching channels.
  final List<ChannelSummary> channels;

  /// If there are more channels than <code>maxResults</code>, use
  /// <code>nextToken</code> in the request to get the next set.
  final String? nextToken;

  ListChannelsResponse({
    required this.channels,
    this.nextToken,
  });
  factory ListChannelsResponse.fromJson(Map<String, dynamic> json) {
    return ListChannelsResponse(
      channels: (json['channels'] as List)
          .whereNotNull()
          .map((e) => ChannelSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class ListPlaybackKeyPairsResponse {
  /// List of key pairs.
  final List<PlaybackKeyPairSummary> keyPairs;

  /// If there are more key pairs than <code>maxResults</code>, use
  /// <code>nextToken</code> in the request to get the next set.
  final String? nextToken;

  ListPlaybackKeyPairsResponse({
    required this.keyPairs,
    this.nextToken,
  });
  factory ListPlaybackKeyPairsResponse.fromJson(Map<String, dynamic> json) {
    return ListPlaybackKeyPairsResponse(
      keyPairs: (json['keyPairs'] as List)
          .whereNotNull()
          .map(
              (e) => PlaybackKeyPairSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class ListStreamKeysResponse {
  /// List of stream keys.
  final List<StreamKeySummary> streamKeys;

  /// If there are more stream keys than <code>maxResults</code>, use
  /// <code>nextToken</code> in the request to get the next set.
  final String? nextToken;

  ListStreamKeysResponse({
    required this.streamKeys,
    this.nextToken,
  });
  factory ListStreamKeysResponse.fromJson(Map<String, dynamic> json) {
    return ListStreamKeysResponse(
      streamKeys: (json['streamKeys'] as List)
          .whereNotNull()
          .map((e) => StreamKeySummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class ListStreamsResponse {
  /// List of streams.
  final List<StreamSummary> streams;

  /// If there are more streams than <code>maxResults</code>, use
  /// <code>nextToken</code> in the request to get the next set.
  final String? nextToken;

  ListStreamsResponse({
    required this.streams,
    this.nextToken,
  });
  factory ListStreamsResponse.fromJson(Map<String, dynamic> json) {
    return ListStreamsResponse(
      streams: (json['streams'] as List)
          .whereNotNull()
          .map((e) => StreamSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class ListTagsForResourceResponse {
  final Map<String, String> tags;

  /// If there are more tags than <code>maxResults</code>, use
  /// <code>nextToken</code> in the request to get the next set.
  final String? nextToken;

  ListTagsForResourceResponse({
    required this.tags,
    this.nextToken,
  });
  factory ListTagsForResourceResponse.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResponse(
      tags: (json['tags'] as Map<String, dynamic>)
          .map((k, e) => MapEntry(k, e as String)),
      nextToken: json['nextToken'] as String?,
    );
  }
}

/// A key pair used to sign and validate a playback authorization token.
class PlaybackKeyPair {
  /// Key-pair ARN.
  final String? arn;

  /// Key-pair identifier.
  final String? fingerprint;

  /// Key-pair name.
  final String? name;

  /// Array of 1-50 maps, each of the form <code>string:string (key:value)</code>.
  final Map<String, String>? tags;

  PlaybackKeyPair({
    this.arn,
    this.fingerprint,
    this.name,
    this.tags,
  });
  factory PlaybackKeyPair.fromJson(Map<String, dynamic> json) {
    return PlaybackKeyPair(
      arn: json['arn'] as String?,
      fingerprint: json['fingerprint'] as String?,
      name: json['name'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// Summary information about a playback key pair.
class PlaybackKeyPairSummary {
  /// Key-pair ARN.
  final String? arn;

  /// Key-pair name.
  final String? name;

  /// Array of 1-50 maps, each of the form <code>string:string (key:value)</code>
  final Map<String, String>? tags;

  PlaybackKeyPairSummary({
    this.arn,
    this.name,
    this.tags,
  });
  factory PlaybackKeyPairSummary.fromJson(Map<String, dynamic> json) {
    return PlaybackKeyPairSummary(
      arn: json['arn'] as String?,
      name: json['name'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class StopStreamResponse {
  StopStreamResponse();
  factory StopStreamResponse.fromJson(Map<String, dynamic> _) {
    return StopStreamResponse();
  }
}

/// Specifies a live video stream that has been ingested and distributed.
class Stream {
  /// Channel ARN for the stream.
  final String? channelArn;

  /// The stream’s health.
  final StreamHealth? health;

  /// URL of the video master manifest, required by the video player to play the
  /// HLS stream.
  final String? playbackUrl;

  /// ISO-8601 formatted timestamp of the stream’s start.
  final DateTime? startTime;

  /// The stream’s state.
  final StreamState? state;

  /// Number of current viewers of the stream.
  final int? viewerCount;

  Stream({
    this.channelArn,
    this.health,
    this.playbackUrl,
    this.startTime,
    this.state,
    this.viewerCount,
  });
  factory Stream.fromJson(Map<String, dynamic> json) {
    return Stream(
      channelArn: json['channelArn'] as String?,
      health: (json['health'] as String?)?.toStreamHealth(),
      playbackUrl: json['playbackUrl'] as String?,
      startTime: timeStampFromJson(json['startTime']),
      state: (json['state'] as String?)?.toStreamState(),
      viewerCount: json['viewerCount'] as int?,
    );
  }
}

enum StreamHealth {
  healthy,
  starving,
  unknown,
}

extension on StreamHealth {
  String toValue() {
    switch (this) {
      case StreamHealth.healthy:
        return 'HEALTHY';
      case StreamHealth.starving:
        return 'STARVING';
      case StreamHealth.unknown:
        return 'UNKNOWN';
    }
  }
}

extension on String {
  StreamHealth toStreamHealth() {
    switch (this) {
      case 'HEALTHY':
        return StreamHealth.healthy;
      case 'STARVING':
        return StreamHealth.starving;
      case 'UNKNOWN':
        return StreamHealth.unknown;
    }
    throw Exception('$this is not known in enum StreamHealth');
  }
}

/// Object specifying a stream key.
class StreamKey {
  /// Stream-key ARN.
  final String? arn;

  /// Channel ARN for the stream.
  final String? channelArn;

  /// Array of 1-50 maps, each of the form <code>string:string (key:value)</code>.
  final Map<String, String>? tags;

  /// Stream-key value.
  final String? value;

  StreamKey({
    this.arn,
    this.channelArn,
    this.tags,
    this.value,
  });
  factory StreamKey.fromJson(Map<String, dynamic> json) {
    return StreamKey(
      arn: json['arn'] as String?,
      channelArn: json['channelArn'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      value: json['value'] as String?,
    );
  }
}

/// Summary information about a stream key.
class StreamKeySummary {
  /// Stream-key ARN.
  final String? arn;

  /// Channel ARN for the stream.
  final String? channelArn;

  /// Array of 1-50 maps, each of the form <code>string:string (key:value)</code>.
  final Map<String, String>? tags;

  StreamKeySummary({
    this.arn,
    this.channelArn,
    this.tags,
  });
  factory StreamKeySummary.fromJson(Map<String, dynamic> json) {
    return StreamKeySummary(
      arn: json['arn'] as String?,
      channelArn: json['channelArn'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

enum StreamState {
  live,
  offline,
}

extension on StreamState {
  String toValue() {
    switch (this) {
      case StreamState.live:
        return 'LIVE';
      case StreamState.offline:
        return 'OFFLINE';
    }
  }
}

extension on String {
  StreamState toStreamState() {
    switch (this) {
      case 'LIVE':
        return StreamState.live;
      case 'OFFLINE':
        return StreamState.offline;
    }
    throw Exception('$this is not known in enum StreamState');
  }
}

/// Summary information about a stream.
class StreamSummary {
  /// Channel ARN for the stream.
  final String? channelArn;

  /// The stream’s health.
  final StreamHealth? health;

  /// ISO-8601 formatted timestamp of the stream’s start.
  final DateTime? startTime;

  /// The stream’s state.
  final StreamState? state;

  /// Number of current viewers of the stream.
  final int? viewerCount;

  StreamSummary({
    this.channelArn,
    this.health,
    this.startTime,
    this.state,
    this.viewerCount,
  });
  factory StreamSummary.fromJson(Map<String, dynamic> json) {
    return StreamSummary(
      channelArn: json['channelArn'] as String?,
      health: (json['health'] as String?)?.toStreamHealth(),
      startTime: timeStampFromJson(json['startTime']),
      state: (json['state'] as String?)?.toStreamState(),
      viewerCount: json['viewerCount'] as int?,
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

class UpdateChannelResponse {
  final Channel? channel;

  UpdateChannelResponse({
    this.channel,
  });
  factory UpdateChannelResponse.fromJson(Map<String, dynamic> json) {
    return UpdateChannelResponse(
      channel: json['channel'] != null
          ? Channel.fromJson(json['channel'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AccessDeniedException extends _s.GenericAwsException {
  AccessDeniedException({String? type, String? message})
      : super(type: type, code: 'AccessDeniedException', message: message);
}

class ChannelNotBroadcasting extends _s.GenericAwsException {
  ChannelNotBroadcasting({String? type, String? message})
      : super(type: type, code: 'ChannelNotBroadcasting', message: message);
}

class ConflictException extends _s.GenericAwsException {
  ConflictException({String? type, String? message})
      : super(type: type, code: 'ConflictException', message: message);
}

class InternalServerException extends _s.GenericAwsException {
  InternalServerException({String? type, String? message})
      : super(type: type, code: 'InternalServerException', message: message);
}

class PendingVerification extends _s.GenericAwsException {
  PendingVerification({String? type, String? message})
      : super(type: type, code: 'PendingVerification', message: message);
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

class StreamUnavailable extends _s.GenericAwsException {
  StreamUnavailable({String? type, String? message})
      : super(type: type, code: 'StreamUnavailable', message: message);
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
  'ChannelNotBroadcasting': (type, message) =>
      ChannelNotBroadcasting(type: type, message: message),
  'ConflictException': (type, message) =>
      ConflictException(type: type, message: message),
  'InternalServerException': (type, message) =>
      InternalServerException(type: type, message: message),
  'PendingVerification': (type, message) =>
      PendingVerification(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ServiceQuotaExceededException': (type, message) =>
      ServiceQuotaExceededException(type: type, message: message),
  'StreamUnavailable': (type, message) =>
      StreamUnavailable(type: type, message: message),
  'ThrottlingException': (type, message) =>
      ThrottlingException(type: type, message: message),
  'ValidationException': (type, message) =>
      ValidationException(type: type, message: message),
};
