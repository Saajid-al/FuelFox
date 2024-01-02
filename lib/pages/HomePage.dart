import 'package:flutter/material.dart';
import 'package:gasapp/helpers/AppText.dart';
import 'package:gasapp/helpers/boldtext.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:gasapp/helpers/station.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final addressController = TextEditingController();

  List<Station> stations = []; //creating a list of stations
  List<Station> fetchedStations = [];

  List images = ["img/pink1.png", "img/pink2.png"];

  @override
  void initState() {
    super.initState();
  }

  Future scrapeGasBuddy(String postalCode) async {
    String url =
        'https://www.gasbuddy.com/home?search=$postalCode&fuel=1&method=all';

    http.Response response = await http.get(Uri.parse(url));

    var document = parse(response.body);

    final stationName = document
        .querySelectorAll('.StationDisplay-module__stationNameHeader___1A2q8');
    final stationPrice =
        document.querySelectorAll('.StationDisplayPrice-module__price___3rARL');
    final stationAddressNodes =
        document.querySelectorAll('.StationDisplay-module__address___2_c7v');

    for (var i = 0; i < stationName.length; i++) {
      final name = stationName[i].text.trim();
      final price = stationPrice[i].text.trim();
      String address = stationAddressNodes[i].innerHtml;
      address = address.replaceAll('<br>', '\n').trim();
      print('Station Name: $name');
      print('Price: $price');
      print('Address: $address');
      print('---------------------------');

      fetchedStations.add(Station(name: name, price: price, address: address));
    }
    setState(() {
      stations = fetchedStations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 239, 244),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.shade100,
                    blurRadius: 0,
                    offset: Offset(0, 5),
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 255, 240, 240),
                    Color.fromARGB(255, 255, 242, 242),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: Colors.pink.shade100,
              ),
              child: Column(
                children: [
                  Expanded(
                    //TITLE
                    flex: 3,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BoldText(
                        text: "FUEL FOX",
                        color: Colors.pink.shade100,
                      ),
                    ),
                  ),
                  Expanded(
                    //SUB TEXT
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: AppText(
                        text: "Find the cheapest stations around you.",
                        color: Colors.pink.shade100,
                        size: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    //TEXT INPUT ? ADD FIND ME BUTTON HERE?
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: addressController,
                          onSubmitted: (String value) {
                            scrapeGasBuddy(addressController.text);
                          },
                          decoration: InputDecoration(
                            hintText: "Enter City/ZipCode",
                            hintStyle: TextStyle(
                                fontSize: 10, color: Colors.pink.shade100),
                            contentPadding: const EdgeInsets.only(top: 15),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 219, 219)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), //END OF THE PINK BACKDROP
            Expanded(
              // PINK LIST
              child: ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: ((context, index) {
                    Station station = stations[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Card(
                        elevation: 1,
                        //TILE PROPERTIES
                        child: ListTile(
                          //to fix, learn how to fix the title, subtitle, and trailings.
//                          title: Text(station.name),
                          // subtitle: Text(station.address),
                          // trailing: Text(station.price),
                          tileColor: Colors.white,
                          title: Row(
                            children: [
                              Container(
                                //ICON IMAGES
                                height: 50,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.gas_meter,
                                    color: Colors.pink.shade100,
                                  ),
                                ),
                              ),
                              Container(
                                //ADDRESS AND NAME OF GAS STATION
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: BoldText(
                                          text: (station.name),
                                          color: Color.fromARGB(
                                              255, 255, 179, 205),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: BoldText(
                                          text: (station.address),
                                          size: 11,
                                          color: Colors.pink.shade100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //PRICE
                                height: 60,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Align(
                                  child: FittedBox(
                                    child: BoldText(
                                      text: (station.price),
                                      color: Colors.pink.shade100,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
