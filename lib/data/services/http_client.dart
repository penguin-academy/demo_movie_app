import 'package:dio/dio.dart';

class HttpClient {
  final Dio _client;

  HttpClient(this._client);

  Future<dynamic> get(String url) async {
    final response = await _client.get(url);

    return response.data;
  }

  Future<Map<String, dynamic>> post(String url, {dynamic data}) async {
    final response = await _client.post(url, data: data);

    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> put(String url, {dynamic data}) async {
    final response = await _client.put(url, data: data);

    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> delete(String url) async {
    final response = await _client.delete(url);

    return response.data as Map<String, dynamic>;
  }
}

final dioClient = Dio(
  BaseOptions(
    baseUrl:
        'https://api.themoviedb.org/3/movie/popular?api_key=583b54c68d64a0ebe6943569bfe588db',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ),
);

final httpClient = HttpClient(dioClient);
