import 'package:hive_flutter/hive_flutter.dart';

part 'devicedetails_model.g.dart';

@HiveType(typeId: 0)
class DeviceDetailsModel {
  DeviceDetailsModel({
    this.osVersion,
    this.deviceName,
    this.deviceType,
    this.versionCode,
    this.notificationToken,
    this.phoneId,
    this.buildNumber,
    this.deviceToken,
  });
  @HiveField(0)
  final String? osVersion;
  @HiveField(1)
  final String? deviceName;
  @HiveField(2)
  final String? deviceType;
  @HiveField(3)
  final String? versionCode;
  @HiveField(4)
  final String? notificationToken;
  @HiveField(5)
  final String? phoneId;
  @HiveField(6)
  final String? buildNumber;
  @HiveField(7)
  final String? deviceToken;
}
