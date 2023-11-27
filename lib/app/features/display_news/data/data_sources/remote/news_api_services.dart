import 'package:dio/dio.dart';
import 'package:news_app/app/core/constants/constants.dart';
import 'package:news_app/app/core/resources/data_state.dart';

class NewsApiService {
  var dio = Dio();
  // search article
  Future<DataState> searchArticles(String search) async {
    Response response;
    try {
      response = await dio.get('$newsAPIBaseURL/everything',
          queryParameters: {'apiKey': apiKey, 'q': search});

      // print(response);
      if (response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(DioException(
            error: 'Error in connection To internet',
            //response: response,
            type: DioExceptionType.badResponse,
            requestOptions: RequestOptions()));
      }
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
