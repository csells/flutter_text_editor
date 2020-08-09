library text_editor;

export 'package:text_editor/src/text_editor_plain.dart'
    if (dart.library.html) 'package:text_editor/src/text_editor_web.dart';
