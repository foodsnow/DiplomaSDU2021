import 'package:chopper/chopper.dart';
part 'auth_api_services.chopper.dart';

@ChopperApi()
abstract class AuthApiServices extends ChopperService {
  @Post(path: 'auth/send-otp/')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postOtp(
    @Field("email") String email,
  );

  @Post(path: 'auth/validate-otp/')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> validateOtp(
      @Field("email") String email, @Field("otp") String otp);

  @Post(path: 'auth/registration/step/1')
  Future<Response> sendStepOne(
    @Header("Authorization") String token,
    @Field("name") String name,
    @Field("surname") String surname,
    @Field("iin") String iin,
    @Field("role") int role,
  );

  @Post(path: 'auth/registration/step/2')
  Future<Response> sendStepTwo(
    @Header("Authorization") String token,
    @Field("birth_date") String birth_date,
    @Field("gender") int gender,
    @Field("phone") String phone,
    @Field("city") int city,
    @Field("role") int role,
  );

  @Post(path: 'auth/registration/step/3')
  Future<Response> sendStepThree(
    @Header("Authorization") String token,
    @Field("work_place") String workPlace,
    @Field("education") String education,
    @Field("stacks") int stacks,
    @Field("skills") List<int> skills,
    @Field("about") String about,
    @Field("work_experience") String workExperience,
    @Field("role") int role,
  );

  @Post(path: 'auth/registration/step/4')
  Future<Response> sendStepFour(
    @Header("Authorization") String token,
    @Field("service_title") String serviceTitle,
    @Field("service_description") String serviceDescription,
    @Field("price") double price,
    @Field("price_fix") bool priceFix,
    @Field("role") int role,
  );

  @Get(path: 'api/stacks/')
  Future<Response> getStacks();

  @Get(path: 'api/skills/')
  Future<Response> getSkills();

  @Get(path: 'api/cities/')
  Future<Response> getCities();

  @Get(path: '/api/my-profile')
  Future<Response> getMyProfInfo(
    @Header("Authorization") String token,
  );

  static AuthApiServices create() {
    final client = ChopperClient(
        baseUrl: 'http://139.59.179.254',
        services: [
          _$AuthApiServices(),
        ],
        converter: JsonConverter(),
        interceptors: [HttpLoggingInterceptor(), CurlInterceptor()]);
    return _$AuthApiServices(client);
  }
}
