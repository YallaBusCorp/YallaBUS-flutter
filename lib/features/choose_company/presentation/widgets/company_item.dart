import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: widget.bloc.isSelected[widget.index]
              ? Theme.of(context).backgroundColor == Colors.black
                  ? ColorsManager.black2
                  : Colors.grey
              : Theme.of(context).backgroundColor == Colors.black
                  ? ColorsManager.black2
                  : Colors.white,
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
              Text(
                widget.bloc.companies[widget.index].tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 18),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(ValuesManager.v16),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(ValuesManager.v16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: ValuesManager.v50,
                                        height: ValuesManager.v5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                ValuesManager.v16)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: ValuesManager.v10,
                                    ),
                                    Text(
                                      widget.bloc.companies[widget.index],
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    const SizedBox(
                                      height: ValuesManager.v10,
                                    ),
                                    Text('Works hours : 9am to 5pm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const SizedBox(
                                      height: ValuesManager.v10,
                                    ),
                                    Text(
                                        'Facebook account : www: https://facebook.com/${widget.bloc.companies[widget.index]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const SizedBox(
                                      height: ValuesManager.v10,
                                    ),
                                    Text('Phone number : +201019035005',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                  ]),
                            ),
                          ));
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
    );
  }
}
