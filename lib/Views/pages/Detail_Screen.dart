import 'dart:math';
import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text("${data['name']}"),
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
                duration: Duration(seconds: 3),
                builder: (context, position, _) {
                  return Transform.rotate(
                    angle: position,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
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
              const SizedBox(height: 16),
              Text(
                "${data['name']}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "${data['description']}",
                    overflow:
                        readMore ? TextOverflow.visible : TextOverflow.ellipsis,
                    maxLines: readMore ? null : 4,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 08),
              TextButton(
                onPressed: () {
                  readMore = !readMore;
                  setState(() {});
                },
                child: Text(readMore ? "Read Less" : "Read More"),
              ),
              const SizedBox(height: 16),
              const Text(
                "Facts",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: (data['facts'] as List).length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.fiber_manual_record,
                        color: Colors.white,
                      ),
                      title: Text(
                        data['facts'][index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
