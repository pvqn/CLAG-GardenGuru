import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gardenguru/screens/navigation_bar/shopping/shopping.dart';
import 'package:gardenguru/screens/screen.dart';
import 'home/home.dart';
import 'doctor/doctor.dart';

@RoutePage()
class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyNavigationBarApp();
  }
}

class MyNavigationBarApp extends StatefulWidget {
  const MyNavigationBarApp({super.key});

  @override
  MyNavigationBarAppState createState() => MyNavigationBarAppState();
}

class MyNavigationBarAppState extends State<MyNavigationBarApp> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final screens = [
    HomeScreen(),
    PlantGeneratorScreen(),
    ShoppingScreen(),
    DoctorScreen(),
    const ThirdScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: buildMyNavigationBar(context),
    );
  }

  Widget buildMyNavigationBar(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              icon: _currentIndex == 0
                  ? const Icon(
                      Icons.home_outlined,
                      color: Color(0xFFE25E3E),
                      size: 30,
                    )
                  : const Icon(Icons.home_outlined,
                      color: Color(0xFF55604C),
                      size: 30) // Replace with your desired icon
              ),
          IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              icon: _currentIndex == 1
                  ? const Icon(Icons.search_outlined,
                      color: Color(0xFFE25E3E), size: 30)
                  : const Icon(Icons.search_outlined,
                      color: Color(0xFF55604C),
                      size: 30) // Replace with your desired icon
              ),
          IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              icon: _currentIndex == 2
                  ? const Icon(Icons.shopping_bag_outlined,
                      color: Color(0xFFE25E3E), size: 30)
                  : const Icon(Icons.shopping_bag_outlined,
                      color: Color(0xFF55604C),
                      size: 30) // Replace with your desired icon
              ),
          IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
              icon: _currentIndex == 3
                  ? const Icon(Icons.medical_services_outlined,
                      color: Color(0xFFE25E3E), size: 30)
                  : const Icon(Icons.medical_services_outlined,
                      color: Color(0xFF55604C),
                      size: 30) // Replace with your desired icon
              ),
          IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
              icon: _currentIndex == 4
                  ? const Icon(Icons.person_2_outlined,
                      color: Color(0xFFE25E3E), size: 30)
                  : const Icon(Icons.person_2_outlined,
                      color: Color(0xFF55604C),
                      size: 30) // Replace with your desired icon
              ),
        ],
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}
