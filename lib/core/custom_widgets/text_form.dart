import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';

import '../resources/colors_manager.dart';

class TextFormWidget extends StatefulWidget {
  final String text;
  final double width;
  final IconData icon;
  const TextFormWidget(
      {Key? key, required this.text, required this.width, required this.icon})
      : super(key: key);

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: MediaQuery.of(context).size.height / 15,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: ValuesManager.v5),
          child: TextFormField(
            cursorColor: Colors.grey,
            controller: _controller,
            style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: ValuesManager.v20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ValuesManager.v16),
                borderSide: BorderSide(
                  color: ColorsManager.orange,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ValuesManager.v16),
                borderSide: BorderSide.none,
              ),
              hintText: widget.text,
              prefixIcon: Icon(
                widget.icon,
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
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
