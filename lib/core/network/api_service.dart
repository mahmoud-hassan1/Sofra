import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:5000/api/",
      connectTimeout: const Duration(seconds:3),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2YTQwMDI2OGFjOGI3M2JlOGE5NWM4MjAiLCJpYXQiOjE3ODI1Nzk5MzksImV4cCI6MTc4MzE4NDczOX0.-bcGkCrNLuAAb4sOxb9RhRj-fPOFBTii8bcQS_ELXis",
      },
    ),
  );

  Future<List<dynamic>> getRecipes({String? search, String? region, String? category}) async {
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

    final response = await dio.get('recipes', queryParameters: queryParameters);
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> toggleSaveRecipe(String recipeId) async {
    final response = await dio.post('recipes/$recipeId/save');
    return response.data as Map<String, dynamic>;
  }
}