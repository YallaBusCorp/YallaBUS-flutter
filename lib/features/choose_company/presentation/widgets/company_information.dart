import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CompanyInfo extends StatelessWidget {
  final Company company;
  const CompanyInfo({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      radius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: ValuesManager.v50,
                  height: ValuesManager.v5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ValuesManager.v16)),
                ),
              ),
              const SizedBox(
                height: ValuesManager.v10,
              ),
              Center(
                child: Text(
                  company.companyName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(
                height: ValuesManager.v10,
              ),
              Container(
                height: ValuesManager.v150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ValuesManager.v16),
                  image: const DecorationImage(
                    image: AssetImage(
                      AssetManager.unibusImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: ValuesManager.v10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        launchUrl(company.facebookUrl, company.companyName);
                      },
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Facebook',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Call',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: ValuesManager.v10,
              ),
              Text(
                company.description,
                textDirection: TextDirection.ltr,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: ValuesManager.v80,
              ),
              // Text('Facebook account : ${company.facebookUrl}',
              //     style: Theme.of(context).textTheme.headline5),
              // const SizedBox(
              //   height: ValuesManager.v10,
              // ),
              // Text('Phone number : ${company.companyPhone}',
              //     style: Theme.of(context).textTheme.headline5),
            ]),
      ),
    );
  }
}

Future<void> launchUrl(String link, String name) async {
  String fbProtocolUrl = name == 'Sarkees'
      ? 'fb://page/218760131510200'
      : 'fb://page/1637744216443207';

  String fallbackUrl = link;

  try {
    bool launched =
        await launch(fbProtocolUrl, forceSafariVC: false, forceWebView: false);

    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}
