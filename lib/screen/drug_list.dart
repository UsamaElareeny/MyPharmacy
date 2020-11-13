import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_pharmacy/widget/app_drawer.dart';

class DrugList extends StatelessWidget {
  /*List<Map<String, Object>> drugs = [
    {
      'title': 'Floxamo',
      'type': 'antibiotic',
      'image':
          'https://gardeniapharmacy.com/image/cache/catalog/new%20product/00047632-2-800x533.jpg'
    },
    {
      'title': 'Ciprocin',
      'type': 'antibiotic',
      'image':
          'https://oushode.com/wp-content/uploads/2019/09/Ciprocin-500-square-Oushode.com_.jpg'
    },
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PhramAppDrawer(),
      appBar: AppBar(
        title: Text('Drugs List'),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: FutureBuilder<QuerySnapshot>(
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                      child: ListTile(
                        trailing: Column(
                          children: <Widget>[
                            Icon(Icons.arrow_forward),
                            Text(
                                '${snapshot.data.documents[index]['pharm'].length??0}')
                          ],
                        ),
                        title:
                            Text('${snapshot.data.documents[index]['name']}'),
                        subtitle:
                            Text('${snapshot.data.documents[index]['type']}'),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            snapshot.data.documents[index]['image'].toString(),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/pharmacies',arguments: snapshot.data.documents[index].data);
                    },
                  );
                },
                itemCount: snapshot.data.documents.length,
              );
            },
            future: Firestore.instance.collection('drugs').getDocuments(),
          )),
    );
  }
}
