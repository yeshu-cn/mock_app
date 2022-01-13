import 'package:lushan/domain/repository/comment_repository.dart';
import 'package:lushan/domain/repository/user_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/dto/comment_dto.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class GetCommentListUseCase extends UseCase {
  final CommentRepository _commentRepository;
  final UserRepository _userRepository;
  final AuthService _authService;


  GetCommentListUseCase(
      this._commentRepository, this._userRepository, this._authService);

  Future<List<CommentDTO>> execute(String postId) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    var data = await _commentRepository.queryListByPostId(postId);
    List<CommentDTO> list = [];
    for (var i = 0; i < data.length; i++) {
      var comment = data[i];
      var author = await _userRepository.queryUserById(data[i].authorUid);
      if (null == author) {
        throw Exception('author is null');
      }
      var replyUid = data[i].replyUid;
      var reply;
      if (null != replyUid) {
        reply = await _userRepository.queryUserById(replyUid);
        if (null == reply) {
          throw Exception('reply is null');
        }
      }

      String authorAvatar = author.avatar;
      String authorNickname = author.nickname;
      String replyNickname = reply != null ? reply.nickname : '';
      list.add(CommentDTO(id: comment.id,
          postId: postId,
          content: comment.content,
          authorUid: comment.authorUid,
          replyUid: comment.replyUid,
          time: comment.time,
          authorAvatar: authorAvatar,
          authorNickname: authorNickname,
          replyNickname: replyNickname));
    }
    // List<CommentDTO> list = [];
    // for (var i = 0; i < 10; i++) {
    //   var author = _userProfileRepository.getCurrentUserProfile();
    //   var reply = _userProfileRepository.getCurrentUserProfile();
    //   String authorAvatar = author.avatar;
    //   String authorNickname = author.nickname;
    //   String replyNickname = reply.nickname;
    //   list.add(CommentDTO(id: Uuid().v4(),
    //       postId: postId,
    //       content: "hahah $i",
    //       authorUid: author.id,
    //       replyUid: null,
    //       time: DateTime.now().millisecondsSinceEpoch,
    //       authorAvatar: authorAvatar,
    //       authorNickname: authorNickname,
    //       replyNickname: replyNickname));
    // }
    return list;
  }
}