import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/Theme_Povider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    bool themeData = Provider.of<ThemeNotifier>(context).isDarkMode;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${data['name']}"),
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
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 2 * pi),
                curve: Curves.easeInOut,
                duration: const Duration(seconds: 12),
                builder: (context, position, _) {
                  return Transform.rotate(
                    angle: position,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "${data['planetImage']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: themeData ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${data['description']}",
                        overflow: readMore
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        maxLines: readMore ? null : 4,
                        style: TextStyle(
                          fontSize: 18,
                          color: themeData ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            readMore = !readMore;
                          });
                        },
                        child: Text(readMore ? "Read Less" : "Read More"),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Facts",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: themeData ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data['facts'].map<Widget>((fact) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "- $fact",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: themeData
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
*const SizedBox(height: 16),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: themeData ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                child: Text(
                  "${data['description']}",
                  overflow:
                      readMore ? TextOverflow.visible : TextOverflow.ellipsis,
                  maxLines: readMore ? null : 4,
                  style: TextStyle(
                    fontSize: 18,
                    color: themeData ? Colors.white : Colors.black,
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: (data['facts'] as List).length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.fiber_manual_record,
                        color: themeData ? Colors.white : Colors.black,
                      ),
                      title: Text(
                        data['facts'][index],
                        style: TextStyle(
                            color: themeData ? Colors.white : Colors.black),
                      ),
                    );
                  },
                ),
              ),
* */
