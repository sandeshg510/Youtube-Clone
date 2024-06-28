import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_clone/main.dart';

import '../../../const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  late final StreamSubscription<AuthState> _authSubscription;
  @override
  void initState() {
    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Login'),
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(label: Text('Email')),
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  final email = _emailController.text.trim();
                  await supabase.auth.signInWithOtp(
                      email: email,
                      emailRedirectTo:
                          'io.supabase.flutterquickstart://login-callback/');
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Check your inbox')));
                  }
                } on AuthException catch (error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.message)));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Some error occurred please try again')));
                }
              },
              child: const Text('Login'
                  ''))
        ],
      ),
    );
  }
}
