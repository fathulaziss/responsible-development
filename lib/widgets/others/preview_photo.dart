import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsible_development/services/navigation_service.dart';

class PreviewPhoto extends StatefulWidget {
  const PreviewPhoto({
    super.key,
    required this.imagePath,
    this.onTapClose,
  });

  final String imagePath;
  final Function()? onTapClose;

  @override
  State<PreviewPhoto> createState() => _PreviewPhotoState();
}

class _PreviewPhotoState extends State<PreviewPhoto> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(),
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.black,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PhotoView(
          imageProvider: FileImage(File(widget.imagePath)),
          minScale: 0.65,
          maxScale: 3.0,
        ),
      ),
      actions: [
        InkWell(
          onTap: NavigationService.pop,
          child: Card(
            color: Colors.red,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'TUTUP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
