import '../entities/house.dart';
import '../entities/member.dart';

abstract class HouseRepository {
  Future<House> createHouse({
    required String name,
    required String creatorName,
  });
  
  Future<House?> joinHouse({
    required String code,
    required String memberName,
  });
  
  Future<House?> getCurrentHouse();
  
  Future<List<Member>> getHouseMembers(String houseId);

  Future<House?> updateHouseName({
    required String houseId,
    required String newName,
  });

  Future<bool> leaveHouse({
    required String houseId,
    required String memberId,
  });

  Future<bool> deleteHouse(String houseId);
} 