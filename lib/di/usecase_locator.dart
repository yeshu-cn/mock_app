import 'package:lushan/di/repository_locator.dart';
import 'package:lushan/di/service_locator.dart';
import 'package:lushan/domain/usecase/auth/login_usecase.dart';
import 'package:lushan/domain/usecase/auth/logout_usecase.dart';
import 'package:lushan/domain/usecase/auth/register_usecase.dart';
import 'package:lushan/domain/usecase/auth/wechat_login_usecase.dart';
import 'package:lushan/domain/usecase/post/comment/create_comment_usecase.dart';
import 'package:lushan/domain/usecase/post/comment/delete_comment_usecase.dart';
import 'package:lushan/domain/usecase/post/comment/get_comment_list_usecase.dart';
import 'package:lushan/domain/usecase/post/favorite_post_usecase.dart';
import 'package:lushan/domain/usecase/post/get_favorite_posts_usecase.dart';
import 'package:lushan/domain/usecase/post/get_liked_posts_usecase.dart';
import 'package:lushan/domain/usecase/post/get_post_list_usecase.dart';
import 'package:lushan/domain/usecase/post/get_post_tag_list_usecase.dart';
import 'package:lushan/domain/usecase/post/get_post_usecase.dart';
import 'package:lushan/domain/usecase/post/like_post_usecase.dart';
import 'package:lushan/domain/usecase/post/create_post_usecase.dart';
import 'package:lushan/domain/usecase/update_user_profile_usecase.dart';
import 'package:lushan/domain/usecase/upload_avatar_usecase.dart';

class UseCaseLocator {
  static FavoritePostUseCase get favoritePostUseCase {
    return FavoritePostUseCase(
        RepositoryLocator.favoritePostRepo, ServiceLocator.authService);
  }

  static LikePostUseCase get likePostUseCase {
    return LikePostUseCase(
        RepositoryLocator.likedPostRepo, ServiceLocator.authService);
  }

  static GetPostListUseCase get getPostListUseCase {
    return GetPostListUseCase(
        RepositoryLocator.getPostRepository(),
        RepositoryLocator.userRepository,
        RepositoryLocator.likedPostRepo,
        RepositoryLocator.favoritePostRepo,
        RepositoryLocator.commentRepository,
        ServiceLocator.authService);
  }

  static GetFavoritePostsUseCase get getFavoritePostUseCase {
    return GetFavoritePostsUseCase(
        RepositoryLocator.getPostRepository(),
        RepositoryLocator.userRepository,
        RepositoryLocator.likedPostRepo,
        RepositoryLocator.favoritePostRepo,
        RepositoryLocator.commentRepository,
        ServiceLocator.authService);
  }

  static GetLikedPostsUseCase get getLikedPostUseCase {
    return GetLikedPostsUseCase(
        RepositoryLocator.getPostRepository(),
        RepositoryLocator.userRepository,
        RepositoryLocator.likedPostRepo,
        RepositoryLocator.favoritePostRepo,
        RepositoryLocator.commentRepository,
        ServiceLocator.authService);
  }

  static GetPostUseCase get getPostUseCase {
    return GetPostUseCase(
        RepositoryLocator.getPostRepository(),
        RepositoryLocator.userRepository,
        RepositoryLocator.likedPostRepo,
        RepositoryLocator.favoritePostRepo,
        RepositoryLocator.commentRepository,
        ServiceLocator.authService);
  }

  static GetPostTagListUseCase get getPostTagListUseCase {
    return GetPostTagListUseCase();
  }

  static CreatePostUseCase get createPostUseCase {
    return CreatePostUseCase(
        RepositoryLocator.getPostRepository(), ServiceLocator.authService);
  }

  static GetCommentListUseCase get getCommentListUseCase {
    return GetCommentListUseCase(RepositoryLocator.commentRepository,
        RepositoryLocator.userRepository, ServiceLocator.authService);
  }

  static CreateCommentUseCase get createCommentUseCase {
    return CreateCommentUseCase(RepositoryLocator.userRepository,
        RepositoryLocator.commentRepository, ServiceLocator.authService);
  }

  static DeleteCommentUseCase get deleteCommentUseCase {
    return DeleteCommentUseCase(
        RepositoryLocator.commentRepository, ServiceLocator.authService);
  }

  static UpdateUserProfileUseCase get updateUserProfileUseCase {
    return UpdateUserProfileUseCase(
        RepositoryLocator.userRepository, ServiceLocator.authService);
  }

  static RegisterUseCase get registerUseCase {
    return RegisterUseCase(
        ServiceLocator.userService, ServiceLocator.authService);
  }

  static LoginUseCase get loginUseCase {
    return LoginUseCase(ServiceLocator.userService, ServiceLocator.authService);
  }

  static WeChatLoginUseCase get wechatLoginUseCase {
    return WeChatLoginUseCase(ServiceLocator.wechatService,
        ServiceLocator.authService, ServiceLocator.userService);
  }

  static UploadAvatarUseCase get uploadAvatarUseCase {
    return UploadAvatarUseCase(ServiceLocator.authService);
  }

  static LogoutUseCase get logoutUseCase {
    return LogoutUseCase(ServiceLocator.authService);
  }
}
