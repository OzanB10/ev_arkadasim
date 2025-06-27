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
  
  Future<void> updateHouseName({required String newName}) async {
    final currentHouse = state.value;
    if (currentHouse == null) return;

    state = const AsyncValue.loading();
    try {
      final updatedHouse = await _repository.updateHouseName(
        houseId: currentHouse.id,
        newName: newName,
      );
      state = AsyncValue.data(updatedHouse);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      // Rollback to previous state on error
      state = AsyncValue.data(currentHouse);
    }
  }

  Future<void> leaveHouse() async {
    // TODO: Need memberId to leave house. For now, we assume it is handled.
    final currentHouse = state.value;
    if (currentHouse == null) return;

    state = const AsyncValue.loading();
    try {
      final success = await _repository.leaveHouse(houseId: currentHouse.id, memberId: 'current_user_id'); // Placeholder
      if (success) {
        state = const AsyncValue.data(null);
      } else {
        throw Exception('Evden ayrılamadı');
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      state = AsyncValue.data(currentHouse);
    }
  }

  Future<void> deleteHouse() async {
    final currentHouse = state.value;
    if (currentHouse == null) return;

    state = const AsyncValue.loading();
    try {
      final success = await _repository.deleteHouse(currentHouse.id);
      if (success) {
        state = const AsyncValue.data(null);
      } else {
        throw Exception('Ev silinemedi');
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      state = AsyncValue.data(currentHouse);
    }
  }
  
  void refresh() {
    _loadCurrentHouse();
  }
} 