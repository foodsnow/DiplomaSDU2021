import 'package:diploma_flutter_app/cubit/auth/auth_cubit.dart';
import 'package:diploma_flutter_app/cubit/home/home_cubit.dart';
import 'package:diploma_flutter_app/pages/auth/auth_step_five.dart';
import 'package:diploma_flutter_app/pages/auth/auth_step_four.dart';
import 'package:diploma_flutter_app/pages/auth/auth_step_one.dart';
import 'package:diploma_flutter_app/pages/auth/auth_step_three.dart';
import 'package:diploma_flutter_app/pages/auth/auth_step_two.dart';
import 'package:diploma_flutter_app/pages/edit/burnout_detail_page.dart';
import 'package:diploma_flutter_app/pages/edit/create_burn_out_page.dart';
import 'package:diploma_flutter_app/pages/home/user_details.dart';
import 'package:diploma_flutter_app/pages/home_bottom_nav.dart';
import 'package:diploma_flutter_app/pages/auth/otp_sms.dart';
import 'package:diploma_flutter_app/pages/auth/roles_dev_client.dart';
import 'package:diploma_flutter_app/services/chopper_services/auth/repository.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/home_repository.dart';
import 'package:diploma_flutter_app/utils/main_theme.dart';
import 'package:diploma_flutter_app/widgets/open_pdf_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  Bloc.observer = AppBlocObserver();
  runApp(HomeApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class HomeApp extends StatelessWidget {
  final theme = MainTheme.light();
  final repository = Repository();
  final homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(repository),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(homeRepository),
        ),
      ],
      child: MaterialApp(
          home: Home(),
          theme: theme,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) {
                return _makeRoute(
                    context: context,
                    routeName: settings.name,
                    arguments: settings.arguments);
              },
              maintainState: true,
              fullscreenDialog: false,
            );
          }),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}

Widget _makeRoute(
    {@required BuildContext context,
    @required String routeName,
    Object arguments}) {
  final Widget child = _buildRoute(
    context: context,
    routeName: routeName,
    arguments: arguments,
  );
  return child;
}

Widget _buildRoute({
  @required BuildContext context,
  @required String routeName,
  Object arguments,
}) {
  switch (routeName) {
    case '/OtpSms':
      return Otp(email: arguments);
    case '/Roles':
      return DevClientRolesPage();
    case '/Step1':
      return StepOne(arguments);
    case '/Step2':
      return StepTwo(arguments);
    case '/Step3':
      return StepThree(arguments);
    case '/Step4':
      return StepFour(arguments);
    case '/Step5':
      return StepFive(arguments);
    case '/Home':
      return Home();
    case '/AccountDetails':
      return UserDetails(arguments);
    case '/BurnOutDetailPage':
      return BurnOurDetailPage(arguments);
    case '/CreateBurnOutPage':
      return CreateBurnOutPage();
    case '/OpenPdfView':
      return MyHomePage(url: arguments);
    default:
      return Container();
  }
}
