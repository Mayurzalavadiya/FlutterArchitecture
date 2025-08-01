import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../permissions.dart';
import 'mediaAction.dart';

class MediaPicker {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickMedia({
    required BuildContext context,
    required MediaAction action,
    required Function(List<String> paths) onSelected,
    required Function(String message) onFail,
    bool crop = false,
    bool allowMultiple = false,
  }) async {
    try {
      switch (action) {
        case MediaAction.imageFromCamera:
          if (!await Permissions.requestCameraPermission(context)) return;
          final image = await _picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            final cropped = crop ? await _cropImage(image.path) : image.path;
            final compressed = await _compressImage(cropped);
            if (compressed != null) onSelected([compressed]);
          } else {
            onFail("No image captured.");
          }
          break;

        case MediaAction.imageFromGallery:
          if (!await Permissions.requestStoragePermission(context)) return;
          List<XFile>? images;
          if (allowMultiple) {
            images = await _picker.pickMultiImage();
          } else {
            final image = await _picker.pickImage(source: ImageSource.gallery);
            if (image != null) images = [image];
          }

          if (images != null && images.isNotEmpty) {
            List<String> paths = [];
            for (var image in images) {
              final cropped = crop ? await _cropImage(image.path) : image.path;
              final compressed = await _compressImage(cropped);
              if (compressed != null) paths.add(compressed);
            }
            onSelected(paths);
          } else {
            onFail("No image selected.");
          }

          break;

        case MediaAction.videoFromCamera:
          if (!await Permissions.requestCameraPermission(context)) return;
          final video = await _picker.pickVideo(source: ImageSource.camera,
              maxDuration: const Duration(seconds: 60));
          if (video == null) {
            onFail("Invalid or no video captured.");
          } else if (!await _isVideoDurationValid(video.path)) {
            onFail("Video duration cannot exceed 1 minute.");
          } else {
            onSelected([video.path]);
          }

          break;

        case MediaAction.videoFromGallery:
          if (!await Permissions.requestStoragePermission(context)) return;
          final video = await _picker.pickVideo(source: ImageSource.gallery);
          if (video == null) {
            onFail("Invalid or no video captured.");
          } else if (!await _isVideoDurationValid(video.path)) {
            onFail("Video duration cannot exceed 1 minute.");
          } else {
            onSelected([video.path]);
          }

          break;

        case MediaAction.selectDocument:
          if (!await Permissions.requestStoragePermission(context)) return;
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['pdf'], ///< e.g. ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
          );
          final paths = result?.paths.whereType<String>().toList() ?? [];
          if (paths.isNotEmpty) {
            onSelected(paths);
          } else {
            onFail("No document selected.");
          }
          break;
      }
    } catch (e) {
      onFail(e.toString());
    }
  }

  Future<String?> _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.original,
          ],
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );
    return croppedFile?.path;
  }

  Future<String?> _compressImage(String? imagePath) async {
    if (imagePath == null) return null;
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.path}/${DateTime
        .now()
        .millisecondsSinceEpoch}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      targetPath,
      quality: 85,
    );
    return result?.path;
  }

  Future<bool> _isVideoDurationValid(String path) async {
    final videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController.initialize();
    final duration = videoPlayerController.value.duration;
    await videoPlayerController.dispose();
    return duration.inSeconds <= 60;
  }
}


/// USAGE:
///
///  String? _selectedImagePath;
///   String? _selectedVideoPath;
///   List<String> _selectedDocuments = [];
///
///   final picker = MediaPicker();
///   VideoPlayerController? _videoController;
///
///  imageVideoPickerDialog(
///     context: context,
///     showImage: true,
///     onActionSelected: _handlePick,
///    );
///
///  void _handlePick(MediaAction action) {
///     picker.pickMedia(
///       context: context,
///       action: action,
///       onSelected: (paths) async {
///         setState(() {
///           if (action == MediaAction.imageFromCamera || action == MediaAction.imageFromGallery) {
///             _selectedImagePath = paths.first;
///           } else if (action == MediaAction.videoFromCamera || action == MediaAction.videoFromGallery) {
///             _selectedVideoPath = paths.first;
///           } else if (action == MediaAction.selectDocument) {
///             _selectedDocuments = paths;
///           }
///         });
///
///         if (action == MediaAction.videoFromCamera || action == MediaAction.videoFromGallery) {
///           _videoController?.dispose();
///           _videoController = VideoPlayerController.file(File(paths.first))
///             ..initialize().then((_) => setState(() {}));
///         }
///       },
///       onFail: (error) {
///         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
///       },
///     );
///   }