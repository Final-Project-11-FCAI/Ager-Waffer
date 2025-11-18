
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../common/config.dart';
import '../common/shared_preference_manger.dart';
import 'network-mappers.dart';
class NetworkUtil {
  static final NetworkUtil _instance = new NetworkUtil.internal();
SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();
  NetworkUtil.internal();

  factory NetworkUtil() => _instance;


  Future<ResponseType> get<ResponseType extends Mappable>(
      ResponseType responseType, String url,
      {Map<String, dynamic>? headers, bool useCache = false}) async {
    Dio dio = new Dio();
    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      final dioClient = HttpClient();
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    Response? response;
   /* if (useCache) {
      print("data from offline");
      // Use cache if available
      var cacheManager = DefaultCacheManager();
      var fileInfo = await cacheManager.getFileFromCache(url);
      if (fileInfo != null) {
        // Cache hit, load from cache
        final file = fileInfo.file;
        final cachedResponse = await file.readAsString();
        return handleResponse(Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 200,
          data: cachedResponse,
        ), responseType);
      }
    }*/

    try {
      dio.options.baseUrl = baseUrl;
      response = await dio.get(url,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ));

      // Save response to cache
      if (useCache && response.statusCode == 200) {
        var cacheManager = DefaultCacheManager();
        await cacheManager.putFile(url, Uint8List.fromList(response.data.toString().codeUnits));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }

    print("response*** : ${handleResponse(response, responseType)}");
    return handleResponse(response, responseType);
  }

/*  Future<ResponseType> get <ResponseType extends Mappable>(ResponseType responseType, String url,
      {Map<String, dynamic>? headers}) async {
    Dio dio = new Dio();
    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      final dioClient = HttpClient();
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };
    Response? response ;
    try {
      dio.options.baseUrl = baseUrl;
      response = await dio.get(
          url,
   //       queryParameters:Map<String, dynamic>.from(headers),
        options: Options(
          headers: headers,
          contentType: 'application/json',
        )
      );
    } on DioException catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    print("response : ${response}");
    return handleResponse(response, responseType);
  }*/

  Future<ResponseType> post<ResponseType extends Mappable>(ResponseType responseType, String url,
      {Map<String, dynamic>? headers, var body, encoding}) async {
    Dio dio = new Dio();
    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      final dioClient = HttpClient();
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };
    var response;
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    try {
      print("url : $url");
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding ,
              followRedirects: false,  validateStatus: (status) { return status! < 500; })
      );
    } on DioException catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse(response, responseType);

  }


  Future<ResponseType> delete<ResponseType extends Mappable>(ResponseType responseType,String url,
      {Map<String, dynamic>? headers}) {
    Dio dio = new Dio();
    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      final dioClient = HttpClient();
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };
    return dio
        .delete(
      url,
      options: Options(headers: headers!),

    )
        .then((Response response) {
      return handleResponse(response, responseType);
    });
  }

  Future<ResponseType> put<ResponseType extends Mappable>(ResponseType? responseType,String? url,
      {Map<String, dynamic>? headers, body, encoding}) {
    Dio dio = new Dio();
    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      final dioClient = HttpClient();
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };
    return dio
        .put(url!,
        data: body,
        options: Options(headers: headers, requestEncoder: encoding))
        .then((Response response) {
      return handleResponse(response, responseType);
    });
  }


  ResponseType handleResponse<ResponseType extends Mappable>(Response? response, ResponseType? responseType) {
    final int? statusCode = response!.statusCode;
    if (statusCode! >= 200 && statusCode < 300) {
      return Mappable(responseType!, response.toString()) as ResponseType;
    } else {
      return Mappable(responseType!, response.toString()) as ResponseType;
    }
  }


}
