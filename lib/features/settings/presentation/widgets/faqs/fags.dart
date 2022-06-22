import 'package:flutter/material.dart';
import 'package:yalla_bus/features/settings/presentation/bloc/settings_bloc.dart';
import '../../../../../core/injection/di.dart';

class FAQs extends StatefulWidget {
  FAQs({Key? key}) : super(key: key);

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  SettingsBloc bloc = di<SettingsBloc>();
  List<bool> _open = [false, false, false, false];
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
              ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Theme.of(context).backgroundColor,
                headerBuilder: ((context, isExpanded) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Is there a deadline for booking a ride ?',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 18),
                      ),
                    )),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'You can book a ride until 3 hours before each ride bro. Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                ),
                isExpanded: _open[0],
              ),
              ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Theme.of(context).backgroundColor,
                headerBuilder: ((context, isExpanded) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Is there a deadline for booking a ride ?',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 18),
                      ),
                    )),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'You can book a ride until 3 hours before each ride bro. Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                ),
                isExpanded: _open[1],
              ),
              ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Theme.of(context).backgroundColor,
                headerBuilder: ((context, isExpanded) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Is there a deadline for booking a ride ?',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 18),
                      ),
                    )),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'You can book a ride until 3 hours before each ride bro. Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up Harry up ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                ),
                isExpanded: _open[2],
              ),
            ],
            expansionCallback: (i, open) {
              setState(() {
                _open[i] = !open;
              });
            },
          ),
        ),
      ),
    );
  }
}
