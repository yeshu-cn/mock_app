import 'package:lushan/domain/model/liked_post.dart';
import 'package:lushan/domain/repository/liked_post_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class LikePostUseCase extends UseCase{
  final LikedPostRepository _likedPostRepository;
  final AuthService _authService;


  LikePostUseCase(this._likedPostRepository,
      this._authService);

  Future<bool> execute(String postId, bool like) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    if (like) {
      return await _likedPostRepository.create(LikedPost(postId: postId, uid: uid));
    } else {
      return await _likedPostRepository.delete(LikedPost(postId: postId, uid: uid));
    }
  }
}