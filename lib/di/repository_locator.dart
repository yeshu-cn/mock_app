import 'package:lushan/data/repository/fake/fake_comment_repository_impl.dart';
import 'package:lushan/data/repository/fake/fake_favorite_post_repository_impl.dart';
import 'package:lushan/data/repository/fake/fake_liked_post_repository_impl.dart';
import 'package:lushan/data/repository/fake/fake_poem_repository_impl.dart';
import 'package:lushan/data/repository/fake/fake_post_repository_impl.dart';
import 'package:lushan/data/repository/fake/fake_scenic_spot_repository_impl.dart';
import 'package:lushan/data/repository/fake/fake_user_repository_impl.dart';
import 'package:lushan/domain/repository/comment_repository.dart';
import 'package:lushan/domain/repository/favorite_post_repository.dart';
import 'package:lushan/domain/repository/liked_post_repository.dart';
import 'package:lushan/domain/repository/poem_repository.dart';
import 'package:lushan/domain/repository/post_repository.dart';
import 'package:lushan/domain/repository/scenic_spot_repository.dart';
import 'package:lushan/domain/repository/user_repository.dart';

class RepositoryLocator {
  static final PostRepository _postRepository = FakePostRepositoryImpl();
  static final ScenicSpotRepository _scenicSpotRepository =
      FakeScenicSpotRepositoryImpl();
  static final PoemRepository _poemRepository = FakePoemRepositoryImpl();
  static LikedPostRepository _likedPostRepository =
      FakeLikedPostRepositoryImpl();
  static FavoritePostRepository _favoritePostRepository =
      FakeFavoritePostRepositoryImpl();
  static CommentRepository _commentRepository = FakeCommentRepositoryImpl();
  static UserRepository _userRepository = FakeUserRepositoryImpl();

  static PostRepository getPostRepository() {
    return _postRepository;
  }

  static ScenicSpotRepository getScenicSpotRepository() {
    return _scenicSpotRepository;
  }

  static PoemRepository getPoemRepo() {
    return _poemRepository;
  }

  static LikedPostRepository get likedPostRepo => _likedPostRepository;

  static FavoritePostRepository get favoritePostRepo => _favoritePostRepository;

  static CommentRepository get commentRepository => _commentRepository;

  static UserRepository get userRepository => _userRepository;
}
