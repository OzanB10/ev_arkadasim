import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 2)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  late String expenseId;
  
  @HiveField(1)
  late String houseId;
  
  @HiveField(2)
  late String payerId;
  
  @HiveField(3)
  late double amount;
  
  @HiveField(4)
  late String description;
  
  @HiveField(5)
  late List<String> participantIds;
  
  @HiveField(6)
  late DateTime createdAt;
} 