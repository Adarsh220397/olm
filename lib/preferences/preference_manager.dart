import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'preference_constants.dart';

class PreferenceManager {
  //Singleton instance
  PreferenceManager._internal();

  static PreferenceManager instance = PreferenceManager._internal();
  static late SharedPreferences _prefs;

  factory PreferenceManager() {
    return instance;
  }

  Future<void> clearAll() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  /// ------------------( IS LOGIN )------------------
  Future<bool> getIsLogin() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(PreferenceConstants.isLogin) ?? false;
  }

  Future<void> setIsLogin(bool isLogin) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(PreferenceConstants.isLogin, isLogin);
  }

  /// ------------------( IS BASIC USER DATA FILLED )------------------
  Future<bool> getBasicUserDataFilled() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(PreferenceConstants.isBasicUserDataFilled) ?? false;
  }

  Future<void> setBasicUserDataFilled(bool isBasicUserDataFilled) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(
        PreferenceConstants.isBasicUserDataFilled, isBasicUserDataFilled);
  }

  /// ------------------( DIAL CODE )------------------
  Future<String> getDialCode() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.dialCode) ?? "";
  }

  Future<void> setDialCode(String dialCode) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.dialCode, dialCode);
  }

  /// ------------------( DIAL CODE )------------------
  Future<String> getCountryCode() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.countryCode) ?? "";
  }

  Future<void> setCountryCode(String countryCode) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.countryCode, countryCode);
  }

  /// ------------------( DIAL CODE )------------------
  Future<String> getCountryName() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.countryName) ?? "";
  }

  Future<void> setCountryName(String countryName) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.countryName, countryName);
  }

  /// ------------------( USER ID )------------------
  Future<String> getUserId() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.userId) ?? "";
  }

  Future<void> setUserId(String userId) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.userId, userId);
  }

  /// ------------------( MOBILE NUMBER )------------------
  Future<String> getMobileNumber() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.mobileNumber) ?? "";
  }

  Future<void> setMobileNumber(String mobileNumber) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.mobileNumber, mobileNumber);
  }

  /// ------------------( FIRST NAME )------------------
  Future<String> getFirstName() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.firstName) ?? "";
  }

  Future<void> setFirstName(String firstName) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.firstName, firstName);
  }

  /// ------------------( LAST NAME )------------------
  Future<String> getLastName() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.lastName) ?? "";
  }

  Future<void> setLastName(String lastName) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.lastName, lastName);
  }

  Future<int> getShowCaseVisibilityStatus() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt(PreferenceConstants.showCaseVisibilityStatus) ?? 1;
  }

  Future<void> setShowCaseVisibilityStatus(int num) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setInt(PreferenceConstants.showCaseVisibilityStatus, num);
  }

  Future<int> getShowCaseVisibilityStatusForTheatreReport() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt(
            PreferenceConstants.showCaseVisibilityStatusForTheatreReport) ??
        1;
  }

  Future<void> setShowCaseVisibilityStatusForTheatreReport(int num) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setInt(
        PreferenceConstants.showCaseVisibilityStatusForTheatreReport, num);
  }
}
