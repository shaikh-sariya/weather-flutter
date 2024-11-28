import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cityName = ["Mumbai", "Delhi", "Chennai", "Dhar", "Indore", "London"];
    final random = Random();
    var city = cityName[random.nextInt(cityName.length)];
    Map info = ModalRoute.of(context)!.settings.arguments as Map;
    String temp = ((info['temp_value']).toString());
    String airSpeed = ((info['airSpeed_value']).toString());
    if (temp == "NA") {
    } else {
      temp = ((info['temp_value']).toString()).substring(0, 4);
      airSpeed = ((info['airSpeed_value']).toString()).substring(0, 4);
    }
    String icon = info['icon_value'];
    String getCity = info['city_value'];
    String hum = info['hum_value'];
    String description = info['des_value'];

    String toTitleCase(String text) {
      if (text.isEmpty) return text;
      return text.split(' ').map((word) {
        if (word.isEmpty) return word;
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue.shade800, Colors.blue.shade300])),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchController.text).replaceAll(" ", "") ==
                            "") {
                        } else {
                          Navigator.pushReplacementNamed(context, "/loading",
                              arguments: {
                                "searchText": searchController.text,
                              });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                          onSubmitted: (value){
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": value,
                                });
                    },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city"),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Image.network(
                                "https://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  toTitleCase(description),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In ${toTitleCase(getCity)}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.thermometer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                temp,
                                style: TextStyle(fontSize: 90),
                              ),
                              Text(
                                "℃",
                                style: TextStyle(fontSize: 30),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      padding: EdgeInsets.all(26),
                      height: 200,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.day_windy),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            airSpeed,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text("km/hr")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      padding: EdgeInsets.all(26),
                      height: 200,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.humidity),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            hum,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text("Percent")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made by Sariya"),
                      Text("Data Provided By Openweathermap.org")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
