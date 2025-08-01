import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Permissions {
  static Future<bool> requestNotificationPermission(BuildContext context) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        var status = await Permission.notification.status;
        if (!status.isGranted) {
          status = await Permission.notification.request();
        }
        if (!status.isGranted) {
          _showPermissionDialog(context, "Notifications");
          return false;
        }
      }
    } else if (Platform.isIOS) {
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        _showPermissionDialog(context, "Notifications");
        return false;
      }
    }
    return true;
  }

  static Future<bool> requestStoragePermission(BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      _showPermissionDialog(context, "Storage");
      return false;
    }
    return true;
  }

  static Future<bool> requestCameraPermission(BuildContext context) async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      _showPermissionDialog(context, "Camera");
      return false;
    }
    return true;
  }

  static void _showPermissionDialog(BuildContext context, String permissionName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$permissionName Permission Required"),
        content: Text("This feature needs $permissionName permission to work properly. Please enable it in app settings."),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
