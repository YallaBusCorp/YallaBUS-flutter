import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';

import '../../../../core/resources/colors_manager.dart';

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
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? ColorsManager.black2
              : Colors.white,
          boxShadow:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                      ),
                    ]
                  : [
                      const BoxShadow(blurRadius: 0),
                    ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: widget.bloc.isSelected[widget.index]
                ? ColorsManager.blue2
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                      image: NetworkImage(AssetManager.companyPhoto),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.bloc.companies[widget.index].tr(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: ColorsManager.black2,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.bloc.companies[widget.index],
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Works hours : 9am to 5pm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Facebook account : www: https://facebook.com/${widget.bloc.companies[widget.index]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Phone number : +201019035005',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ]),
                            ),
                          ));
                },
                icon: Icon(
                  Icons.info_outline_rounded,
                  size: 25,
                  color: ColorsManager.blue2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
