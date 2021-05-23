import 'package:chopper/chopper.dart';
import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/cubit/auth/models/user.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/auth_api_services.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/data_provider.dart';

class Repository {
  DataProvider _dataProvider = DataProvider();
  AuthApiServices authApiServices = AuthApiServices.create();

  Future<List<User>> getUsers() => _dataProvider.getUsersList();

  Future<Response<dynamic>> getOtpCode(String email) =>
      authApiServices.postOtp(email);

  Future<Response<dynamic>> validateOtpCode(String email, String otp) =>
      authApiServices.validateOtp(email, otp);

  Future<Response<dynamic>> getStacks() => authApiServices.getStacks();

  Future<Response<dynamic>> getSkills() => authApiServices.getSkills();

  Future<Response<dynamic>> getCities() => authApiServices.getCities();

  Future<Response<dynamic>> sendStepOne(
          AuthRequestShortInfo shortInfo, String token) =>
      authApiServices.sendStepOne(
        token,
        shortInfo.name,
        shortInfo.surname,
        shortInfo.iin,
        shortInfo.role,
      );

  Future<Response<dynamic>> sendStepTwo(
          AuthRequestInfo authInfo, String token) =>
      authApiServices.sendStepTwo(
        token,
        authInfo.birth_date,
        authInfo.gender,
        authInfo.phone,
        authInfo.city,
        authInfo.role,
      );

  Future<Response<dynamic>> sendStepThree(
          AuthRequestProfInfo authInfo, String token) =>
      authApiServices.sendStepThree(
        token,
        authInfo.workPlace,
        authInfo.education,
        authInfo.stacks,
        authInfo.skills,
        authInfo.about,
        authInfo.workExperience,
        authInfo.role,
      );

  Future<Response<dynamic>> sendStepFour(
          AuthRequestServiceInfo authInfo, String token) =>
      authApiServices.sendStepFour(
        token,
        authInfo.serviceTitle,
        authInfo.serviceDescription,
        authInfo.price,
        authInfo.priceFix,
        authInfo.role,
      );

  Future<Response<dynamic>> getMyProfInfo(String token) =>
      authApiServices.getMyProfInfo(token);
}
