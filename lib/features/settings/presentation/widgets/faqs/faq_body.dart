import 'package:flutter/material.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/faqs/faq_body_model.dart';


ExpansionPanel faqBody(
    BuildContext context, SettingsBloc bloc, FAQModel model) {
  return ExpansionPanel(
    canTapOnHeader: true,
    backgroundColor: Theme.of(context).backgroundColor,
    headerBuilder: ((context, isExpanded) => Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
            model.header,
            style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18),
          ),
    )),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        model.body,
        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
      ),
    ),
    isExpanded: bloc.isOpen[model.index],
  );
}
