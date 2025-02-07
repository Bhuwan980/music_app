import 'package:client/features/home/view/pages/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CustomSideScrollableWidget extends StatelessWidget {
  const CustomSideScrollableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CardContainer(
              image: AssetImage('assets/images/login_image.png'),
              text: 'download Text',
              width: 120, // Square shape
              height: 120,
            ),
          );
        },
      ),
    );
  }
}
