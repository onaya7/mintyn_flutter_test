import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('{path}')
  Future<HttpResponse<dynamic>> postRequest({
    @Path() required String path,
    @Body() required dynamic body,
    @Header('Authorization') String? token,
    @Header('Accept') String accept = 'Application/json',
  });

  @GET('{path}')
  Future<HttpResponse<dynamic>> getRequest({
    @Path() required String path,
    @Queries() required Map<String, dynamic> query,
    @Header('Authorization') String? token,
    @Header('Accept') String accept = 'Application/json',
  });

  @PUT('{path}')
  Future<HttpResponse<dynamic>> putRequest({
    @Path() required String path,
    @Body() required Map<String, dynamic> body,
    @Header('Authorization') String? token,
    @Header('Accept') String accept = 'Application/json',
  });

  @PATCH('{path}')
  Future<HttpResponse<dynamic>> patchRequest({
    @Path() required String path,
    @Body() required dynamic body,
    @Queries() Map<String, dynamic>? query,
    @Header('Authorization') String? token,
    @Header('Accept') String accept = 'Application/json',
  });

  @DELETE('{path}')
  Future<HttpResponse<dynamic>> deleteRequest({
    @Path() required String path,
    @Queries() required Map<String, dynamic> query,
    @Header('Authorization') String? token,
    @Header('Accept') String accept = 'Application/json',
  });
}
