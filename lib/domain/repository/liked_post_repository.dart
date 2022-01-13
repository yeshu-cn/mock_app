import 'package:lushan/domain/model/liked_post.dart';

abstract class LikedPostRepository {
  Future<bool> create(LikedPost likedPost);

  Future<bool> delete(LikedPost likedPost);

  Future<List<LikedPost>> queryListByPostId(String postId);

  Future<List<LikedPost>> queryListByUid(String uid);
}