import 'package:lushan/domain/model/favorite_post.dart';
import 'package:lushan/domain/repository/favorite_post_repository.dart';

class FakeFavoritePostRepositoryImpl implements FavoritePostRepository {
  List<FavoritePost> data = [];
  @override
  Future<bool> create(FavoritePost favoritePost) async {
    data.add(favoritePost);
    return true;
  }

  @override
  Future<bool> delete(FavoritePost favoritePost) async {
    data.removeWhere((element) => element == favoritePost);
    return true;
  }

  @override
  Future<List<FavoritePost>> queryListByUid(String uid) async {
    return data.where((value) => value.uid == uid).toList();
  }

}