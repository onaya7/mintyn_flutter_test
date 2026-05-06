import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/local_data/model/devicedetails_model.dart';
import 'package:mintyn/utils/logger.dart';

abstract class LocalDataStorage {
  Future<void> setDeviceDetails({required DeviceDetailsModel value});
  DeviceDetailsModel getDeviceDetails();

  Future<void> setIsLoggedIn({required bool value});
  bool getIsLoggedIn();

  Future<void> setOnboarded({required bool value});
  bool getOnboarded();

  Future<void> clear();
}

class SavedJobsModel {}

@LazySingleton(as: LocalDataStorage)
class LocalDataStorageImpl implements LocalDataStorage {
  LocalDataStorageImpl(this.box);
  final Box<dynamic> box;
  final _deviceDetails = 'deviceDetails';
  final _isLoggedIn = 'isLoggedIn';
  final _onboarded = 'onboarded';

  @override
  Future<void> setDeviceDetails({required DeviceDetailsModel value}) async {
    try {
      await box.put(_deviceDetails, value);
    } catch (e) {
      logger.e('Error setting device details: $e');
    }
  }

  @override
  DeviceDetailsModel getDeviceDetails() {
    try {
      return box.get(_deviceDetails) as DeviceDetailsModel;
    } catch (e) {
      logger.e('Error getting device details: $e');
      return DeviceDetailsModel();
    }
  }

  @override
  Future<void> setIsLoggedIn({bool value = false}) async {
    try {
      await box.put(_isLoggedIn, value);
    } catch (e) {
      logger.e('Error setting isLoggedIn: $e');
    }
  }

  @override
  bool getIsLoggedIn() {
    try {
      return box.get(_isLoggedIn) as bool;
    } catch (e) {
      logger.e('Error getting isLoggedIn: $e');
      return false;
    }
  }

  @override
  Future<void> setOnboarded({bool value = false}) async {
    try {
      await box.put(_onboarded, value.toString());
    } catch (e) {
      logger.e('Error setting onboarded: $e');
    }
  }

  @override
  bool getOnboarded() {
    try {
      return box.get(_onboarded) == 'true';
    } catch (e) {
      logger.e('Error getting onboarded: $e');
      return false;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await box.clear();
    } catch (e) {
      logger.e('Error clearing local data: $e');
    }
  }
}
