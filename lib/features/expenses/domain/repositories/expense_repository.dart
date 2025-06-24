import '../entities/expense.dart';
import '../entities/balance.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);
  
  Future<List<Expense>> getHouseExpenses(String houseId);
  
  Future<List<Expense>> getMonthlyExpenses(String houseId, DateTime month);
  
  Future<List<Balance>> calculateBalances(String houseId);
  
  Future<List<Debt>> calculateDebts(String houseId);
  
  Future<void> deleteExpense(String expenseId);
  
  Future<double> getTotalExpenses(String houseId);
  
  Future<double> getMonthlyTotal(String houseId, DateTime month);
} 