import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginScreenInitialState());
 late ShopLoginModel loginModel ;
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(LoginScreenChangePassword());
  }

  void userLogin(
    String email,
    String password,
  ) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(LoginSuccessState(model: loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error: error.toString()));

    });
  }
}
