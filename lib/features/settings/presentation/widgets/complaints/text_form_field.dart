// import 'package:easy_localization/easy_localization.dart' as localized;

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/custom_widgets/button_widget.dart';
// import '../../../../../core/custom_widgets/error_dialog.dart';
// import '../../../../../core/custom_widgets/success_dialog.dart';
// import '../../../../../core/custom_widgets/text_widget.dart';
// import '../../../../../core/extensions/extensions.dart';
// import '../../../../../core/resources/colors_manager.dart';
// import '../../../../../core/resources/values_manager.dart';
// import '../../bloc/settings_bloc.dart';

// class TxtField extends StatefulWidget {
//   const TxtField({Key? key}) : super(key: key);

//   @override
//   State<TxtField> createState() => _TxtFieldState();
// }

// class _TxtFieldState extends State<TxtField> {
//   late TextEditingController controller;
//   late SettingsBloc bloc;
//   @override
//   void initState() {
//     controller = TextEditingController();
//     bloc = BlocProvider.of<SettingsBloc>(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
      
//       const Spacer(),
//       TextWidget(
//           text:
//               "We are very sorry that you've faced some issues please be assured we are working very hard to make your experience as smooth as possible",
//           style: Theme.of(context).textTheme.caption!),
//       const SizedBox(
//         height: 10,
//       ),
//       BlocConsumer<SettingsBloc, SettingsState>(
//         listener: (context, state) {
//           if (state is PostComplaintSuccess) {
//             FocusScope.of(context).requestFocus(FocusNode());
//             showDialog(
//               context: context,
//               builder: (BuildContext context) => const Dialog(
//                 backgroundColor: Colors.transparent,
//                 child: SuccessDialog(
//                   message: 'You have sent your complaint!',
//                 ),
//               ),
//             );
//             Future.delayed(const Duration(seconds: 2), () {
//               Navigator.of(context).pop();
//               Navigator.of(context).pop();
//             });
//           }
//           if (state is PostComplaintError) {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) => Dialog(
//                 backgroundColor: Colors.transparent,
//                 child: ErrorDialog(
//                   message: 'Try again in another time',
//                   onTap: () {},
//                 ),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Align(
//             alignment: Alignment.center,
//             child: ButtonWidget(
//               onPressed: bloc.value.isNotEmpty
//                   ? () {
//                       bloc.add(PostComplaintEvent(controller.text));
//                     }
//                   : null,
//               child: Text(
//                 'Submit Complaint',
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//             ),
//           );
//         },
//       ),
//     ]);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
