import 'package:flutter/material.dart';
//import 'service1_page.dart';
//import 'service2_page.dart';
//import 'service3_page.dart';
//import 'service4_page.dart';
//import 'service5_page.dart';
//import 'service6_page.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of services with their respective routes
    final List<Map<String, dynamic>> services = [
      {'image': 'images/service1.png'},
      {'image': 'images/service2.png'},
      {'image': 'images/service3.png'},
      {'image': 'images/service4.png'},
      {'image': 'images/service5.png'},
      {'image': 'images/service6.png'},
      //{'image': 'images/service6.png', 'route': Service6Page()},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image(
              image: AssetImage('images/paddy_blur.jpg'), // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Grid for services
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: services.length, // 6 boxes
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => services[index]['route'], // Navigate to the respective page
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset(
                                services[index]['image'],
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    // Back Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Navigate back to the previous page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Go Back',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
