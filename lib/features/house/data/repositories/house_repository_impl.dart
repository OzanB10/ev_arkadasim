import 'package:uuid/uuid.dart';

import '../../../../core/services/database_service.dart';
import '../../../../core/utils/code_generator.dart';
import '../../domain/entities/house.dart';
import '../../domain/entities/member.dart';
import '../../domain/repositories/house_repository.dart';
import '../models/house_model.dart';
import '../models/member_model.dart';

class HouseRepositoryImpl implements HouseRepository {
  static const Uuid _uuid = Uuid();
  
  @override
  Future<House> createHouse({
    required String name,
    required String creatorName,
  }) async {
    final houseId = _uuid.v4();
    final memberId = _uuid.v4();
    final code = CodeGenerator.generateHouseCode();
    final now = DateTime.now();
    
    // Create house
    final houseModel = HouseModel()
      ..houseId = houseId
      ..name = name
      ..code = code
      ..memberIds = [memberId]
      ..createdAt = now
      ..updatedAt = now;
    
    await DatabaseService.housesBox.put(houseId, houseModel);
    
    // Create creator as member
    final memberModel = MemberModel()
      ..memberId = memberId
      ..name = creatorName
      ..houseId = houseId
      ..joinedAt = now;
    
    await DatabaseService.membersBox.put(memberId, memberModel);
    
    return House(
      id: houseId,
      name: name,
      code: code,
      memberIds: [memberId],
      createdAt: now,
      updatedAt: now,
    );
  }
  
  @override
  Future<House?> joinHouse({
    required String code,
    required String memberName,
  }) async {
    // Find house by code
    final houseModel = DatabaseService.housesBox.values
        .where((house) => house.code == code)
        .firstOrNull;
    
    if (houseModel == null) return null;
    
    final memberId = _uuid.v4();
    final now = DateTime.now();
    
    // Add member to house
    houseModel.memberIds.add(memberId);
    houseModel.updatedAt = now;
    await houseModel.save();
    
    // Create new member
    final memberModel = MemberModel()
      ..memberId = memberId
      ..name = memberName
      ..houseId = houseModel.houseId
      ..joinedAt = now;
    
    await DatabaseService.membersBox.put(memberId, memberModel);
    
    return House(
      id: houseModel.houseId,
      name: houseModel.name,
      code: houseModel.code,
      memberIds: houseModel.memberIds,
      createdAt: houseModel.createdAt,
      updatedAt: houseModel.updatedAt,
    );
  }
  
  @override
  Future<House?> getCurrentHouse() async {
    final houseModel = DatabaseService.housesBox.values.firstOrNull;
    
    if (houseModel == null) return null;
    
    return House(
      id: houseModel.houseId,
      name: houseModel.name,
      code: houseModel.code,
      memberIds: houseModel.memberIds,
      createdAt: houseModel.createdAt,
      updatedAt: houseModel.updatedAt,
    );
  }
  
  @override
  Future<List<Member>> getHouseMembers(String houseId) async {
    final memberModels = DatabaseService.membersBox.values
        .where((member) => member.houseId == houseId)
        .toList();
    
    return memberModels.map((model) => Member(
      id: model.memberId,
      name: model.name,
      houseId: model.houseId,
      joinedAt: model.joinedAt,
    )).toList();
  }
} 