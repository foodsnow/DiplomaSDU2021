// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AuthApiServices extends AuthApiServices {
  _$AuthApiServices([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthApiServices;

  @override
  Future<Response<dynamic>> postOtp(String email) {
    final $url = 'auth/send-otp/';
    final $body = <String, dynamic>{'email': email};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> validateOtp(String email, String otp) {
    final $url = 'auth/validate-otp/';
    final $body = <String, dynamic>{'email': email, 'otp': otp};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> sendStepOne(
      String token, String name, String surname, String iin, int role) {
    final $url = 'auth/registration/step/1';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{
      'name': name,
      'surname': surname,
      'iin': iin,
      'role': role
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendStepTwo(String token, String birth_date,
      int gender, String phone, int city, int role) {
    final $url = 'auth/registration/step/2';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{
      'birth_date': birth_date,
      'gender': gender,
      'phone': phone,
      'city': city,
      'role': role
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendStepThree(
      String token,
      String workPlace,
      String education,
      int stacks,
      List<int> skills,
      String about,
      String workExperience,
      int role) {
    final $url = 'auth/registration/step/3';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{
      'work_place': workPlace,
      'education': education,
      'stacks': stacks,
      'skills': skills,
      'about': about,
      'work_experience': workExperience,
      'role': role
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendStepFour(String token, String serviceTitle,
      String serviceDescription, double price, bool priceFix, int role) {
    final $url = 'auth/registration/step/4';
    final $headers = {'Authorization': token};
    final $body = <String, dynamic>{
      'service_title': serviceTitle,
      'service_description': serviceDescription,
      'price': price,
      'price_fix': priceFix,
      'role': role
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStacks() {
    final $url = 'api/stacks/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSkills() {
    final $url = 'api/skills/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCities() {
    final $url = 'api/cities/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyProfInfo(String token) {
    final $url = '/api/my-profile';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
