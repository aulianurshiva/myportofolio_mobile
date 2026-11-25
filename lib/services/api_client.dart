import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/interest.dart';

/// Exception yang dilempar saat API membalas status non-2xx.
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// HTTP client untuk backend Django REST Framework MyPortfolio.
class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  /// Decode body sebagai UTF-8 supaya karakter non-ASCII tidak rusak.
  dynamic _decode(http.Response response) =>
      jsonDecode(utf8.decode(response.bodyBytes));

  Future<List<Interest>> getInterests() async {
    final response = await _client.get(
      _uri('/api/v1/interests/'),
      headers: const {'Accept': 'application/json'},
    );
    _ensureSuccess(response);

    final decoded = _decode(response) as List<dynamic>;
    return decoded
        .map((item) => Interest.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Interest> createInterest(
    Interest interest, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/interests/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(interest.toJson()),
    );
    _ensureSuccess(response);

    return Interest.fromJson(_decode(response) as Map<String, dynamic>);
  }

  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );
    _ensureSuccess(response);

    final decoded = _decode(response) as Map<String, dynamic>;
    return decoded['token'] as String;
  }

  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    throw ApiException(response.statusCode, response.body);
  }
}
