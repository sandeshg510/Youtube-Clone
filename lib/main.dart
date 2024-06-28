import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_clone/presentation/pages/profile/account_page.dart';
import 'package:youtube_clone/presentation/pages/credential/login_page.dart';
import 'package:youtube_clone/presentation/pages/home/home_page.dart';
import 'package:youtube_clone/presentation/pages/splash_page.dart';
import 'package:youtube_clone/presentation/pages/upload_page/upload_page.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://qwjydrywacvadmrrmsua.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF3anlkcnl3YWN2YWRtcnJtc3VhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTkyODQ3ODAsImV4cCI6MjAzNDg2MDc4MH0.WEGDwCLNOmMVn15xCA-cPOrFqyFkwi3oahhUQbOE8XU',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Clone',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/account': (context) => const AccountPage(),
        '/homepage': (context) => const HomePage(),
        '/upload': (context) => const UploadPage(),
      },
    );
  }
}
