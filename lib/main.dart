import 'package:bloc_test/mvc/get_module/bloc/get_bloc.dart';
import 'package:bloc_test/mvc/get_module/views/get_screen.dart';
import 'package:bloc_test/mvc/signin_module/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloc_test/data_provider/pref_helper.dart';
import 'package:bloc_test/utils/navigation_service.dart';
import 'package:bloc_test/utils/styles/styles.dart';
//localization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  //Set Potraite Mode only
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

/// Make sure you always init shared pref first. It has token and token is need
/// to make API call
initServices() async {
  await PrefHelper.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Test',
        navigatorKey: Navigation.key,
        debugShowCheckedModeBanner: false,
        // localization.
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: (PrefHelper.getLanguage() == 1)
            ? const Locale('en', 'US')
            : const Locale('bn', 'BD'),
        theme: ThemeData(
          // globally handle progress color using themeData class
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: Colors.green),
          textTheme: GoogleFonts.robotoMonoTextTheme(),
          primaryColor: KColor.primary.color,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(secondary: KColor.secondary.color),
          primarySwatch: KColor.primary.color as MaterialColor,
        ),
        home: GetScreen(),
      ),
    );
  }
}
