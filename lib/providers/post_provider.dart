import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gardenguru/models/post.dart';

class RepostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  Future<List<Post>> fetchPosts() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        String userId = user.uid;
        DatabaseReference userPostsRef =
            _databaseReference.child('users').child(userId).child('repost');

        DatabaseEvent databaseEvent = await userPostsRef.once();
        dynamic dataList = databaseEvent.snapshot.value;

        if (dataList != null) {
          if (dataList is List<dynamic>) {
            _posts = dataList.map((data) => Post.fromMap(data)).toList();
          } else if (dataList is Map<dynamic, dynamic>) {
            _posts = dataList.values.map((data) => Post.fromMap(data)).toList();
          }
        } else {
          _posts = [];
        }
      }
    } catch (e) {
      print(e);
    }
    return _posts;
  }
}

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  Future<List<Post>> fetchPosts() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        String userId = user.uid;
        DatabaseReference userPostsRef =
            _databaseReference.child('users').child(userId).child('post');

        DatabaseEvent databaseEvent = await userPostsRef.once();
        dynamic dataList = databaseEvent.snapshot.value;

        if (dataList != null) {
          if (dataList is List<dynamic>) {
            _posts = dataList.map((data) => Post.fromMap(data)).toList();
          } else if (dataList is Map<dynamic, dynamic>) {
            _posts = dataList.values.map((data) => Post.fromMap(data)).toList();
          }
        } else {
          _posts = [];
        }
      }
    } catch (e) {
      print(e);
    }
    return _posts;
  }
}

class GardenProvider with ChangeNotifier {
  List<int> _garden = [];

  List<int> get garden => _garden;

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  Future<List<int>> fetchGardenNumbers() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        String userId = user.uid;
        DatabaseReference userNumbersRef =
            _databaseReference.child('users').child(userId).child('numbers');

        DatabaseEvent databaseEvent = await userNumbersRef.once();
        dynamic dataList = databaseEvent.snapshot.value;

        if (dataList != null && dataList is Map<dynamic, dynamic>) {
          _garden = dataList.values.map<int>((value) => value as int).toList();
        } else {
          _garden = [];
        }

        notifyListeners();
        return _garden;
      }
    } catch (e) {
      print(e);
    }
    return _garden;
  }
}
