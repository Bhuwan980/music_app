import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLibraryItem(
                image: "assets/images/image.png",
                title: "Liked Songs",
                onTap: () {},
              ),
              _buildLibraryItem(
                image: "assets/images/image.png",
                title: "Playlists",
                onTap: () {},
              ),
              _buildLibraryItem(
                image: "assets/images/image.png",
                title: "Podcasts",
                onTap: () {},
              ),
              _buildLibraryItem(
                image: "assets/images/image.png",
                title: "Mixes",
                onTap: () {},
              ),
              _buildLibraryItem(
                image: "assets/images/image.png",
                title: "Shows",
                onTap: () {},
              ),
              _buildLibraryItem(
                title: "Add Artist",
                onTap: () {},
              ),
              _buildLibraryItem(
                image: null, // ✅ Pass null for "Add Podcast"
                title: "Add Podcast",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Reusable Library Item Widget (Fixes Image Null Issue)
  Widget _buildLibraryItem({
    String? image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: image != null && image.isNotEmpty
                  ? Image.asset(
                      image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 30),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
