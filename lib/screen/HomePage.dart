import 'Package:flutter/material.dart';
import 'package:my_pharmacy/screen/home.dart';
import 'package:my_pharmacy/widget/app_drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PhramAppDrawer(),
      appBar: AppBar( 
        title: Text('My Pharmacy'),
      ),
      body: HomeButtons(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('/maps');
        },
        child: Icon(Icons.location_city,size: 35,),
        tooltip: 'Near Houspital',
      ),
    );
  }
}
