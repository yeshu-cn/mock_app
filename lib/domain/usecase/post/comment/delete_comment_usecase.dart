import 'package:lushan/domain/repository/comment_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class DeleteCommentUseCase extends UseCase {
  final CommentRepository _commentRepository;
  final AuthService _authService;

  DeleteCommentUseCase(this._commentRepository, this._authService);

  Future<bool> execute(String commentId) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    // 只能删除自己的评论
    return await _commentRepository.deleteComment(commentId);
  }
}
