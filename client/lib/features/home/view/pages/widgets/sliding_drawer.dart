import 'package:flutter/material.dart';

class SlidingDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const SlidingDrawer({
    super.key,
    required this.isOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: isOpen ? 0 : -screenWidth * 0.8, // Slide in/out
      top: 0,
      bottom: 0,
      width: screenWidth * 0.8, // Drawer width (80% of screen)
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta! < -10) {
            onClose(); // Swipe left to close
          }
        },
        child: Container(
          color: Colors.black, // Drawer background
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: onClose, // Close drawer
                ),
              ),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/image.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                "Bhuwan Bahadur Neupane",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text("Profile",
                    style: TextStyle(color: Colors.white)),
                onTap: onClose,
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text("Settings",
                    style: TextStyle(color: Colors.white)),
                onTap: onClose,
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title:
                    const Text("Logout", style: TextStyle(color: Colors.red)),
                onTap: onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
