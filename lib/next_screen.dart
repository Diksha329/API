import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class NextScreen extends StatelessWidget {
String title;
String image;
String price;
var rating;
String ratingCount;
String description;
   NextScreen({super.key,required this.title,required this.description,required this.image,required this.price,required this.rating,required this.ratingCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  
    children: [
  
      Image.network(image,width: MediaQuery.of(context).size.width,height: 300,),
  
      Text(title,style: TextStyle(fontSize: 16,),),
      
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            RatingBar.builder(
              
         initialRating: rating,
         itemSize: 20,
         direction: Axis.horizontal,
         allowHalfRating: true,
         itemCount: 5,
         itemPadding: EdgeInsets.zero,
         itemBuilder: (context, _) => Icon(
           Icons.star,
           color: Colors.green,
         ),
         onRatingUpdate: (rating) {
           print(rating);
         },
      ),SizedBox(width: 4,),
      Text('${ratingCount} ratings',style: TextStyle(color: Color.fromARGB(255, 75, 33, 243)),)
          ],
        ),
      ),
      
 
      Text('Rs ${price}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
  
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(description),
      )
  
    ],
  
  ),
),
    );
  }
}