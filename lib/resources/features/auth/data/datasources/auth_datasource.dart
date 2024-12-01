import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../core/api/endpoints.dart';
import '../../../../core/api/https_consumer.dart';
import '../../../../core/utils/result.dart';
import '../../../../../main.dart';
import '../models/governorate_model.dart';

class AuthDatasource {
  final HttpsConsumer httpsConsumer;

  AuthDatasource({
    required this.httpsConsumer,
  });

  Future<Result<void>> sendOTP(
    String phoneNumber,
  ) async {
    final result = await httpsConsumer.post(
      endpoint: EndPoints.sendOTP,
      body: {
        'phone': phoneNumber,
      },
    );
    if (result.isSuccess && result.data != null) {
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }

  Future<Result<void>> login(String phoneNumber, String otp) async {
    final result = await httpsConsumer.post(
      endpoint: EndPoints.login,
      body: {
        'phone': phoneNumber,
        'otp': otp,
      },
    );

    if (result.isSuccess && result.data != null) {
      final response = result.data!;
      final responseBody = jsonDecode(response.body);

      final String? accessToken = responseBody['access_token'];
      if (accessToken != null) {
        await preferences!.setString('token', accessToken);
      }
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }

  Future<Result<void>> register({
    required String name,
    required String governorateId,
    required String filePath,
    required String phoneNumber,
  }) async {
    List<http.MultipartFile> files = [];
    if (filePath.isNotEmpty) {
      final file = File(filePath);
      final avatarFile = http.MultipartFile(
        'avatar',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last,
      );
      files.add(avatarFile);
    }

    final fields = {
      'name': name,
      'phone': phoneNumber,
      'governorate_id': governorateId,
    };

    final result = await httpsConsumer.multipartPost(
      endpoint: EndPoints.register,
      fields: fields,
      fileKey: 'avatar',
      files: files,
      isProfile: true,
    );

    if (result.data != null) {
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }

  Future<Result<void>> fetchGovernorates() async {
    List<GovernorateModel> governorateModels = [];
    Map<String, int> governorates = {};
    final result = await httpsConsumer.get(
      endpoint: EndPoints.governorate,
    );
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);
      for (Map<String, dynamic> governorate in responseBody['data']) {
        governorateModels.add(GovernorateModel.fromJson(governorate));
      }
      for (GovernorateModel governorateModel in governorateModels) {
        governorates[governorateModel.name] = governorateModel.id;
      }
      preferences!.setString('governorates', jsonEncode(governorates));
      return Result<void>(data: null);
    } else {
      return Result<void>(error: result.error);
    }
  }
}
