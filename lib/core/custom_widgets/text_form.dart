import 'package:flutter/material.dart';

import '../resources/colors_manager.dart';

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({Key? key}) : super(key: key);

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 15,
      child: Center(
        child: TextFormField(
          cursorColor: Colors.grey,
          controller: _controller,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 20),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ColorsManager.orange,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search ..',
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.grey),
            filled: true,
            fillColor: Theme.of(context).backgroundColor,
          ),
        ),
      ),
    );
  }
}
