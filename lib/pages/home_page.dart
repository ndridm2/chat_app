import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial_chat/data/datasources/firebase_datasource.dart';
import 'package:trial_chat/pages/profile_page.dart';

import '../data/models/user_model.dart';
import 'chat_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontFamily: 'Oxygen',
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
            color: Colors.black87,
            iconSize: 30.0,
          ),
          PopupMenuButton<String>(
            onSelected: (string) {},
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'profile',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const ProfilePage();
                  }));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, color: Colors.blueGrey),
                    SizedBox(width: 5),
                    Text('Profile', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (string) {},
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Logout',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      FirebaseAuth.instance.signOut();
                      return const LoginPage();
                    },
                  ));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout, color: Colors.blueGrey),
                    SizedBox(width: 5),
                    Text('Logout', style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: FirebaseDatasource.instance.allUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blueGrey));
          }
          final List<UserModel> users = (snapshot.data ?? [])
              .where((element) => element.id != currentUser!.uid)
              .toList();
          //if user is null
          if (users.isEmpty) {
            return const Center(
              child: Text('No user found'),
            );
          }
          return ListView.separated(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 25,
                  child: Text(users[index].userName[0].toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Oxygen')),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      users[index].userName,
                      style: const TextStyle(fontFamily: 'Platypi'),
                    ),
                    Text(
                      '${DateTime.now().hour}.${DateTime.now().minute}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Oxygen',
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                subtitle: const Row(
                  children: [
                    SizedBox(width: 3),
                    Text(
                      '',
                      style: TextStyle(fontFamily: 'Oxygen'),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ChatPage(
                      partnerUser: users[index],
                    );
                  }));
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
