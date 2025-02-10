import 'package:client/features/home/view/pages/profile_page.dart';
import 'package:client/features/home/view/widgets/widgets_search_page/browse_card.dart';
import 'package:client/features/home/view/widgets/widgets_search_page/discover_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateProvider<String>((ref) => "");

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchProvider);
    final searchController = TextEditingController(text: searchQuery);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            TextField(
              controller: searchController,
              onChanged: (value) =>
                  ref.read(searchProvider.notifier).state = value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: "Search for music, podcasts...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // 🎵 Start Browsing Section
            const SectionTitle(title: "Start Browsing"),
            const SizedBox(height: 10),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5, // Rectangular cards
              ),
              children: const [
                BrowseCard(
                    title: "Music", icon: Icons.music_note, color: Colors.blue),
                BrowseCard(
                    title: "Podcasts",
                    icon: Icons.podcasts,
                    color: Colors.purple),
                BrowseCard(
                    title: "Audiobooks",
                    icon: Icons.book,
                    color: Colors.orange),
                BrowseCard(
                    title: "Live Events",
                    icon: Icons.live_tv,
                    color: Colors.red),
              ],
            ),
            const SizedBox(height: 20),

            // 🎧 Discover Something New
            const SectionTitle(title: "Discover Something New"),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  DiscoverCard(
                      title: "Trending Now",
                      image: "assets/images/bhuwan.jpeg"),
                  DiscoverCard(
                      title: "New Releases",
                      image: "assets/images/bhuwan.jpeg"),
                  DiscoverCard(
                    title: "Top Charts",
                    image: "assets/images/bhuwan.jpeg",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🎼 Browse All Section
            const SectionTitle(title: "Browse All"),
            const SizedBox(height: 10),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // Square cards
              ),
              children: const [
                BrowseCard(
                    title: "Pop", icon: Icons.audiotrack, color: Colors.pink),
                BrowseCard(
                    title: "Hip-Hop",
                    icon: Icons.headphones,
                    color: Colors.green),
                BrowseCard(
                    title: "Jazz",
                    icon: Icons.surround_sound,
                    color: Colors.cyan),
                BrowseCard(
                    title: "Electronic",
                    icon: Icons.speaker,
                    color: Colors.deepPurple),
                BrowseCard(
                    title: "Rock", icon: Icons.album, color: Colors.blueGrey),
                BrowseCard(
                    title: "Classical",
                    icon: Icons.library_music,
                    color: Colors.teal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
