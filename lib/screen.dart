import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          width: 180,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.network(
                                data[index]['image'],
                                height: 120,
                                width: 100,
                              ),
                              Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    height: 18,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            Color.fromARGB(179, 232, 232, 232)),
                                    child: Row(
                                      children: [
                                        Text(
                                            '${data[index]['rating']['rate']}'),
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                        ),
                                        VerticalDivider(
                                          width: 2,
                                        ),
                                        Text(
                                            '${data[index]['rating']['count']}'),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['title'],
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                              maxLines: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                '${data[index]['description']}',
                                maxLines: 1,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                            Text('Rs ${data[index]['price']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
