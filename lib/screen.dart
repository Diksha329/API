import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hbhb/electronics.dart';
import 'package:hbhb/mens.dart';
import 'package:hbhb/next_screen.dart';
import 'package:hbhb/womens.dart';

import 'all.dart';
import 'jewelery.dart';

class ScreenA extends StatefulWidget {
  const ScreenA({super.key});

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  final dio = Dio();
  var data;
  void getHttp() async {
    Response response = await dio.get('https://fakestoreapi.com/products');

    setState(() {
      try {
        data = jsonDecode(response.data.toString());
      } catch (e) {
        data = response.data;
      }
    });
  }

  @override
  void initState() {
    getHttp();

    super.initState();
  }

  List<Widget> pages = [All(), Mens(), Womens(), Jewelery(), Electronics()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: TabBar(isScrollable: true, tabs: [
              Text('All'),
              Text("Men's Clothing"),
              Text("Women's clothing"),
              Text('Jewelery'),
              Text('Electronics'),
            ]),
          ),
          body: TabBarView(children: pages)),
    );
  }
}
