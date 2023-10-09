import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/plant.dart';

@RoutePage()
class PlantScreen extends StatefulWidget {
  final Plant plant;
  PlantScreen({required this.plant});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .reference(); // Reference to your Firebase Realtime Database
  List<int> numbersList = [];

  Future<void> _addToNumbersList(int index) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid; // Get the current user's ID

        DatabaseReference numbersRef =
            _databaseReference.child('users').child(userId).child('numbers');

        numbersRef.push().set(index);
      } else {
        print('User not authenticated.');
      }
    } catch (e) {
      print('Error updating numbers array: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Three tabs: Summary, Ingredients, and Directions
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(context), // Back icon and image
            _buildTabsContent(), // Tabs content
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black
                  .withOpacity(0.5), // Adjust the color and opacity as needed
              BlendMode
                  .srcATop, // BlendMode to control how the color will blend with the image
            ),
            child: Container(
              child: Image.asset(
                'assets/plants/' +
                    widget.plant.id.toString() +
                    '.jpg', // Replace with your image asset path
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
                // Adjust the height as needed
              ),
            ),
          ),
        ),
        Align(
          alignment:
              Alignment.topLeft, // Align the icons to the top-left corner
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 20, right: 20), // Add some padding if needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Text('')),
                      ElevatedButton(
                        onPressed: () {
                          print('ok');
                          _addToNumbersList(widget.plant.id);
                          print('Number added to the list!');
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Same as ClipRRect radius
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(
                          'Add to your garden',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 190,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Type',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13)),
                            ),
                            Text(
                              widget.plant.type,
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Growing duration',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13)),
                            ),
                            Text(
                              '~ ' +
                                  widget.plant.growingDuration['ideal']
                                      .toString() +
                                  ' ' +
                                  widget.plant.growingTimeUnit,
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Ideal temperture',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13)),
                            ),
                            Text(
                              widget.plant.temperature['ideal'].toString() +
                                  ' ' +
                                  widget.plant.temperatureUnit,
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget _buildTabsContent() {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: TabBar(
              labelColor: const Color(0xFF666538),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: const Color(0xFF666538),
              labelStyle: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              tabs: [
                Tab(text: 'Summary'),
                Tab(text: 'Directions'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                SummaryTab(
                  plant: widget.plant,
                ),
                DirectionsTab(plant: widget.plant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryTab extends StatelessWidget {
  final Plant plant;
  SummaryTab({required this.plant});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant.name,
              style: GoogleFonts.poppins(
                  textStyle:
                      const TextStyle(fontSize: 24, color: Color(0xFF666538)),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              plant.description,
              style: GoogleFonts.poppins(
                  textStyle:
                      const TextStyle(fontSize: 14, color: Color(0xFF666538))),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Growing duration',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF666538),
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Min',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF666538),
                                fontSize: 14)),
                      ),
                      Text(
                        plant.growingDuration['min'].toString() +
                            ' ' +
                            plant.growingTimeUnit,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538), fontSize: 14)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Ideal',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF666538),
                                fontSize: 14)),
                      ),
                      Text(
                        plant.growingDuration['ideal'].toString() +
                            ' ' +
                            plant.growingTimeUnit,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538), fontSize: 14)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Max',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF666538),
                                fontSize: 14)),
                      ),
                      Text(
                        plant.growingDuration['max'].toString() +
                            ' ' +
                            plant.growingTimeUnit,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538), fontSize: 14)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Temperature',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF666538),
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Min',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF666538),
                                fontSize: 14)),
                      ),
                      Text(
                        plant.temperature['min'].toString() +
                            ' ' +
                            plant.temperatureUnit,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538), fontSize: 14)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Ideal',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF666538),
                                fontSize: 14)),
                      ),
                      Text(
                        plant.temperature['ideal'].toString() +
                            ' ' +
                            plant.temperatureUnit,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538), fontSize: 14)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Max',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF666538),
                                fontSize: 14)),
                      ),
                      Text(
                        plant.temperature['max'].toString() +
                            ' ' +
                            plant.temperatureUnit,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538), fontSize: 14)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Properties',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF666538),
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        // No need to specify height here
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 165, 165, 110),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Position',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              plant.position,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 110, 110, 75),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Soil',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              plant.soil,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        // No need to specify height here
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 133, 133, 75),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Spacing',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              plant.spacing,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 68, 68, 26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Feeding',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              plant.feeding,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DirectionsTab extends StatelessWidget {
  final Plant plant;
  DirectionsTab({required this.plant});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Material',
            style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontSize: 24, color: Color(0xFF666538)),
                fontWeight: FontWeight.bold),
          ),
          Text(
            plant.plantingMaterial,
            style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontSize: 14, color: Color(0xFF666538))),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Steps',
            style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontSize: 24, color: Color(0xFF666538)),
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: plant.plantingSteps.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(
                    Icons
                        .arrow_forward_ios_rounded, // You can change this to any desired icon
                    color: Color(0xFF666538),
                  ),
                  title: Text(
                    plant.plantingSteps[index],
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14, color: Color(0xFF666538))),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
