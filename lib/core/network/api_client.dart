abstract class ApiClient {
  Future<dynamic> get(String path, {Map<String, dynamic>? query, String? token});
  Future<dynamic> post(String path, dynamic data,{String? token});
  Future<dynamic> put(String path, dynamic data,{String? token});
  Future<dynamic> delete(String path,{String? token});
}
