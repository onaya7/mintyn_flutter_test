// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'datetime') int? datetime,
    @JsonKey(name: 'headline') String? headline,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'related') String? related,
    @JsonKey(name: 'source') String? source,
    @JsonKey(name: 'summary') String? summary,
    @JsonKey(name: 'url') String? url,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
}
