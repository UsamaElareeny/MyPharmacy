import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final Map<String, Object> order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(
              (widget.order['orders'] as List<dynamic>).length *
                      20.0 +
                  110,
              200)
          : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.order['totalAmount']}\$'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format((widget.order['date'] as Timestamp).toDate()),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded
                  ? min(
                      (widget.order['orders'] as List<dynamic>)
                                  .length *
                              20.0 +
                          15,
                      100)
                  : 0,
              child: ListView(
                children: (widget.order['orders'] as List<dynamic>)
                    .map(
                      (prod) => Column(children: <Widget>[
                        //Text(prod['pharmacy']),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                             '${prod['name']}: ${prod['pharmacyName']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                           Row(children: <Widget>[
                             Text(
                               '${prod['quantity']}x \$${prod['price']}',
                               style: TextStyle(
                                 fontSize: 18,
                                 color: Colors.grey,
                               ),
                             )
                           ],)
                          ],
                        ),
                      ],),
                    ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
