// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_settings_model.freezed.dart';
part 'card_settings_model.g.dart';

@freezed
class CardSettingsModel with _$CardSettingsModel {
  const factory CardSettingsModel({
    @JsonKey(name: 'changePinEnabled') required bool changePinEnabled,
    @JsonKey(name: 'qrPaymentEnabled') required bool qrPaymentEnabled,
    @JsonKey(name: 'onlineShoppingEnabled') required bool onlineShoppingEnabled,
  }) = _CardSettingsModel;

  factory CardSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$CardSettingsModelFromJson(json);
}
