import 'package:flutter/material.dart';
import 'package:youtube_clone/main.dart';

import '../../const.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _redirect();
    super.initState();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;

    if (!mounted) {
      return;
    }
    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/homepage');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SizedBox(
            height: 100, width: 100, child: Image.asset('assets/yt_logo.png')),
      ),
    );
  }
}
