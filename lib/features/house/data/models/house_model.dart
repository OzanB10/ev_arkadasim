import 'package:hive/hive.dart';

part 'house_model.g.dart';

@HiveType(typeId: 0)
class HouseModel extends HiveObject {
  @HiveField(0)
  late String houseId;
  
  @HiveField(1)
  late String name;
  
  @HiveField(2)
  late String code;
  
  @HiveField(3)
  late List<String> memberIds;
  
  @HiveField(4)
  late DateTime createdAt;
  
  @HiveField(5)
  late DateTime updatedAt;
} 