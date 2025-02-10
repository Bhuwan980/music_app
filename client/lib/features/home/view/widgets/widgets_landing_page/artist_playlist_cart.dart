import 'package:flutter/material.dart';

class ArtistPlaylistCard extends StatelessWidget {
  final String image;
  final String title;

  const ArtistPlaylistCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // Fixed height for uniform design
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Row(
        children: [
          // ✅ Image covering full height, but taking less width
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              image,
              width: 70, // Adjusted width (1:1 ratio for square image)
              height: double.infinity, // ✅ Full height of the container
              fit: BoxFit.cover, // Ensures the image fills the space
            ),
          ),

          const SizedBox(width: 10), // Space between image and text

          // ✅ Title (Flexible to avoid overflow)
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
