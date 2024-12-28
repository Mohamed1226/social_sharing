import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'social_sharing_platform_interface.dart';

/// An implementation of [SocialSharingPlatform] that uses method channels.
class MethodChannelSocialSharing extends SocialSharingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('social_sharing');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
