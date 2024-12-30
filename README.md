# social_sharing

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# social_manager

A new Flutter project.



you need to request permission as this
status = await Permission.photos.request();

and add this in manifiest
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.WRITE_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

android configration in manifiest

        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths_app" />
        </provider>

and create  file in res/xml folder called provider_paths_app.xml and add this

<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-path name="external_files" path="." />
</paths>


you must add  im manifest

    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
        <package android:name="com.snapchat.android" />

    </queries>


donot forget to add your app id in snapchat account 
to use add

for ios
add

<key>LSApplicationQueriesSchemes</key>
<array>
<string>tiktokopensdk</string>
<string>tiktoksharesdk</string>
<string>snssdk1180</string>
<string>snssdk1233</string>
<string>snapchat</string>
<string>bitmoji-sdk</string>
<string>itms-apps</string>
<string>instagram</string>
<string>instagram-stories</string>
<string>musically</string>
</array>

	<key>UIFileSharingEnabled</key>
	<true/>
	<key>TikTokClientKey</key>
	<string>your tiktok client key</string>
	<key>LSSupportsOpeningDocumentsInPlace</key>
	<true/>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>i need to access library because my core logic depend on that user can share his files to anther apps</string>

    <key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>your tiktok client key</string>
    </array>
  </dict>
</array>