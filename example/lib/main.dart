import 'dart:io';

import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:social_sharing/social/airdrop.dart';
import 'package:social_sharing/social/instgram.dart';
import 'package:social_sharing/social/snapchat.dart';
import 'package:social_sharing/social/tiktok.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _requestPermission();
    super.initState();
  }

  _requestPermission() async {
    late PermissionStatus status;

    status = await Permission.photos.status;
    //  PermissionStatus status1 = await Permission.videos.status;

    if (status.isGranted) {
      return;
    } else {
      status = await Permission.photos.request();
      if (status.isGranted) {
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('social share example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    SnapChat.share(
                        clintID: "e40a41de-7196-42b1-a454-e96bff26a61a",
                        files: [result.files.single.path!]);
                  }
                },
                child: const Text("share to snapchat"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    final fileType = determineFileType(
                        result.files.map((file) => file.extension).toList());
                    if (fileType == null) return;
                    Tiktok.shareToTikTokMultiFiles(
                        files: result.files.map((file) => file.path!).toList(),
                        filesType: fileType,
                        redirectUrl: "yourapp://tiktok-share");
                  }
                },
                child: const Text("share to tiktok"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    final fileType = determineFileType(
                        result.files.map((file) => file.extension).toList());
                    if (fileType == null) return;
                    Tiktok.shareToTikTokMultiFiles1(
                        files: result.files.map((file) => file.path!).toList(),
                        filesType: fileType,
                        redirectUrl: "yourapp://tiktok-share");
                  }
                },
                child: const Text("share to tiktok"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    final fileType = determineFileType(
                        result.files.map((file) => file.extension).toList());
                    if (fileType == null) return;
                    Tiktok.shareToTiktokOneFile(
                        file: result.files.single.path!,
                        filesType: fileType,
                        redirectUrl: "yourapp://tiktok-share");
                  }
                },
                child: const Text("share to tiktok"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  String clintId = "";

                  /// add you clint id here
                  if (result != null) {
                    SnapChat.shareAsSticker(
                        clintID: clintId,
                        stickerPath: result.files.single.path!);
                  }
                },
                child: const Text("share to snapchat as sticker"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    Instagram.share([result.files.single.path!]);
                  }
                },
                child: const Text("share to instagram"),
              ),
              if (Platform.isIOS)
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      AirDrop.share("sharing this text");
                    }
                  },
                  child: const Text("share to airDrop"),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String? determineFileType(List<String?> fileExtensions) {
    // Supported extensions for images and videos
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    final videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'flv', 'wmv'];

    bool hasImage = false;
    bool hasVideo = false;

    for (var extension in fileExtensions) {
      if (extension == null) continue; // Skip null extensions
      final ext = extension.toLowerCase();

      if (imageExtensions.contains(ext)) {
        hasImage = true;
      } else if (videoExtensions.contains(ext)) {
        hasVideo = true;
      }
    }

    // Return the result based on what types were found
    if (hasImage && !hasVideo) {
      return 'image';
    } else if (hasVideo && !hasImage) {
      return 'video';
    }
    return null;
  }
}
