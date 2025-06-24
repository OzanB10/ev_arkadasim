// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Balance {
  String get memberId => throw _privateConstructorUsedError;
  String get memberName => throw _privateConstructorUsedError;
  double get totalPaid => throw _privateConstructorUsedError;
  double get totalOwed => throw _privateConstructorUsedError;
  double get netBalance => throw _privateConstructorUsedError;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BalanceCopyWith<Balance> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceCopyWith<$Res> {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) then) =
      _$BalanceCopyWithImpl<$Res, Balance>;
  @useResult
  $Res call(
      {String memberId,
      String memberName,
      double totalPaid,
      double totalOwed,
      double netBalance});
}

/// @nodoc
class _$BalanceCopyWithImpl<$Res, $Val extends Balance>
    implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? memberName = null,
    Object? totalPaid = null,
    Object? totalOwed = null,
    Object? netBalance = null,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      totalOwed: null == totalOwed
          ? _value.totalOwed
          : totalOwed // ignore: cast_nullable_to_non_nullable
              as double,
      netBalance: null == netBalance
          ? _value.netBalance
          : netBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceImplCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$$BalanceImplCopyWith(
          _$BalanceImpl value, $Res Function(_$BalanceImpl) then) =
      __$$BalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String memberId,
      String memberName,
      double totalPaid,
      double totalOwed,
      double netBalance});
}

/// @nodoc
class __$$BalanceImplCopyWithImpl<$Res>
    extends _$BalanceCopyWithImpl<$Res, _$BalanceImpl>
    implements _$$BalanceImplCopyWith<$Res> {
  __$$BalanceImplCopyWithImpl(
      _$BalanceImpl _value, $Res Function(_$BalanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? memberName = null,
    Object? totalPaid = null,
    Object? totalOwed = null,
    Object? netBalance = null,
  }) {
    return _then(_$BalanceImpl(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      totalOwed: null == totalOwed
          ? _value.totalOwed
          : totalOwed // ignore: cast_nullable_to_non_nullable
              as double,
      netBalance: null == netBalance
          ? _value.netBalance
          : netBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$BalanceImpl extends _Balance {
  const _$BalanceImpl(
      {required this.memberId,
      required this.memberName,
      required this.totalPaid,
      required this.totalOwed,
      required this.netBalance})
      : super._();

  @override
  final String memberId;
  @override
  final String memberName;
  @override
  final double totalPaid;
  @override
  final double totalOwed;
  @override
  final double netBalance;

  @override
  String toString() {
    return 'Balance(memberId: $memberId, memberName: $memberName, totalPaid: $totalPaid, totalOwed: $totalOwed, netBalance: $netBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.totalOwed, totalOwed) ||
                other.totalOwed == totalOwed) &&
            (identical(other.netBalance, netBalance) ||
                other.netBalance == netBalance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, memberId, memberName, totalPaid, totalOwed, netBalance);

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      __$$BalanceImplCopyWithImpl<_$BalanceImpl>(this, _$identity);
}

abstract class _Balance extends Balance {
  const factory _Balance(
      {required final String memberId,
      required final String memberName,
      required final double totalPaid,
      required final double totalOwed,
      required final double netBalance}) = _$BalanceImpl;
  const _Balance._() : super._();

  @override
  String get memberId;
  @override
  String get memberName;
  @override
  double get totalPaid;
  @override
  double get totalOwed;
  @override
  double get netBalance;

  /// Create a copy of Balance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Debt {
  String get debtorId => throw _privateConstructorUsedError;
  String get debtorName => throw _privateConstructorUsedError;
  String get creditorId => throw _privateConstructorUsedError;
  String get creditorName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebtCopyWith<Debt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtCopyWith<$Res> {
  factory $DebtCopyWith(Debt value, $Res Function(Debt) then) =
      _$DebtCopyWithImpl<$Res, Debt>;
  @useResult
  $Res call(
      {String debtorId,
      String debtorName,
      String creditorId,
      String creditorName,
      double amount});
}

/// @nodoc
class _$DebtCopyWithImpl<$Res, $Val extends Debt>
    implements $DebtCopyWith<$Res> {
  _$DebtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? debtorId = null,
    Object? debtorName = null,
    Object? creditorId = null,
    Object? creditorName = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      debtorId: null == debtorId
          ? _value.debtorId
          : debtorId // ignore: cast_nullable_to_non_nullable
              as String,
      debtorName: null == debtorName
          ? _value.debtorName
          : debtorName // ignore: cast_nullable_to_non_nullable
              as String,
      creditorId: null == creditorId
          ? _value.creditorId
          : creditorId // ignore: cast_nullable_to_non_nullable
              as String,
      creditorName: null == creditorName
          ? _value.creditorName
          : creditorName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DebtImplCopyWith<$Res> implements $DebtCopyWith<$Res> {
  factory _$$DebtImplCopyWith(
          _$DebtImpl value, $Res Function(_$DebtImpl) then) =
      __$$DebtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String debtorId,
      String debtorName,
      String creditorId,
      String creditorName,
      double amount});
}

/// @nodoc
class __$$DebtImplCopyWithImpl<$Res>
    extends _$DebtCopyWithImpl<$Res, _$DebtImpl>
    implements _$$DebtImplCopyWith<$Res> {
  __$$DebtImplCopyWithImpl(_$DebtImpl _value, $Res Function(_$DebtImpl) _then)
      : super(_value, _then);

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? debtorId = null,
    Object? debtorName = null,
    Object? creditorId = null,
    Object? creditorName = null,
    Object? amount = null,
  }) {
    return _then(_$DebtImpl(
      debtorId: null == debtorId
          ? _value.debtorId
          : debtorId // ignore: cast_nullable_to_non_nullable
              as String,
      debtorName: null == debtorName
          ? _value.debtorName
          : debtorName // ignore: cast_nullable_to_non_nullable
              as String,
      creditorId: null == creditorId
          ? _value.creditorId
          : creditorId // ignore: cast_nullable_to_non_nullable
              as String,
      creditorName: null == creditorName
          ? _value.creditorName
          : creditorName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DebtImpl implements _Debt {
  const _$DebtImpl(
      {required this.debtorId,
      required this.debtorName,
      required this.creditorId,
      required this.creditorName,
      required this.amount});

  @override
  final String debtorId;
  @override
  final String debtorName;
  @override
  final String creditorId;
  @override
  final String creditorName;
  @override
  final double amount;

  @override
  String toString() {
    return 'Debt(debtorId: $debtorId, debtorName: $debtorName, creditorId: $creditorId, creditorName: $creditorName, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtImpl &&
            (identical(other.debtorId, debtorId) ||
                other.debtorId == debtorId) &&
            (identical(other.debtorName, debtorName) ||
                other.debtorName == debtorName) &&
            (identical(other.creditorId, creditorId) ||
                other.creditorId == creditorId) &&
            (identical(other.creditorName, creditorName) ||
                other.creditorName == creditorName) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, debtorId, debtorName, creditorId, creditorName, amount);

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtImplCopyWith<_$DebtImpl> get copyWith =>
      __$$DebtImplCopyWithImpl<_$DebtImpl>(this, _$identity);
}

abstract class _Debt implements Debt {
  const factory _Debt(
      {required final String debtorId,
      required final String debtorName,
      required final String creditorId,
      required final String creditorName,
      required final double amount}) = _$DebtImpl;

  @override
  String get debtorId;
  @override
  String get debtorName;
  @override
  String get creditorId;
  @override
  String get creditorName;
  @override
  double get amount;

  /// Create a copy of Debt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebtImplCopyWith<_$DebtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
