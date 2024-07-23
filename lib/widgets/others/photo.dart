import 'dart:io';

import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  const Photo({
    super.key,
    required this.imagePath,
    required this.onTapRemove,
    required this.onTapView,
  });

  final String imagePath;
  final Function() onTapRemove;
  final Function() onTapView;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapView,
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            Image.file(
              File(imagePath),
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: InkWell(
                onTap: onTapRemove,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.cancel, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
