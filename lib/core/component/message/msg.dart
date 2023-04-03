  import 'package:flutter/material.dart';

msg(context,msg,{color,close}){
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color ?? const Color(0xFF006DFF),
        content: Text(msg),
        duration:close == null ? Duration(seconds: 2) : Duration(seconds: 10),
        action: SnackBarAction(
          label: "Kapat",
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
}