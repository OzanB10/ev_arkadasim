import 'package:freezed_annotation/freezed_annotation.dart';

part 'house.freezed.dart';

@freezed
class House with _$House {
  const factory House({
    required String id,
    required String name,
    required String code,
    required List<String> memberIds,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _House;
  
  const House._();
  
  int get memberCount => memberIds.length;
  
  bool hasMember(String memberId) {
    return memberIds.contains(memberId);
  }
} 