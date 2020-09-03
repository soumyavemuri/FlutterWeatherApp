import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherSearch extends StatefulWidget {
  final Function callback;

  const WeatherSearch({
    Key key,
    @required this.callback,
  }) : super(key: key);

  @override
  _WeatherSearchState createState() => _WeatherSearchState();
}

class _WeatherSearchState extends State<WeatherSearch> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void citySubmitted(String city) async {
    if (city.isEmpty) {
      print("Nothing entered so not going to search for a city!");
      return;
    }

    textController.clear();

    // THIS BLOCK OF CODE TRIES TO FIND THE WOEID
    // UNIQUE IDENTIFIER FOR A CITY
    var url = "https://www.metaweather.com/api/location/search/?query=$city";
    var response = await http.get(url);
    var encodedResponse = jsonDecode(response.body);

    // Checks if the response is empty.
    // If it is then the function returns otherwise.
    if (encodedResponse.length == 0) {
      print("Unable to find the city");
      return;
    }

    // THIS BLOCK OF CODE FINDS THE WEATHER INFORMATION AND PASSES THE RETRIEVED
    // INFO TO THE CALLBACK
    int woeid = encodedResponse[0]['woeid'];
    String locationURL = "https://www.metaweather.com/api/location/$woeid/";
    var locationResponse = await http.get(locationURL);
    var locationEncodedResponse = jsonDecode(locationResponse.body);

    String newCity = city;
    int newTemp =
        locationEncodedResponse['consolidated_weather'][0]['the_temp'].toInt();
    String weatherStatus = locationEncodedResponse['consolidated_weather'][0]
        ['weather_state_abbr'];
    String weatherStatusURL =
        "https://www.metaweather.com/static/img/weather/png/$weatherStatus.png";

    // Passing in all of my newly acquired data to the callback
    widget.callback(newCity, newTemp, weatherStatusURL);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: textController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Enter a city",
        ),
        onSubmitted: citySubmitted,
      ),
    );
  }
}