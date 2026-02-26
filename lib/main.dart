
import 'package:application/core/service_locator.dart';
import 'package:application/features/category_listing/presentation/bloc/category_bloc.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_bloc.dart';
import 'package:application/screens/login/presentation/bloc/auth_bloc.dart';
import 'package:application/screens/name_page/presentation/bloc/name_bloc.dart';
import 'package:flutter/material.dart';
import 'package:application/router/app_router.dart';
import 'package:application/router/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();   
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<TransactionBloc>()),
                BlocProvider(create: (_) => sl<NameBloc>()),
                BlocProvider(create: (_) => sl<CategoryBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}