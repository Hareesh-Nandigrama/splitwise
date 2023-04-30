import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final Function? onChanged;
  final int? index;
  final String? value;

  const CustomDropDown(
  {super.key,
  required this.items,
  required this.hintText,
  required this.onChanged,
  this.index,
  this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        menuMaxHeight: 400,
        value: value,
        isExpanded: true,
        style: TextStyle(color: Colors.black,),
        hint: Text(hintText),
        // decoration: InputDecoration(
        //   floatingLabelStyle: TextStyle(color: Colors.black),
        //   label: RichText(
        //     text: TextSpan(
        //       children: [
        //         TextSpan(
        //           text: hintText,
        //           //style: bodyText1,
        //         ),
        //         TextSpan(
        //           text: ' * ',
        //           //style: headline5,
        //         ),
        //       ],
        //     ),
        //   ),
        //   labelStyle: TextStyle(color: Colors.black),
        //   contentPadding:
        //   const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        //   focusedBorder:  OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.black, width: 1),
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(4),
        //     ),
        //   ),
        //   enabledBorder:  OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.black, width: 1),
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(4),
        //     ),
        //   ),
        //   errorBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.black, width: 1),
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(4),
        //     ),
        //   ),
        //   focusedErrorBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.black, width: 1),
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(4),
        //     ),
        //   ),
        // ),
        dropdownColor: Colors.white,
        isDense: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 28,
        ),
        elevation: 16,
        //style: headline6,
        onChanged: (String? value) {
          if (index != null) {
            onChanged!(value, index);
          } else {
            onChanged!(value);
          }
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}