import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherInfo {
  final String location;
  final String temperature;
  final String weatherDescription;
  final String rainfall;

  WeatherInfo({
    required this.location,
    required this.temperature,
    required this.weatherDescription,
    required this.rainfall,
  });
}

class Service2 extends StatefulWidget {
  @override
  _Service1State createState() => _Service1State();
}

class _Service1State extends State<Service2> {
  List<WeatherInfo> weatherData = [];
  List<WeatherInfo> filteredWeather = [];
  final TextEditingController searchController = TextEditingController();
  final String apiKey = 'YOUR_API_KEY'; // Replace with your API key

  @override
  void initState() {
    super.initState();
    fetchWeatherForDefaultCities();
  }

  Future<void> fetchWeatherForDefaultCities() async {
    final List<String> defaultCities = [
      'Colombo',
      'Kandy',
      'Jaffna',
      'Galle',
      'Trincomalee',
      'Anuradhapura',
      'Nuwara Eliya',
      'Batticaloa',
      'Matara',
      'Kurunegala',
    ];

    List<WeatherInfo> weatherList = [];
    for (String city in defaultCities) {
      WeatherInfo? info = await fetchWeather(city);
      if (info != null) {
        weatherList.add(info);
      }
    }

    setState(() {
      weatherData = weatherList;
      filteredWeather = weatherList;
    });
  }

  Future<WeatherInfo?> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city,lk&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherInfo(
          location: data['name'],
          temperature: '${data['main']['temp']}°C',
          weatherDescription: data['weather'][0]['description'],
          rainfall: data['rain']?['1h']?.toString() ?? 'No recent rain',
        );
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
    return null;
  }

  void filterWeather(String query) {
    setState(() {
      filteredWeather = weatherData
          .where((info) =>
          info.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showDailyUpdates() {
    for (var weather in weatherData) {
      if (weather.rainfall != 'No recent rain') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Rain Update'),
              content: Text(
                  '${weather.location} is experiencing rainfall: ${weather.rainfall}mm.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Information in Sri Lanka'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search City',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: filterWeather,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredWeather.length,
                itemBuilder: (context, index) {
                  final weather = filteredWeather[index];
                  return Card(
                    child: ListTile(
                      title: Text(weather.location),
                      subtitle: Text(
                          'Temperature: ${weather.temperature}\nWeather: ${weather.weatherDescription}'),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(weather.location),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Temperature: ${weather.temperature}'),
                                Text(
                                    'Weather: ${weather.weatherDescription}'),
                                Text('Rainfall: ${weather.rainfall}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close'),
                            ),
                          ],
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showDailyUpdates();
  }
}

void main() {
  runApp(MaterialApp(
    home: Service2(),
  ));
}
