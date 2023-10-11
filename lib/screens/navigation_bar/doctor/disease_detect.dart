import 'dart:html' as html;
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/disease.dart';
import 'package:gardenguru/providers/disease_provider.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@RoutePage()
class DiseaseDetectScreen extends StatefulWidget {
  @override
  State<DiseaseDetectScreen> createState() => _DiseaseDetectState();
}

class _DiseaseDetectState extends State<DiseaseDetectScreen> {
  int index = 0;
  late List<Disease> diseases;
  XFile? _selectedImage;

  final IO.Socket socket = IO.io('http://localhost:5000', <String, dynamic>{
    'transports': ['websocket'],
  });
  @override
  void initState() {
    super.initState();

    // Set up event listener for 'prediction_results' event
    socket.on('prediction_results', (data) {
      print('Received prediction result: $data');
      index = int.parse(data);
      // Handle the prediction result here
    });
  }

  void _selectImage() {
    final html.InputElement input = html.InputElement(type: 'file');
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file);

      reader.onLoadEnd.listen((loadEndEvent) {
        if (reader.readyState == html.FileReader.DONE) {
          setState(() {
            _selectedImage = XFile(reader.result.toString());
          });
          final String base64Data = reader.result.toString().split(',').last;
          // Now you can send the base64Data to your server
          try {
            socket.emit('image', base64Data);
          } catch (e) {
            print(e);
          }
          //print(base64Data);
        }
      });
    });
  }

  void _predictImage() {
    context.router.push(DiseaseRoute(item: diseases[index]));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Disease>>(
        future: Provider.of<DiseaseProvider>(context, listen: false)
            .fetchDiseases(),
        //plantProvider.fetchPlants(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const SizedBox(
              height: 10,
            );
          } else {
            diseases = snapshot.data!;
            return Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )
                      ],
                    ),
                    onTap: () {
                      context.router.pop();
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  GestureDetector(
                      onTap: _selectImage,
                      child: DottedBorder(
                        color: Colors.grey,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                        padding: const EdgeInsets.all(6),
                        strokeWidth: 2,
                        dashPattern: const [6, 3],
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Center(
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(18.0),
                                    child: kIsWeb
                                        ? Image.network(
                                            width: double.infinity,
                                            _selectedImage!.path,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            width: double.infinity,
                                            File(_selectedImage!.path),
                                            fit: BoxFit.cover,
                                          ),
                                  )
                                : const Icon(Icons.add_a_photo,
                                    size: 60, color: Colors.grey),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Same as ClipRRect radius
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF666538)),
                      ),
                      onPressed: () {
                        context.router
                            .push(DiseaseRoute(item: diseases[index]));
                      },
                      child: Text(
                        'Predict disease',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
