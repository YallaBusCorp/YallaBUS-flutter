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
    return Container(
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
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager.orange,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            hintText: 'Search ..',
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
            filled: true,
            fillColor: ColorsManager.black2,
          ),
        ),
      ),
    );
  }
}
