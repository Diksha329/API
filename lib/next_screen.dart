import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
String title;
String image;
String price;
String description;
   NextScreen({super.key,required this.title,required this.description,required this.image,required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body: Column(
  children: [
    Image.network(image,width: MediaQuery.of(context).size.width,height: 300,),
    Text(title),
    Text('${price}'),
    Text(description)
  ],
),
    );
  }
}