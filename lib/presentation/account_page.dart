import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_clone/presentation/pages/widgets/profile_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getInitialProfile();
    super.initState();
  }

  Future<void> _getInitialProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('profiles').select().eq('id', userId).single();
    setState(() {
      _usernameController.text = data['username'];
      _websiteController.text = data['website'];
    });
  }

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('no image has been selected');
        }
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          // 'Some error occurred please try again',
          e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accounts')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: profileWidget(image: _image),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: GestureDetector(
                onTap: selectImage,
                child: const Text(
                  'Upload Profile Photo',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(label: Text('Username')),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(label: Text('Website')),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () async {
                final username = _usernameController.text.trim();
                final website = _websiteController.text.trim();
                final userId = supabase.auth.currentUser!.id;
                await supabase.from('profiles').update({
                  'username': username,
                  'website': website,
                }).eq('id', userId);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Your data has been saved')));
                }
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }

  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName) async {
    // final uploadTask = ref.putFile(file!);

    final imageUrl =
        (await uploadTask.whenComplete(() => {})).ref.getDownloadURL();

    return await imageUrl;
  }
}
