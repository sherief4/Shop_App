import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_layout/cubit/states.dart';
import 'package:shop_app/shared/common_widgets.dart';
import 'package:shop_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        if (cubit.userModel != null) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                defaultTextField(
                  controller: nameController,
                  label: 'Name',
                  obscure: false,
                  prefix: Icons.person,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                defaultTextField(
                  controller: emailController,
                  label: 'Email Address',
                  obscure: false,
                  prefix: Icons.email,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                defaultTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  obscure: false,
                  prefix: Icons.phone,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                  signOut(context);
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    color: Colors.deepPurple,
                    child: const Center(
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Error Getting user data, Pleas try again!'),
          );
        }
      },
    );
  }
}
