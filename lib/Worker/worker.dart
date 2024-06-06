import 'package:http/http.dart' as http;
import 'dart:convert';

class worker {
  String location;

  //Constructor
  worker({required this.location}) {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;
  late String icon;

  //method =
  Future<void> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=e756acaa3c3fb9694ccaa837b0e72aa2"));
      Map data = jsonDecode(response.body);

      print(data);
      //Getting temp,Humidity,
      var mainData = data['main'];
      String getHumidity = mainData['humidity'].toString();
      double getTemp = mainData['temp'] - 273.15;

      //Getting air_speed
      Map wind = data['wind'];
      double getAirSpeed = wind["speed"] / 5 / 18;

      //Getting Description
      List weatherData = data['weather'];
      Map weatherMainData = weatherData[0];
      String getMainDes = weatherMainData['main'];
      String getDesc = weatherMainData[
          'description']; //This is the main issue which was cauing error due to which the api was able to fetch the data from the api try to match the spellings properly otherwise it'll cause error

      //Assigning Values
      temp = getTemp.toString(); //C
      humidity = getHumidity; //%
      airSpeed = getAirSpeed.toString(); //km/hr
      description = getDesc;
      main = getMainDes;
      icon = weatherMainData["icon"].toString();
    } catch (e) {
      print(e);
      temp = "NA";
      humidity = "NA";
      airSpeed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "09d";
    }
  }
}
