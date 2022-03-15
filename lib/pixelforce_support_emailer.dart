library pixelforce_support_emailer;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info/package_info.dart';

class PixelSupportMailer {
  String? userId;

  PixelSupportMailer(this.userId);

  void sendSupportEmail(String toEmailAddress, String subject, BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionNum = packageInfo.version;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceName;
    String? systemName;
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
      systemName = iosInfo.systemVersion;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
      systemName = androidInfo.version.release;
    }
    EmailContent emailContent = EmailContent(
        to: [toEmailAddress],
        subject: subject,
        body: '''\n\n\nUser ID: $userId Fernando\nDevice: $deviceName\nApp Version: $versionNum\nOSversion: Android $systemName''');

    OpenMailAppResult result = await OpenMailApp.composeNewEmailInMailApp(
        nativePickerTitle: 'Select email app to compose', emailContent: emailContent);
    if (!result.didOpen && !result.canOpen) {
      showNoMailAppsDialog(context);
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) =>
          MailAppPickerDialog(
            mailApps: result.options,
            emailContent: emailContent,
          ),
      );
    }
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
