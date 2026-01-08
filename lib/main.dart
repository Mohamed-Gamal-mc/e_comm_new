import 'package:e_comm_new/core/app_bloc_observer/app_bloc_observer.dart';
import 'package:e_comm_new/core/di/service_locator.dart';
import 'package:e_comm_new/core/routes/route_generator.dart';
import 'package:e_comm_new/core/routes/routes.dart';
import 'package:e_comm_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  configureDependencies();
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator.get<AuthCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.register,
        ),
      ),
    );
  }
}
