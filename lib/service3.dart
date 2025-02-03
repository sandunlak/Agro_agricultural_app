import 'package:flutter/material.dart';

class Service3 extends StatelessWidget {
  // Dummy data for the grid items
  final List<Map<String, dynamic>> items = [
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 1',
      'price': '\$10.00',
      'mobile': '+1 123 456 7890',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 2',
      'price': '\$15.00',
      'mobile': '+1 234 567 8901',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 3',
      'price': '\$20.00',
      'mobile': '+1 345 678 9012',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 4',
      'price': '\$25.00',
      'mobile': '+1 456 789 0123',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 5',
      'price': '\$30.00',
      'mobile': '+1 567 890 1234',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 6',
      'price': '\$35.00',
      'mobile': '+1 678 901 2345',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 7',
      'price': '\$40.00',
      'mobile': '+1 789 012 3456',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 8',
      'price': '\$45.00',
      'mobile': '+1 890 123 4567',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 9',
      'price': '\$50.00',
      'mobile': '+1 901 234 5678',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Item 10',
      'price': '\$55.00',
      'mobile': '+1 012 345 6789',
    },
  ];

  // Function to show the mobile number dialog
  void _showMobileNumberDialog(BuildContext context, String mobileNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Call to Order'),
          content: Text('Call $mobileNumber to place your order.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 10, // Spacing between columns
            mainAxisSpacing: 10, // Spacing between rows
            childAspectRatio: 0.75, // Aspect ratio of the grid items
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                _showMobileNumberDialog(context, item['mobile']);
              },
              child: Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        item['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            item['price'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Go back to the previous screen
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}