import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  SharedPreferences? sharedPreferences;

  Future<bool> removeData(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.remove(key.value);
  }

  Future<Future> writeData(CachingKey key, value) async {
    print("${key.value} : $value");
    sharedPreferences = await SharedPreferences.getInstance();
    Future? returnedValue;
    if (value is String) {
      returnedValue = sharedPreferences!.setString(key.value, value);
    } else if (value is int) {
      returnedValue = sharedPreferences!.setInt(key.value, value);
    } else if (value is bool) {
      returnedValue = sharedPreferences!.setBool(key.value, value);
    } else if (value is double) {
      returnedValue = sharedPreferences!.setDouble(key.value, value);
    }else if (value is List<String>) {

      returnedValue = sharedPreferences!.setStringList(key.value, value);

    }else {
      return Future.error(NotValidCacheTypeException());
    }
    return returnedValue;
  }

  Future<List<String>> readListString(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();

    return Future.value(sharedPreferences!.getStringList(key.value) ?? []);
  }

  Future<String> readString(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getString(key.value).toString() ?? "");
  }

  Future<bool> readBool(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getBool(key.value)?? true);
  }
  Future<int> readInt(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();

    return Future.value(sharedPreferences!.getInt(key.value) ?? 0);
  }
  Future<double> readDouble(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getDouble(key.value) ?? 0);
  }
}

class NotValidCacheTypeException implements Exception {
  String message() => "Not a valid cahing type";
}

class CachingKey extends Enum<String> {
  const CachingKey(String val) : super(val);

  static const CachingKey AUTH_TOKEN = CachingKey('AUTH_TOKEN');
  static const CachingKey DEVICE_TOKEN = CachingKey('DEVICE_TOKEN');
  static const CachingKey USER_NAME = const CachingKey('USER_NAME');
  static const CachingKey REFRESH_TOKEN = const CachingKey('REFRESH_TOKEN');
  static const CachingKey VISITOR = const CachingKey('VISITOR');

  static const CachingKey USER_ID = const CachingKey('USER_ID');
  static const CachingKey USER_PHONE = const CachingKey('USER_PHONE');
  static const CachingKey PROFILE_IMAGE = const CachingKey('PROFILE_IMAGE');
  static const CachingKey USER_LOCATION_ID= const CachingKey('USER_LOCATION_ID');

  static const CachingKey APP_LANGUAGE = const CachingKey('APP_LANGUAGE');
  static const CachingKey CAR_ID = const CachingKey('CAR_ID');
  static const CachingKey CAR_MODEL_ID = const CachingKey('CAR_MODEL_ID');
  static const CachingKey CAR_Brand_ID = const CachingKey('CAR_MODEL_ID');
  static const CachingKey CAR_PLATE_NUMBER = const CachingKey('CAR_PLATE_NUMBER');
  static const CachingKey CAR_CHASSIS_NUMBER = const CachingKey('CAR_CHASSIS_NUMBER');
  static const CachingKey CAR_MANUFACTURE_YEAR = const CachingKey('CAR_MANUFACTURE_YEAR');
  static const CachingKey CAR_MANUFACTURE_COUNTRY = const CachingKey('CAR_MANUFACTURE_COUNTRY');
  static const CachingKey CAR_WAKER = const CachingKey('CAR_MANUFACTURE_COUNTRY');
  static const CachingKey CAR_GEAR= const CachingKey('CAR_GEAR');
  static const CachingKey CAR_BODY= const CachingKey('CAR_BODY');
  static const CachingKey CAR_FUEL_TYPE= const CachingKey('CAR_FUEL_TYPE');
  static const CachingKey CAR_COLOR= const CachingKey('CAR_COLOR');
  static const CachingKey ENGINE_CAPACITY= const CachingKey('ENGINE_CAPACITY');
  static const CachingKey MAX_SPEED= const CachingKey('MAX_SPEED');
  static const CachingKey DOOR_NUMBERS= const CachingKey('DOOR_NUMBERS');
  static const CachingKey CYLNDER_NUMBER= const CachingKey('CYLNDER_NUMBER');

  //ORDER
  static const CachingKey DELIVERY_METHOD= const CachingKey('DELIVERY_METHOD');


  static const CachingKey CAR_STATUS= const CachingKey('CAR_STATUS');
  static const CachingKey CAR_SURFACE_TYPE= const CachingKey('CAR_SURFACE_TYPE');
  static const CachingKey CAR_PROBLEM= const CachingKey('CAR_PROBLEM');
  static const CachingKey DEPARTMENT_ID= const CachingKey('DEPARTMENT_ID');
  static const CachingKey SERVICE_ID = const CachingKey('SERVICE_ID');
  static const CachingKey SELECTED_SERVICE_INDEX = const CachingKey('SELECTED_SERVICE_INDEX');
  static const CachingKey SPARE_PARTS_ID = const CachingKey('SPARE_PARTS_ID');
  static const CachingKey SELECTED_SPARE_PART_INDEX = const CachingKey('SELECTED_SPARE_PART_INDEX');
  static const CachingKey DRAFT_PROBLEM_TYPE = const CachingKey('DRAFT_PROBLEM_TYPE');

  static const CachingKey SPARE_PARTS_REQUESTED = const CachingKey('SPARE_PARTS_REQUESTED');
  static const CachingKey PROVIDER_ID = const CachingKey('PROVIDER_ID');
  static const CachingKey SCHEDULE_DELIVERY_DATE = const CachingKey('SCHEDULE_DELIVERY_DATE');

  static const CachingKey SELECTED_PROVIDER_WORKING_HOUR = const CachingKey('SELECTED_PROVIDER_WORKING_HOUR');
  static const CachingKey SELECTED_PROVIDER_WORKING_DAY = const CachingKey('SELECTED_PROVIDER_WORKING_DAY');
  static const CachingKey SELECTED_DAY_DATE = const CachingKey('SELECTED_DAY_DATE');
  static const CachingKey SELECTED_PROVIDER_INDEX = const CachingKey('SELECTED_PROVIDER_INDEX');
  static const CachingKey ORDER_ID = const CachingKey('ORDER_ID');
  static const CachingKey ORDER_STATUS_CODE = const CachingKey('ORDER_STATUS_CODE');
  static const CachingKey ORDER_SUB_STATUS_CODE = const CachingKey('ORDER_SUB_STATUS_CODE');
  static const CachingKey ORDER_FROM_DATE = const CachingKey('ORDER_FROM_DATE');
  static const CachingKey ORDER_TO_DATE = const CachingKey('ORDER_TO_DATE');
  static const CachingKey ORDER_SORT_ID = const CachingKey('ORDER_SORT_ID');
  static const CachingKey ORDER_TOTAL_PRICE = const CachingKey('ORDER_TOTAL_PRICE');
  static const CachingKey DRAFT_ORDER_ID = const CachingKey('DRAFT_ORDER_ID');

  static const CachingKey DESTINATION_LATITUDE = const CachingKey('DESTINATION_LATITUDE');
  static const CachingKey DESTINATION_LONGTITUDE = const CachingKey('DESTINATION_LONGTITUDE');

  static const CachingKey FROM_LATITUDE = const CachingKey('FROM_LATITUDE');
  static const CachingKey FROM_LONGTITUDE = const CachingKey('FROM_LONGTITUDE');
  static const CachingKey TOW_TRACK_ORDER_TYPE = const CachingKey('TOW_TRACK_ORDER_TYPE');

}

final sharedPreferenceManager = SharedPreferenceManager();
abstract class Enum<T> {
  final T _value;

  const Enum(this._value);

  T get value => _value;
}
