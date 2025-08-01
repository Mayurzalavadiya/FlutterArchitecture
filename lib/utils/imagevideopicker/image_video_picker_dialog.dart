import 'package:flutter/material.dart';

import 'mediaAction.dart';

/// Displays a bottom sheet with media picking options.
void imageVideoPickerDialog ({
  required BuildContext context,
  bool showImage = false,
  bool showVideo = false,
  bool showDocument = false,
  required void Function(MediaAction action) onActionSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            if (showImage) ...[
              const Text(
                "Select Photo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _OptionItem(
                    icon: Icons.camera_alt,
                    label: "Take Photo",
                    onTap: () => onActionSelected(MediaAction.imageFromCamera),
                  ),
                  // const SizedBox(width: 24),
                  _OptionItem(
                    icon: Icons.photo_library,
                    label: "From Gallery",
                    onTap: () => onActionSelected(MediaAction.imageFromGallery),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            if (showVideo) ...[
              const Text(
                "Select Video",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _OptionItem(
                    icon: Icons.videocam,
                    label: "Take Video",
                    onTap: () => onActionSelected(MediaAction.videoFromCamera),
                  ),
                  // const SizedBox(width: 24),
                  _OptionItem(
                    icon: Icons.video_library,
                    label: "From Gallery",
                    onTap: () => onActionSelected(MediaAction.videoFromGallery),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            if (showDocument) ...[
              const Text(
                "Select Document",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
              Center(
                child: _OptionItem(
                  icon: Icons.picture_as_pdf,
                  label: "Select PDF",
                  onTap: () => onActionSelected(MediaAction.selectDocument),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      );
    },
  );
}

class _OptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OptionItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close bottom sheet
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            child: Icon(icon, size: 28, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
