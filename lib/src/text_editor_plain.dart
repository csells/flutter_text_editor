import 'package:flutter/material.dart';

class TextEditor extends StatelessWidget {
  final bool autofocus;
  final TextEditingController _controller;
  const TextEditor({
    Key key,
    this.autofocus,
    @required TextEditingController controller,
  })  : _controller = controller,
        assert(controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: TextField(
          maxLines: null,
          autofocus: autofocus,
          controller: _controller,
          decoration: InputDecoration(border: InputBorder.none, hintText: 'input'),
        ),
      );
}
