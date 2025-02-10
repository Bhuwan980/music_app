import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  final String image;
  final String songTitle;
  final String artistName;

  const RecentCard(
      {super.key,
      required this.image,
      required this.songTitle,
      required this.artistName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(songTitle,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: Text(artistName,
          style: const TextStyle(color: Colors.white54, fontSize: 14)),
      trailing: const Icon(Icons.more_vert, color: Colors.white),
    );
  }
}
