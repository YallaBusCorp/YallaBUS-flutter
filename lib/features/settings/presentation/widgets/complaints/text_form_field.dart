import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../bloc/settings_bloc.dart';

class TxtField extends StatelessWidget {
  final TextEditingController controller;
  const TxtField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      style: Theme.of(context).textTheme.headline6,
      cursorColor: ColorsManager.orange,
      controller: controller,
      decoration: InputDecoration(
        focusColor: ColorsManager.orange,
        contentPadding: const EdgeInsets.all(ValuesManager.v20),
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
        hintText: 'Type Something',
        hintStyle:
            Theme.of(context).textTheme.headline6!.copyWith(color: Colors.grey),
        filled: true,
        fillColor: ColorsExtensions.setColorOfTextForm(context),
        
      ),
      onChanged: (String value){
        BlocProvider.of<SettingsBloc>(context).add(RefershMessageEvent(value));
      },
    );
  }
}
