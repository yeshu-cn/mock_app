import 'package:lushan/domain/model/liked_post.dart';
import 'package:lushan/domain/repository/liked_post_repository.dart';

class FakeLikedPostRepositoryImpl implements LikedPostRepository {
  List<LikedPost> data = [];
  @override
  Future<bool> create(LikedPost likedPost) async {
    data.add(likedPost);
    return true;
  }

  @override
  Future<bool> delete(LikedPost likedPost) async {
    data.removeWhere((element) => element == likedPost);
    return true;
  }

  @override
  Future<List<LikedPost>> queryListByPostId(String postId) async {
    return data.where((value) => value.postId == postId).toList();
  }

  @override
  Future<List<LikedPost>> queryListByUid(String uid) async {
    return data.where((value) => value.uid == uid).toList();
  }
  
}