import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> continents = [
    "Africa",
    "Asia",
    "Europe",
    "North America",
    "Oceania",
    "South America",
    "Antarctica"
  ];
  String? selectedContinent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filter")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Select Continent"),
              value: selectedContinent,
              items: continents.map((continent) {
                return DropdownMenuItem(
                  value: continent,
                  child: Text(continent),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedContinent = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, selectedContinent);
            },
            child: Text("Apply Filter"),
          ),
        ],
      ),
    );
  }
}
