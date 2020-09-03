import 'package:flutter/material.dart';
import 'package:weather_app/weather-information.dart';
import './weather-search.dart';

class WeatherPage extends StatefulWidget {
	const WeatherPage({
		Key key,
	}) : super(key: key);

	@override
	_WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
	String cityTitle;
	int temperature;
	String weatherStatusURL;

	@override
	void initState(){
		super.initState();
		cityTitle = "No city has been looked up";
		temperature = 0;
		weatherStatusURL = "";
	}

	void updateInformation(String newTitle, int newTemp, String newURL) {
		setState(() {
			cityTitle = newTitle;
			temperature = newTemp;
			weatherStatusURL = newURL;
		});
	}

	@override
	Widget build(BuildContext context) {
		return SingleChildScrollView(
			child: Column(
				children: [ 
					WeatherInformation(
						this.cityTitle, this.temperature, this.weatherStatusURL),
					Padding(
						padding: EdgeInsets.all(8.0),
					),
					WeatherSearch(callback: updateInformation),
				],
			),
		);
	}
}
