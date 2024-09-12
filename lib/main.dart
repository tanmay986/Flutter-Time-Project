import 'package:flutter/material.dart';
import 'package:flutter_time_project/pages/loading.dart';
import 'package:flutter_time_project/pages/home.dart';
import 'package:flutter_time_project/pages/choose_location.dart';
import 'package:http/http.dart';

void main() => runApp( MaterialApp(
  initialRoute: '/home',
  routes: {
    "/" : (context) => Loading(),
    "/home" : (context) => Home(),
    "/location" : (context) =>ChooseLocation(),
  },

));

