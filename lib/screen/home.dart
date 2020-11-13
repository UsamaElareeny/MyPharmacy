import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          height: 200.0,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [Color(0xfff9f9f9), Color(0xfff9f9f9)],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp), /**/
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/drugs');
                },
                child: new Stack(
                  children: <Widget>[
                    Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 150.0,
                      decoration: new BoxDecoration(
                        //border: new Border.all(color: Colors.black38),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0)),
                        gradient: new LinearGradient(
                            colors: [Colors.purple, Colors.pink],
                            begin: const FractionalOffset(0.5, 0.0),
                            end: const FractionalOffset(0.0, 0.5),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              0.0,
                              13.0,
                            ),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/drugs.png",
                            width: 100,
                            height: 100,
                            excludeFromSemantics: true,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: new EdgeInsets.only(
                          top: 130.0,
                          left: MediaQuery.of(context).size.width / 23.2),
                      width: MediaQuery.of(context).size.width / 2.7,
                      height: 30.0,
                      //color: Colors.red,
                      child: new Padding(
                        padding: EdgeInsets.all(3.0),
                        child: new Center(
                          child: new Text(
                            "Pharmacies",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                        gradient: new LinearGradient(
                            colors: [Color(0xffffffff), Color(0xffffffff)],
                            begin: const FractionalOffset(0.5, 0.0),
                            end: const FractionalOffset(0.0, 0.5),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(156, 39, 176, 0.30),
                            offset: Offset(3.0, 5.0),
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        new Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          height: 200.0,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [Color(0xfff9f9f9), Color(0xfff9f9f9)],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp), /**/
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/tips');
                },
                child: new Stack(
                  children: <Widget>[
                    Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 150.0,
                      decoration: new BoxDecoration(
                        //border: new Border.all(color: Colors.black38),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0)),
                        gradient: new LinearGradient(
                            colors: [
                              Color(0xff52baf8),
                              Color(0xff45dcddd),
                            ],
                            begin: const FractionalOffset(0.5, 0.0),
                            end: const FractionalOffset(0.0, 0.5),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              0.0,
                              13.0,
                            ),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero(
                            tag: 'mathematics_literacy',
                            child: Image.asset(
                              "assets/images/health.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: new EdgeInsets.only(
                          top: 130.0,
                          left: MediaQuery.of(context).size.width / 23.2),
                      width: MediaQuery.of(context).size.width / 2.7,
                      height: 30.0,
                      //color: Colors.red,
                      child: new Padding(
                        padding: EdgeInsets.all(5.0),
                        child: new Center(
                          child: new Text(
                            "Protections",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                        gradient: new LinearGradient(
                            colors: [Color(0xffffffff), Color(0xffffffff)],
                            begin: const FractionalOffset(0.5, 0.0),
                            end: const FractionalOffset(0.0, 0.5),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff52baf8).withOpacity(0.4),
                            offset: Offset(3.0, 5.0),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/chat');
                },
                child: new Stack(
                  children: <Widget>[
                    Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 150.0,
                      decoration: new BoxDecoration(
                        //border: new Border.all(color: Colors.black38),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0)),
                        gradient: new LinearGradient(
                            colors: [Colors.indigoAccent, Colors.indigo],
                            begin: const FractionalOffset(0.5, 0.0),
                            end: const FractionalOffset(0.0, 0.5),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              0.0,
                              13.0,
                            ),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero(
                            tag: 'mathematics',
                            child: Image.asset(
                              "assets/images/doctor.jpg",
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: new EdgeInsets.only(
                          top: 130.0,
                          left: MediaQuery.of(context).size.width / 23.2),
                      width: MediaQuery.of(context).size.width / 2.7,
                      height: 30.0,
                      //color: Colors.red,
                      child: new Padding(
                        padding: EdgeInsets.all(3.0),
                        child: new Center(
                          child: new Text(
                            "Doctors",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: new LinearGradient(
                            colors: [Color(0xffffffff), Color(0xffffffff)],
                            begin: const FractionalOffset(0.5, 0.0),
                            end: const FractionalOffset(0.0, 0.5),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(33, 150, 243, 0.30),
                            offset: Offset(3.0, 5.0),
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
