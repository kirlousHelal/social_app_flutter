import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<Object?> navigateTo({
  required BuildContext context,
  required Widget widget,
  bool removeAllPrevious =
      false, // Controls whether to remove all previous routes
}) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => removeAllPrevious
        ? false
        : route.isFirst, // Condition to keep the first route or remove all
  );
}

Widget defaultTextForm(
        {required TextEditingController controller,
        required FormFieldValidator<String> validator,
        required String label,
        required IconData prefixIcon,
        required Color focusColor,
        FocusNode? focusNode,
        IconData? suffixIcon,
        VoidCallback? suffixPressed,
        bool isPassword = false,
        GestureTapCallback? onTap,
        ValueChanged<String>? onSubmit,
        TextInputType keyboardType = TextInputType.text,
        Color unFocusColor = Colors.black45,
        ValueChanged<String>? onChange}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      focusNode: focusNode,
      controller: controller,
      obscureText: isPassword,
      // style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
          // suffixIconColor: focusNode!.hasFocus ? focusColor : unFocusColor,
          // prefixIconColor: focusNode!.hasFocus ? focusColor : unFocusColor,
          suffixIcon:
              IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)),
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   // borderSide: BorderSide(color: unFocusColor),
          // ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: focusColor)),
          label: Text(label)),
      validator: validator,
      onChanged: onChange,
    );

Widget defaultTextButton({
  required VoidCallback onPress,
  required String text,
  bool isUppercase = false,
  Color foregroundColor = Colors.grey,
  double fontSize = 18,
}) =>
    TextButton(
      onPressed: onPress,
      style:
          ButtonStyle(foregroundColor: WidgetStatePropertyAll(foregroundColor)),
      child: Text(
        isUppercase ? text.toUpperCase() : text,
        style: TextStyle(fontSize: fontSize),
      ),
    );

dynamic showToast(
        {required String message, required ToastColors backgroundColor}) =>
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: chooseColor(backgroundColor: backgroundColor),
      fontSize: 16.0,
      textColor: Colors.white,
      timeInSecForIosWeb: 6,
      toastLength: Toast.LENGTH_LONG,
    );

enum ToastColors { success, warning, error }

Color chooseColor({required ToastColors backgroundColor}) {
  switch (backgroundColor) {
    case ToastColors.success:
      return Colors.green;
    case ToastColors.error:
      return Colors.red;
    case ToastColors.warning:
      return Colors.amber;
  }
}
