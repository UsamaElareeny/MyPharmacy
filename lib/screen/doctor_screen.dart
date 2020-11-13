import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pharmacy/providers/doctor.dart';
import 'package:my_pharmacy/screen/chat_screen.dart';
import 'package:my_pharmacy/widget/app_drawer.dart';

class DoctorScreen extends StatefulWidget {
  @override
  State<DoctorScreen> createState() {
    // TODO: implement createState
    return DoctorScreenState();
  }
}

class DoctorScreenState extends State<DoctorScreen> {
  String id;
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    id =_user.uid;
    name = _user.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PhramAppDrawer(),
      appBar: AppBar(
        title: Text('Talk to A Doctor'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.documents.length<=0) {
            return Center(
              child: Column(children: <Widget>[
                SizedBox(height: 42,),
                Image.asset('assets/images/doctors.jpg',fit: BoxFit.fill,),
                SizedBox(height: 8,)
                ,Text(
                  'No Avalibale Doctors at current moment!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],),
            );
          }
          List<DocumentSnapshot> snapshots = snapshot.data.documents;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(left: 8, right: 8, top: 12),
            child: ListView.builder(
              itemBuilder: (context, index) {
                Map<String, Object> doctorItem = snapshots[index].data;
                Doctor doctor = Doctor(
                    id: snapshots[index].documentID,
                    name: doctorItem['name'],
                    imageUrl: doctorItem['imageUrl']);

                print(doctorItem);
                return InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25))),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          doctorItem['imageUrl'],
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(doctorItem['name']),
                      subtitle: Text(doctorItem['speciality']),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              id: id,
                              doctor: doctor,
                              name: name,
                            )));
                  },
                );
              },
              itemCount: snapshots.length,
            ),
          );
        },
        stream: Firestore.instance.collection('doctor').snapshots(),
      ),
    );
  }
}
