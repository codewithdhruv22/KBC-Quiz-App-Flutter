import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



  Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 66, 33, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(Offset(size.width*0.50,size.height*0.28),Offset(size.width*0.50,size.height*0.72),[Color(0xff006bc1),Color(0xff007fff),Color(0xff0092de)],[0.00,0.49,1.00]);

    Path path0 = Path();
    path0.moveTo(size.width*0.1675000,size.height*0.2842857);
    path0.lineTo(size.width*0.8325000,size.height*0.2842857);
    path0.lineTo(size.width*0.9600000,size.height*0.5000000);
    path0.lineTo(size.width*0.8341667,size.height*0.7128571);
    path0.lineTo(size.width*0.1675000,size.height*0.7185714);
    path0.lineTo(size.width*0.0400000,size.height*0.5014286);

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
