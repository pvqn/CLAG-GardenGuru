import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/post.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  TextEditingController _description = TextEditingController();
  Future<void> addPostForUser(Post post) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid; // Get the current user's ID

      DatabaseReference userPostsRef = FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(userId)
          .child('post');

      Map<String, dynamic> postJson = post.toMap();
      await userPostsRef.push().set(postJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.router.pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                const Expanded(child: Text(''))
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Add a post',
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF666538)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/plants/6.jpg'),
                ),
                const SizedBox(
                    width:
                        20), // Add some space between CircleAvatar and TextField
                Expanded(
                  child: TextField(
                    controller: _description,
                    maxLines: 5,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'What are you thinking now?',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFD9D9D9), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(child: Text('')),
                ElevatedButton(
                  onPressed: () async {
                    String description =
                        _description.text; // Get the text from the TextField
                    print(description);
                    if (description.isNotEmpty) {
                      // Check if the description is not empty
                      await addPostForUser(Post(
                          comment: 0,
                          likes: 0,
                          repost: 0,
                          name: 'antihcmus',
                          time: 'now',
                          status: description, // Use the extracted text here
                          isLiked: false,
                          isRepost: false));
                      context.router.pop();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF666538)), // Set background color
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ), // Set padding
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Set border radius
                      ),
                    ), // Set border shape
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white)), // Set text style
                    ), // Set text style
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
