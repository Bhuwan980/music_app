import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final String image;
  final String songTitle;
  final String albumName;

  const AlbumCard(
      {super.key,
      required this.image,
      required this.songTitle,
      required this.albumName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(image,
              width: double.infinity, height: 150, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Text(songTitle,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        Text(albumName,
            style: const TextStyle(color: Colors.white54, fontSize: 14)),
      ],
    );
  }
}
