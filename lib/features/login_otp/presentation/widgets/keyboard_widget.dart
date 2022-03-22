import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/constants_manager.dart';

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.8,
      decoration: BoxDecoration(
        color: ColorsManager.black2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(1));
                  },
                  child: Text(
                    ValuesManager.v1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(2));
                  },
                  child: Text(
                    ValuesManager.v2,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(3));
                  },
                  child: Text(
                    ValuesManager.v3,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(4));
                  },
                  child: Text(
                    ValuesManager.v4,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(5));
                  },
                  child: Text(
                    ValuesManager.v5,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(6));
                  },
                  child: Text(
                    ValuesManager.v6,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(7));
                  },
                  child: Text(
                    ValuesManager.v7,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(8));
                  },
                  child: Text(
                    ValuesManager.v8,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(9));
                  },
                  child: Text(
                    ValuesManager.v9,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '*',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(const WritePhoneNumber(0));
                  },
                  child: Text(
                    ValuesManager.v0,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    bloc.add(RemovePhoneNumber());
                  },
                  child:
                      const Icon(Icons.backspace_outlined, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
