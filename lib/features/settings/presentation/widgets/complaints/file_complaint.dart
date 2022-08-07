import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/error_dialog.dart';
import '../../../../../core/custom_widgets/success_dialog.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../bloc/settings_bloc.dart';

class FileComplaint extends StatefulWidget {
  const FileComplaint({Key? key}) : super(key: key);

  @override
  State<FileComplaint> createState() => _FileComplaintState();
}

class _FileComplaintState extends State<FileComplaint> {
  late TextEditingController controller;
  late SettingsBloc bloc;
  @override
  void initState() {
    controller = TextEditingController();
    bloc = BlocProvider.of<SettingsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
                filled: true,
                fillColor: ColorsExtensions.setColorOfTextForm(context),
              ),
              onChanged: (value){
                bloc.add(RefershMessageEvent(value));
              },
            ),
            const Spacer(),
            TextWidget(
                text:
                    "We are very sorry that you've faced some issues please be assured we are working very hard to make your experience as smooth as possible",
                style: Theme.of(context).textTheme.caption!),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is PostComplaintSuccess) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const Dialog(
                      backgroundColor: Colors.transparent,
                      child: SuccessDialog(
                        message: 'You have sent your complaint!',
                      ),
                    ),
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                }
                if (state is PostComplaintError) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      backgroundColor: Colors.transparent,
                      child: ErrorDialog(
                        message: 'Try again in another time',
                        onTap: () {},
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Align(
                  alignment: Alignment.center,
                  child: ButtonWidget(
                    onPressed: bloc.value.isNotEmpty
                        ? () {
                            bloc.add(PostComplaintEvent(controller.text));
                          }
                        : null,
                    child: Text(
                      'Submit Complaint',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
