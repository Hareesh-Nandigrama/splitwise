import 'package:flutter/material.dart';
import 'package:splitwise/constants/colors.dart';

class InField extends StatefulWidget {
  final String text;
  final bool hide;
  final TextEditingController control;
  final int type;
  final int typo;
  const InField(this.text, this.hide, this.control, this.type, this.typo, {super.key});
  @override
  _InFieldState createState() => _InFieldState(text,hide,control,type,typo);
}
class _InFieldState extends State<InField> {
  late final text;
  late final hide;
  late final control;
  late final type;
  late final typo;
  _InFieldState(this.text,this.hide,this.control,this.type, this.typo);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: typo == 0? 350 : 392,
      height: typo == 0? 60 : 70,
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        keyboardType: (type == 1)? TextInputType.emailAddress : (type == 10)? TextInputType.number :TextInputType.text,
        controller: control,
        obscureText: hide,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kgreen
            )
          ),
          labelText: text,
        ),
      ),
    );
  }
}




