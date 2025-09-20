import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase;
  final String functionsBaseUrl;

  SupabaseService({required this.supabase, required this.functionsBaseUrl});

  // 🔑 AUTH

  /// Register new user
  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  /// Login existing user
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Logout user
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  // 📡 News Articles

  Future<String?> _getAuthToken() async {
    final session = supabase.auth.currentSession;
    return session?.accessToken;
  }

  Future<Map<String, dynamic>> getHeadlines({String country = 'us'}) async {
    return _callFunction(
      action: 'headlines',
      params: {'country': country},
      requireAuth: false,
    );
  }

  Future<Map<String, dynamic>> searchNews({
    String? category,
    String? query,
  }) async {
    return _callFunction(
      action: 'search',
      params: {
        if (category != null) 'category': category,
        if (query != null) 'q': query,
      },
      requireAuth: true, // search requires login
    );
  }

  /// Core function caller
  Future<Map<String, dynamic>> _callFunction({
    required String action,
    Map<String, String>? params,
    bool requireAuth = true,
  }) async {
    final token = await _getAuthToken();

    if (requireAuth && token == null) {
      return {"type": "error", "message": "User not logged in"};
    }

    final uri = Uri.parse(
      functionsBaseUrl,
    ).replace(queryParameters: {'action': action, ...?params});

    final response = await http.get(
      uri,
      headers: {
        if (token != null) "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    try {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {
        "type": "error",
        "status": response.statusCode,
        "message": "Invalid response: ${response.body}",
      };
    }
  }
}
