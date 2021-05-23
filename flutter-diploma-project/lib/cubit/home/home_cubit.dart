import 'dart:convert';

import 'package:diploma_flutter_app/services/chopper_services/auth/models/base_response.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/burn.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/burn_list.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/respond.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/respond_list.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/home_repository.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/developer.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/developers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'homecubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  final HomeRepository repository;
  int page = 1;
  int pageFavorites = 1;
  int pageResponds = 1;
  int pageBurnList = 1;
  bool isFetching = false;
  String searchKey;
  int stacksId = 0;
  var stacksListId = <int>[];
  int cityId = 0;
  double minPrice = 0;
  double maxPrice = 400;

  HomeCubit(this.repository) : super(HomeEmptyState());

  Future<void> fetchProfileInfo() async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      final authHeader = prefs.getString('token') != null
          ? "Bearer ${prefs.getString('token')}"
          : null;

      final map = Map<String, dynamic>();
      if (searchKey != null) map['search'] = searchKey;
      if (stacksId != 0) map['stacks_id'] = stacksId;
      if (cityId != 0) map['user__city'] = cityId;
      if (minPrice != 0) map['min_price'] = minPrice * 1000;
      if (maxPrice != 400) map['max_price'] = maxPrice * 1000;
      final response = await repository.getDevProfiles(page, authHeader, map);
      final Developers developers =
          Developers.fromJson(json.decode(response.bodyString));
      emit(HomeSuccessInfoState(developers: developers.results));
    } catch (_) {
      emit(HomeErrorState(detail: "Error"));
    }
  }

  Future<void> fetchDeveloperInfo(int developerId) async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";

      final response =
          await repository.getDeveloperInfo(authHeader, developerId);

      final Developer developer =
          Developer.fromJson(jsonDecode(response.bodyString));
      emit(HomeDeveloperInfoState(developer: developer));
    } catch (error) {
      emit(HomeDeveloperErrorState(detail: "Error + ${error}"));
    }
  }

  Future<void> getFavoritesDeveloperInfo() async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(FavoritesDevErrorState(detail: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.getFavorites(pageFavorites, authHeader);
      final Developers developers =
          Developers.fromJson(json.decode(response.bodyString));
      emit(FavoritesDevInfoState(developers: developers.results));
    } catch (_) {
      emit(FavoritesDevErrorState(detail: "Ошибка"));
    }
  }

  Future<void> chooseFavoriteDeveloper(int developerId, bool isFavorite) async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(IsFavoriteErrorState(detail: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.chooseFavoriteDeveloper(
          authHeader, developerId, isFavorite == true ? 'one' : '');
      final baseResponse =
          BaseModelResponse.fromJson(json.decode(response.bodyString));

      if (baseResponse.status == true) {
        print(
            "Status baseresponse  +${baseResponse.status}, ${baseResponse.detail}");
        emit(IsFavoriteState());
      } else {
        emit(IsFavoriteErrorState(detail: baseResponse.detail));
      }
    } catch (_) {
      emit(IsFavoriteErrorState(detail: "Ошибка"));
    }
  }

  Future<void> inContact(int developerId) async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(RespondErrorState(detail: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";
      final response = await repository.inContact(authHeader, developerId);

      emit(RespondState());
    } catch (_) {
      emit(RespondErrorState(detail: "Ошибка"));
    }
  }

  Future<void> getAllBurnProjects() async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(BurnProjectListErrorState(details: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";

      final response =
          await repository.getAllBurnProjects(pageBurnList, authHeader);
      final BurnList burnList =
          BurnList.fromJson(json.decode(response.bodyString));
      emit(BurnProjectListSuccessState(burns: burnList.results));
    } catch (_) {
      emit(BurnProjectListErrorState(details: "Ошибка"));
    }
  }

  Future<void> getBurnProjectById(int id) async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(BurnProjectErrorState(details: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.getBurnProjectById(authHeader, id);
      final Burn burn = Burn.fromJson(json.decode(response.bodyString));
      emit(BurnProjectSuccessState(burn: burn));
    } catch (_) {
      emit(BurnProjectErrorState(details: "Ошибка"));
    }
  }

  Future<void> createBurnProjects(String pdfPath, String title,
      String description, String deadline, List<int> stacksId) async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final authHeader = "Bearer ${prefs.getString('token')}";

      if (prefs.getString('token') == null) {
        emit(CreateBurnProjectErrorState(
            details: "Пользователь не авторизован"));
        return;
      }

      // final pdfDocFile = (await pdfFile.readAsBytes()).toList();
      // final file =
      // await http.MultipartFile.fromBytes('file_doc', pdfDocFile);
      var headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "${authHeader}",
      };
      var request = new http.MultipartRequest(
          "POST", Uri.parse('http://139.59.179.254/api/burn-projects/'));
      request.headers.addAll(headers);
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['deadline'] = deadline;
      request.fields['stacks'] = stacksId.toString();
      request.files.add(await http.MultipartFile.fromPath('file_doc', pdfPath));
      request.send().then((response) {
        http.Response.fromStream(response).then((onValue) {
          try {
            print("Status code + ${response.statusCode}");
            print("Body ++++ ${onValue.body}");
            emit(CreateBurnSuccessState());
          } catch (e) {
            print("Error ++++++++ ${e}");
          }
        });
      });
    } catch (error) {
      emit(CreateBurnProjectErrorState(details: 'Ошибка'));
    }
  }

  Future<void> getAllRespondProjects() async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(RespondListErrorState(details: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";

      final response =
          await repository.getAllRespondProjects(pageResponds, authHeader);
      final RespondList respondList =
          RespondList.fromJson(json.decode(response.bodyString));
      emit(RespondListSuccessState(respond: respondList.results));
    } catch (_) {
      emit(RespondListErrorState(details: "Ошибка"));
    }
  }

  Future<void> respondDevToClient(
      int price, int burnProjectId, int stackId) async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(RespondDevToClientErrorState(
            details: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";

      print("Burn project id + ${burnProjectId}");

      final response = await repository.respondDevToClient(
          authHeader, price, burnProjectId, stackId);
      final Respond respond =
          Respond.fromJson(json.decode(response.bodyString));
      emit(RespondDevToClientSuccessState(respond: respond));
    } catch (_) {
      emit(RespondDevToClientErrorState(details: "Ошибка"));
    }
  }

  Future<void> acceptClientResponse(
      int id, bool isAccept, int developerId, int burnProjectId) async {
    try {
      emit(HomeLoadingState());
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString('token') == null) {
        emit(AcceptClientErrorState(details: "Пользователь не авторизован"));
        return;
      }

      final authHeader = "Bearer ${prefs.getString('token')}";

      final response = await repository.acceptRespondClient(
          authHeader, id, isAccept, developerId, burnProjectId);
      final Respond respond =
          Respond.fromJson(json.decode(response.bodyString));
      emit(AcceptClientSuccessState(respond: respond));
    } catch (_) {
      emit(AcceptClientErrorState(details: "Ошибка"));
    }
  }
}
