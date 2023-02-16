import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/messages.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          DropdownButton(
            icon: Icon( Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,
            ),
              items: [
                DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(width: 8,),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  value: 'Logout',
                ),
              ],
              onChanged: (item) {
                if(item == 'Logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
          )
        ],
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}