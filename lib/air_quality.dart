import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AQI extends StatefulWidget {
  @override
  _AQIState createState() => _AQIState();
}

class _AQIState extends State<AQI> {
  String city = "Loading...";
  int aqi = 0;
  double temp = 0.0;
  bool isLoading = true;

  Future<void> getAQI() async {
    final lat = 13.7563;
    final lon = 100.5018;

    final url = Uri.parse(
        "https://api.waqi.info/feed/here/?token=6ce953046b3e9e1e8ae1c46dc2534b1459e3081a");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == "ok") {
          setState(() {
            city = data['data']['city']['name'];
            aqi = data['data']['aqi'];
            temp = data['data']['iaqi']['t']['v'].toDouble();
            isLoading = false;
          });
        } else {
          showError();
        }
      } else {
        showError();
      }
    } catch (e) {
      showError();
    }
  }

  void showError() {
    setState(() {
      city = "Error";
      aqi = 0;
      temp = 0.0;
      isLoading = false;
    });
  }

  Color getAqiColor(int aqi) {
    if (aqi <= 50) return const Color.fromARGB(255, 130, 238, 133);
    if (aqi <= 100) return const Color.fromARGB(255, 255, 238, 80);
    if (aqi <= 150) return const Color.fromARGB(255, 255, 178, 62);
    if (aqi <= 200) return const Color.fromARGB(255, 243, 78, 66);
    if (aqi <= 300) return const Color.fromARGB(255, 211, 51, 239);
    return const Color.fromARGB(255, 67, 62, 60);
  }

  String getAqiStatus(int aqi) {
    if (aqi <= 50) return "Good";
    if (aqi <= 100) return "Moderate";
    if (aqi <= 150) return "Unhealthy for Sensitive Groups";
    if (aqi <= 200) return "Unhealthy";
    if (aqi <= 300) return "Very Unhealthy";
    return "Hazardous";
  }

  Color getTempColor(double temp) {
    return const Color.fromARGB(255, 0, 0, 0);
  }

  @override
  void initState() {
    super.initState();
    getAQI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Air Quality Index (AQI)",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 105, 201, 239),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 122, 92, 244)),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$city",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 170,
                    width: 370,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: getAqiColor(aqi),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$aqi",
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getAqiStatus(aqi),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(text: " 🌡️Temperature: "),
                        TextSpan(
                          text: "${temp.toStringAsFixed(1)}°C",
                          style: TextStyle(color: getTempColor(temp)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 130,
                      child: ElevatedButton.icon(
                        onPressed: getAQI,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 250, 235, 244),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        label: Text(
                          "Refresh",
                          style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 134, 7, 115)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
