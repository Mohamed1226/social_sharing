import Flutter
import UIKit
import TikTokOpenSDKCore
import TikTokOpenShareSDK
import UniformTypeIdentifiers

public class SocialSharingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "social_sharing", binaryMessenger: registrar.messenger())
    let instance = SocialSharingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            switch call.method {
            case "addStickerToSnapchat":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.addStickerToSnapchat(args: args, result: result)

            case "launchSnapchatPreviewWithImage":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.launchSnapchatPreviewWithImage(args: args, result: result)

            case "launchSnapchatPreviewWithVideo":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.launchSnapchatPreviewWithVideo(args: args, result: result)

            case "launchSnapchatCamera":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.launchSnapchatCamera(args: args, result: result)

            case "launchSnapchatCameraWithLens":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.launchSnapchatCameraWithLens(args: args, result: result)

            case "launchSnapchatPreviewWithMultipleFiles":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.launchSnapchatPreviewWithMultipleFiles(args: args, result: result)

            case "shareToTiktok":
                guard let args = call.arguments as? [String: Any] else {return result(FlutterError(code: "INVALID_ARGUMENT", message: "File paths required", details: nil)) }
                self?.shareToTikTok(args: args, result : result)



            case "shareToInstagram":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.shareToInstagram(args: args, result: result)

            case "airdropShareText":
                guard let args = call.arguments as? [String: Any] else { return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil)) }
                self?.airdropShareText(args: args, result: result)


    default:
      result(FlutterMethodNotImplemented)
    }
  }

      private func addStickerToSnapchat(args: [String: Any], result: @escaping FlutterResult) {
          guard let stickerPath = args["stickerPath"] as? String,
                let posX = args["posX"] as? Double,
                let clientId = args["clientId"] as? String,
                let posY = args["posY"] as? Double,
                let rotation = args["rotation"] as? Double,
                let widthDp = args["widthDp"] as? Int,
                let heightDp = args["heightDp"] as? Int else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
          }

          guard let imageData = UIImage(contentsOfFile: stickerPath)?.jpegData(compressionQuality: 1.0) else {
              return result(FlutterError(code: "FILE_NOT_FOUND", message: "Sticker file not found", details: nil))
          }

          let sticker = StickerData(posX: posX, posY: posY, rotation: rotation, widthDp: widthDp, heightDp: heightDp, image: imageData)
          shareToCamera(clientID: clientId, caption: nil, sticker: sticker)
          result(nil)
      }

      private func launchSnapchatPreviewWithImage(args: [String: Any], result: @escaping FlutterResult) {
          guard let filePath = args["filePath"] as? String,
                let clientId = args["clientId"] as? String,
                let caption = args["caption"] as? String else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
          }

          guard let imageData = UIImage(contentsOfFile: filePath)?.jpegData(compressionQuality: 1.0) else {
              return result(FlutterError(code: "FILE_NOT_FOUND", message: "Image file not found", details: nil))
          }

          shareToPreview(clientID: clientId, mediaType: .image, mediaData: imageData, caption: caption, sticker: nil)
          result(nil)
      }

      private func launchSnapchatPreviewWithVideo(args: [String: Any], result: @escaping FlutterResult) {
          guard let filePath = args["filePath"] as? String,
                let clientId = args["clientId"] as? String,
                let caption = args["caption"] as? String else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
          }

          guard let videoData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
              return result(FlutterError(code: "FILE_NOT_FOUND", message: "Video file not found", details: nil))
          }

          shareToPreview(clientID: clientId, mediaType: .video, mediaData: videoData, caption: caption, sticker: nil)
          result(nil)
      }

      private func launchSnapchatCamera(args: [String: Any], result: @escaping FlutterResult) {
          guard let clientId = args["clientId"] as? String,
                let caption = args["caption"] as? String,
                let appName = args["appName"] as? String else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
          }

          shareToCamera(clientID: clientId, caption: caption, sticker: nil)
          result(nil)
      }

      private func launchSnapchatCameraWithLens(args: [String: Any], result: @escaping FlutterResult) {
          guard let lensUUID = args["lensUUID"] as? String,
                let clientId = args["clientId"] as? String,
                let launchData = args["launchData"] as? [String: String] else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
          }

          shareDynamicLenses(clientID: clientId, lensUUID: lensUUID, launchData: launchData as NSDictionary, caption: nil, sticker: nil)
          result(nil)
      }



      private func shareToInstagram(args: [String: Any], result: @escaping FlutterResult) {
          guard let filePaths = args["filePaths"] as? [String] else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
          }

          var items: [[String: Any]] = []

          // Iterate through each file path and add to the items array
          for filePath in filePaths {
              let fileURL = URL(fileURLWithPath: filePath)
              let fileExtension = fileURL.pathExtension.lowercased()

              if fileExtension == "mp4" || fileExtension == "mov" || fileExtension == "jpg" || fileExtension == "jpeg" || fileExtension == "png" {
                  // Add the URL to the items array
                  items.append(["com.instagram.exclusivegramstory": fileURL])
              } else {
                  return result(FlutterError(code: "INVALID_FILE_TYPE", message: "Unsupported file type: \(filePath)", details: nil))
              }
          }

          // Set the items into the UIPasteboard
          UIPasteboard.general.setItems(items, options: [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)]) // Expire in 5 minutes

          // Create the Instagram Stories URL and open it
          guard let instagramURL = URL(string: "instagram-stories://share"),
                UIApplication.shared.canOpenURL(instagramURL) else {
              return result(FlutterError(code: "INSTAGRAM_NOT_INSTALLED", message: "Instagram is not installed on this device", details: nil))
          }

          UIApplication.shared.open(instagramURL, options: [:]) { success in
              if success {
                  result(nil)
              } else {
                  result(FlutterError(code: "OPEN_URL_FAILED", message: "Failed to open Instagram", details: nil))
              }
          }
      }







      private func shareToTikTok(args: [String: Any], result: @escaping FlutterResult) {
          guard let filePaths = args["filePaths"] as? [String] else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
          }

          let localIdentifiers = filePaths.map { URL(fileURLWithPath: $0).absoluteString }

          guard !localIdentifiers.isEmpty else {
              return result(FlutterError(code: "FILES_NOT_FOUND", message: "None of the files exist", details: nil))
          }

          let shareRequest = TikTokShareRequest(localIdentifiers: localIdentifiers,
                                                mediaType: .video,
                                                redirectURI: "")
          shareRequest.send { response in
              guard let shareResponse = response as? TikTokShareResponse else {
                  return result(FlutterError(code: "TIKTOK_SHARE_FAILED", message: "Failed to share to TikTok", details: nil))
              }

              if shareResponse.errorCode == .noError {
                  result(nil)
              } else {
                  result(FlutterError(code: "TIKTOK_SHARE_FAILED", message: "Share failed", details: shareResponse.errorDescription))
              }
          }
      }



      private func airdropShareText(args: [String: Any], result: @escaping FlutterResult) {
          guard let text = args["text"] as? String else {
              return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
          }

          guard let rootViewController = window?.rootViewController else {
              result(FlutterError(code: "NO_VIEW_CONTROLLER", message: "Root view controller not found", details: nil))
              return
          }

          let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
          activityController.popoverPresentationController?.sourceView = rootViewController.view

          rootViewController.present(activityController, animated: true) {
              result(nil) // Success
          }
      }



  private func launchSnapchatPreviewWithMultipleFiles(args: [String: Any], result: @escaping FlutterResult) {
      guard let filePaths = args["filePaths"] as? [String],
            let clientId = args["clientId"] as? String else {
          return result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
      }

      var items: [[String: Any]] = []

      // Iterate through each file path and add to the items array
      for filePath in filePaths {
          let fileURL = URL(fileURLWithPath: filePath)
          let fileExtension = fileURL.pathExtension.lowercased()

          if fileExtension == "mp4" || fileExtension == "mov" {
              // Add video data
              guard let videoData = try? Data(contentsOf: fileURL) else {
                  return result(FlutterError(code: "FILE_NOT_FOUND", message: "Video file not found: \(filePath)", details: nil))
              }
              items.append([CreativeKitLiteKeys.backgroundVideo: videoData])
          } else if fileExtension == "jpg" || fileExtension == "jpeg" || fileExtension == "png" {
              // Add image data
              guard let imageData = UIImage(contentsOfFile: filePath)?.jpegData(compressionQuality: 1.0) else {
                  return result(FlutterError(code: "FILE_NOT_FOUND", message: "Image file not found: \(filePath)", details: nil))
              }
              items.append([CreativeKitLiteKeys.backgroundImage: imageData])
          } else {
              return result(FlutterError(code: "INVALID_FILE_TYPE", message: "Unsupported file type: \(filePath)", details: nil))
          }
      }

      // Combine all items into the clipboard dictionary
      var dict: [String: Any] = [
          CreativeKitLiteKeys.clientID: clientId
      ]

      // Add all media items to the dictionary
      for item in items {
          dict.merge(item) { (_, new) in new }
      }

      // Set the items into the UIPasteboard
      UIPasteboard.general.setItems([dict], options: [
          UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300) // Expire in 5 minutes
      ])

      // Create the Snapchat URL and open it
      guard let snapchatURL = URL(string: ShareDestination.preview.rawValue),
            UIApplication.shared.canOpenURL(snapchatURL) else {
          return result(FlutterError(code: "SNAPCHAT_NOT_INSTALLED", message: "Snapchat is not installed on this device", details: nil))
      }

      UIApplication.shared.open(snapchatURL, options: [:]) { success in
          if success {
              result(nil)
          } else {
              result(FlutterError(code: "OPEN_URL_FAILED", message: "Failed to open Snapchat", details: nil))
          }
      }
  }
}
