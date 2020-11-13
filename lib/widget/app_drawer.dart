import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_pharmacy/providers/user.dart';
import 'package:provider/provider.dart';

class PhramAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(
            icon: Icons.view_list,
            text: 'Orders',
            onTap: () => Navigator.of(context).pushNamed('/orders'),
          ),
          _createDrawerItem(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onTap: () => Navigator.of(context).pushNamed('/cart'),
          ),
          _createDrawerItem(
            icon: Icons.local_pharmacy,
            text: 'Drugs',
            onTap: () => Navigator.of(context).pushNamed('/drugs'),
          ),
          Divider(),
          _createDrawerItem(
            icon: Icons.chat,
            text: 'Doctor',
            onTap: () => Navigator.of(context).pushNamed('/drugs'),
          ),
          _createDrawerItem(
            icon: Icons.list,
            text: 'Tips',
            onTap: () => Navigator.of(context).pushNamed('/drugs'),
          ),
          Divider(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.of(context).pushReplacementNamed('/home')),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Sign Out',
              onTap: () async {
                bool result = await showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('Confirm Sign Out'),
                        content: Text('Signo out from this app?'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('CANCEL')),
                          FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('SIGN OUT')),
                        ],
                      );
                    });
                if (result) {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();

                  Navigator.of(context).pushReplacementNamed('/login');
                }
              }),
        ],
      ),
    );
  }

  Widget _createHeader(context) {
    UserData _user = Provider.of<User>(context).getUserData;
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/drawer.jpeg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage('${_user.getPhotoUrl}'),
                    radius: 35,
                  ),
                  Text('${_user.getName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                  Text('${_user.getPhoneNumber}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300))
                ],
              )),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
