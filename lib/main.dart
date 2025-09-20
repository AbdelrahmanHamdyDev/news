import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/blocs/theme_cubit.dart';
import 'package:news/services/supabase_service.dart';
import 'package:news/views/auth_page.dart';
import 'package:news/views/navigation_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  const supabaseFunctionUrl = String.fromEnvironment('SUPABASE_FUNCTIONS_URL');

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  final supabase = Supabase.instance.client;
  final supabaseService = SupabaseService(
    supabase: supabase,
    functionsBaseUrl: supabaseFunctionUrl,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewsBloc(service: supabaseService)),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, int>(
        builder: (context, themeState) {
          final themeCubit = context.read<ThemeCubit>();
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeCubit.themeMode,
              themeAnimationDuration: Duration(milliseconds: 300),
              themeAnimationCurve: Curves.fastEaseInToSlowEaseOut,
              initialRoute: '/login',
              routes: {
                '/login': (_) => const AuthPage(),
                '/app': (_) => NavigationPage(),
              },
            ),
          );
        },
      ),
    ),
  );
}
