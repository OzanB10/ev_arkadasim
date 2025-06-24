import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';

@freezed
class Expense with _$Expense {
  const factory Expense({
    required String id,
    required String houseId,
    required String payerId,
    required double amount,
    required String description,
    required List<String> participantIds,
    required DateTime createdAt,
  }) = _Expense;
  
  const Expense._();
  
  double get amountPerPerson => amount / participantIds.length;
  
  bool isParticipant(String memberId) {
    return participantIds.contains(memberId);
  }
  
  bool isPayer(String memberId) {
    return payerId == memberId;
  }
} 