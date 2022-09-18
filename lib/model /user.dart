// ignore_for_file: public_member_api_docs, sort_constructors_first
enum React { love, haha, wow, sad, angry }

class User {
  final String _username;
  final String _email;
  final String _uid;
  final String _imageUrl;

  User({
    required String username,
    required String email,
    required String uid,
    required String imageUrl,
  })  : _username = username,
        _email = email,
        _uid = uid,
        _imageUrl = imageUrl;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': _username,
      'email': _email,
      'uid': _uid,
      'imageurl': _imageUrl,
    };
  }

  String get uid => _uid;
}
