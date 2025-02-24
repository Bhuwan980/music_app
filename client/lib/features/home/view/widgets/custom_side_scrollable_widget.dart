import 'package:client/features/home/view/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CustomSideScrollableWidget extends StatelessWidget {
  const CustomSideScrollableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          int ind = index + 9;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CardContainer(
              image: AssetImage('assets/images/$ind.png'),
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
