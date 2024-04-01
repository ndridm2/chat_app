import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Calls',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
            color: Colors.blue[700],
            iconSize: 30.0,
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 25,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text('Call ${index + 1}',),
            subtitle: const Row(
              children: [
                Icon(Icons.call, size: 16),
                Text(
                  ' Outgoing',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
