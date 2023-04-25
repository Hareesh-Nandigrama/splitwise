import 'package:flutter/material.dart';

import '../../constants/colors.dart';


class AutocompleteTextField extends StatefulWidget {
  final String? name;
  final List<String> users;

  const AutocompleteTextField({super.key, this.name, required this.users,});

  @override
  State<AutocompleteTextField> createState() => _AutocompleteTextField();
}

class _AutocompleteTextField extends State<AutocompleteTextField> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue val) {
        if (val.text == '') {
          return const Iterable<String>.empty();
        }
        return widget.users.where((element) =>
            element
                .toLowerCase()
                .contains(val.text.toLowerCase()));
      },
      initialValue:
      TextEditingValue(text: widget.name ?? ""),
      optionsMaxHeight: 50,
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: ListView.builder(
              // padding: EdgeInsets.all(10.0),
              padding:
              const EdgeInsets.symmetric(vertical: 0),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final String option =
                options.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                  },
                  child: ListTile(
                    tileColor: Colors.red,
                    title: Text(option,
                        style:
                       TextStyle(color: Colors.yellow)),
                  ),
                );
              },
            ),
          ),
        );
      },
      fieldViewBuilder: (context, c, f, __) {
        return CustomTextField(
          hintText: 'Event Name',
          validator: (s) {
            if (widget.users.contains(s)) {
              return null;
            }
            return "Enter a valid user";
          },
          controller: c,
          focusNode: f, isNecessary: true,
        );
      },
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final String? value;
  final void Function(String)? onChanged;
  final bool isNecessary;
  final TextEditingController? controller;
  final void Function()? onTap;
  final FocusNode? focusNode;

  const CustomTextField(
  {super.key,
  required this.hintText,
  required this.validator,
  this.value,
  this.onChanged,
  required this.isNecessary,
  this.inputType,
  this.controller,
  this.onTap,
  this.focusNode});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.onTap != null,
      //style: Themes.theme.textTheme.headline6?.copyWith(color: Colors.white),
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      initialValue: widget.value == 'null' ? '' : widget.value,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
        //errorStyle: basicFontStyle,
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.hintText,
                style: TextStyle(color: kgrey)
              ),
              if (widget.isNecessary)
                TextSpan(
                  text: ' * ',
                    style: TextStyle(color: kgrey)
                ),
            ],
          ),
        ),
        labelStyle: TextStyle(color: Colors.brown),
        hintStyle: TextStyle(color: Colors.brown),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kgrey, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kgrey, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
    );
  }
}
