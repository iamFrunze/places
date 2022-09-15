import 'dart:io';

import 'package:dio/dio.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/settings/dio_settings.dart';
import 'package:places/utils/status_codes.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final DioSettings _dioSettings;

  PlaceRepositoryImpl(DioSettings dioSettings) : _dioSettings = dioSettings;

  @override
  Future<List<PlaceModel>> postFilteredPlaces(
    PostFilteredPlacesRequestModel model,
  ) async {
    final response = await _dioSettings.dio.post<List<PlaceModel>>(
      '/filtered_places',
      data: model.toJson(),
    );

    if (response.statusCode == invalidRequest) {
      throw Exception('Invalid request');
    }
    if (response.statusCode == successCode) {
      final data = response.data;
      if (data != null && data.isNotEmpty) {
        return data;
      } else {
        throw Exception('Data is empty');
      }
    } else {
      throw Exception('Callback cannt fetch data');
    }
  }

  @override
  Future<PlaceModel> postPlace(PlaceModel model) async {
    final response = await _dioSettings.dio.post<PlaceModel>(
      '/place',
      data: model.toJson(),
    );

    if (response.statusCode == invalidRequest) {
      throw Exception('Invalid request');
    }
    if (response.statusCode == successCode) {
      final data = response.data;
      if (data != null) {
        return data;
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Callback cannt fetch data');
    }
  }

  @override
  Future<List<PlaceModel>> getPlace({
    required GetPlaceRequestModel model,
  }) async {
    final response = await _dioSettings.dio.get<List<PlaceModel>>(
      '/place',
      queryParameters: model.toJson(),
    );

    if (response.statusCode == invalidRequest) {
      throw Exception('Invalid request');
    }
    if (response.statusCode == successCode) {
      final data = response.data;
      if (data != null && data.isNotEmpty) {
        return data;
      } else {
        throw Exception('Data is empty');
      }
    } else {
      throw Exception('Callback cannt fetch data');
    }
  }

  @override
  Future<PlaceModel> getPlaceId({required String id}) async {
    final response = await _dioSettings.dio.get<PlaceModel>(
      '/place/$id',
    );

    if (response.statusCode == invalidRequest) {
      throw Exception('Invalid request');
    }
    if (response.statusCode == alreadyExists) {
      throw Exception('Object already exists');
    }
    if (response.statusCode == successCode) {
      final data = response.data;
      if (data != null) {
        return data;
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Callback cannt fetch data');
    }
  }

  @override
  Future<bool> deletePlace({required String id}) async {
    final response = await _dioSettings.dio.delete<void>('/place/$id');

    return response.statusCode == successCode;
  }

  @override
  Future<bool> putPlace(PlaceModel model) async {
    final response = await _dioSettings.dio.put<void>(
      '/place/${model.id}',
      data: model.toJson(),
    );

    return response.statusCode == successCode;
  }

  @override
  Future<List<String>> postUploadFile(File file) async {
    _dioSettings.dio.options.headers['Content-Type'] = 'multipart/form-data';
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap(<String, MultipartFile>{
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await _dioSettings.dio.post<List<String>>(
      '/upload_file',
      data: formData,
    );

    if (response.statusCode == invalidRequest) {
      throw Exception('Invalid request');
    }
    if (response.statusCode == successCode) {
      final data = response.data;
      if (data != null) {
        return data;
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Callback cannt fetch data');
    }
  }

  @override
  Future<String> getClient(String path) async {
    final response = await _dioSettings.dio.get<String>(
      '/client',
      queryParameters: <String, String>{'path': path},
    );

    if (response.statusCode == successCode) {
      final data = response.data;
      if (data != null && data.isNotEmpty) {
        return data;
      } else {
        throw Exception('Data is empty');
      }
    } else {
      throw Exception('Callback cannt fetch data');
    }
  }

  @override
  Future<String> getFiles(String filePath) async {
    final response = await _dioSettings.dio.get<String>(
      '/files',
      queryParameters: <String, String>{'path': filePath},
    );

    if (response.statusCode == successCode) {
      final data = response.data;
      if (data != null && data.isNotEmpty) {
        return data;
      } else {
        throw Exception('Data is empty');
      }
    } else {
      throw Exception('Callback cannt fetch data');
    }
  }
}
