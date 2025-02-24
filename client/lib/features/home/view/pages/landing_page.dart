import 'package:client/core/theme/app_pallet.dart';
import 'package:client/features/home/view/pages/play_song.dart';
import 'package:client/features/home/view/pages/profile_page.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/album_card.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/artist_playlist_cart.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/recent_card.dart';
import 'package:client/features/home/view/widgets/widgets_landing_page/top_mix_card.dart';
//import 'package:client/features/home/view/widgets/widgets_search_page/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
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
                return ArtistPlaylistCard(
                  image: "assets/images/${index.toString()}.png",
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
                return AlbumCard(
                  image: "assets/images/${index.toString()}.png",
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
                  TopMixCard(image: "assets/images/1.png", title: "Mix 1"),
                  TopMixCard(image: "assets/images/2.png", title: "Mix 2"),
                  TopMixCard(image: "assets/images/3.png", title: "Mix 3"),
                  TopMixCard(image: "assets/images/4.png", title: "Mix 4"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ⏳ Recent Section
            const SectionTitle(title: "Recently Played"),
            const SizedBox(height: 10),
            Column(
              children: List.generate(5, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PlaySong(
                              currentIndex: index,
                              playlist: [
                                {
                                  "songTitle": "Shape of You",
                                  "artistName": "Ed Sheeran",
                                  "songUrl": "https://www.example.com/song.mp3",
                                },
                                {
                                  "songTitle": "Blinding Lights",
                                  "artistName": "The Weeknd",
                                  "songUrl":
                                      "https://www.example.com/blinding_lights.mp3",
                                },
                                {
                                  "songTitle": "Levitating",
                                  "artistName": "Dua Lipa",
                                  "songUrl":
                                      "https://www.example.com/levitating.mp3",
                                },
                              ],
                              songTitle: 'Random Dude',
                              artistName: 'Bhuwan',
                              songUrl: '',
                              coverImage: 'assets/images/1.png');
                        },
                      ),
                    );
                  },
                  child: RecentCard(
                    image: "assets/images/${index.toString()}.png",
                    songTitle: "Recent Song",
                    artistName: "Artist Name",
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
