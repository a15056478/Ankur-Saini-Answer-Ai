import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:answers_ai/blocs_list.dart';
import 'package:answers_ai/wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:answers_ai/domain/di/get_it.dart' as get_it;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void dprint(dynamic data) {
  if (kDebugMode) {
    print(data.toString);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const AppBlocObserver();
  await get_it.init();
  await ScreenUtil.ensureScreenSize();
  await dotenv.load(fileName: ".env");

  runApp(MultiBlocProvider(
    providers: AppBlocs().blocs,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize:
          Size(375, MediaQuery.of(context).size.height > 720 ? 815 : 700),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            splash: 'assets/images/answerai_logo.png',
            nextScreen: const WrapperPage(),
            splashTransition: SplashTransition.slideTransition,
          ),
        );
      },
    );
  }
}

/// Bloc observer to check bloc state changes in flutter
class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) dprint('👍🏻$change');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    dprint('👍🏻$transition');
  }
}
