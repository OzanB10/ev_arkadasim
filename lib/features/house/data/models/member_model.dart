import 'package:hive/hive.dart';

part 'member_model.g.dart';

@HiveType(typeId: 1)
class MemberModel extends HiveObject {
  @HiveField(0)
  late String memberId;
  
  @HiveField(1)
  late String name;
  
  @HiveField(2)
  late String houseId;
  
  @HiveField(3)
  late DateTime joinedAt;
} 