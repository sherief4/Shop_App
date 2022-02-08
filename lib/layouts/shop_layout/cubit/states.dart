import 'package:shop_app/models/change_favourites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopHomeDataSuccessState extends ShopStates {}

class ShopHomeDataErrorState extends ShopStates {
  final String error;

  ShopHomeDataErrorState({required this.error});
}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopCategoriesDataSuccessState extends ShopStates {}

class ShopCategoriesDataErrorState extends ShopStates {
  final String error;

  ShopCategoriesDataErrorState({required this.error});
}

class ShopChangeFavouritesSuccessState extends ShopStates {
  final ChangeFavouritesModel? model ;

  ShopChangeFavouritesSuccessState(this.model);

}

class ShopChangeFavouritesState extends ShopStates {}

class ShopChangeFavouritesErrorState extends ShopStates {
  final String error;

  ShopChangeFavouritesErrorState(this.error);
}

class ShopGetFavouritesDataSuccessState extends ShopStates{}

class ShopGetFavouritesDataLoadingState extends ShopStates{}

class ShopGetFavouritesDataErrorState extends ShopStates{
  final String error;

  ShopGetFavouritesDataErrorState(this.error);


}

class ShopGetUserDataSuccessState extends ShopStates{}

class ShopGetUserDataLoadingState extends ShopStates{}

class ShopGetUserDataErrorState extends ShopStates{
  final String error;
  ShopGetUserDataErrorState(this.error);
}