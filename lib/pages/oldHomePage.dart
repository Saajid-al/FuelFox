// import 'package:flutter/material.dart';
// import 'package:gasapp/helpers/AppText.dart';
// import 'package:gasapp/helpers/boldtext.dart';
// import 'package:html/parser.dart';
// import 'package:http/http.dart' as http;
// import 'dart:developer' as developer;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final addressController = TextEditingController();

//   List images = ["img/pink1.png", "img/pink2.png"];
//   @override
//   @override
//   void initState() {
//     super.initState();
//   }
//   //from gas buddies website what we can do is scrape from it, and grab the results
//   //https://www.gasbuddy.com/home?search=m1r1w5&fuel=3&method=all
//   //we just need to replace the ?search= with a variable here.
//   //getting gas prices

//   //for tomorrow we figure out how to scrape the rest of the website properly

//   //TO DO
//   //update the UI
//   //Add location-based-tracking
// //////////////////////////////////////////////////////////////////////////////////
// // Function to perform the scraping
//   Future scrapeGasBuddy(String postalCode) async {
//     // Generate the URL with the user input
//     String url =
//         'https://www.gasbuddy.com/home?search=$postalCode&fuel=3&method=all';

//     // Make a GET request to the URL

//     http.Response response = await http.get(Uri.parse(url));

//     //print(response.body);
//     //developer.log(response.body);

//     var document = parse(response.body);

//     final stationName = document
//         .querySelectorAll('.StationDisplay-module__stationNameHeader___1A2q8');
//     final stationPrice =
//         document.querySelectorAll('.StationDisplayPrice-module__price___3rARL');
//     final stationAddress =
//         document.querySelectorAll('.StationDisplay-module__address___2_c7v');

//     for (var i = 0; i < stationName.length; i++) {
//       final name = stationName[i].text.trim();
//       final price = stationPrice[i].text.trim();
//       final address = stationAddress[i].text.trim();

//       print('Station Name: $name');
//       print('Price: $price');
//       print('Address: $address');
//       print('---------------------------');
//     }
//   }

// //////////////////////////////////////////////////////////////////////////////////

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//           scrollDirection: Axis.vertical,
//           itemCount: images.length,
//           itemBuilder: (_, index) {
//             return Container(
//               width: double.maxFinite,
//               height: double.maxFinite,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(images[index]),
//                       fit: BoxFit.cover,
//                       colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(0.2), BlendMode.darken))),
//               child: Container(
//                 margin: const EdgeInsets.only(top: 150, left: 40, right: 20),
//                 child: Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         BoldText(text: "GassGo"), //bold text helper
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: 250,
//                           child: AppText(
//                             text: "Please Enter Your Postal Code.",
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           height: 30,
//                           width: 250,
//                           child: TextField(
//                             controller: addressController,
//                             decoration: const InputDecoration(
//                               hintText: "Enter",
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 255, 223, 251)),
//                               ),
//                             ),
//                           ),
//                         ),

//                         ElevatedButton(
//                             onPressed: () async {
//                               await scrapeGasBuddy(addressController.text);
//                             },
//                             child: const Text('Go')),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
