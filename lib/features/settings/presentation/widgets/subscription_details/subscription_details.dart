import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/asset_manager.dart';

class SubscriptionDetails extends StatelessWidget {
  const SubscriptionDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Details',
            style: Theme.of(context).textTheme.headline5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            DecorationBoxWidget(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DecorationBoxWidget(
                          color: ColorsExtensions.setColorOfContainersOverMap(
                              context),
                          radius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              AssetManager.subsctiptionIcon,
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Unibus',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 18),
                            ),
                            Text(
                              '18 May, 2018',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '120 EGP',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '15 days left',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Payment history',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            DecorationBoxWidget(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecorationBoxWidget(
                      color:
                          ColorsExtensions.setColorOfContainersOverMap(context),
                      radius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AssetManager.cash,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Unibus',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          '18 April, 2018',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '120 EGP',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DecorationBoxWidget(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecorationBoxWidget(
                      color:
                          ColorsExtensions.setColorOfContainersOverMap(context),
                      radius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AssetManager.visa,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Unibus',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          '18 March, 2018',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '120 EGP',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
