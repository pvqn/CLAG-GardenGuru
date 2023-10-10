import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/models/province.dart';
import 'package:gardenguru/models/weather.dart';
import 'package:gardenguru/providers/maintenance_provider.dart';
import 'package:gardenguru/providers/plant_provider.dart';
import 'package:gardenguru/providers/province_provider.dart';
import 'package:gardenguru/providers/weather_provider.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:gardenguru/utils/plants_support.dart';
import 'package:gardenguru/utils/provinces_support.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class PlantGeneratorScreen extends StatefulWidget {
  String selectedProvince = 'An Giang';
  List<Plant> plants = [];
  int randomIndex = 0;
  TextEditingController desiredGrowingDuration = TextEditingController();

  @override
  State<PlantGeneratorScreen> createState() => _PlantGeneratorScreenState();
}

class _PlantGeneratorScreenState extends State<PlantGeneratorScreen> {
  void _onProvinceChanged(String? newValue) {
    setState(() {
      widget.selectedProvince = newValue ?? 'An Giang'; // Handle null case
    });
  }

  @override
  void initState() {
    Random random = Random();
    widget.randomIndex = random.nextInt(17);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Province>>(
      future: Provider.of<ProvinceProvider>(context, listen: false)
          .fetchProvinces(),
      //plantProvider.fetchPlants(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('No plants available.'));
        } else {
          List<Province> provinces = snapshot.data!;
          // for (int i = 0; i < provinces.length; ++i) {
          //   print(provinces[i].name);
          // }
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<Plant>>(
                      future: Provider.of<PlantProvider>(context, listen: false)
                          .fetchPlants(),
                      //plantProvider.fetchPlants(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return const SizedBox(height: 0);
                        } else {
                          widget.plants = snapshot.data!;
                          // for (int i = 0; i < widget.plants.length; ++i) {
                          //   print(widget.plants[i].id.toString() +
                          //       ',' +
                          //       widget.plants[i].name +
                          //       '\n');
                          // }
                          return const SizedBox(height: 0);
                        }
                      }),
                  Text(
                    'Plant Your Dreams \nHarvest Happiness Tomorrow',
                    style: GoogleFonts.handlee(
                        textStyle: const TextStyle(
                            color: Color(0xFF666538),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Maintenance tip for today',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Color(0xFF666538),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<String>>(
                      future: Provider.of<MaintenanceProvider>(context,
                              listen: false)
                          .fetchTips(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No plants available.'));
                        } else {
                          List<String> tips = snapshot.data!;

                          return Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 152, 152, 118),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.forest_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: 1,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  tips[widget.randomIndex],
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 13, color: Colors.white)),
                                ))
                              ],
                            ),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Weather>(
                    future: Provider.of<WeatherProvider>(context, listen: false)
                        .getWeather('Ho Chi Minh city'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('error'),
                        );
                      } else if (snapshot.data == null) {
                        return const Center(
                            child: Text('No plants available.'));
                      } else {
                        Weather weather = snapshot.data!;
                        DateTime now = DateTime.now();

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF666538)),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ho Chi Minh City',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ),
                                  Text(formatDate(now),
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)))
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                        (weather.temperature - 273)
                                                .toInt()
                                                .toString() +
                                            ' ° F',
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 30))),
                                    Text(
                                      weather.description.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 80,
                                child: SvgPicture.asset(
                                    'assets/weather/' + weather.main + '.svg'),
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Choose your plant',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Color(0xFF666538),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Province',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Color(0xFF666538),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ProvinceDropdown(
                    selectedCategory: widget.selectedProvince,
                    categories:
                        getListofProvinceName(provinces).toSet().toList(),
                    onChanged: _onProvinceChanged,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    controller: widget.desiredGrowingDuration,
                    hintText: 'Enter Your Desired Growing Duration (days)',
                    maxLines: 1,
                    labelText: 'Desired growing duration',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        String inputString = widget.desiredGrowingDuration.text;
                        String sanitizedString =
                            inputString.replaceAll(RegExp(r'[^0-9]'), '');
                        int day = sanitizedString.isEmpty
                            ? 0
                            : int.parse(sanitizedString);

                        Province temp = provinces[0];
                        for (Province province in provinces) {
                          if (province.name == widget.selectedProvince) {
                            temp = province;
                          }
                        }

                        context.pushRoute(SelectCategoryRoute(
                            category: 'Result',
                            plants:
                                findByDayAndTemp(widget.plants, day, temp)));
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF666538)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Find the plant',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ProvinceDropdown extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String?> onChanged;

  const ProvinceDropdown({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      onChanged: onChanged,
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String labelText;

  const InputField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF666538),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFD9D9D9), width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              )),
        )
      ],
    );
  }
}

String formatDate(DateTime date) {
  // List of month names
  final monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Get month name
  String month = monthNames[date.month - 1];

  // Get day with suffix (e.g., 1st, 2nd, 3rd)
  String day = date.day.toString();
  if (date.day >= 11 && date.day <= 13) {
    day += 'th';
  } else {
    switch (date.day % 10) {
      case 1:
        day += 'st';
        break;
      case 2:
        day += 'nd';
        break;
      case 3:
        day += 'rd';
        break;
      default:
        day += 'th';
        break;
    }
  }

  // Get year
  String year = date.year.toString();

  // Format the date
  String formattedDate = '$month $day, $year';

  return formattedDate;
}
