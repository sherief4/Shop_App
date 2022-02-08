import 'package:shop_app/modules/shop_login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/common_widgets.dart';

void signOut(context){
  CacheHelper.removeData('token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}


late String? token ;
