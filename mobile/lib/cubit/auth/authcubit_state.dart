part of 'auth_cubit.dart';

@immutable
abstract class AuthCubitState {}

class AuthEmptyState extends AuthCubitState {}

class AuthLoadingState extends AuthCubitState {}

class AuthErrorState extends AuthCubitState {
  bool status;
  String detail;
  String errorType;

  AuthErrorState({this.status, this.detail, this.errorType});
}

class AuthSuccessStepOneState extends AuthCubitState {
  bool status;
  String detail;

  AuthSuccessStepOneState({this.status, this.detail});
}

class AuthErrorStepOneState extends AuthCubitState {
  bool status;
  String detail;

  AuthErrorStepOneState({this.status, this.detail});
}

class AuthSuccessStepTwoState extends AuthCubitState {
  bool status;
  String detail;

  AuthSuccessStepTwoState({this.status, this.detail});
}

class AuthErrorStepTwoState extends AuthCubitState {
  bool status;
  String detail;

  AuthErrorStepTwoState({this.status, this.detail});
}

class AuthSuccessStepThreeState extends AuthCubitState {
  bool status;
  String detail;

  AuthSuccessStepThreeState({this.status, this.detail});
}

class AuthErrorStepThreeState extends AuthCubitState {
  bool status;
  String detail;

  AuthErrorStepThreeState({this.status, this.detail});
}

class AuthSuccessStepFourState extends AuthCubitState {
  bool status;
  String detail;

  AuthSuccessStepFourState({this.status, this.detail});
}

class AuthErrorStepFourState extends AuthCubitState {
  bool status;
  String detail;

  AuthErrorStepFourState({this.status, this.detail});
}

class AuthSuccessStepFiveState extends AuthCubitState {
  bool status;
  String detail;

  AuthSuccessStepFiveState({this.status, this.detail});
}

class AuthErrorStepFiveState extends AuthCubitState {
  bool status;
  String detail;

  AuthErrorStepFiveState({this.status, this.detail});
}

//Sms State Send Otp code
class AuthSmsInitState extends AuthCubitState {}

class AuthSmsResponseState extends AuthCubitState {
  String token;
  bool registered;
  int role;
  AuthSmsResponseState(
      {@required this.token, @required this.registered, @required this.role})
      : assert(token != null);
}

class AuthSmsErrorState extends AuthCubitState {
  bool status;
  String detail;

  AuthSmsErrorState({this.status, this.detail});
}

//Get OTP code
class AuthOtpInitState extends AuthCubitState {}

class AuthOtpResponseState extends AuthCubitState {}

// Step 1
class AuthStepOneInitState extends AuthCubitState {}

class AuthStepOneResposnseState extends AuthCubitState {}

// Step 2
class AuthStepTwoInitState extends AuthCubitState {}

class AuthStepTwoResponseState extends AuthCubitState {}

// Step 3
class AuthStepThreeInitState extends AuthCubitState {}

class AuthStepThreeResponseState extends AuthCubitState {}

// Step 4
class AuthStepFourInitState extends AuthCubitState {}

class AuthStepFourResponseState extends AuthCubitState {}

// Step 5
class AuthStepFiveInitState extends AuthCubitState {}

class AuthStepFiveResponseState extends AuthCubitState {}

class AuthStacksResponseState extends AuthCubitState {
  List<Categories> categories;
  AuthStacksResponseState({this.categories});
}

class AuthStacksErrorState extends AuthCubitState {
  bool status;
  String detail;

  AuthStacksErrorState({this.status, this.detail});
}

class AuthSkillsResponseState extends AuthCubitState {
  List<Categories> categories;
  AuthSkillsResponseState({this.categories});
}

class AuthSkillsErrorState extends AuthCubitState {
  bool status;
  String detail;

  AuthSkillsErrorState({this.status, this.detail});
}

class AuthCitiesResponseState extends AuthCubitState {
  List<Categories> categories;
  AuthCitiesResponseState({this.categories});
}

class AuthCitiesErrorState extends AuthCubitState {
  bool status;
  String detail;

  AuthCitiesErrorState({this.status, this.detail});
}

class ShowProfState extends AuthCubitState {
  bool status;
  ShowProfState({this.status});
}

class AuthProfInfoResponseState extends AuthCubitState {
  Developer developer;

  AuthProfInfoResponseState({this.developer});
}

class AuthProfInfoErrorState extends AuthCubitState {
  bool status;
  String detail;

  AuthProfInfoErrorState({this.status, this.detail});
}

class AuthRequest {
  String _email;
  String _name;
  String _surname;
  String _iin;
  String _birthday;
  String _phone;
  int _cityId;
  String _xex;
  bool _userType;

  AuthRequest();

  get email => this._email;

  set email(String email) {
    this._email = email;
  }

  get name => this._name;

  set name(String name) {
    this._name = name;
  }

  get surname => this._surname;

  set surname(String surname) {
    this._surname = surname;
  }

  get iin => this._iin;

  set iin(String iin) {
    this._iin = iin;
  }

  get birthday => this._birthday;

  set birthday(String birthday) {
    this._birthday = birthday;
  }

  get phone => this._phone;

  set phone(String phone) {
    this._phone = phone;
  }

  get cityId => this._cityId;

  set cityId(int cityId) {
    this._cityId = cityId;
  }

  get xex => this._xex;

  set xex(String phone) {
    this._xex = xex;
  }

  get userType => this._userType;

  set userType(bool userType) {
    this._userType = userType;
  }
}

class AuthRequestShortInfo {
  String name;
  String surname;
  String iin;
  int role;

  AuthRequestShortInfo({
    @required this.name,
    @required this.surname,
    @required this.iin,
    @required this.role,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'surname': surname, 'iin': iin, 'role': role};
  }

  String toJson() => json.encode(toMap());
}

class AuthRequestInfo {
  String birth_date;
  int gender;
  String phone;
  int city;
  int role;

  AuthRequestInfo({
    @required this.birth_date,
    @required this.gender,
    @required this.phone,
    @required this.city,
    @required this.role,
  });
}

class AuthRequestServiceInfo {
  String serviceTitle;
  String serviceDescription;
  double price;
  bool priceFix;
  int role;

  AuthRequestServiceInfo({
    @required this.serviceTitle,
    @required this.serviceDescription,
    @required this.price,
    @required this.priceFix,
    @required this.role,
  });
}

class AuthRequestProfInfo {
  String workPlace;
  String education;
  int stacks;
  List<int> skills;
  String about;
  String workExperience;
  int role;

  AuthRequestProfInfo({
    @required this.workPlace,
    @required this.education,
    @required this.stacks,
    @required this.skills,
    @required this.about,
    @required this.workExperience,
    @required this.role,
  });
}

class AuthRequestImagesInfo {
  http.MultipartFile frontPhoto;
  http.MultipartFile passport;
  http.MultipartFile avatar;
  int role;

  AuthRequestImagesInfo({
    @required this.frontPhoto,
    @required this.passport,
    @required this.avatar,
    @required this.role,
  });
}
