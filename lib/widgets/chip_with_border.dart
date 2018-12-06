import 'package:flutter/material.dart';

class ChipWithBorder extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final Widget inner;
  final ValueChanged<String> ontap;
  final Icon icon;
  final String iconPosition;
  final double fontSize;
  final bool boxShadow;
  final double verticalPadding;

  ChipWithBorder({@required this.text, this.fillColor = Colors.white, this.borderColor, this.textColor = Colors.black, this.inner, this.ontap, this.icon, this.iconPosition, this.fontSize, this.boxShadow = false, this.verticalPadding = 3});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ontap != null) {
          ontap(text);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: verticalPadding),
        decoration: new BoxDecoration(
          color: fillColor,
          border: new Border.all(color: borderColor == null ? fillColor : borderColor),
          borderRadius:
          BorderRadius.all(Radius.circular(20)),
          boxShadow: [boxShadow ? new BoxShadow(
            color: fillColor,
            blurRadius: 3.0,
          ) : new BoxShadow()]
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon != null && iconPosition != 'right' ? Padding(padding: EdgeInsets.only(right: 5), child: icon) : Container(),
            Text(text, style: TextStyle(color: textColor, fontSize: fontSize),),
            icon != null && iconPosition == 'right' ? Padding(padding: EdgeInsets.only(left: 5)) : Container(),
          ],
        ),
      ),
    );
  }
}