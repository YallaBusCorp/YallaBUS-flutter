import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';

import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class DropDownWidget extends StatefulWidget {
  final String hint;
  final List<String> options;
  const DropDownWidget({Key? key, required this.hint, required this.options})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late String initalValue;
  @override
  void initState() {
    initalValue = widget.options[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ValuesManager.v5),
      child: DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: ValuesManager.v20),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ValuesManager.v8),
              borderSide: BorderSide(
                color: ColorsManager.orange,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ValuesManager.v8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(
              Icons.location_city,
              color: Colors.grey,
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.grey),
            filled: true,
            fillColor: Theme.of(context).backgroundColor,
          ),
          hint: TextWidget(
            text: widget.hint,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 18,
                  color: Colors.grey,
                ),
          ),
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 18,
              ),
          value: initalValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
            size: ValuesManager.v20,
          ),
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              initalValue = newValue.toString();
            });
          }),
    );
  }
}
