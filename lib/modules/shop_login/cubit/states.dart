import 'package:shop_app/models/login_model.dart';

abstract class LoginStates{}

class LoginScreenInitialState extends LoginStates{}

class LoginScreenChangePassword extends LoginStates{}

class LoginSuccessState extends LoginStates{
  ShopLoginModel model;
  LoginSuccessState({required this.model});
}

class LoginLoadingState extends LoginStates{}

class LoginErrorState extends LoginStates{
  final String error ;
  LoginErrorState({required this.error});

}

