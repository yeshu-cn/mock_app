import 'package:lushan/domain/usecase/usecase.dart';

class GetPostTagListUseCase extends UseCase {
  Future<List<String>> execute() async {
    await Future.delayed(Duration(seconds: 1));
    List<String> tags = [
      '足球',
      '乒乓球',
      '单板',
      '双板',
    ];
    return tags;
  }
}
