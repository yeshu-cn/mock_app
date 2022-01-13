import 'package:lushan/domain/model/post.dart';
import 'package:lushan/domain/repository/post_repository.dart';

class FakePostRepositoryImpl implements PostRepository {
  var _data = <Post>[];

  @override
  Future<List<Post>> getPostList(int offset, int limit) async {
    var start = offset;
    var end = start + limit;
    if (start > _data.length - 1) {
      return [];
    }
    if (end > _data.length) {
      end = _data.length;
    }
    return _data.sublist(start, end);
  }

  @override
  Future<bool> createPost(Post post) async{
    _data.add(post);
    return true;
  }

  @override
  Future<List<Post>> getFavoritePost(int offset, int limit) async {
    return _data;
  }

  @override
  Future<List<Post>> getLikedPost(int offset, int limit) async {
    return _data;
  }

  @override
  Future<Post?> getPost(String postId) async {
    return _data.firstWhere((element) => element.id == postId);
  }

  @override
  Future<List<Post>> getPostListByIds(List<String> ids) async {
    return _data.where((element) => ids.contains(element.id)).toList();
  }
}
