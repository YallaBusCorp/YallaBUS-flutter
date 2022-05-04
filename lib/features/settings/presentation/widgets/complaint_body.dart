import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';

class ComplaintBody extends StatelessWidget {
  const ComplaintBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);
    return InkWell(
      onTap: () {},
      child: DecorationBoxWidget(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: bloc.replyOrNot,
                    radius: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('3053252362626',
                      style: Theme.of(context).textTheme.headline6!),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '24 March',
                  style: Theme.of(context).textTheme.caption!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
