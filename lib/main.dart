import 'dart:io';
import 'package:ager_waffer/Features/Authentication/presentation/pages/frogetpassword.dart';
import 'package:ager_waffer/Features/Authentication/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Authentication/presentation/pages/register_screen.dart';
import 'package:ager_waffer/Features/Splash/presentation/pages/splash_screen.dart';
import 'package:ager_waffer/firebase_options.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Base/Notifications/local_notification_service.dart';
import 'Base/common/shared.dart';
import 'Base/common/shared_preference_manger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (message != null) {
    final routeMessage = message.data['Type'];
    if (!Shared.vistor_value!) {
      switch (routeMessage) {
        case "Jobs":
          /*          Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  PreviousJobsScreen(
                    notification_job_id: message.data['RefId'],
                  )));*/
          break;
        case "Initiatives":
          /*          Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  PreviousIntativesScreen(
                    notification_job_id: message.data['RefId'],
                  )));*/
          break;
      }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await LocalizeAndTranslate.init(
    defaultType: LocalizationDefaultType.device,
    supportedLanguageCodes: const <String>['ar', 'en'],
    assetLoader: const AssetLoaderRootBundleJson('assets/i18n/'),
  );

  sharedPreferenceManager.readString(CachingKey.APP_LANGUAGE).then((
    value,
  ) async {
    // check if value is null so its length will be more than two letter
    if (value.length > 3) {
      await LocalizeAndTranslate.setLanguageCode(
        WidgetsBinding.instance.window.locale.languageCode,
      );
    } else {
      await LocalizeAndTranslate.setLanguageCode(value);
    }
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return LocalizedApp(
          // ← LocalizedApp stays here
          child: child!,
        );
      },
      child:
          const MyApp(), // ← Renamed from MyMaterial → now this is your real MaterialApp
    ),
  );
}

// ← Rename your MyMaterial class to MyApp (or just use this)
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // ... all your previous code from MyMaterialState stays exactly the same ...

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      // ← ONLY ONE MaterialApp in the entire app!
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Tajawal'),
      locale: LocalizeAndTranslate.getLocale(),
      supportedLocales: LocalizeAndTranslate.getLocals(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        CountryLocalizations.delegate,
      ],
      home: const SplashScreen(),
      routes: {

        'LoginScreen': (context) => LoginScreen(),
        'RegisterScreen': (context) => RegisterScreen(),
        'FrogetPassword': (context) => Frogetpassword(),

      },
    );
  }

  // ... rest of your _fcmConfigure, didChangeMetrics, etc. stays unchanged ...
}

var navigatorKey = GlobalKey<NavigatorState>();

class MyMaterial extends StatefulWidget {
  static var app_langauge;

  @override
  MyMaterialState createState() => MyMaterialState();

  static void setLocale(BuildContext context, Locale newLocale) {
    MyMaterialState? state = context.findAncestorStateOfType();

    app_langauge = newLocale.languageCode;
    state?.setState(() => state.local = newLocale);
  }
}

class MyMaterialState extends State<MyMaterial> with WidgetsBindingObserver {
  Locale? local;
  String? _currentLanguageCode;
  Key? key = UniqueKey();

  void get_device_token() async {
    String? device_token = await FirebaseMessaging.instance.getToken();
    sharedPreferenceManager.writeData(CachingKey.DEVICE_TOKEN, device_token);
  }

