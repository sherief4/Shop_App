import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favourites_screen/favourites_screen.dart';
import 'package:shop_app/modules/products_screen/products_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';
import 'package:shop_app/shared/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int curIn = 0;

  List<Widget> shopScreens =  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    curIn = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favourites = {};

  void getHomeData({required String? token}) async {
    emit(ShopLoadingHomeDataState());
    await DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favourites.addAll({element.id!: element.inFavourites});
      }
      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeDataErrorState(error: error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() async {
    emit(ShopLoadingCategoriesDataState());
    await DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesDataErrorState(error: error));
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;

  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavouritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      if (!changeFavouritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      }else{
        getFavourites();
      }
      emit(ShopChangeFavouritesSuccessState(changeFavouritesModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopChangeFavouritesErrorState(error));
    });
  }

  FavouritesModel? favouritesModel;

  void getFavourites() async {
    emit(ShopGetFavouritesDataSuccessState());
    await DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopCategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavouritesDataErrorState(error.toString()));
    });
  }
  ShopLoginModel? userModel;

  void getUserData() async {
    emit(ShopGetUserDataLoadingState());
    await DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopGetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetUserDataErrorState(error.toString()));
    });
  }

}
