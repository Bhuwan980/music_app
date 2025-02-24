import 'package:client/core/theme/app_pallet.dart';
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
          color: Pallete.greyColor,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: Row(
        children: [
          // Image covering full height, but taking less width
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: Image.asset(
              image,
              width: 70,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 10),

          //  Title (Flexible to avoid overflow)
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
