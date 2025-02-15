import 'package:flutter/material.dart';
import '../service/api_service.dart';
import '../models/models.dart';
import 'screeen/filter_screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'screeen/details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<Country> countryList = [];
  List<Country> filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  void fetchCountries() async {
    try {
      List<dynamic> response = await ApiService().fetchCountries();
      List<Country> countries =
          response.map((e) => Country.fromJson(e)).toList();

      setState(() {
        countryList = countries;
        filteredList = countries;
      });
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  void filterCountries(String query) {
    setState(() {
      filteredList = countryList
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Explore",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FilterScreen()),
            ),
          ),
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? Colors.grey[900]
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search Country",
                  hintStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white54
                          : Colors.black54),
                  prefixIcon: Icon(Icons.search,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: filterCountries,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final country = filteredList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: themeProvider.isDarkMode
                        ? Colors.grey[850]
                        : Colors.white,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(country.flag,
                            width: 50, height: 30, fit: BoxFit.cover),
                      ),
                      title: Text(
                        country.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          size: 18,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(country: country),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
