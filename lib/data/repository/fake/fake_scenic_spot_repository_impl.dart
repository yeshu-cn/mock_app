import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lushan/domain/model/scenic_spot.dart';
import 'package:lushan/domain/repository/scenic_spot_repository.dart';

class FakeScenicSpotRepositoryImpl implements ScenicSpotRepository {
  List<ScenicSpot> _data = [];

  @override
  Future<List<ScenicSpot>> getScenicSpotList(int offset, int limit) async {
    await Future.delayed(Duration(seconds: 1));
    var start = offset;
    var end = start + limit;
    if (start > _data.length - 1) {
      return [];
    }
    if (end > _data.length - 1) {
      end = _data.length - 1;
    }
    return _data.sublist(start, end);
  }

  @override
  Future<List<ScenicSpot>> getFavoriteScenicSpotList() {
    // TODO: implement getFavoriteScenicSpotList
    throw UnimplementedError();
  }

  void initFakeData() async {
    var json = jsonDecode(await rootBundle.loadString('assets/data/scenicSpot'));
    List<ScenicSpot> list = List<ScenicSpot>.from(json.map((x) => ScenicSpot.fromJson(x)));
    _data.addAll(list);
  }

  FakeScenicSpotRepositoryImpl() {
    initFakeData();
  }
}
