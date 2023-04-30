import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../stores/common_store.dart';

class FilterBar extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final int? index;

  const FilterBar(
  {super.key,
  required this.items,
  required this.hintText,
  this.index,
  });

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            menuMaxHeight: 400,
            value: widget.index == 0 ? commonStore.type : commonStore.type2,
            isExpanded: true,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: Colors.black),
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.hintText,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              labelStyle: TextStyle(color: Colors.black),
              contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            dropdownColor: Colors.white,
            isDense: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 28,
            ),
            elevation: 16,
            //style: headline6,
            onChanged: (String? value) {
              if(widget.index == 1)
                {
                  commonStore.type2 = value!;
                }
              else if(widget.index == 0)
                {
                  commonStore.type = value!;
                }
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      }
    );
  }
}