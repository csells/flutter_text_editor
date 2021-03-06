// MIT License
//
// Copyright (c) 2020 Simon Lightfoot
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
import 'package:flutter/gestures.dart' show PointerSignalEvent, PointerScrollEvent;
import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'html_element_widget.dart';

class TextAreaWidget extends HtmlElementWidget {
  final String initialValue;
  final String wrap;
  final String style;
  final bool autofocus;
  final String placeholder;
  final int rows;
  final ValueChanged<String> onChanged;

  const TextAreaWidget({
    Key key,
    this.initialValue = '',
    this.wrap = 'soft',
    this.style = 'border: 0; outline: none; resize: none;',
    this.autofocus,
    this.placeholder,
    this.rows,
    this.onChanged,
  }) : super(key: key);

  @override
  HtmlElementWidgetState<HtmlElementWidget> createState() {
    return TextAreaWidgetState();
  }
}

class TextAreaWidgetState extends HtmlElementWidgetState<TextAreaWidget> {
  html.TextAreaElement _element;
  StreamSubscription<html.Event> _onInputSub;

  @override
  html.HtmlElement createHtmlElement(BuildContext context) => _element;

  String get text => _element.value;
  set text(String text) => _element.value = text;

  @override
  void initState() {
    super.initState();
    _element = html.TextAreaElement()
      ..wrap = widget.wrap
      ..value = widget.initialValue
      ..autofocus = widget.autofocus
      ..placeholder = widget.placeholder
      ..rows = widget.rows
      ..style.cssText = widget.style;

    _onInputSub = _element.onInput.listen(_onInput);
  }

  @override
  void didUpdateWidget(TextAreaWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _element
      ..wrap = widget.wrap
      ..style.cssText = widget.style;
  }

  void _onInput(html.Event event) => widget.onChanged?.call(_element.value);

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final delta = event.scrollDelta;
      _element.scrollBy(delta.dx, delta.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: super.build(context),
    );
  }

  @override
  void dispose() {
    _onInputSub.cancel();
    _element = null;
    super.dispose();
  }
}
