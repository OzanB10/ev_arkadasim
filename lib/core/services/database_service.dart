import 'package:hive_flutter/hive_flutter.dart';

import '../../features/house/data/models/house_model.dart';
import '../../features/house/data/models/member_model.dart';
import '../../features/expenses/data/models/expense_model.dart';

class DatabaseService {
  static const String _housesBoxName = 'houses';
  static const String _membersBoxName = 'members';
  static const String _expensesBoxName = 'expenses';
  
  static Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(HouseModelAdapter());
    Hive.registerAdapter(MemberModelAdapter());
    Hive.registerAdapter(ExpenseModelAdapter());
    
    // Open boxes
    await Hive.openBox<HouseModel>(_housesBoxName);
    await Hive.openBox<MemberModel>(_membersBoxName);
    await Hive.openBox<ExpenseModel>(_expensesBoxName);
  }
  
  static Box<HouseModel> get housesBox => Hive.box<HouseModel>(_housesBoxName);
  static Box<MemberModel> get membersBox => Hive.box<MemberModel>(_membersBoxName);
  static Box<ExpenseModel> get expensesBox => Hive.box<ExpenseModel>(_expensesBoxName);
  
  static Future<void> close() async {
    await Hive.close();
  }
} 