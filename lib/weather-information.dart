import 'package:flutter/material.dart';

class WeatherInformation extends StatelessWidget {
	final String cityTitle;
	final int temperature;
	final String weatherStatusURL;

	WeatherInformation(this.cityTitle, this.temperature, this.weatherStatusURL);

	Widget build(BuildContext context) {
		return Column(
			children: [
				Text(this.cityTitle),
				if (weatherStatusURL.isEmpty)
					Image.asset("assets/sad_face.png")
				else
					Padding(
						padding: const EdgeInsets.all(20),
						child: Image.network(weatherStatusURL),
					),
				Text(this.temperature.toString()),
			],
		);
	}
}