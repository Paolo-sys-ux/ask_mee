import 'package:ask_mee/constants/navigation_bar.dart';
import 'package:ask_mee/screens/bloc/email_login/email_login_bloc.dart';
import 'package:ask_mee/screens/bloc/facebook/facebook_bloc.dart';
import 'package:ask_mee/screens/bloc/google/google_bloc.dart';
import 'package:ask_mee/screens/bloc/signup/signup_bloc.dart';
import 'package:ask_mee/screens/home_screen/home_screen.dart';
import 'package:ask_mee/screens/login_screen/login_screen.dart';
import 'package:ask_mee/screens/signup_screen/signup_screen.dart';
import 'package:ask_mee/screens/user_screen/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
          create: (BuildContext context) => SignupBloc(),
        ),
        BlocProvider<FacebookBloc>(
          create: (BuildContext context) => FacebookBloc(),
        ),
        BlocProvider<GoogleBloc>(
          create: (BuildContext context) => GoogleBloc(),
        ),
        BlocProvider<EmailLoginBloc>(
          create: (BuildContext context) => EmailLoginBloc(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/homescreen': (context) => HomeScreen(),
          '/userscreen': (context) => UserScreen(),
          '/navigationbar': (context) => NavigationBar(),
          '/signupscreen': (context) => SignupScreen(),
          '/loginscreen': (context) => LoginScreen(),
        },
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Ask Me',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
