import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if(futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        return StreamBuilder(
      stream: Firestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
        builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        final chatDocs = snapshot.data.documents;
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
              itemBuilder: (ctx, index) {
              return MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['userId'] == futureSnapshot.data.uid,
                chatDocs[index]['username'],
                chatDocs[index]['userImage'],
                key: ValueKey(chatDocs[index].documentID),
              );
        }
          );
        },
        );
        },
    );
  }
}
