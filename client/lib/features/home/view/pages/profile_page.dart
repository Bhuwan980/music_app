import 'package:client/features/home/view/pages/widgets/card_container.dart';
import 'package:client/features/home/view/pages/widgets/custom_side_scrollable_widget.dart';
import 'package:client/features/home/view/pages/widgets/info_box.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: const ProfileContent(),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Image at Center
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/image.png'),
        ),
        const SizedBox(height: 10),

        // Name & Username
        Text(
          "Bhuwan Bahadur Neupane",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          "@Bhuwan",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 15),

        // Follower & Following
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            InfoBox(value: "17", label: "Follower"),
            SizedBox(width: 20),
            InfoBox(value: "270", label: "Following"),
          ],
        ),
        const SizedBox(height: 30),

        //  Favorite Topics
        SectionTitle(
          title: "Favorite Genres",
        ),
        const SizedBox(height: 10),
        FavoriteTopicsList(),
        const SizedBox(height: 20),

        // Downloaded Songs
        SectionTitle(title: "Downloaded Songs"),
        const SizedBox(height: 10),
        CustomSideScrollableWidget(),
      ],
    );
  }
}

//  Section Title with '>' Icon
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Icon(Icons.chevron_right, size: 24),
      ],
    );
  }
}

class FavoriteTopicsList extends StatelessWidget {
  const FavoriteTopicsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CardContainer(
              image: AssetImage('assets/images/login_image.png'),
              text: 'Design text',
              width: 200, // Rectangular shape
              height: 120,
            ),
          );
        },
      ),
    );
  }
}
