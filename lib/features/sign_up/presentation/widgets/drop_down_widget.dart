import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/completeprofile_bloc.dart';

class DropDownWidget extends StatefulWidget {
  final bool type;
  final String hint;
  final List<String> options;
  final List<int> ids;
  const DropDownWidget({
    Key? key,
    required this.hint,
    required this.options,
    required this.ids,
    required this.type,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late String initalValue;
  @override
  void initState() {
    initalValue = widget.hint;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ValuesManager.v10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v16),
        ),
        child: DropdownButtonFormField<String>(
            isExpanded: true,
            hint: TextWidget(
              text: widget.hint.tr(),
              style: Theme.of(context).textTheme.headline6!,
            ),
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
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                initalValue = newValue.toString();
                if (widget.type == true) {
                  BlocProvider.of<CompleteprofileBloc>(context)
                      .add(SendTownValueEvent(
                    widget.ids.elementAt(widget.options.indexOf(initalValue)),
                    initalValue,
                  ));
                } else {
                  BlocProvider.of<CompleteprofileBloc>(context).add(
                      SendUniValueEvent(
                          widget.ids
                              .elementAt(widget.options.indexOf(initalValue)),
                          initalValue));
                }
              });
            }),
      ),
    );
  }
}
