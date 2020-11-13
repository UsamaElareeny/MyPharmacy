import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_pharmacy/providers/doctor.dart';
import 'package:my_pharmacy/providers/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_pharmacy/providers/user.dart';
import 'package:my_pharmacy/widget/app_drawer.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  final Doctor doctor;
  final String name;

  ChatScreen({@required this.id, @required this.name, @required this.doctor});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _editingController = TextEditingController();

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _editingController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              String text = _editingController.text;
              String time =
                  DateFormat.yMMMMd("en_US").add_jm().format(DateTime.now());
              String user = widget.name;
              if (user == null) {
                user = Provider.of<User>(context, listen: false).getName;
                if (user == null) user = 'user';
              }
              FirebaseUser _user = await FirebaseAuth.instance.currentUser();

              Map<String, Object> message = {
                'senderName': user,
                'senderId': widget.id,
                'text': text,
                'time': time
              };
              _editingController.clear();
              Firestore.instance
                  .collection('users')
                  .document(_user.uid)
                  .collection(widget.doctor.id)
                  .add(message);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.doctor.id);
    return Scaffold(
      drawer: PhramAppDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.doctor.name,
        ),
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, snapShot) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: snapShot.data.documents.length <= 0
                          ? Center(
                              child: Image.asset(
                                'assets/images/empty.png',
                                width: 300,
                                height: 300,
                              ),
                            )
                          : ListView.builder(
                              reverse: true,
                              padding: EdgeInsets.only(top: 15.0),
                              itemCount: snapShot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, Object> document =
                                    snapShot.data.documents[index].data;
                                snapShot.data.documents[index].data;
                                Doctor doctor = Doctor(
                                    id: document['senderId'],
                                    imageUrl:
                                        'https://static.medmonks.com/home/img/doctors/1540460888.jpeg',
                                    name: document['senderName']);
                                final Message message = Message(
                                  sender: doctor,
                                  text: document['text'],
                                  time: document['time'],
                                );
                                final bool isMe =
                                    message.sender.id == widget.id;
                                return _buildMessage(message, isMe);
                              },
                            ),
                    ),
                  ),
                ),
                _buildMessageComposer(),
              ],
            ),
          );
        },
        stream: Firestore.instance
            .collection('users')
            .document(widget.id)
            .collection(widget.doctor.id)
            .orderBy('time', descending: true)
            .snapshots(),
      ),
    );
  }
}
