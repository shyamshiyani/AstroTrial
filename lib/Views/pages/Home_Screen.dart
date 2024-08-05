import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/Theme_Povider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool themeData;
  late Future<List<dynamic>> jsonData;

  @override
  void initState() {
    super.initState();
    jsonData = loadData();
  }

  Future<List<dynamic>> loadData() async {
    String data = await rootBundle.loadString("assets/Data.json");
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    themeData = Provider.of<ThemeNotifier>(context).isDarkMode;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planets"),
        actions: [
          IconButton(
            icon: Icon(themeData ? Icons.light_mode : Icons.dark_mode),
            color: themeData ? Colors.white : Colors.black,
            onPressed: () async {
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool(
                  "IsDarkTheme",
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .isDarkMode);
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: jsonData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<dynamic> data = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.5,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var planet = data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "DetailScreen",
                        arguments: planet);
                  },
                  child: Card(
                    color: themeData ? Colors.black : Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                planet["image"]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  planet["name"]!,
                                  style: TextStyle(
                                    color:
                                        themeData ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  planet["description"]!,
                                  style: TextStyle(
                                    color:
                                        themeData ? Colors.white : Colors.black,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border),
                            color: themeData ? Colors.red : Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
