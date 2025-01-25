import 'package:flutter/material.dart';

class Crop {
  final String name;
  final String category;
  final String plantingSeason;
  final String duration;
  final String soilType;
  final String optimalTemperature;
  final String rainfall;
  final String fertilizer;
  final String pests;
  final String yield;

  Crop({
    required this.name,
    required this.category,
    required this.plantingSeason,
    required this.duration,
    required this.soilType,
    required this.optimalTemperature,
    required this.rainfall,
    required this.fertilizer,
    required this.pests,
    required this.yield,
  });
}

class Service1 extends StatefulWidget {
  @override
  _Service1State createState() => _Service1State();
}

class _Service1State extends State<Service1> {
  final List<Crop> crops = [
    Crop(
      name: 'Rice',
      category: 'Grain',
      plantingSeason: 'June to August',
      duration: '90–120 days',
      soilType: 'Clayey, pH 5.5–7',
      optimalTemperature: '20–35°C',
      rainfall: '100–200 cm',
      fertilizer: 'Urea (3 doses during growth), Potash',
      pests: 'Stem borers (use neem oil or carbofuran)',
      yield: '4–6 tons per hectare',
    ),
    Crop(
      name: 'Wheat',
      category: 'Grain',
      plantingSeason: 'November to April',
      duration: '120–150 days',
      soilType: 'Loamy, pH 6.0–7.5',
      optimalTemperature: '15–25°C',
      rainfall: '50–100 cm',
      fertilizer: 'NPK (Nitrogen, Phosphorus, Potassium)',
      pests: 'Aphids (use insecticidal soap)',
      yield: '2–3 tons per hectare',
    ),
    // Add 8 more crops similarly.
  ];

  List<Crop> filteredCrops = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCrops = crops;
  }

  void filterCrops(String query) {
    setState(() {
      filteredCrops = crops
          .where((crop) => crop.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Crop',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: filterCrops,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCrops.length,
                itemBuilder: (context, index) {
                  final crop = filteredCrops[index];
                  return Card(
                    child: ListTile(
                      title: Text(crop.name),
                      subtitle: Text('Category: ${crop.category}'),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(crop.name),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Category: ${crop.category}'),
                                Text('Planting Season: ${crop.plantingSeason}'),
                                Text('Duration: ${crop.duration}'),
                                Text('Soil Type: ${crop.soilType}'),
                                Text('Optimal Temperature: ${crop.optimalTemperature}'),
                                Text('Rainfall: ${crop.rainfall}'),
                                Text('Fertilizer: ${crop.fertilizer}'),
                                Text('Pests: ${crop.pests}'),
                                Text('Yield: ${crop.yield}'),
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
}

void main() {
  runApp(MaterialApp(
    home: Service1(),
  ));
}
