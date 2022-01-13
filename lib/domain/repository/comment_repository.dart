import 'package:lushan/domain/model/comment.dart';

abstract class CommentRepository {
  Future<bool> addComment(Comment comment);

  Future<bool> deleteComment(String commentId);

  Future<List<Comment>> queryListByPostId(String postId);
}