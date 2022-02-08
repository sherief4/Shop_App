import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_register/cubit/states.dart';
import 'package:shop_app/shared/common_widgets.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
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
                        'Register now to explore our hot offers',
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
                        controller: nameController,
                        obscure: false,
                        label: 'User name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      defaultTextField(
                        controller: phoneController,
                        obscure: false,
                        label: 'Phone Number',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      defaultTextField(
                        controller: emailController,
                        obscure: false,
                        label: 'Email',
                        prefix: Icons.mail_outline_rounded,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      defaultTextField(
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock,
                          obscure: cubit.isPassword,
                          suffix: cubit.isPassword
                              ? Icons.remove_red_eye_rounded
                              : Icons.visibility_off_rounded,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          }),
                      const SizedBox(
                        height: 32.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 55.0,
                        child: state is! RegisterLoadingState
                            ? MaterialButton(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.deepPurple,
                                onPressed: () {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                },
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ],
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
