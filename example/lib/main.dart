import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
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
                    Tiktok.share([result.files.single.path!]);
                  }
                },
                child: const Text("share to tiktok"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                  await FilePicker.platform.pickFiles();

                  if (result != null) {
                    SnapChat.shareAsSticker(
                        clintID: "e40a41de-7196-42b1-a454-e96bff26a61a",
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
            ],
          ),
        ),
      ),
    );
  }
}
