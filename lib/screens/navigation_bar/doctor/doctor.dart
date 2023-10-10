import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/disease.dart';
import 'package:gardenguru/providers/disease_provider.dart';
import 'package:gardenguru/providers/plant_provider.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:gardenguru/screens/navigation_bar/doctor/disease_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatefulWidget {
  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late List<Disease> diseases;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'What \'s wrong with your plant?',
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF666538))),
          ),
          Text(
            'Early prediction, brighter tomorrow.',
            style: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontSize: 14, color: Color(0xFF666538))),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Same as ClipRRect radius
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF666538)),
                  ),
                  onPressed: () {
                    if (diseases != null)
                      context.pushRoute(DiseaseDetectRoute());
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Add image to detect',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 12, color: Colors.white)),
                        )
                      ],
                    ),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Same as ClipRRect radius
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF666538)),
                  ),
                  onPressed: () {
                    context.router.push(ChatWithDoctorRoute());
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.chat_bubble,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Ask doctor',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 12, color: Colors.white)),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Diseases',
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF666538))),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<Disease>>(
              future: Provider.of<DiseaseProvider>(context, listen: false)
                  .fetchDiseases(),
              //plantProvider.fetchPlants(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No plants available.'));
                } else {
                  diseases = snapshot.data!;
                  //print(diseases[0].diseaseName);
                  diseases.removeAt(4);
                  return Expanded(child: DiseaseListView(diseases: diseases));
                }
              })
        ],
      ),
    );
  }
}
