import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'social_sharing_method_channel.dart';

abstract class SocialSharingPlatform extends PlatformInterface {
  /// Constructs a SocialSharingPlatform.
  SocialSharingPlatform() : super(token: _token);

  static final Object _token = Object();

  static SocialSharingPlatform _instance = MethodChannelSocialSharing();

  /// The default instance of [SocialSharingPlatform] to use.
  ///
  /// Defaults to [MethodChannelSocialSharing].
  static SocialSharingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SocialSharingPlatform] when
  /// they register themselves.
  static set instance(SocialSharingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
