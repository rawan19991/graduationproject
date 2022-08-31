import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/invisible_icon.dart';

// ignore: non_constant_identifier_names
TextFormField TextFormFieldAll(String hintText,
    TextEditingController controller,  bool obscureText,Function function,
    { BuildContext ctx,bool suffixIcon,IconData prefixIcon, }) {
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    validator: function,
    decoration: InputDecoration(
      suffixIcon: suffixIcon == null
          ? null
          : Padding(
              padding: EdgeInsets.all(2),
              child: GestureDetector(
                child:Provider.of<InvisibleIcon>(ctx, listen: false).invisible==true? Icon( Icons.visibility_off,):Icon( Icons.visibility_rounded),
                onTapDown:
                    Provider.of<InvisibleIcon>(ctx, listen: false).inContact,
                onTapUp:
                    Provider.of<InvisibleIcon>(ctx, listen: false).outContact,
              ),
            ),
      prefixIcon: Icon(
        prefixIcon,
        color: Color.fromRGBO(106, 119, 145, 1).withOpacity(.5),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: 18.0,
          color: Color.fromRGBO(106, 119, 145, 1).withOpacity(.5)),
      filled: true,
      fillColor: Color.fromRGBO(232, 234, 243, 1),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: Color.fromRGBO(232, 234, 243, 1),
          )),
      contentPadding: new EdgeInsets.symmetric(
        vertical: 20.0,
      ),
    ),
  );
}
// ignore: missing_return
String validatorEmail(val) {
  if (!val.contains('@')) {
    return 'Not a valid email.';
  }

}

// ignore: missing_return
String validatorPassword(val) {
  if (val.length > 20) {
    return "Password can't to be larger than 20 letter";
  } else if (val.length < 5) {
    return "Password can't to be less than 5 letter";
  }
}

// ignore: missing_return
String validatorName(val) {
  if (val.length > 20) {
    return "Name can't to be larger than 15 letter";
  } else if (val.length < 5) {
    return "Name can't to be less than 4 letter";
  }
}
// ignore: missing_return
String validatorPrice(val) {
  if (val.length > 20) {
    return "Price can't to be larger than 15 letter";
  } else if (val.length < 1) {
    return "Price can't to be less than 1 letter";
  }
}
// ignore: missing_return
String validatorDescription(val) {
  if (val.length > 50) {
    return "Description can't to be larger than 50 letter";
  } else if (val.length < 5) {
    return "Description can't to be less than 1 letter";
  }
}

// ignore: missing_return
String validatorCategory(val) {
  if (val.length > 100) {
    return "Category can't to be larger than 100 letter";
  } else if (val.length < 3) {
    return "Category can't to be less than 3 letter";
  }
}
// ignore: missing_return
String validatorImage(val) {
  if (val.length > 300) {
    return "Image can't to be larger than 40 letter";
  } else if (val.length < 3) {
    return "Image can't to be less than 3 letter";
  }
}