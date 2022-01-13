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

class GetLikedPostsUseCase extends UseCase{
  PostRepository _postRepository;
  UserRepository _userRepository;
  LikedPostRepository _likedPostRepository;
  FavoritePostRepository _favoritePostRepository;
  CommentRepository _commentRepository;
  final AuthService _authService;


  GetLikedPostsUseCase(
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
    var userLikedPostsIds = (await _likedPostRepository.queryListByUid(user.uid)).map((e) => e.postId).toList();
    var favoritePostIds = (await _favoritePostRepository.queryListByUid(user.uid)).map((e) => e.postId).toList();
    var userLikedPosts = await _postRepository.getPostListByIds(userLikedPostsIds);
    var list = <PostDTO>[];
    for (var i = 0; i < userLikedPosts.length; i++) {
      var postDTO = await _toPostDTO(userLikedPosts[i], favoritePostIds);
      list.add(postDTO);
    }
    return list;
  }

  Future<PostDTO> _toPostDTO(Post post, List<String> favoritePosts) async {
    List<LikedPost> likedPostList = await _likedPostRepository.queryListByPostId(post.id);
    var likeCount = likedPostList.length;
    var author = await _userRepository.queryUserById(post.authorId);
    if (null == author) {
      throw Exception('authorUserProfile is null');
    }
    var favorite = favoritePosts.contains(post.id);
    var commentCount = (await _commentRepository.queryListByPostId(post.id)).length;
    return PostDTO(desc: post.desc,
        images: post.images,
        likeCount: likeCount,
        like: true,
        commentCount: commentCount,
        favorite: favorite,
        time: post.time,
        nickname: author.nickname,
        avatar: author.avatar,
        id: post.id);
  }
}