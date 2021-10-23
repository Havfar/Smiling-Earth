import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/bloc/bloc_login_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/repository/user_repository.dart';
import 'package:smiling_earth_frontend/pages/home_page.dart';
import 'package:smiling_earth_frontend/pages/log_in_page.dart';
import 'package:smiling_earth_frontend/pages/splash_page.dart';
import 'package:smiling_earth_frontend/utils/services/background_services.dart';
import 'package:smiling_earth_frontend/widgets/loading_indicator.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(new SmilingEarthHome());
// }

// class SmilingEarthHome extends StatefulWidget {
//   @override
//   _SmilingEarthHomeState createState() => new _SmilingEarthHomeState();
// }

// class _SmilingEarthHomeState extends State<SmilingEarthHome> {
//   @override
//   void initState() {
//     super.initState();
//     startActivityMonitor();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (false) {
//       return HomePage();
//     } else {
//       return MaterialApp(home: SplashPage());
//     }
//   }
// }

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocDelegate();

  final userRepository = UserRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
  //todo: if authenticated
  initializeWorkManagerAndPushNotification();
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return HomePage();
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
