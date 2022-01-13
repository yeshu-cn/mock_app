import 'package:lushan/domain/model/post.dart';

abstract class PostService {
  Future<bool> createPost(String desc, List<String> filePaths);
}
