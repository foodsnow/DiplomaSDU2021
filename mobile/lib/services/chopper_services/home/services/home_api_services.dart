import 'package:chopper/chopper.dart';

part 'home_api_services.chopper.dart';

@ChopperApi()
abstract class HomeApiService extends ChopperService {
  @Get()
  Future<Response> getProfileInfo();

  @Get(path: 'api/developer-profiles')
  Future<Response> getDevelopersProfilesWithToken(
      @Header("Authorization") String token,
      @Query('page') int page,
      @QueryMap() Map<String, dynamic> query);

  @Get(path: 'api/favorites')
  Future<Response> getFavorites(
      @Header("Authorization") String token, @Query('page') int page);

  @Get(path: 'api/developer-profiles')
  Future<Response> getDevelopersProfiles(
      @Query('page') int page, @QueryMap() Map<String, dynamic> query);

  @Get(path: 'api/developer-profiles/{id}')
  Future<Response> getDeveloperInfo(
      @Header("Authorization") String token, @Path("id") int developerId);

  @Post(path: 'api/favorites/')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> chooseFavoriteDeveloper(
      @Header("Authorization") String token,
      @Field("developer_id") int developerId,
      @Field("is_favorite") String isFavorite);

  @Post(path: 'api/incontact/')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> inContact(@Header("Authorization") String token,
      @Field("developer_id") int developerId);

  @Get(path: 'api/burn-projects')
  Future<Response> getAllBurnProjects(
      @Header("Authorization") String token, @Query('page') int page);

  @Get(path: 'api/burn-projects/{id}')
  Future<Response> getBurnProjectById(
      @Header("Authorization") String token, @Path("id") int burnProjectId);

  @Get(path: 'api/user-projects')
  Future<Response> getRespondProjects(
      @Header("Authorization") String token, @Query('page') int page);

  @Post(path: 'api/dev-projects/')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> respondDevToClient(
      @Header("Authorization") String token,
      @Field("price") int developerId,
      @Field('burn_project_id') int burnProjectId,
      @Field('stacks') int stackId);

  @Post(path: 'api/user-projects/')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> acceptClientFromDev(
      @Header("Authorization") String token,
      @Field("id") int id,
      @Field("accept_bool") bool acceptBool,
      @Field("developer_id") int developerId,
      @Field('burn_project_id') int burnProjectId);

  static HomeApiService create() {
    final client = ChopperClient(
        baseUrl: 'http://139.59.179.254',
        services: [
          _$HomeApiService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HeadersInterceptor({'Cache-Control': 'no-cache'}),
          HttpLoggingInterceptor(),
          CurlInterceptor()
        ]);
    return _$HomeApiService(client);
  }
}
