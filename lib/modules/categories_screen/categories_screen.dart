import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layouts/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(cubit.categoriesModel != null){
          return ListView.separated(
              itemBuilder: (context, index) {
                return buildCategoryItem(
                    cubit.categoriesModel!.data.data[index]
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 3.0,
                    color: Colors.grey,
                  ),
                );
              },
              itemCount: cubit.categoriesModel!.data.data.length) ;
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );
  }

  Widget buildCategoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
              width: 100.0,
              height: 100.0,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              model.name!,
              style: const TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      );
}
