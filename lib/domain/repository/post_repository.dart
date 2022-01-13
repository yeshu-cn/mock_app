import '../model/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPostList(int offset, int limit);

  Future<bool> createPost(Post post);

  Future<List<Post>> getFavoritePost(int offset, int limit);

  Future<List<Post>> getLikedPost(int offset, int limit);

  Future<Post?> getPost(String postId);

  Future<List<Post>> getPostListByIds(List<String> ids);
}
