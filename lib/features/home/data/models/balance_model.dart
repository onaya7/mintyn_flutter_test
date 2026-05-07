// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_model.freezed.dart';
part 'balance_model.g.dart';

@freezed
class BalanceModel with _$BalanceModel {
  const factory BalanceModel({
    @JsonKey(name: 'balance') required int balance,
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'holder') required String holder,
  }) = _BalanceModel;

  /// Unwraps the API envelope: { "data": { ... } }
  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json['data'] as Map<String, dynamic>);
}
