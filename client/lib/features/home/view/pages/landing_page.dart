import 'package:client/features/home/view/pages/profile_page.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/album_card.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/artist_playlist_cart.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/recent_card.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/top_mix_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎵 Artists & Playlists Section
            const SectionTitle(title: "Artists & Playlists"),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.5, // Wide cards
              ),
              itemCount: 8, // 8 cards
              itemBuilder: (context, index) {
                return const ArtistPlaylistCard(
                  image: "assets/images/image.png",
                  title: "Artist Name",
                );
              },
            ),
            const SizedBox(height: 20),

            // 🎼 Popular Albums & Singles
            const SectionTitle(title: "Popular Albums & Singles"),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: .85, // Portrait mode cards
              ),
              itemCount: 4, // Adjust as needed
              itemBuilder: (context, index) {
                return const AlbumCard(
                  image: "assets/images/bhuwan.jpeg",
                  songTitle: "Song Name",
                  albumName: "Album - Album Name",
                );
              },
            ),
            const SizedBox(height: 20),

            // 🔥 Your Top Mix (Horizontally Scrollable)
            const SectionTitle(title: "Your Top Mix"),
            const SizedBox(height: 10),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  TopMixCard(
                      image: "assets/images/bhuwan.jpeg", title: "Mix 1"),
                  TopMixCard(
                      image: "assets/images/bhuwan.jpeg", title: "Mix 2"),
                  TopMixCard(
                      image: "assets/images/bhuwan.jpeg", title: "Mix 3"),
                  TopMixCard(
                      image: "assets/images/bhuwan.jpeg", title: "Mix 4"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ⏳ Recent Section
            const SectionTitle(title: "Recently Played"),
            const SizedBox(height: 10),
            Column(
              children: List.generate(5, (index) {
                return const RecentCard(
                  image: "assets/images/image.png",
                  songTitle: "Recent Song",
                  artistName: "Artist Name",
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
