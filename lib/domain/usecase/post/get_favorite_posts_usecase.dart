import 'package:lushan/domain/model/liked_post.dart';
import 'package:lushan/domain/model/post.dart';
import 'package:lushan/domain/repository/comment_repository.dart';
import 'package:lushan/domain/repository/favorite_post_repository.dart';
import 'package:lushan/domain/repository/liked_post_repository.dart';
import 'package:lushan/domain/repository/post_repository.dart';
import 'package:lushan/domain/repository/user_repository.dart';
import 'package:lushan/domain/service/auth_service.dart';
import 'package:lushan/domain/usecase/dto/post_dto.dart';
import 'package:lushan/domain/usecase/usecase.dart';
import 'package:collection/collection.dart';

class GetFavoritePostsUseCase extends UseCase{
  PostRepository _postRepository;
  UserRepository _userRepository;
  LikedPostRepository _likedPostRepository;
  FavoritePostRepository _favoritePostRepository;
  CommentRepository _commentRepository;
  final AuthService _authService;


  GetFavoritePostsUseCase(
      this._postRepository,
      this._userRepository,
      this._likedPostRepository,
      this._favoritePostRepository,
      this._commentRepository,
      this._authService);

  Future<List<PostDTO>> execute(int offset, int limit) async {
    var uid = _authService.getUid(token);
    if (null == uid) {
      throw Exception('invalid token');
    }
    var user = await _userRepository.queryUserById(uid);
    if (null == user) {
      throw Exception('user is null');
    }
    var userLikedPosts = await _likedPostRepository.queryListByUid(user.uid);
    var favoritePostIds = (await _favoritePostRepository.queryListByUid(user.uid)).map((e) => e.postId).toList();
    var favoritePost = await _postRepository.getPostListByIds(favoritePostIds);
    var list = <PostDTO>[];
    for (var i = 0; i < favoritePost.length; i++) {
      var postDTO = await _toPostDTO(favoritePost[i], userLikedPosts);
      list.add(postDTO);
    }
    return list;
  }

  Future<PostDTO> _toPostDTO(Post post, List<LikedPost> userLikedPosts) async {
    List<LikedPost> likedPostList = await _likedPostRepository.queryListByPostId(post.id);
    var likeCount = likedPostList.length;
    var like = userLikedPosts.firstWhereOrNull((likedPost) => likedPost.postId == post.id) == null ? false : true;
    var authorUser = await _userRepository.queryUserById(post.authorId);
    if (null == authorUser) {
      throw Exception('authorUser is null');
    }
    var commentCount = (await _commentRepository.queryListByPostId(post.id)).length;
    return PostDTO(desc: post.desc,
        images: post.images,
        likeCount: likeCount,
        like: like,
        commentCount: commentCount,
        favorite: true,
        time: post.time,
        nickname: authorUser.nickname,
        avatar: authorUser.avatar,
        id: post.id);
  }
}
