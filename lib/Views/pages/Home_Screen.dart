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
    themeData = Provider.of<ThemeNotifier>(context, listen: false).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Planets",
        ),
        actions: [
          IconButton(
            icon: Icon((themeData) ? Icons.light_mode : Icons.dark_mode),
            color: themeData ? Colors.white : Colors.black,
            onPressed: () async {
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();

              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              prefs.setBool(
                  "IsDarkThem",
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.5,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var planet = data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Image(
                            image: NetworkImage(
                              planet["image"],
                            ),
                          ),
                        ),
                        Text(
                          planet["name"],
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ],
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
