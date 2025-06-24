import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/house.dart';
import '../../domain/repositories/house_repository.dart';

final houseControllerProvider = FutureProvider<House?>((ref) async {
  final repository = sl<HouseRepository>();
  return await repository.getCurrentHouse();
});

final houseNotifierProvider = StateNotifierProvider<HouseNotifier, AsyncValue<House?>>((ref) {
  return HouseNotifier(sl<HouseRepository>());
});

class HouseNotifier extends StateNotifier<AsyncValue<House?>> {
  final HouseRepository _repository;
  
  HouseNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadCurrentHouse();
  }
  
  Future<void> _loadCurrentHouse() async {
    try {
      final house = await _repository.getCurrentHouse();
      state = AsyncValue.data(house);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> createHouse({
    required String name,
    required String creatorName,
  }) async {
    state = const AsyncValue.loading();
    try {
      final house = await _repository.createHouse(
        name: name,
        creatorName: creatorName,
      );
      state = AsyncValue.data(house);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> joinHouse({
    required String code,
    required String memberName,
  }) async {
    state = const AsyncValue.loading();
    try {
      final house = await _repository.joinHouse(
        code: code,
        memberName: memberName,
      );
      if (house != null) {
        state = AsyncValue.data(house);
      } else {
        state = AsyncValue.error('Geçersiz ev kodu', StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  void refresh() {
    _loadCurrentHouse();
  }
} 