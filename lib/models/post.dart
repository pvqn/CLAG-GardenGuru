class Post {
  int likes;
  int repost;
  int comment;
  String name;
  String time;
  String status;
  bool isLiked;
  bool isRepost;
  Post(
      {required this.likes,
      required this.repost,
      required this.comment,
      required this.name,
      required this.time,
      required this.status,
      required this.isLiked,
      required this.isRepost});

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      likes: map['likes'] ?? 0,
      repost: map['repost'] ?? 0,
      comment: map['comment'] ?? 0,
      name: map['name'] ?? 'atsuki mashiko',
      time: map['time'] ?? 'now',
      status: map['status'] ??
          'Red roses are perhaps the most well-known symbol of love and romance. They are often given on special occasions, particularly Valentine\'s Day, to express deep love and passion.',
      isLiked: map['isLiked'] ?? false,
      isRepost: map['isRepost'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'likes': likes,
      'repost': repost,
      'comment': comment,
      'name': name,
      'time': time,
      'status': status,
      'isLiked': isLiked,
      'isRepost': isRepost,
    };
  }
}
