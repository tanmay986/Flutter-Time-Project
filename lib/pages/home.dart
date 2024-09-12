// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    // data = ModalRoute.of(context)?.settings.arguments as Map;
    // data = data.isNotEmpty? data: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      data = data.isNotEmpty ? data : arguments;
    }
    // print(data);
    print(data.values);

    // set background
    String bgImage = data['isDaytime'] ? 'Day.jpg' : 'Night2.jpg';
    Color? bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];
    Color textColor = data['isDaytime'] ? Color(0xFF021526) : Color(0xFF36C2CE) ;


    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImage"),
              // image: AssetImage("assets/Day.jpg"),
              fit: BoxFit.cover,
            )),
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result =  await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time' : result['time'],
                          'location' : result['location'],
                          'isDaytime' : result['isDaytime'],
                          'flag' : result['flag'],
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location, color: textColor),
                    label: Text('Edit Location', style: TextStyle(color: textColor)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: textColor,
                          fontSize: 40.0,
                          letterSpacing: 2.0,
                        ),
                      ),

                    ],

                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 60.0,
                      // color: Color(0x77E4C8),
                      // color: Colors.white60,
                      // color: Color.fromARGB(0xAARRGGBB),
                      color: textColor,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
