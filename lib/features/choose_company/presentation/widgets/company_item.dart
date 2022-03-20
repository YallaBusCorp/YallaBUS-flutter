import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';

class CompanyItem extends StatefulWidget {
  final int index;
  final CompanySelectionBloc bloc;
  const CompanyItem({Key? key, required this.index,required this.bloc}) : super(key: key);

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
              color: ColorsManager.black2,
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
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info_outline_rounded,
                      size: 30,
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
