import 'package:flutter/material.dart';
import '../models/models.dart';

class DetailsScreen extends StatelessWidget {
  final Country country;

  DetailsScreen({required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
              //alignment: Alignment.centerLeft,
              child: Text(country.name))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(country.flag, width: 100)),
            SizedBox(height: 20),
            Text("Name: ${country.name}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Capital: ${country.capital}"),
            Text("Region: ${country.region}"),
            Text("Country Code: ${country.countryCode}"),
            Text("Population: ${country.population ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}
