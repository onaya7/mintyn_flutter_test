// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mintyn/features/card/data/model/card_settings_model.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

@freezed
class CardModel with _$CardModel {
  const factory CardModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'lastFour') required String lastFour,
    @JsonKey(name: 'holder') required String holder,
    @JsonKey(name: 'validDate') required String validDate,
    @JsonKey(name: 'cvv') required String cvv,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'isActive') required bool isActive,
    @JsonKey(name: 'settings') required CardSettingsModel settings,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
}
