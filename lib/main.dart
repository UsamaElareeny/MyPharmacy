import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:my_pharmacy/providers/cart.dart';
import 'package:my_pharmacy/providers/user.dart';
import 'package:my_pharmacy/screen/HomePage.dart';
import 'package:my_pharmacy/screen/cart_screen.dart';
import 'package:my_pharmacy/screen/doctor_screen.dart';
import 'package:my_pharmacy/screen/drug_list.dart';
import 'package:my_pharmacy/screen/map.dart';
import 'package:my_pharmacy/screen/orders_screen.dart';
import 'package:my_pharmacy/screen/products_overview_screen.dart';
import 'package:my_pharmacy/screen/tips.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>.value(value: Cart()),
        ChangeNotifierProvider<User>.value(value: User()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.red, accentColor: Colors.redAccent),
        home: GoogleScreen(),
        routes: {
          '/login': (context) => GoogleScreen(),
          '/drugs': (context) => DrugList(),
          '/pharmacies': (context) => ProductsOverviewScreen(),
          '/tips': (context) => Tips(),
          '/home': (context) => MyHomePage(),
          '/cart': (context) => CartScreen(),
          '/orders': (context) => OrdersScreen(),
          '/chat': (context) => DoctorScreen(),
          '/maps': (context) => MapScreen(),
        },
      ),
    );
  }
}

class GoogleScreen extends StatefulWidget {
  @override
  _GoogleScreenState createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  LocationData _locationData;
  TextEditingController _phoneController;
  String _phoneNumber = '';

  bool isSignup = false;

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;

      print('User Id: ' + user.uid);
      print('name: ' + user.displayName);
      print('photo: ' + user.photoUrl);
      if (!isSignup) {
        final snapShot = await Firestore.instance
            .collection('users')
            .document(user.uid)
            .get();

        if (snapShot == null || !snapShot.exists) {
          await showDialog<AlertDialog>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Authentiaction Failed'),
                  content: Text(
                      'Email is not registered. Sign Up to register this email'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK!'))
                  ],
                );
              });
          return;
        }
        
        Map<String, dynamic> map = (await Firestore.instance
                .collection('users')
                .document(user.uid)
                .get())
            .data;

        final token = await FirebaseMessaging().getToken();  
        await Firestore.instance.collection('users').document(user.uid).updateData({'token':token});  
        Provider.of<User>(context, listen: false).setUser(
          UserData(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoUrl,
            location: map['location'],
            phoneNumber: map['phoneNumber'],
          ),
        );
        print(Provider.of<User>(context, listen: false).getUserData);
        await showDialog<AlertDialog>(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Authentiaction Succeeded'),
                content: Text('You have been authorized successfully.'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK!'))
                ],
              );
            });
        Navigator.pushReplacementNamed(context, '/home');
      }
      final token  = await FirebaseMessaging().getToken();
      await Firestore.instance.collection('users').document(user.uid).setData({
        'name': user.displayName,
        'email': user.email,
        'location': GeoPoint(_locationData.latitude, _locationData.longitude),
        'phoneNumber': _phoneNumber,
        'photoUrl': user.photoUrl,
        'token':token,
      });
      Provider.of<User>(context, listen: false).setUser(
        UserData(
          id: user.uid,
          name: user.displayName,
          email: user.email,
          photoUrl: user.photoUrl,
          location: GeoPoint(_locationData.latitude, _locationData.longitude),
          phoneNumber: _phoneNumber,
        ),
      );
      print(Provider.of<User>(context, listen: false).getUserData);
      await showDialog<AlertDialog>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Authentiaction Succeeded'),
              content: Text('You have been authorized successfully.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK!'))
              ],
            );
          });
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('Errorss:${error}');
    }
  }

  Future<void> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    final _locationNameData =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
    });
  }

  Function _counterButtonPress() {
    if ((_locationData != null &&
            _phoneNumber != null &&
            _phoneNumber.isNotEmpty) ||
        !isSignup) {
      return () {
        // do anything else you may want to here
        _handleSignIn();
      };
    } else {
      return null;
    }
  }

  List<Widget> signUpBlock() {
    return [
      Container(
        width: 300,
        child: TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            hintText: 'Number start with +',
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Colors.white),
            border: new OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(25)),
          ),
          onChanged: (value) {
            print(value);
            setState(() {
              _phoneNumber = value;
            });
          },
          onSubmitted: (value) {
            print(value);
            setState(() {
              _phoneNumber = value;
            });
          },
          keyboardType: TextInputType.phone,
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Container(
        width: 300,
        height: 200,
        child: _locationData != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                    'https://maps.googleapis.com/maps/api/staticmap?center=${_locationData.latitude},${_locationData.longitude}&zoom=15&size=300x200&markers=size:mid%7Ccolor:red%7C${_locationData.latitude},${_locationData.longitude}&key=AIzaSyDQuhxy-KKPmEXqGeyFf2HcaisBAI0Uso8'))
            : Center(
                child: Text('No Location has been selected'),
              ),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      OutlineButton(
        color: Colors.white,
        splashColor: Colors.grey,
        onPressed: getLocation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.location_on,
                  color: Colors.black.withOpacity(0.7), size: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Location Detection',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 8,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                    ),
                  ),
                  SizedBox(
                    height: !isSignup ? 24 : 8,
                  ),
                  if (isSignup) ...signUpBlock() else Container(),
                  OutlineButton(
                    splashColor: Colors.grey,
                    onPressed: _counterButtonPress(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image:
                                  AssetImage("assets/images/google_logo.png"),
                              height: 35.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 32),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            isSignup = !isSignup;
                          });
                        },
                        child: Text(
                          isSignup ? 'Sign In' : 'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
