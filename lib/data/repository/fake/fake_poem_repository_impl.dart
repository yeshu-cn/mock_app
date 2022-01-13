import 'package:lushan/domain/repository/poem_repository.dart';
import 'package:lushan/domain/model/poem.dart';

class FakePoemRepositoryImpl implements PoemRepository {
  @override
  Future<List<Poem>> getPoemList() async {
    return [];
  }
}