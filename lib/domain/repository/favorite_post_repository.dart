import 'package:lushan/domain/model/favorite_post.dart';

abstract class FavoritePostRepository {
  Future<bool> create(FavoritePost favoritePost);

  Future<bool> delete(FavoritePost favoritePost);

  Future<List<FavoritePost>> queryListByUid(String uid);
}