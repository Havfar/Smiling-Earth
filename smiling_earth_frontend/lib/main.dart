import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/bloc/bloc_login_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/repository/user_repository.dart';
import 'package:smiling_earth_frontend/pages/home/home_page.dart';
import 'package:smiling_earth_frontend/pages/log_in_page.dart';
import 'package:smiling_earth_frontend/pages/registration/welcome.dart';
import 'package:smiling_earth_frontend/pages/splash_page.dart';
import 'package:smiling_earth_frontend/utils/services/activity_recognition.dart';
import 'package:smiling_earth_frontend/utils/services/background_services.dart';
import 'package:smiling_earth_frontend/utils/services/local_notifications_service.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';
import 'package:smiling_earth_frontend/widgets/loading_indicator.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  Bloc.observer = SimpleBlocDelegate();

  final userRepository = UserRepository();
  initializeWorkManagerAndPushNotification();
  startActivityMonitor();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
  //todo: if authenticated
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return FutureBuilder<bool>(
                future: SettingsDatabaseManager.instance.hasRegistered(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!) {
                      // initializeWorkManagerAndPushNotification();
                      // startActivityMonitor();
                      return HomePage();
                    } else {
                      return WelcomePage();
                    }
                  }

                  return SplashPage();
                });
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}
