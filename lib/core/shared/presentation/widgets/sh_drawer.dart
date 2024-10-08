import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_home/core/app/app.dart';
import 'package:smart_home/main.dart';

import '../../../../settings/settings.dart';
import '../../../../notification/notification.dart';


class ShDrawer extends StatefulWidget {
  @override
  _ShDrawerState createState() => _ShDrawerState();
}

class _ShDrawerState extends State<ShDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/images.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'SAMRT HOME',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SmartHomeApp(),
                          ));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'HOME ',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.contact_support,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'support',
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                  onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                  ));
                  },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'notifications',
                          style: TextStyle(color: Colors.white.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountScreen(),
                          ));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'settings ',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  try {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                      (route) => false,
                    );
                  } catch (e) {
                    print("Error: $e");
                  }
                  setState(() {});
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.logout,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'log out ',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
