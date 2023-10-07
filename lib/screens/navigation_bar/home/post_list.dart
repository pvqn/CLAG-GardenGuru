import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Post {
  int likes = 1000;
  int repost = 1000;
  int comment = 1000;
  String name;
  String time;
  String status;
  Post(
      {this.name = 'atsuki mashiko',
      this.status =
          'Red roses are perhaps the most well-known symbol of love and romance. They are often given on special occasions, particularly Valentine\'s Day, to express deep love and passion.',
      this.time = '1 hour ago'});
}

class PostList extends StatefulWidget {
  final List<Post> posts = [
    Post(),
    Post(
        name: 'higuchi kouhei',
        status:
            'Different colors of tulips can convey different emotions, but in general, they are associated with perfect love. Red tulips specifically represent true love.',
        time: '2 hours ago')
  ];

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/plants/6.jpg'),
                ),
                SizedBox(
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
                SizedBox(
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
                const Icon(
                  Icons.favorite,
                  color: Color(0xFF666538),
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
                const Icon(
                  Icons.repeat,
                  color: Color(0xFF666538),
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
