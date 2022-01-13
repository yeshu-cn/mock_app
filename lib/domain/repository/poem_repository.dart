import '../model/poem.dart';

abstract class PoemRepository {
  Future<List<Poem>> getPoemList();
}
