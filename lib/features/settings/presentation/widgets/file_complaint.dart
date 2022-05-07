import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/drop_down_widget.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';

class FileComplaint extends StatefulWidget {
  const FileComplaint({Key? key}) : super(key: key);

  @override
  State<FileComplaint> createState() => _FileComplaintState();
}

class _FileComplaintState extends State<FileComplaint> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('File a complaint',
            style: Theme.of(context).textTheme.headline5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
                text: 'Please choose a category',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            const DropDownComplaintWidget(),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
                text: 'Please tell us what happened in detail.',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              style: Theme.of(context).textTheme.headline6,
              cursorColor: ColorsManager.orange,
              controller: _controller,
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
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
                filled: true,
                fillColor: ColorsExtensions.setColorOfTextForm(context),
              ),
            ),
            const Spacer(),
            TextWidget(
                text:
                    "We are very sorry that you've faced some issues please be assured we are working very hard to make your experience as smooth as possible",
                style: Theme.of(context).textTheme.caption!),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: ButtonWidget(
                onPressed: () {},
                child: Text(
                  'Submit Complaint',
                  style: Theme.of(context).textTheme.headline6!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
