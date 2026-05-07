import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactionhistory_model.freezed.dart';
part 'transactionhistory_model.g.dart';

@freezed
class TransactionHistoryModel with _$TransactionHistoryModel {
  const factory TransactionHistoryModel({
    @JsonKey(name: 'tranxType') String? tranxType,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'dateTime') DateTime? dateTime,
    @JsonKey(name: 'amount') String? amount,
    @JsonKey(name: 'isDebit') bool? isDebit,
  }) = _TransactionHistoryModel;

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => _$TransactionHistoryModelFromJson(json);
}
