part of 'home_cubit.dart';

@immutable
abstract class HomeCubitState {}

class HomeEmptyState extends HomeCubitState {}

class HomeInitialState extends HomeCubitState {}

class HomeLoadingState extends HomeCubitState {}

class HomeErrorState extends HomeCubitState {
  bool status;
  String detail;

  HomeErrorState({this.status, this.detail});
}

class HomeSuccessInfoState extends HomeCubitState {
  bool status;
  String detail;
  List<Developer> developers;

  HomeSuccessInfoState({this.status, this.detail, this.developers});
}

class HomeDeveloperInfoState extends HomeCubitState {
  Developer developer;

  HomeDeveloperInfoState({this.developer});
}

class HomeDeveloperErrorState extends HomeCubitState {
  bool status;
  String detail;

  HomeDeveloperErrorState({this.status, this.detail});
}

class FavoritesDevInfoState extends HomeCubitState {
  List<Developer> developers;

  FavoritesDevInfoState({this.developers});
}

class FavoritesDevErrorState extends HomeCubitState {
  bool status;
  String detail;

  FavoritesDevErrorState({this.status, this.detail});
}

class IsFavoriteState extends HomeCubitState {
  Developer developer;

  IsFavoriteState({this.developer});
}

class IsFavoriteErrorState extends HomeCubitState {
  bool status;
  String detail;

  IsFavoriteErrorState({this.status, this.detail});
}

class RespondState extends HomeCubitState {
  Developer developer;

  RespondState({this.developer});
}

class RespondErrorState extends HomeCubitState {
  bool status;
  String detail;

  RespondErrorState({this.status, this.detail});
}

class BurnProjectListSuccessState extends HomeCubitState {
  List<Burn> burns;

  BurnProjectListSuccessState({this.burns});
}

class BurnProjectListErrorState extends HomeCubitState {
  bool status;
  String details;

  BurnProjectListErrorState({this.status, this.details});
}

class CreateBurnProjectErrorState extends HomeCubitState {
  bool status;
  String details;

  CreateBurnProjectErrorState({this.status, this.details});
}

class CreateBurnSuccessState extends HomeCubitState {
  bool status;
  String details;

  CreateBurnSuccessState({this.status, this.details});
}

class RespondListSuccessState extends HomeCubitState {
  List<Respond> respond;

  RespondListSuccessState({this.respond});
}

class RespondListErrorState extends HomeCubitState {
  bool status;
  String details;

  RespondListErrorState({this.status, this.details});
}


class RespondDevToClientSuccessState extends HomeCubitState {
  Respond respond;

  RespondDevToClientSuccessState({this.respond});
}

class RespondDevToClientErrorState extends HomeCubitState {
  bool status;
  String details;

  RespondDevToClientErrorState({this.status, this.details});
}


class BurnProjectSuccessState extends HomeCubitState {
  Burn burn;

  BurnProjectSuccessState({this.burn});
}

class BurnProjectErrorState extends HomeCubitState {
  bool status;
  String details;

  BurnProjectErrorState({this.status, this.details});
}


class AcceptClientSuccessState extends HomeCubitState {
  Respond respond;

  AcceptClientSuccessState({this.respond});
}

class AcceptClientErrorState extends HomeCubitState {
  bool status;
  String details;

  AcceptClientErrorState({this.status, this.details});
}
