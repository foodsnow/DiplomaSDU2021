import 'package:chopper/chopper.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/services/home_api_services.dart';

class HomeRepository {
  HomeApiService authApiServices = HomeApiService.create();

  Future<Response<dynamic>> getDevProfiles(
          int page, String token, Map<String, dynamic> query) =>
      token != null
          ? authApiServices.getDevelopersProfilesWithToken(token, page, query)
          : authApiServices.getDevelopersProfiles(page, query);

  Future<Response<dynamic>> getFavorites(int page, String token) =>
      authApiServices.getFavorites(token, page);

  Future<Response<dynamic>> getDeveloperInfo(
    String token,
    int developerId,
  ) =>
      authApiServices.getDeveloperInfo(token, developerId);

  Future<Response<dynamic>> chooseFavoriteDeveloper(
          String token, int developerId, String isFavorite) =>
      authApiServices.chooseFavoriteDeveloper(token, developerId, isFavorite);

  Future<Response<dynamic>> inContact(
    String token,
    int developerId,
  ) =>
      authApiServices.inContact(token, developerId);

  Future<Response<dynamic>> getAllBurnProjects(int page, String token) =>
      authApiServices.getAllBurnProjects(token, page);

  Future<Response<dynamic>> getBurnProjectById(String token, int id) =>
      authApiServices.getBurnProjectById(token, id);

  Future<Response<dynamic>> getAllRespondProjects(int page, String token) =>
      authApiServices.getRespondProjects(token, page);

  Future<Response<dynamic>> respondDevToClient(
          String token, int price, int burnProjectId, int stackId) =>
      authApiServices.respondDevToClient(token, price, burnProjectId, stackId);

  Future<Response<dynamic>> acceptRespondClient(String token, int id,
          bool isAccept, int developerId, int burnProjectId) =>
      authApiServices.acceptClientFromDev(
          token, id, isAccept, developerId, burnProjectId);
}
