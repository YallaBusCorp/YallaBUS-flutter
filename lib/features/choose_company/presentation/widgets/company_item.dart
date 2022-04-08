import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/company_information.dart';

import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CompanyItem extends StatefulWidget {
  final int index;
  final CompanySelectionBloc bloc;
  const CompanyItem({Key? key, required this.index, required this.bloc})
      : super(key: key);

  @override
  State<CompanyItem> createState() => _CompanyItemState();
}

class _CompanyItemState extends State<CompanyItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.bloc.add(SelectCompanyEvent(widget.index));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ValuesManager.v8, vertical: ValuesManager.v2),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsExtensions.setColorOfCompanyItem(
                widget.bloc, context, widget.index),
            boxShadow: selectShadow(context),
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
                      widget.bloc.searchedElements.isNotEmpty
                          ? widget.bloc.searchedElements[widget.index].tr()
                          : widget.bloc.companies[widget.index].tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: ValuesManager.v16),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetManager.mapPinPointCompany,
                          color: ColorsManager.orange,
                          width: ValuesManager.v16,
                          height: ValuesManager.v16,
                        ),
                        const SizedBox(
                          width: ValuesManager.v5,
                        ),
                        TextWidget(
                            text: StringManager.companyNo6.tr(),
                            style: Theme.of(context).textTheme.caption!),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    CompanyInfo(widget.bloc, context, widget.index);
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
