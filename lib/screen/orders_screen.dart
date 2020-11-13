import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_pharmacy/providers/user.dart';
import 'package:my_pharmacy/widget/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    print('IDsss:${Provider.of<User>(context, listen: false).getId}');
    return Scaffold(
      drawer: PhramAppDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, data) {
          if(data.connectionState == ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }
          return StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(data.data.uid)
                .collection('orders')
                .snapshots(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.error != null) {
                  // ...
                  // Do error handling stuff
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: dataSnapshot.data.documents.length,
                    itemBuilder: (ctx, i) =>
                        OrderItem(dataSnapshot.data.documents[i].data),
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
