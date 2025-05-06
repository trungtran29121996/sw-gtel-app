import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sw_app_gtel/common/pref/sp_util.dart';
import 'package:sw_app_gtel/common/style/color.dart';
import 'package:sw_app_gtel/navigation/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(builder: (_, child) {
          return MaterialApp(
            title: 'Gtel',
            //debugShowCheckedModeBanner: true,
            theme: ColorsUtils.driverTheme,
            initialRoute: AppRoutes.INITIAL_ROOT,
            onGenerateRoute: AppRoutes.generateRoute,
            localizationsDelegates: const [
              //AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            //locale: state.currentLocale,
            //supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              );
            },
          );
        }));
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<AppBloc>(
    //         create: (context) => AppBloc()
    //           ..add(CheckLocaleEvent())
    //           ..add(GetDevicesIdEvent())),
    //   ],
    //   child: BlocBuilder<AppBloc, AppState>(
    //     builder: (context, state) {
    //       return ScreenUtilInit(
    //           designSize: const Size(360, 690),
    //           minTextAdapt: true,
    //           splitScreenMode: true,
    //           child: MaterialApp(builder: (_, child) {
    //             return MaterialApp(
    //               title: 'Gtel',
    //               //debugShowCheckedModeBanner: true,
    //               theme: ColorsUtils.driverTheme,
    //               initialRoute: AppRoutes.INITIAL_ROOT,
    //               onGenerateRoute: AppRoutes.generateRoute,
    //               localizationsDelegates: const [
    //                 AppLocalizations.delegate,
    //                 GlobalMaterialLocalizations.delegate,
    //                 GlobalWidgetsLocalizations.delegate,
    //                 GlobalCupertinoLocalizations.delegate,
    //               ],
    //               locale: state.currentLocale,
    //               supportedLocales: AppLocalizations.supportedLocales,
    //               builder: (context, child) {
    //                 return MediaQuery(
    //                   data: MediaQuery.of(context)
    //                       .copyWith(textScaler: TextScaler.linear(1.0)),
    //                   child: child!,
    //                 );
    //               },
    //             );
    //           }));
    //     },
    //   ),
    // );
  }
}
