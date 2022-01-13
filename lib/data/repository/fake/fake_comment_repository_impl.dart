import 'package:lushan/domain/model/comment.dart';
import 'package:lushan/domain/repository/comment_repository.dart';

class FakeCommentRepositoryImpl implements CommentRepository {
  List<Comment> data = [];

  @override
  Future<bool> addComment(Comment comment) async {
    data.add(comment);
    return true;
  }

  @override
  Future<bool> deleteComment(String commentId) async {
    data.removeWhere((element) => commentId == element.id);
    return true;
  }

  @override
  Future<List<Comment>> queryListByPostId(String postId) async {
    return data.where((element) => element.postId == postId).toList();
  }
}
