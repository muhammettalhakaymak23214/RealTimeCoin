import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/features/navigation/view/main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 914),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.scaffoldBg,
            //Text Theme
            textTheme: TextTheme(
              //Display
              displayLarge: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.0,
                height: 1.1,
                color: AppColors.textPrimary,
              ),
              //Headline
              headlineLarge: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                height: 1.2,
                color: AppColors.textPrimary,
              ),
              headlineMedium: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: AppColors.textPrimary,
              ),
              headlineSmall: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              //Title
              titleLarge: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: AppColors.textPrimary,
              ),
              titleMedium: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.15,
                height: 1.4,
                color: AppColors.textPrimary,
              ),
              titleSmall: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
                color: AppColors.textPrimary,
              ),
              //Body
              bodyLarge: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                height: 1.5,
                color: AppColors.textPrimary,
              ),
              bodyMedium: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                height: 1.4,
                color: AppColors.textPrimary,
              ),
              bodySmall: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
                height: 1.4,
                color: AppColors.textPrimary.withValues(alpha: 0.7),
              ),
              //Label
              labelLarge: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
                color: AppColors.textPrimary,
              ),
              labelMedium: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: AppColors.textPrimary,
              ),
              labelSmall: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const MainWrapper(),
        );
      }
    );
  }
}
