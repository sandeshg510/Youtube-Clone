import 'package:flutter/material.dart';
import 'package:youtube_clone/presentation/pages/widgets/profile_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            child: const SizedBox(
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 46,
                      child: profileWidget(),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Views',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'days ago',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                const Icon(Icons.more_vert)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
