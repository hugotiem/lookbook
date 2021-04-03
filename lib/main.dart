import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lookbook/home/home.dart';

import 'home/add.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lookbook',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FutureBuilder(
        future: _fbApp,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          print('ERROR');
          return new Text('ERROR');
        }
        else if(snapshot.hasData){
          return Home();
        }
        else {
          return new Center(child: new CircularProgressIndicator());
        }
      },)
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Home();
  }
}

class _Home extends State<Home> {
  int currentTabIndex = 0;

  displayPage() {
    switch (currentTabIndex) {
      case 0:
        return new HomePage();

      case 2:
        //return new ListViewTest();
        break;
      default:
        //return new HomePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new CupertinoTabBar(
        currentIndex: currentTabIndex,
        backgroundColor: Colors.white,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
          ),
          new BottomNavigationBarItem(
            icon: Container(
              child: new CupertinoButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AddItem(),
                    ),
                  );
                },
                child: new Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
          ),
        ],
        onTap: (int index) {
          if (index != 1) {
            setState(() {
              currentTabIndex = index;
            });
          }
        },
      ),
      body: displayPage(),
    );
  }
}
