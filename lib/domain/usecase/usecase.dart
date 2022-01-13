import 'package:lushan/utils/config_utils.dart';

class UseCase {
  late String token;
  UseCase() {
    // 这个本来是应该通过参数传进来的，为了偷懒统一在生成UseCase时注入
    token = ConfigUtils.getUserToken()!;
  }
}