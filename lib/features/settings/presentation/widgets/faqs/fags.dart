import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/faqs/faq_body.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/faqs/faq_body_model.dart';

import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/injection/di.dart';

class FAQs extends StatelessWidget {
  FAQs({Key? key}) : super(key: key);
  SettingsBloc bloc = di<SettingsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQs',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            dividerColor: Colors.grey.shade800,
            children: [
              faqBody(
                context,
                bloc,
                FAQModel(
                    'Is there a deadline for booking a ride ?',
                    'You can book a ride until 3 hours before each ride bro. Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up ',
                    0),
              ),
              faqBody(
                context,
                bloc,
                FAQModel(
                    'Is there a deadline for booking a ride ?',
                    'You can book a ride until 3 hours before each ride bro. Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up ',
                    1),
              ),
              faqBody(
                context,
                bloc,
                FAQModel(
                    'Is there a deadline for booking a ride ?',
                    'You can book a ride until 3 hours before each ride bro. Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up ',
                    2),
              ),
              faqBody(
                context,
                bloc,
                FAQModel(
                    'Is there a deadline for booking a ride ?',
                    'You can book a ride until 3 hours before each ride bro. Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up ',
                    3),
              ),
            ],
            expansionCallback: (i, open) {
              bloc.add(SelectFaqQuestionEvent(i, open));
            },
          ),
        ),
      ),
    );
  }
}
