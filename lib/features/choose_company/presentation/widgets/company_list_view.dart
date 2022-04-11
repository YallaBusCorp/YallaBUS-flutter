import 'package:flutter/material.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/company_item.dart';

import '../../../../core/resources/values_manager.dart';
import '../../domain/enitity/company.dart';

class CompaniesListView extends StatelessWidget {
  final List<Company> companies;
  const CompaniesListView({Key? key, required this.companies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: companies.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: ValuesManager.v10,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return CompanyItem(
              index: index,
              company: companies[index],
            );
          },
        ),
      ),
    );
  }
}
