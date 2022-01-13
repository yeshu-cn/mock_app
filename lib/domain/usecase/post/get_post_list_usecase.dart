import 'package:lushan/domain/model/favorite_post.dart';
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

class GetPostListUseCase extends UseCase {
  PostRepository _postRepository;
  UserRepository _userRepository;
  LikedPostRepository _likedPostRepository;
  FavoritePostRepository _favoritePostRepository;
  CommentRepository _commentRepository;
  final AuthService _authService;


  GetPostListUseCase(
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
    var data = await _postRepository.getPostList(offset, limit);
    var user = await _userRepository.queryUserById(uid);
    if (null == user) {
      throw Exception('user is null');
    }
    var userLikedPosts = await _likedPostRepository.queryListByUid(user.uid);
    var userFavoritePosts = await _favoritePostRepository.queryListByUid(user.uid);
    var list = <PostDTO>[];
    for (var i = 0; i < data.length; i++) {
      var postDTO = await _toPostDTO(data[i], userLikedPosts, userFavoritePosts);
      list.add(postDTO);
    }
    return list;
  }

  Future<PostDTO> _toPostDTO(Post post, List<LikedPost> userLikedPosts, List<FavoritePost> userFavoritePosts) async {
    List<LikedPost> likedPostList = await _likedPostRepository.queryListByPostId(post.id);
    var likeCount = likedPostList.length;
    var like = userLikedPosts.firstWhereOrNull((likedPost) => likedPost.postId == post.id) == null ? false : true;
    var favorite = userFavoritePosts.firstWhereOrNull((favoritePost) => favoritePost.postId == post.id) == null ? false : true;
    var author = await _userRepository.queryUserById(post.authorId);
    if (null == author) {
      throw Exception('author is null');
    }
    var commentCount = (await _commentRepository.queryListByPostId(post.id)).length;
    return PostDTO(desc: post.desc,
        images: post.images,
        likeCount: likeCount,
        like: like,
        commentCount: commentCount,
        favorite: favorite,
        time: post.time,
        nickname: author.nickname,
        avatar: author.avatar,
        id: post.id);
  }
}
