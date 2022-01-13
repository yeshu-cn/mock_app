import 'package:lushan/domain/model/comment.dart';
import 'package:lushan/domain/repository/comment_repository.dart';
import 'package:lushan/domain/repository/user_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';
import 'package:uuid/uuid.dart';

class CreateCommentUseCase extends UseCase {
  final UserRepository _userRepository;
  final CommentRepository _commentRepository;
  final AuthService _authService;


  CreateCommentUseCase(
      this._userRepository, this._commentRepository, this._authService);

  Future<bool> execute(String postId, String content,
      {String? replyUid}) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    var user = await _userRepository.queryUserById(uid);
    Comment comment = Comment(
        id: Uuid().v4(),
        postId: postId,
        content: content,
        time: DateTime.now().millisecondsSinceEpoch,
        authorUid: user!.uid,
        replyUid: replyUid);
    return await _commentRepository.addComment(comment);
  }
}
