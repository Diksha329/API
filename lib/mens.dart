import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'next_screen.dart';

class Mens extends StatefulWidget {
  const Mens({super.key});

  @override
  State<Mens> createState() => _MensState();
}

class _MensState extends State<Mens> {
  final dio = Dio();
  var data;
  var data1;
  void getHttp() async {
    Response response = await dio
        .get("https://fakestoreapi.com/products/category/men's clothing");

    setState(() {
      try {
        data = jsonDecode(response.data.toString());
      } catch (e) {
        data = response.data;
      }
    });
  }

  void putHttp() async {
    Response response = await dio.put("https://fakestoreapi.com/products/1");

    setState(() {
      data1 = {
        'price': 13.5,
      };

      data = jsonEncode(data1);
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
      // floatingActionButton: FloatingActionButton(onPressed: putHttp),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .9),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NextScreen(
                                title: data[index]['title'],
                                description: data[index]['description'],
                                image: data[index]['image'],
                                price: '${data[index]['price']}',
                                rating: double.parse(
                                    data[index]['rating']['rate'].toString()),
                                ratingCount:
                                    "${data[index]['rating']['count']}",
                              ))),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.network(
                                    data[index]['image'],
                                    height: 120,
                                    width: 100,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 8,
                                  left: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            Color.fromARGB(194, 232, 232, 232)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${data[index]['rating']['rate']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Colors.green,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1),
                                          height: 12,
                                          child: VerticalDivider(
                                            width: 6,
                                            thickness: 1,
                                          ),
                                        ),
                                        Text(
                                          '${data[index]['rating']['count']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  '${data[index]['description']}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ),
                              Text(
                                '\$${data[index]['price']}',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
