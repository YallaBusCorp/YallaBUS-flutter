import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../domain/enitity/company.dart';
import '../bloc/company_selection_bloc.dart';
import 'company_information.dart';

class CompanyItem extends StatefulWidget {
  final int index;
  final Company company;
  const CompanyItem({Key? key, required this.index, required this.company})
      : super(key: key);

  @override
  State<CompanyItem> createState() => _CompanyItemState();
}

class _CompanyItemState extends State<CompanyItem> {
  @override
  Widget build(BuildContext context) {
    CompanySelectionBloc bloc = BlocProvider.of<CompanySelectionBloc>(context);
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        bloc.add(SelectCompanyUIEvent(widget.index));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ValuesManager.v8, vertical: ValuesManager.v2),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsExtensions.setColorOfCompanyItem(
                bloc, context, widget.index),
    
            borderRadius: BorderRadius.circular(ValuesManager.v16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(ValuesManager.v8),
            child: Row(
              children: [
                Container(
                  width: ValuesManager.v40,
                  height: ValuesManager.v40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ValuesManager.v16),
                    image: const DecorationImage(
                        image: NetworkImage(AssetManager.companyPhoto),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: ValuesManager.v10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.company.companyName,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: ValuesManager.v16),
                    ),
                    Row(
                      children: [
                        Icon(Icons.pin_drop_outlined,
                            size: ValuesManager.v16,
                            color: ColorsManager.green),
                        const SizedBox(
                          width: ValuesManager.v5,
                        ),
                        TextWidget(
                            text: widget.company.companyLocation,
                            style: Theme.of(context).textTheme.caption!),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => CompanyInfo(
                        company: widget.company,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.info_outline_rounded,
                    size: ValuesManager.v25,
                    color: ColorsManager.orange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
