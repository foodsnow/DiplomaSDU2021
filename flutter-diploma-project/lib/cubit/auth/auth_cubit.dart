import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/models/categories_response.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/models/send_otp_response.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/models/success_response.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/repository.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/developer.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authcubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final Repository repository;

  AuthCubit(this.repository) : super(AuthEmptyState());

  Future<void> getOtpCode(String email) async {
    try {
      emit(AuthLoadingState());
      await repository.getOtpCode(email);
      emit(AuthOtpResponseState());
    } catch (_) {
      emit(AuthErrorState());
    }
  }

  Future<void> sendAuthSmsInitState() async {
    emit(AuthSmsInitState());
  }

  Future<void> validateOtpCode(String email, String otp) async {
    try {
      emit(AuthLoadingState());
      final response = await repository.validateOtpCode(email, otp);
      final sendOtpResponse = SendOtpResponse.fromJson(response.bodyString);
      if (response.isSuccessful && sendOtpResponse.status) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", sendOtpResponse.token);
        if (sendOtpResponse.registered) prefs.setBool("showProfile", true);
        emit(AuthSmsResponseState(
          token: sendOtpResponse.token,
          registered: sendOtpResponse.registered,
          role: sendOtpResponse.role
        ));
      } else {
        emit(AuthSmsErrorState(
          status: sendOtpResponse.status,
          detail: sendOtpResponse.detail,
        ));
      }
    } catch (error) {
      emit(AuthSmsErrorState());
    }
  }

  Future<void> sendAuthStepThreeInitState() async {
    emit(AuthStepThreeInitState());
  }

  Future<void> sendAuthStepTwoInitState() async {
    emit(AuthStepTwoInitState());
  }

  Future<void> sendAuthStepOneInitState() async {
    emit(AuthStepOneInitState());
  }

  Future<void> sendAuthStepFourInitState() async {
    emit(AuthStepFourInitState());
  }

  Future<void> sendAuthStepFiveInitState() async {
    emit(AuthStepFiveInitState());
  }

  Future<void> getListStacks() async {
    try {
      emit(AuthLoadingState());
      final response = await repository.getStacks();
      final List<Categories> _categories =
          (json.decode(response.bodyString) as List)
              .map((i) => Categories.fromJson(i))
              .toList();
      emit(AuthStacksResponseState(categories: _categories));
    } catch (error) {
      emit(AuthStacksErrorState());
    }
  }

  Future<void> getListSkills() async {
    try {
      emit(AuthLoadingState());
      final response = await repository.getSkills();
      final List<Categories> _categories =
          (json.decode(response.bodyString) as List)
              .map((i) => Categories.fromJson(i))
              .toList();
      emit(AuthSkillsResponseState(categories: _categories));
    } catch (error) {
      emit(AuthSkillsErrorState());
    }
  }

  Future<void> getListCities() async {
    try {
      emit(AuthLoadingState());
      final response = await repository.getCities();
      final List<Categories> _categories =
          (json.decode(response.bodyString) as List)
              .map((i) => Categories.fromJson(i))
              .toList();
      emit(AuthCitiesResponseState(categories: _categories));
    } catch (error) {
      emit(AuthCitiesErrorState());
    }
  }

  Future<void> sendAuthShortInfo(AuthRequestShortInfo shortInfo) async {
    try {
      emit(AuthLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.sendStepOne(shortInfo, authHeader);
      final gResponse = BaseResponse.fromJson(response.bodyString);
      if (response.isSuccessful && gResponse.status) {
        emit(AuthSuccessStepOneState(
            status: gResponse.status, detail: gResponse.detail));
      } else {
        emit(AuthErrorStepOneState(
          status: gResponse.status,
          detail: gResponse.detail,
        ));
      }
    } catch (error) {
      emit(AuthErrorStepOneState());
    }
  }

  Future<void> sendAuthFullInfo(AuthRequestInfo authInfo) async {
    try {
      emit(AuthLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.sendStepTwo(authInfo, authHeader);
      final gResponse = BaseResponse.fromJson(response.bodyString);
      if (response.isSuccessful && gResponse.status) {
        emit(AuthSuccessStepTwoState(
            status: gResponse.status, detail: gResponse.detail));
      } else {
        emit(AuthErrorStepTwoState(
          status: gResponse.status,
          detail: gResponse.detail,
        ));
      }
    } catch (error) {
      emit(AuthErrorStepTwoState());
    }
  }

  Future<void> sendAuthProfInfo(AuthRequestProfInfo authInfo) async {
    try {
      emit(AuthLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.sendStepThree(authInfo, authHeader);
      final gResponse = BaseResponse.fromJson(response.bodyString);
      if (response.isSuccessful && gResponse.status) {
        emit(AuthSuccessStepThreeState(
            status: gResponse.status, detail: gResponse.detail));
      } else {
        emit(AuthErrorStepThreeState(
          status: gResponse.status,
          detail: gResponse.detail,
        ));
      }
    } catch (error) {
      emit(AuthErrorStepThreeState());
    }
  }

  Future<void> sendAuthServiceInfo(AuthRequestServiceInfo authInfo) async {
    try {
      emit(AuthLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.sendStepFour(authInfo, authHeader);
      final gResponse = BaseResponse.fromJson(response.bodyString);
      if (response.isSuccessful && gResponse.status) {
        emit(AuthSuccessStepFourState(
            status: gResponse.status, detail: gResponse.detail));
      } else {
        emit(AuthErrorStepFourState(
          status: gResponse.status,
          detail: gResponse.detail,
        ));
      }
    } catch (error) {
      emit(AuthErrorStepFourState());
    }
  }

  Future<void> sendAuthImagesInfo(
      File frontPhoto, File passport, File avatar, int role) async {
    try {
      emit(AuthLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";

      final frontBytes = (await frontPhoto.readAsBytes()).toList();
      final frontFile =
          await http.MultipartFile.fromBytes('front_photo', frontBytes);
      final passportBytes = (await passport.readAsBytes()).toList();
      final passportFile =
          await http.MultipartFile.fromBytes('passport', passportBytes);
      final avatarBytes = (await avatar.readAsBytes()).toList();
      final avatarFile =
          await http.MultipartFile.fromBytes('avatar', avatarBytes);

      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "${authHeader}",
      };
      var request = new http.MultipartRequest(
          "POST", Uri.parse('http://139.59.179.254/auth/registration/step/5'));
      request.headers.addAll(headers);
      request.fields['role'] = role.toString();
      request.files.add(
          await http.MultipartFile.fromPath('front_photo', frontPhoto.path));
      request.files
          .add(await http.MultipartFile.fromPath('passport', passport.path));
      request.files
          .add(await http.MultipartFile.fromPath('avatar', avatar.path));
      request.send().then((response) {
        http.Response.fromStream(response).then((onValue) {
          try {
            print("Status code + ${response.statusCode}");
            print("Body ++++ ${onValue.body}");
            final gResponse = BaseResponse.fromJson(onValue.body);
            print("Success ++++++++ ${gResponse}");
          } catch (e) {
            print("Error ++++++++ ${e}");
          }
        });
      });

      // final authInfo = AuthRequestImagesInfo(
      //     frontPhoto: frontFile,
      //     passport: passportFile,
      //     avatar: avatarFile,
      //     role: role);

      // final response = await repository.sendStepFive(authInfo, authHeader);
      // final gResponse = BaseResponse.fromJson(response.bodyString);
      // if (response.isSuccessful && gResponse.status) {
      //   emit(AuthSuccessStepFiveState(
      //       status: gResponse.status, detail: gResponse.detail));
      // } else {
      //   emit(AuthErrorStepFiveState(
      //     status: gResponse.status,
      //     detail: gResponse.detail,
      //   ));
      // }
    } catch (error) {
      emit(AuthErrorStepFiveState());
    }
  }

  Future<void> getProfStateInitState() async {
    emit(AuthLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final showProfile = prefs.getString('token') != null ? true : false;
    prefs.setBool("showProfile", showProfile);
    emit(ShowProfState(status: showProfile));
  }

  Future<void> getProfInfo() async {
    try {
      emit(AuthLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";
      final response = await repository.getMyProfInfo(authHeader);
      final Developer developer =
          Developer.fromJson(json.decode(response.bodyString));
      emit(AuthProfInfoResponseState(developer: developer));
      print("Hello worllld + ${developer}");
    } catch (error) {
      emit(AuthProfInfoErrorState());
    }
  }


  Future<void> setRole(int role) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("role", role);
  }
}
