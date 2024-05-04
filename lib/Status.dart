import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('grievances')
            .where('userId', isEqualTo: getCurrentUserId())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final grievanceData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              final grievanceId = snapshot.data!.docs[index].id;
              final officerReply =
                  grievanceData['officerReply'] ?? 'No reply yet';
              final officerReplyTimestamp =
                  grievanceData['officerReplyTimestamp']?.toDate() ??
                      DateTime.now();

              return StatusBox(
                text: grievanceData['text'],
                timestamp: grievanceData['timestamp'].toDate(),
                officerReply: officerReply,
                officerReplyTimestamp: officerReplyTimestamp,
              );
            },
          );
        },
      ),
    );
  }
}

class StatusBox extends StatelessWidget {
  final String text;
  final DateTime timestamp;
  final String officerReply;
  final DateTime officerReplyTimestamp;

  StatusBox({
    required this.text,
    required this.timestamp,
    required this.officerReply,
    required this.officerReplyTimestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Submitted on: ${timestamp.toString()}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text(
            'Officer Reply: $officerReply',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Reply Timestamp: ${officerReplyTimestamp.toString()}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

String getCurrentUserId() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    // Handle the case when the user is not logged in
    return '';
  }
}
