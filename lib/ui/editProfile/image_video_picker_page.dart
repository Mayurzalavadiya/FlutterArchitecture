import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/utils/imagevideopicker/image_video_picker_dialog.dart';
import 'package:my_first_app/utils/imagevideopicker/image_video_picker.dart';
import 'package:my_first_app/utils/imagevideopicker/mediaAction.dart';
import 'package:my_first_app/values/colors.dart';
import 'package:my_first_app/widget/show_message.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class ImageVideoPickerPage extends StatefulWidget {
  const ImageVideoPickerPage({super.key});

  @override
  State<ImageVideoPickerPage> createState() => _ImageVideoPickerPageState();
}

class _ImageVideoPickerPageState extends State<ImageVideoPickerPage> {
  List<String> _selectedImagePath = [];
  List<String> _selectedVideoPath = [];
  List<String> _selectedDocuments = [];

  final picker = MediaPicker();
  VideoPlayerController? _videoController;

  void _handlePick(MediaAction action) {
    picker.pickMedia(
      context: context,
      action: action,
      allowMultiple: true,
      onSelected: (paths) async {
        setState(() {
          if (action == MediaAction.imageFromCamera ||
              action == MediaAction.imageFromGallery) {
            _selectedImagePath = paths;
          } else if (action == MediaAction.videoFromCamera ||
              action == MediaAction.videoFromGallery) {
            _selectedVideoPath = paths;
          } else if (action == MediaAction.selectDocument) {
            _selectedDocuments = paths;
          }
        });

        if (action == MediaAction.videoFromCamera ||
            action == MediaAction.videoFromGallery) {
          _videoController?.dispose();
          _videoController = VideoPlayerController.file(File(paths.first))
            ..initialize().then((_) {
              setState(() {}); // Refresh UI after initialization

              // Add listener to detect video end
              _videoController!.addListener(() {
                final controller = _videoController!;
                final isEnded =
                    controller.value.position >= controller.value.duration;

                if (isEnded) {
                  setState(() {}); // refresh to update icon
                }
              });
            });
        }
      },
      onFail: (error) {
        showCustomToast(
          textColor: AppColor.white,
          context,
          // backgroundColor: AppColor.red.withOpacity(0.5),
          message: error,
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignInside,
            width: 2,
            color: AppColor.teal,
          ),
          gradient: LinearGradient(colors: [Colors.red, Colors.black38]),
        );
      },
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Media Picker")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  imageVideoPickerDialog(
                    context: context,
                    showImage: true,
                    onActionSelected: _handlePick,
                  );
                },
                child: const Text("Pick Image"),
              ),
              if (_selectedImagePath.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Selected Images:"),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _selectedImagePath.map((path) {
                      return Image.file(
                        File(path),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  ),
                ),
              ],


              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  imageVideoPickerDialog(
                    context: context,
                    showVideo: true,
                    onActionSelected: _handlePick,
                  );
                },
                child: const Text("Pick Video"),
              ),
              if (_selectedVideoPath.isNotEmpty &&
                  _videoController?.value.isInitialized == true)
                Stack(
                  children: [
                    const SizedBox(height: 16),
                    AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: Icon(
                          _videoController!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: AppColor.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _videoController!.value.isPlaying
                                ? _videoController!.pause()
                                : _videoController!.play();
                          });
                        },
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  imageVideoPickerDialog(
                    context: context,
                    showDocument: true,
                    onActionSelected: _handlePick,
                  );
                },
                child: const Text("Pick Document"),
              ),
              if (_selectedDocuments.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text("Selected Documents:"),
                ..._selectedDocuments.map(
                  (doc) => ListTile(
                    title: Text(doc.split('/').last),
                    subtitle: Text(doc),
                    leading: const Icon(Icons.insert_drive_file),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
