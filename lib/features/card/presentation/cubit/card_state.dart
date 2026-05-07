part of 'card_cubit.dart';

@freezed
class CardState with _$CardState {
  const factory CardState.initial() = _CardInitial;
  const factory CardState.loading() = _CardLoading;
  const factory CardState.loaded({required List<CardModel> cards}) = _CardLoaded;
  const factory CardState.error({required String message}) = _CardError;
}
