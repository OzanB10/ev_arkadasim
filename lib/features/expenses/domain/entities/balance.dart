import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance.freezed.dart';

@freezed
class Balance with _$Balance {
  const factory Balance({
    required String memberId,
    required String memberName,
    required double totalPaid,
    required double totalOwed,
    required double netBalance,
  }) = _Balance;
  
  const Balance._();
  
  bool get isInDebt => netBalance < 0;
  bool get isInCredit => netBalance > 0;
  bool get isBalanced => netBalance == 0;
}

@freezed
class Debt with _$Debt {
  const factory Debt({
    required String debtorId,
    required String debtorName,
    required String creditorId,
    required String creditorName,
    required double amount,
  }) = _Debt;
} 