import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_register/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterScreenStates> {
  RegisterCubit() : super(RegisterScreenInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(RegisterScreenPasswordChanged());
  }

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error: error.toString()));
    });
  }
}
