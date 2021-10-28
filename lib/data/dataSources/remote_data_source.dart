import 'package:image_flip/data/repositories/api/api_response.dart';
import 'package:image_flip/data/service/api_service.dart';
import 'package:image_flip/models/get_meme_response.dart';

class RemoteDataSource {
  Future<ApiResponse> fetchMemeMetaData() async {
    try {
      final response = await ApiService.fetchMemes();
      return ApiResponse.completed(GetMemeResponseModel.fromJson(response));
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
