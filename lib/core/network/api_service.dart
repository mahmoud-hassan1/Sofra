import 'package:dio/dio.dart';
import 'package:sofra/core/network/api_constants.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (status) {
          return status != null && status < 500; 
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }


  Future<List<dynamic>> getRecipes({
    String? search,
    String? region,
    String? category,
  }) async {
    final Map<String, dynamic> queryParameters = {};
    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }
    if (region != null && region.isNotEmpty && region != 'All') {
      queryParameters['region'] = region;
    }
    if (category != null && category.isNotEmpty) {
      queryParameters['category'] = category;
    }

    final response = await _dio.get('recipes', queryParameters: queryParameters);
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> toggleSaveRecipe(String recipeId) async {
    final response = await _dio.post('recipes/$recipeId/save');
    return response.data as Map<String, dynamic>;
  }

  Future<Response> post({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
    );
  }
}