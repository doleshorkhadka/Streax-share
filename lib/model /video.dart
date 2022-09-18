// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:streax_share/model%20/user.dart';

enum React { love, haha, wow, sad, angry }

class Video {
  final User _user;
  final Map<React, double> _react;
  final double _commentCount;
  final double _shareCount;
  final double _saveCount;

  Video(
    user,
    react,
    commentCount,
    shareCount,
    saveCount,
  )   : _user = user,
        _react = react,
        _commentCount = commentCount,
        _shareCount = shareCount,
        _saveCount = saveCount;
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userid': _user.uid,
      'react': _react,
      'commentCount': _commentCount,
      'sharecount': _shareCount,
      'savecount': _saveCount
    };
  }
}
