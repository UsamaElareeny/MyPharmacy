import 'package:flutter/material.dart';
import 'package:my_pharmacy/widget/app_drawer.dart';

class Messaging extends StatelessWidget {
  List<Map<String, Object>> doctors = [
    {
      'name': 'Dr. William A. Abdu',
      'specialty': 'Orthopedics',
      'image':
          'https://d2cyt36b7wnvt9.cloudfront.net/exams/wp-content/uploads/2017/01/05133450/Dr-William.png'
    },
    {
      'name': ' Dr. Myles',
      'specialty': 'Pediatrician',
      'image':
      'https://d2cyt36b7wnvt9.cloudfront.net/exams/wp-content/uploads/2017/01/05133850/Dr.-Myles.-B.-Abbot.png'
    },
    {
      'name': 'Dr. Fouad Abbas',
      'specialty': 'Gynecologist/Oncologist',
      'image':
      'https://uep.medstarhealth.org/content/uploads/profile_images/Fouad-M-Abbas-MHH_jpg.jpg'
    },
    {
      'name': 'Dr. Khalid Abbed',
      'specialty': 'Neuro',
      'image':
      'https://d2cyt36b7wnvt9.cloudfront.net/exams/wp-content/uploads/2017/01/05133453/Dr.-Khalid.png'
    },
    {
      'name': 'Dr. Naresh Trehan',
      'specialty': 'cardiovascular',
      'image':
      'https://miro.medium.com/max/532/1*9cJxJzCdvts05DY9S-Ewsg.jpeg'
    },
    {
      'name': 'Dr. Arthur Reese',
      'specialty': 'Psychiatry',
      'image':
      'https://d2cyt36b7wnvt9.cloudfront.net/exams/wp-content/uploads/2017/01/05042820/Dr.-A.-Reese-Abright.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PhramAppDrawer(),
      appBar: AppBar(
        title: Text('Doctors'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              child: Card(
                elevation: 8,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(doctors[index]['image']),
                    radius: 30,
                  ),
                  title: Text(doctors[index]['name']),
                  subtitle: Text(doctors[index]['specialty']),
                  trailing: Icon(Icons.arrow_forward),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              padding: EdgeInsets.symmetric(vertical: 1),
            );
          },
          itemCount: doctors.length,
        ),
      ),
    );
  }
}
