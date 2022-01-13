import 'package:lushan/domain/model/favorite_post.dart';
import 'package:lushan/domain/repository/favorite_post_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';

class FavoritePostUseCase extends UseCase {
  final FavoritePostRepository _favoritePostRepository;
  final AuthService _authService;


  FavoritePostUseCase(this._favoritePostRepository,
      this._authService);

  Future<bool> execute(String postId, bool favorite) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    if (favorite) {
      return await _favoritePostRepository.create(FavoritePost(postId: postId, uid: uid));
    } else {
      return await _favoritePostRepository.delete(FavoritePost(postId: postId, uid: uid));
    }
  }
}
