import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/post.dart';
import 'package:google_fonts/google_fonts.dart';

class PostList extends StatefulWidget {
  final List<Post> posts;

  PostList({List<Post>? posts})
      : posts = posts ??
            [
              Post(
                name: 'atsuki mashiko',
                status:
                    'Red roses are perhaps the most well-known symbol of love and romance. They are often given on special occasions, particularly Valentine\'s Day, to express deep love and passion.',
                time: '1 hour ago',
                likes: 1000,
                repost: 1000,
                comment: 1000,
                isLiked: false,
                isRepost: false,
              ),
              Post(
                  name: 'higuchi kouhei',
                  status:
                      'Different colors of tulips can convey different emotions, but in general, they are associated with perfect love. Red tulips specifically represent true love.',
                  time: '2 hours ago',
                  likes: 1000,
                  repost: 1000,
                  comment: 1000,
                  isLiked: false,
                  isRepost: false),
            ];

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Future<void> addRepostForUser(Post post) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid; // Get the current user's ID

      DatabaseReference userPostsRef = FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(userId)
          .child('repost');

      Map<String, dynamic> postJson = post.toMap();
      await userPostsRef.push().set(postJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.posts.length,
      physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
      shrinkWrap: true, // Use shrinkWrap property

      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/plants/6.jpg'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(widget.posts[index].name,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)))),
                Text(widget.posts[index].time,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color(0xFF666538),
                            fontSize: 14,
                            fontWeight: FontWeight.w500))),
                const SizedBox(
                  width: 5,
                ),
                Icon(Icons.more_vert)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.posts[index].status,
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  color: Color(0xFF666538),
                  fontSize: 13,
                ))),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.posts[index].isLiked =
                          !widget.posts[index].isLiked;
                      if (widget.posts[index].isLiked) {
                        widget.posts[index].likes++;
                      } else {
                        widget.posts[index].likes--;
                      }
                    });
                  },
                  child: Icon(
                    widget.posts[index].isLiked
                        ? Icons.favorite
                        : Icons.favorite_outline_outlined,
                    color: Color(0xFF666538),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.posts[index].likes.toString(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666538),
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.comment,
                  color: Color(0xFF666538),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.posts[index].comment.toString(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666538),
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      if (widget.posts[index].isRepost) {
                      } else {
                        widget.posts[index].repost++;
                      }
                      widget.posts[index].isRepost =
                          !widget.posts[index].isRepost;
                    });

                    await addRepostForUser(widget.posts[index]);
                  },
                  child: Icon(
                    widget.posts[index].isRepost
                        ? Icons.repeat_on
                        : Icons.repeat,
                    color: Color(0xFF666538),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.posts[index].repost.toString(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666538),
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 2, color: const Color(0xFF666538).withOpacity(0.2))
          ],
        );
      },
    );
  }
}
