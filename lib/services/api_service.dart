import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Backend folder URL (HTTPS zaroori, trailing slash nahi).
const String kApiBaseUrl = 'https://blackxmarket.shop/KheloX/khelox-backend';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final double fcoin;
  final double dcoin;
  final double wcoin;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.fcoin = 0,
    this.dcoin = 0,
    this.wcoin = 0,
  });

  static double _d(dynamic v) => double.tryParse('${v ?? 0}') ?? 0;

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        id: int.parse(j['id'].toString()),
        name: j['name'].toString(),
        email: j['email'].toString(),
        phone: j['phone'].toString(),
        fcoin: _d(j['fcoin']),
        dcoin: _d(j['dcoin']),
        wcoin: _d(j['wcoin']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'fcoin': fcoin,
        'dcoin': dcoin,
        'wcoin': wcoin,
      };
}

class ApiService {
  static Future<Map<String, dynamic>> _post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final res = await http
          .post(
            Uri.parse('$kApiBaseUrl/$endpoint'),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 20));

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      if (data['success'] == true) return data;
      throw ApiException(data['message']?.toString() ?? 'Something went wrong');
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw ApiException('Server slow hai. Dobara try karo.');
    } on SocketException {
      throw ApiException('Internet connection check karo.');
    } on FormatException {
      throw ApiException('Server se galat response aaya.');
    }
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final data = await _post('login.php', {
      'email': email.trim(),
      'password': password,
    });
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final data = await _post('register.php', {
      'name': name.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'password': password,
    });
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }
}

class SessionService {
  static const _key = 'khelox_user';

  static Future<void> save(UserModel user) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_key, jsonEncode(user.toJson()));
  }

  static Future<UserModel?> load() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(_key);
    if (raw == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static Future<void> clear() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_key);
  }
}