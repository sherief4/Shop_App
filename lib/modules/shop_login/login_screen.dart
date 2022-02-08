import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/shop_login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/modules/shop_register/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/common_widgets.dart';
import 'package:shop_app/shared/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            if(state.model.status!){
              CacheHelper.putData(key: 'token', value: state.model.data!.token).then((value){
                token = state.model.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
               showToast(state.model.message!, ToastState.success);
            }else{
            showToast(state.model.message!, ToastState.error);
            }
          }

        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          'Login now to explore our hot offers',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        defaultTextField(
                          controller: emailController,
                          obscure: false,
                          label: 'Email',
                          prefix: Icons.mail_outline_rounded,
                          validate: (String? value) {
                            if (value!.isEmpty ) {
                              return 'Email can\'t be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        defaultTextField(
                          controller: passwordController,
                          obscure: cubit.isPassword,
                          label: 'Password',
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          suffix: cubit.isPassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_rounded,
                          prefix: Icons.lock,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(emailController.text,
                                  passwordController.text);
                            }
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 55.0,
                          child: state is! LoginLoadingState
                              ? MaterialButton(
                                  color: Colors.deepPurple,
                                  onPressed: () {
                                   if(formKey.currentState!.validate()){
                                     cubit.userLogin(emailController.text,
                                         passwordController.text);
                                   }
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Center(
                          child: Row(
                            children: [
                              const Text('Need an account??'),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text('Register Now'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
