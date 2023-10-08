import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatWithDoctorScreen extends StatefulWidget {
  @override
  State<ChatWithDoctorScreen> createState() => _ChatWithDoctorState();
}

class _ChatWithDoctorState extends State<ChatWithDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 20, right: 10, left: 10),
          child: Column(children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.router.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    child: Text(
                  'Chat with doctor',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          decoration: TextDecoration.none,
                          color: Color(0xFF666538))),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(color: Colors.grey),
              child: const Text('eerrr'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/plants/15.jpg'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF666538),
                  ),
                  child: Text(
                    'How can i help you?',
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.none,
                        textStyle:
                            const TextStyle(fontSize: 13, color: Colors.white)),
                  ),
                ),
              ],
            )
          ]),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 50,
              width: 320,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: const Color(0xFF666538))),
              child: Center(
                  child: Text(
                'Enter your message',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.none)),
              )),
            ),
            const Icon(
              Icons.send,
              color: Color(0xFF666538),
            )
          ]),
        )
      ],
    );
  }
}
