import 'dart:io';
import 'package:client/core/theme/app_pallet.dart'; // Make sure this path is correct
import 'package:client/features/home/view/widgets/custom_button.dart'; // Make sure this path is correct
import 'package:client/features/home/view/widgets/widgets_search_page/dotted_border_box.dart'; // Make sure this path is correct
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AddSong extends StatefulWidget {
  const AddSong({super.key});

  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();

  File? _image;
  File? _musicFile;
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickFile(FileType type, String permissionMessage) async {
    var status =
        await Permission.storage.request(); // Request storage permission first
    if (type == FileType.image) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: type,
        );

        if (result != null && result.files.isNotEmpty) {
          setState(() {
            if (type == FileType.image) {
              _image = File(result.files.single.path!);
            } else if (type == FileType.audio) {
              _musicFile = File(result.files.single.path!);
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No file selected')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking file: $e')),
        );
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Import 'package:permission_handler/permission_handler.dart';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(permissionMessage)),
      );
    }
  }

  @override
  void dispose() {
    _songNameController.dispose();
    _descriptionController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text('Create Song'),
      ),
      backgroundColor: Pallete.backgroundColor, // Make sure Pallete is defined
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                                  color: Colors.black45,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () => _pickFile(
                            FileType.image, "Permission Denied for Photos"),
                        child: const DottedBorderBox(
                            icon: Icons.image, text: "Upload Cover"),
                      ),
                const SizedBox(height: 20),
                _musicFile != null
                    ? Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
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
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _musicFile = null;
                                    });
                                  },
                                  child: const Icon(Icons.close,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () => _pickFile(
                            FileType.audio, "Permission Denied for Storage"),
                        child: const DottedBorderBox(
                            icon: Icons.music_note, text: "Upload Song"),
                      ),
                const SizedBox(height: 10),
                // ... Your existing CustomTextField widgets
                CustomTextField(
                    hintText: 'Song Name',
                    icon: Icons.music_note,
                    controller: _songNameController),
                const SizedBox(height: 10),
                CustomTextField(
                    hintText: 'Description',
                    icon: Icons.description,
                    controller: _descriptionController),
                const SizedBox(height: 10),
                CustomTextField(
                    hintText: 'Lyrics',
                    icon: Icons.library_music,
                    controller: _lyricsController,
                    maxLines: 4),
                const SizedBox(height: 20),

                CustomButton(
                  buttonText: 'Add Song',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please upload a cover image.')),
                        );
                        return;
                      }
                      if (_musicFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please upload an audio file.')),
                        );
                        return;
                      }

                      // ... Your existing code to handle song upload
                      print("🎵 Song Uploaded: ${_songNameController.text}");
                      print("📝 Description: ${_descriptionController.text}");
                      print("🎶 Lyrics: ${_lyricsController.text}");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ... Your existing CustomTextField, CustomButton, DottedBorderBox, and Pallete classes
class CustomTextField extends StatelessWidget {
  // Example implementation
  // ... (Your CustomTextField code)
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
