import 'package:flutter/material.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';

import '../../../../core/resources/values_manager.dart';

void CompanyInfo(Company company, BuildContext context, int index) {
  showModalBottomSheet(
      context: context,
      builder: (_) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ValuesManager.v16),
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
                            borderRadius:
                                BorderRadius.circular(ValuesManager.v16)),
                      ),
                    ),
                    const SizedBox(
                      height: ValuesManager.v10,
                    ),
                    Text(
                      company.companyName,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: ValuesManager.v10,
                    ),
                    Text(
                      company.description,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: ValuesManager.v10,
                    ),
                    Text('Facebook account : ${company.facebookUrl}',
                        style: Theme.of(context).textTheme.headline5),
                    const SizedBox(
                      height: ValuesManager.v10,
                    ),
                    Text('Phone number : ${company.companyPhone}',
                        style: Theme.of(context).textTheme.headline5),
                  ]),
            ),
          ));
}
