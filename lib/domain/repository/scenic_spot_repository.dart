
import '../model/scenic_spot.dart';

abstract class ScenicSpotRepository {
  Future<List<ScenicSpot>> getScenicSpotList(int offset, int limit);

  Future<List<ScenicSpot>> getFavoriteScenicSpotList();
}
