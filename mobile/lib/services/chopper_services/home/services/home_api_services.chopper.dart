// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_api_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$HomeApiService extends HomeApiService {
  _$HomeApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = HomeApiService;

  @override
  Future<Response<dynamic>> getProfileInfo() {
    final $url = '';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDevelopersProfilesWithToken(
      String token, int page, Map<String, dynamic> query) {
    final $url = 'api/developer-profiles';
    final $params = <String, dynamic>{'page': page};
    $params.addAll(query);
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFavorites(String token, int page) {
    final $url = 'api/favorites';
    final $params = <String, dynamic>{'page': page};
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDevelopersProfiles(
      int page, Map<String, dynamic> query) {
    final $url = 'api/developer-profiles';
    final $params = <String, dynamic>{'page': page};
    $params.addAll(query);
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDeveloperInfo(String token, int developerId) {
    final $url = 'api/developer-profiles/$developerId';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> chooseFavoriteDeveloper(
      String token, int developerId, String isFavorite) {
    final $url = 'api/favorites/';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{
      'developer_id': developerId,
      'is_favorite': isFavorite
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> inContact(String token, int developerId) {
    final $url = 'api/incontact/';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{'developer_id': developerId};
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> getAllBurnProjects(String token, int page) {
    final $url = 'api/burn-projects';
    final $params = <String, dynamic>{'page': page};
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBurnProjectById(
      String token, int burnProjectId) {
    final $url = 'api/burn-projects/$burnProjectId';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRespondProjects(String token, int page) {
    final $url = 'api/user-projects';
    final $params = <String, dynamic>{'page': page};
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> respondDevToClient(
      String token, int developerId, int burnProjectId, int stackId) {
    final $url = 'api/dev-projects/';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{
      'price': developerId,
      'burn_project_id': burnProjectId,
      'stacks': stackId
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> acceptClientFromDev(String token, int id,
      bool acceptBool, int developerId, int burnProjectId) {
    final $url = 'api/user-projects/';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{
      'id': id,
      'accept_bool': acceptBool,
      'developer_id': developerId,
      'burn_project_id': burnProjectId
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }
}
