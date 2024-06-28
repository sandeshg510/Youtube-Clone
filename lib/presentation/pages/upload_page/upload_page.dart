import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_clone/main.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool isUploading = false;
  bool isUploaded = false;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload your video'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  isUploading = true;
                });
                var pickedFile = await ImagePicker.platform
                    .getVideo(source: ImageSource.gallery);
                if (pickedFile != null) {
                  _image = File(pickedFile.path);

                  await supabase.storage
                      .from('videos')
                      .upload('video1', _image!)
                      .then((value) {
                    print(value);

                    setState(() {
                      isUploading = false;
                      isUploaded = true;
                    });
                  });
                }
              },
              child: const Text('Upload')),
          const SizedBox(
            height: 15,
            width: double.infinity,
          ),
          isUploading ? const CircularProgressIndicator() : const SizedBox(),
          isUploaded ? const Text('Your upload is complete') : const SizedBox(),
        ],
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
//
// class UploadPostMainWidget extends StatefulWidget {
//   final UserEntity currentUser;
//   const UploadPostMainWidget({super.key, required this.currentUser});
//
//   @override
//   State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
// }
//
// class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
//   File? _image;
//   final TextEditingController _descriptionController = TextEditingController();
//   bool _isUploading = false;
//
//   Future selectImage() async {
//     try {
//       final pickedFile = await ImagePicker.platform
//           .getImageFromSource(source: ImageSource.gallery);
//
//       setState(() {
//         if (pickedFile != null) {
//           _image = File(pickedFile.path);
//         } else {
//           print('no image has been selected');
//         }
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'some error occurred $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _image == null
//         ? _uploadPostsWidget()
//         : Scaffold(
//             backgroundColor: backGroundColor,
//             appBar: AppBar(
//               backgroundColor: backGroundColor,
//               leading: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _image = null;
//                     });
//                   },
//                   child: const Icon(
//                     Icons.close,
//                     size: 28,
//                     color: primaryColor,
//                   )),
//               actions: [
//                 GestureDetector(
//                   onTap: _submitPost,
//                   child: const Padding(
//                     padding: EdgeInsets.all(18.0),
//                     child: Icon(
//                       Icons.arrow_forward,
//                       color: primaryColor,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 80,
//                     height: 80,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(40),
//                         child: profileWidget(
//                             imageUrl: '${widget.currentUser.profileUrl}')),
//                   ),
//                   sizedBoxVer(10),
//                   Text(
//                     '${widget.currentUser.username}',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   sizedBoxVer(10),
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     child: profileWidget(image: _image),
//                   ),
//                   sizedBoxVer(10),
//                   ProfileFormWidget(
//                       title: 'Description', controller: _descriptionController),
//                   sizedBoxVer(20),
//                   _isUploading == true
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Uploading...',
//                               style: TextStyle(color: primaryColor),
//                             ),
//                             sizedBoxHor(10),
//                             const CircularProgressIndicator()
//                           ],
//                         )
//                       : const SizedBox(
//                           height: 10,
//                           width: 10,
//                         )
//                 ],
//               ),
//             ),
//           );
//   }
//
//   _submitPost() {
//     {
//       setState(() {
//         _isUploading = true;
//       });
//     }
//     di
//         .sl<UploadImageToStorageUseCase>()
//         .call(_image!, true, 'posts')
//         .then((imageUrl) {
//       _createPostToSubmit(image: imageUrl);
//     });
//   }
//
//   _createPostToSubmit({required String image}) {
//     BlocProvider.of<PostCubit>(context)
//         .createPosts(
//             post: PostEntity(
//           description: _descriptionController.text,
//           postId: const Uuid().v1(),
//           creatorUid: widget.currentUser.uid,
//           username: widget.currentUser.username,
//           postImageUrl: image,
//           likes: [],
//           totalLikes: 0,
//           totalComments: 0,
//           createAt: Timestamp.now(),
//           userProfileUrl: widget.currentUser.profileUrl,
//         ))
//         .then((value) => _clear());
//   }
//
//   _clear() {
//     setState(() {
//       _isUploading = false;
//       _descriptionController.clear();
//       _image = null;
//       Fluttertoast.showToast(msg: 'Post uploaded successfully');
//     });
//   }
//
//   _uploadPostsWidget() {
//     return Scaffold(
//       backgroundColor: backGroundColor,
//       body: Center(
//         child: GestureDetector(
//           onTap: selectImage,
//           child: Container(
//             height: 150,
//             width: 150,
//             decoration: BoxDecoration(
//                 color: secondaryColor.withOpacity(0.3), shape: BoxShape.circle),
//             child: const Icon(
//               Icons.upload,
//               size: 40,
//               color: primaryColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