  @override
  void initState() {
    super.initState();
    _currentLanguageCode = WidgetsBinding.instance.window.locale.languageCode;
    WidgetsBinding.instance.addObserver(this);

    _fcmConfigure(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final newLanguageCode = WidgetsBinding.instance.window.locale.languageCode;
    if (newLanguageCode != _currentLanguageCode) {
      setState(() {
        _currentLanguageCode = newLanguageCode;
        MyMaterial.app_langauge = newLanguageCode;
      });
      LocalizeAndTranslate.setLanguageCode(newLanguageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        return MultiBlocProvider(
          providers: [
            // BlocProvider.value(value: LocationBloc()),
            //   BlocProvider.value(value: NotificationsBloc()),
            //   BlocProvider.value(value: MyCarsBloc()),
            //   BlocProvider.value(value: ProfileBloc()),
            //   BlocProvider.value(value: UploadImageBloc()),
            //   BlocProvider.value(value: CreateOrderBloc()),
            //   BlocProvider.value(value: OrdersBloc())
          ],

          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Tajawal'),
            locale: LocalizeAndTranslate.getLocale(),
            supportedLocales: LocalizeAndTranslate.getLocals(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              CountryLocalizations.delegate,
            ],
            home: SplashScreen(), //CongratulationScreen(),
          ),
        );
      },
    );
  }

  Future<void> _fcmConfigure(BuildContext context) async {
    LocalNotificationService.initialize(context);
    final _firebaseMessaging = FirebaseMessaging.instance;

    String? device_token = await FirebaseMessaging.instance.getToken();
    sharedPreferenceManager.writeData(CachingKey.DEVICE_TOKEN, device_token);
    print("device token : ${device_token}");

    ///required by IOS permissions
    _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
    // //get the current device token
    // _getCustomerNotification();

    ///gives you the message on which use taps
    ///and it opened from the terminated state
    _firebaseMessaging.getInitialMessage().then((message) async {
      // get the remote message when your app opened from push notification while in background state
      RemoteMessage? initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();

      // check if it is exists
      if (initialMessage != null) {
        // check the data property within RemoteMessage and do navigate based on it

        if (initialMessage != null) {
          final routeMessage = initialMessage.data['Type'];
          if (!Shared.vistor_value!) {
            switch (routeMessage) {
              case "Jobs":
                /*       Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PreviousJobsScreen(
                          notification_job_id: 94.toString(),
                        )));*/
                break;
              case "Initiatives":
                /*  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PreviousIntativesScreen()));*/
                break;
            }
          }
        }
      }
    });

    ///app open on ForeGround. notification will not be visibile but you will receive the data
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }

      if (message != null) {
        final routeMessage = message.data['Type'];
        if (!Shared.vistor_value!) {
          switch (routeMessage) {
            case "Jobs":
              /*     Navigator.push(
                  navigatorKey.currentState!.context,
                  MaterialPageRoute(
                      builder: (context) =>
                      PreviousJobsScreen(
                          notification_job_id: message.data['RefId']
                      )

                  ));*/
              break;
            case "Initiatives":
              /*
              Navigator.push(
                  navigatorKey.currentState!.context,
                  MaterialPageRoute(
                      builder: (context) => PreviousIntativesScreen(
                          notification_job_id: message.data['RefId']
                      )));*/
              break;
          }
        }
      }
    });

    ///app in background and not terminated when you click on the notification this should be triggered
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        final routeMessage = message.data['Type'];
        if (!Shared.vistor_value!) {
          switch (routeMessage) {
            case "Jobs":
              /*    Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>

                      PreviousJobsScreen(
                        notification_job_id: message.data['RefId'],
                      )

              ));*/
              break;
            case "Initiatives":
              /*    Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PreviousIntativesScreen(
                          notification_job_id: message.data['RefId']
                      )));*/

              break;
          }
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      await Firebase.initializeApp();

      if (message != null) {
        final routeMessage = message.data['Type'];
        if (!Shared.vistor_value!) {
          switch (routeMessage) {
            case "Jobs":
              /*     Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>JobDetailsScreen(
                    job_id: message.data['RefId'],
                    screen: PreviousJobsScreen(),
                    show_cancellation_status: true,
                    previous_job_status: message.data['Status'] == 10? true : false,
                  )
              ));*/
              break;
            case "Initiatives":
              /*       Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PreviousIntativesScreen(
                          notification_job_id: message.data['RefId']
                      )));*/

              break;
          }
        }
      }
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
