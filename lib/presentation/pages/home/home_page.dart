import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_clone/const.dart';
import 'package:youtube_clone/presentation/pages/widgets/post_widget.dart';

import '../../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Bucket? _bucket;
  String? name = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 100, child: Image.asset('assets/youtube.png')),
              Row(
                children: [
                  SizedBox(width: 32, child: Image.asset('assets/yt_band.png')),
                  const SizedBox(width: 15),
                  const Icon(CupertinoIcons.bell),
                  const SizedBox(width: 15),
                  const Icon(CupertinoIcons.search),
                  const SizedBox(width: 5),
                ],
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const PostWidget(),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _getVideo();
                      });
                    },
                    child: const Text('button')),
              ],
            ),
            CupertinoTabBar(
              backgroundColor: backgroundColor,
              items: [
                const BottomNavigationBarItem(icon: Icon(Icons.home_filled)
                    // Image.asset(
                    //   'assets/hut.png',
                    //   height: 20,

                    ),
                const BottomNavigationBarItem(icon: Icon(Icons.search_sharp)),
                BottomNavigationBarItem(
                    icon: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/upload');
                        },
                        child: const Icon(Icons.add_circle_outline_sharp))),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline_sharp)),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_sharp)),
              ],
              // onTap: navigationTapped,
            ),
          ],
        ));
  }

  void _getVideo() async {
    final List<Bucket> buckets = await supabase.storage.listBuckets();
    super.initState();
    if (_bucket != null) {
      name = buckets.length.toString();
      print(' here is the bucket : ${buckets.length.toString()}');
    } else {
      name = 'bucket not found';
      print(' here is the bucket : $name');
    }
  }
}
