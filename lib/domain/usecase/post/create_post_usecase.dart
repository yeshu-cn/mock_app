import 'package:lushan/domain/model/post.dart';
import 'package:lushan/domain/repository/post_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/usecase.dart';
import 'package:uuid/uuid.dart';

class CreatePostUseCase extends UseCase {
  final PostRepository _postRepository;
  final AuthService _authService;


  CreatePostUseCase(this._postRepository, this._authService);

  Future<bool> execute(
      String desc, List<String> tags, List<String> filePaths) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    var post = Post(
      id: Uuid().v4(),
      desc: desc,
      images: filePaths,
      time: DateTime.now().millisecondsSinceEpoch,
      authorId: uid,
      tags: tags
    );
    _postRepository.createPost(post);
    return true;
  }
}
