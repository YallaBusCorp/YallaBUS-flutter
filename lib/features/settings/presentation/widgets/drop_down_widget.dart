import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../bloc/settings_bloc.dart';

import '../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class DropDownComplaintWidget extends StatefulWidget {
  const DropDownComplaintWidget({Key? key}) : super(key: key);

  @override
  State<DropDownComplaintWidget> createState() =>
      _DropDownComplaintWidgetState();
}

class _DropDownComplaintWidgetState extends State<DropDownComplaintWidget> {
  late SettingsBloc bloc;
  late String initalValue;
  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    initalValue = bloc.dropDownOptions[0];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: initalValue,
          hint: TextWidget(
            text: 'Choose what went wrong',
            style: Theme.of(context).textTheme.headline6!,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: ValuesManager.v20),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ValuesManager.v16),
              borderSide: BorderSide(
                color: ColorsManager.orange,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ValuesManager.v16),
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
            fillColor: ColorsExtensions.setColorOfTextForm(context),
          ),
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 18,
              ),
          icon: const Padding(
            padding: EdgeInsets.only(right: ValuesManager.v10),
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: ValuesManager.v20,
            ),
          ),
          items: bloc.dropDownOptions
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              initalValue = newValue!;
            });
          }),
    );
  }
}
