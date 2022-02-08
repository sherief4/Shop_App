import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, destination) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return destination;
  }));
}

void navigateAndFinish(context, destination) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return destination;
  }), (route) => false);
}

Widget defaultTextField({
  required TextEditingController controller,
  required String label,
  required bool obscure,
  required IconData prefix,
  IconData? suffix,
  String? Function(String?)? validate,
  void Function(String)? onSubmit,
  void Function()? suffixPressed,
}) {
  return SizedBox(
    height: 55.0,
    child: TextFormField(
      controller: controller,
      obscureText: obscure,
      onFieldSubmitted: onSubmit,
      validator: validate,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            prefix,
            color: Colors.deepPurple,
          ),
          labelText: label,
          suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: suffixPressed,
          )),
    ),
  );
}

enum ToastState { success, error, warning }

Color chooseToastColor(ToastState state) {
  Color color ;
  switch (state) {
    case ToastState.error:
      color = Colors.red;
      break;

    case ToastState.success:
      color = Colors.green;
      break;

    case ToastState.warning:
      color = Colors.yellow;
      break;
  }
  return color ;
}

Future<bool?> showToast(
  String message,
  ToastState state,
) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor:chooseToastColor(state),
  );
}
