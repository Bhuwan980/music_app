import 'package:client/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final AssetImage image;
  final String text;
  final double width;
  final double height;

  const CardContainer({
    super.key,
    required this.image,
    required this.text,
    this.width = double.infinity,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 Background Image
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Pallete.borderColor,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 🔹 Overlay with Text
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
