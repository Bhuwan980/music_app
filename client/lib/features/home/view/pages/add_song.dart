import 'dart:io';
import 'package:client/core/theme/app_pallet.dart';
import 'package:client/features/home/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSong extends StatefulWidget {
  const AddSong({super.key});

  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();

  File? _image;
  File? _musicFile;
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickMusic() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _musicFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _songNameController.dispose();
    _artistController.dispose();
    _descriptionController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image Picker Section
                _image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_image!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Pallete.transparentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: _pickImage,
                        child: DottedBorderBox(
                            icon: Icons.image, text: "Upload Cover"),
                      ),
                const SizedBox(height: 20),
                _musicFile != null
                    ? Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.music_note,
                                    color: Colors.blue),
                                Expanded(
                                  child: Text(
                                    _musicFile!.path.split('/').last,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _musicFile = null;
                                    });
                                  },
                                  child: const Icon(Icons.close,
                                      color: Pallete.transparentColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: _pickMusic,
                        child: DottedBorderBox(
                            icon: Icons.music_note, text: "Upload Song"),
                      ),
                const SizedBox(height: 10),
                // Song Name
                CustomTextField(
                    hintText: 'Song Name',
                    icon: Icons.music_note,
                    controller: _songNameController),
                const SizedBox(height: 10),
                // Artist Name
                CustomTextField(
                    hintText: 'Artist',
                    icon: Icons.person,
                    controller: _artistController),
                const SizedBox(height: 10),
                // Description
                CustomTextField(
                    hintText: 'Description',
                    icon: Icons.description,
                    controller: _descriptionController),
                const SizedBox(height: 10),
                // Lyrics
                CustomTextField(
                    hintText: 'Lyrics',
                    icon: Icons.library_music,
                    controller: _lyricsController,
                    maxLines: 4),

                const SizedBox(height: 20),

                CustomButton(buttonText: 'Add Song', onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final int maxLines;

  const CustomTextField({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field can't be empty";
        }
        return null;
      },
    );
  }
}

// Dotted Border Box Widget
class DottedBorderBox extends StatelessWidget {
  final IconData icon;
  final String text;

  const DottedBorderBox({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey, style: BorderStyle.solid, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.grey),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
