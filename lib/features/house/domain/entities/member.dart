import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';

@freezed
class Member with _$Member {
  const factory Member({
    required String id,
    required String name,
    required String houseId,
    required DateTime joinedAt,
  }) = _Member;
} 