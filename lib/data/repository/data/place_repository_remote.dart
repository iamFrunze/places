import 'dart:io';

import 'package:dio/dio.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/settings/dio_settings.dart';
import 'package:places/utils/status_codes.dart';

class PlaceRepositoryRemote implements PlaceRepository {
  final DioSettings _dioSettings;

  PlaceRepositoryRemote(this._dioSettings);

  @override
  Future<List<PlaceModel>> postFilteredPlaces({
    PostFilteredPlacesRequestModel? model,
  }) async {
    try {
      final response = await _dioSettings.dio.post<List<dynamic>>(
        AppStrings.filteredPlacesPath,
        data: model?.toJson(),
      );
      final data = response.data;
      if (data != null) {
        return List<PlaceModel>.from(
          data.map<PlaceModel>(
            (dynamic value) => PlaceModel.fromJson(value as Map<String, dynamic>),
          ),
        );
      } else {
        throw NetworkException(
          code: 404,
          nameRequest: AppStrings.filteredPlacesPath,
          nameError: DioErrorType.response.toString(),
        );
      }
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.filteredPlacesPath,
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<PlaceModel> postPlace(PlaceModel model) async {
    try {
      final response = await _dioSettings.dio.post<PlaceModel>(
        AppStrings.placePath,
        data: model.toJson(),
      );
      final data = response.data;
      if (data != null) {
        return data;
      } else {
        throw NetworkException(
          code: 404,
          nameRequest: AppStrings.placePath,
          nameError: DioErrorType.response.toString(),
        );
      }
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.placePath,
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<List<PlaceModel>> getPlace({
    GetPlaceRequestModel? model,
  }) async {
    try {
      final response = await _dioSettings.dio.get<List<dynamic>>(
        AppStrings.placePath,
        queryParameters: model?.toJson(),
      );
      final data = response.data;
      if (data != null) {
        return List<PlaceModel>.from(
          data.map<PlaceModel>(
            (dynamic value) => PlaceModel.fromJson(value as Map<String, dynamic>),
          ),
        );
      } else {
        throw NetworkException(
          code: 404,
          nameRequest: AppStrings.placePath,
          nameError: DioErrorType.response.toString(),
        );
      }
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.placePath,
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<PlaceModel> getPlaceId({required String id}) async {
    try {
      final response = await _dioSettings.dio.get<Map<String, dynamic>>(
        AppStrings.placeIdPath(int.parse(id)),
      );
      final data = response.data;
      if (data != null) {
        final model = PlaceModel.fromJson(data);

        return model;
      } else {
        throw NetworkException(
          code: 404,
          nameRequest: AppStrings.placeIdPath(int.parse(id)),
          nameError: DioErrorType.response.toString(),
        );
      }
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.placeIdPath(int.parse(id)),
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<bool> deletePlace({required String id}) async {
    try {
      final response = await _dioSettings.dio.delete<void>(AppStrings.placeIdPath(int.parse(id)));

      return response.statusCode == successCode;
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.placeIdPath(int.parse(id)),
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<bool> putPlace(PlaceModel model) async {
    try {
      final response = await _dioSettings.dio.put<void>(
        AppStrings.placeIdPath(model.id),
        data: model.toJson(),
      );

      return response.statusCode == successCode;
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.placeIdPath(model.id),
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<List<String>> postUploadFile(File file) async {
    try {
      _dioSettings.dio.options.headers['Content-Type'] = 'multipart/form-data';
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap(<String, MultipartFile>{
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final response = await _dioSettings.dio.post<List<String>>(
        AppStrings.uploadFilePath,
        data: formData,
      );

      final data = response.data;
      if (data != null) {
        return data;
      } else {
        throw NetworkException(
          code: 404,
          nameRequest: AppStrings.uploadFilePath,
          nameError: DioErrorType.response.toString(),
        );
      }
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.uploadFilePath,
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<String> getClient(String path) async {
    try {
      final response = await _dioSettings.dio.get<String>(
        AppStrings.clientPath,
        queryParameters: <String, String>{'path': path},
      );

      final data = response.data;
      if (data != null && data.isNotEmpty) {
        return data;
      } else {
        throw NetworkException(
          code: 404,
          nameRequest: AppStrings.clientPath,
          nameError: DioErrorType.response.toString(),
        );
      }
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.clientPath,
        nameError: e.type.name,
      );
    }
  }

  @override
  Future<String> getFiles(String filePath) async {
    try {
      final response = await _dioSettings.dio.get<String>(
        AppStrings.filesPath,
        queryParameters: <String, String>{'path': filePath},
      );
      final data = response.data;
      if (data != null && data.isNotEmpty) {
        return data;
      } else {
        throw NetworkException(
          code: 404,
          nameRequest: AppStrings.filesPath,
          nameError: DioErrorType.response.toString(),
        );
      }
    } on DioError catch (e) {
      throw NetworkException(
        code: e.response?.statusCode ?? -1,
        nameRequest: AppStrings.filesPath,
        nameError: e.type.name,
      );
    }
  }
}
