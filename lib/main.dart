import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_layout/cubit/states.dart';
import 'package:shop_app/layouts/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/onBoarding/on_boarding.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/shop_login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  bool isBoarding = await CacheHelper.getData('OnBoarding') ?? false;
  token = await CacheHelper.getData('token');
  if (isBoarding != true) {
    widget = const OnBoardingScreen();
  } else {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }

  runApp(MyApp(
    onBoarding: isBoarding,
    startWidget: widget,
    curToken: token,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;
  final String? curToken;

  const MyApp(
      {Key? key,
      required this.onBoarding,
      required this.startWidget,
      required this.curToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData(token: curToken)
        ..getCategories()..getFavourites()..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
