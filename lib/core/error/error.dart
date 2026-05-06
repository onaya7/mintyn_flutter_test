import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

@freezed
class MintynException with _$MintynException implements Exception {
  /// thrown when there is a problem with the server
  const factory MintynException.server(String message) = _$MintynExceptionServer;

  /// thrown when there is no internet
  const factory MintynException.noInternet() = _$MintynExceptionNoInternet;

  /// thrown when there is a problem with the app
  const factory MintynException.app(String? message) = _$MintynExceptionApp;

  /// thrown when the error is unknown
  const factory MintynException.unknown() = _$MintynExceptionUnknown;
}
