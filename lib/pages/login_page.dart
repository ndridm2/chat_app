// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial_chat/pages/home_page.dart';
import 'package:trial_chat/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 94.0),
            //logo flutter
            const FlutterLogo(
              size: 100,
            ),
            const SizedBox(height: 16.0),
            //title Code with Bahri
            const Text(
              'Chat App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),

            const SizedBox(height: 48.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(14)),
                hintText: 'Email',
                suffixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: _isHide,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(14)),
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_isHide
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      _isHide = !_isHide;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 28.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                child: const Text('Login', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 16.0),
            //register page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
                  },
                  child: const Text('Register', style: TextStyle(color: Colors.blueGrey),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ],
              ));
    }
  }
}
