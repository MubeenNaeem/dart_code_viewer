import 'package:flutter/material.dart';

import 'dart_code_viewer_theme.dart';
import 'pre_highlighter.dart';

/// A code viewer for the dart language.
///
/// A code viewer can be used to display dart code. By default the [DartCodeViewer]
/// gives you a Theme based code view. If you are using a [ThemeMode] that is light
/// than you will get the light option. Note that the default background of the code
/// viewer is based off [ColorScheme.background].
///
/// Supplying a non-null [data] String is required as input.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// Requires one of its ancestors to be a [MediaQuery] widget. Typically, these
/// are introduced by the [MaterialApp] or [WidgetsApp] widget at the top of
/// your application widget tree.
///
/// {@tool dartpad --template=stateless_widget_scaffold}
///
/// ![A dart_code_viewer example for light mode.]
/// (https://github.com/JoseAlba/dart_code_viewer/images/import_example)
///
/// Here is an example of a small string that shows up as Dart code in a flutter
/// application.
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return DartCodeViewer(r'class DartCodeViewer extends StatelessWidget {}');
/// }
/// ```
/// {@end-tool}
///
/// See also:
///  * [DartCodeViewerTheme] and [DartCodeViewerThemeData] for information about
///  controlling the visual appearance of the DartCodeViewer.
///  * [Code viewer online tool](https://romannurik.github.io/SlidesCodeHighlighter/)
///  is a useful tool that lets you choose the color for each different style.
///  On the left side you put your example code and on the right you can choose
///  the colors you want the code viewer to display.
///    background => backgroundColor
///    plain text => baseStyle
///    Punctuation => punctuationStyle
///    String, values => stringStyle
///    Keywords, tags => keywordStyle
///    Comments => commentStyle
///    Types => classStyle
///    Numbers => numberStyle
///    Declarations => constantStyle
///  * [MediaQuery], from which the default height and width factor is obtained.
class DartCodeViewer extends StatelessWidget {
  /// DartCodeViewer requires a [String] that will be the code shown within the
  /// code viewer. This should be dart code and it is preferable if you use a raw
  /// string by adding an r before the string.
  const DartCodeViewer(
    this.data, {
    Key? key,
    this.baseStyle,
    this.classStyle,
    this.commentStyle,
    this.constantStyle,
    this.keywordStyle,
    this.numberStyle,
    this.punctuationStyle,
    this.stringStyle,
    this.backgroundColor,
    this.copyButtonText,
    this.showCopyButton,
    this.height,
    this.width,
  }) : super(key: key);

  /// The string that is transformed into code. This is a required variable.
  final String data;

  /// The text style for the plain text in code.
  final TextStyle? baseStyle;

  /// The text style for the code types in the code.
  ///
  /// For example:
  /// * The class name.
  /// * StatelessWidget and StatefulWidget.
  final TextStyle? classStyle;

  /// The text style for the commented out code.
  final TextStyle? commentStyle;

  /// The text style for the constant style code.
  final TextStyle? constantStyle;

  /// The text style for keywords. For example:
  /// * else
  /// * enum
  /// * export
  /// * external
  /// * factory
  /// * false
  final TextStyle? keywordStyle;

  /// The text style for numbers within the code.
  final TextStyle? numberStyle;

  /// The text style for punctuation code like periods and commas.
  final TextStyle? punctuationStyle;

  /// The text style for Strings. For example the data when using the [Text] widget.
  final TextStyle? stringStyle;

  /// The background Color of the code. By default it is [Theme.of(context).colorScheme.background].
  final Color? backgroundColor;

  /// The text shown in the copy button by default it is 'COPY ALL'.
  final Text? copyButtonText;

  /// Shows copy button that lets user copy all the code as a raw string. By
  /// default the button is showing.
  final bool? showCopyButton;

  /// The height of the [DartCodeViewer] by default it uses the [MediaQuery.of(context).size.height]
  final double? height;

  /// The width of the [DartCodeViewer] by default it uses the [MediaQuery.of(context).size.width]
  final double? width;

  @override
  Widget build(BuildContext context) {
    final codeTextStyle = Theme.of(context).textTheme.bodyText1;

    final lightModeOn = Theme.of(context).brightness == Brightness.light;

    // These are defaults for the different types of text styles. The default
    // returns two different types of styles depending on the brightness of the
    // application.
    final _defaultBaseStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.blueGrey.shade800 : Colors.blueGrey.shade50,
    );
    final _defaultClassStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.purple.shade500 : Colors.purple.shade200,
    );
    final _defaultCommentStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.pink.shade600 : Colors.pink.shade300,
    );
    final _defaultConstantStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.indigo.shade500 : Colors.yellow.shade700,
    );
    final _defaultKeywordStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.indigo.shade500 : Colors.cyan.shade300,
    );
    final _defaultNumberStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.red.shade700 : Colors.yellow.shade700,
    );
    final _defaultPunctuationalStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.blueGrey.shade800 : Colors.blueGrey.shade50,
    );
    final _defaultStringStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.green.shade700 : Colors.lightGreen.shade400,
    );

    const _defaultCopyButtonText = Text('COPY ALL');
    const _defaultShowCopyButton = true;

    var dartCodeViewerThemeData = DartCodeViewerTheme.of(context);
    dartCodeViewerThemeData = dartCodeViewerThemeData.copyWith(
      baseStyle:
          baseStyle ?? dartCodeViewerThemeData.baseStyle ?? _defaultBaseStyle,
      classStyle: classStyle ??
          dartCodeViewerThemeData.classStyle ??
          _defaultClassStyle,
      commentStyle: commentStyle ??
          dartCodeViewerThemeData.commentStyle ??
          _defaultCommentStyle,
      constantStyle: constantStyle ??
          dartCodeViewerThemeData.constantStyle ??
          _defaultConstantStyle,
      keywordStyle: keywordStyle ??
          dartCodeViewerThemeData.keywordStyle ??
          _defaultKeywordStyle,
      numberStyle: numberStyle ??
          dartCodeViewerThemeData.numberStyle ??
          _defaultNumberStyle,
      punctuationStyle: punctuationStyle ??
          dartCodeViewerThemeData.punctuationStyle ??
          _defaultPunctuationalStyle,
      stringStyle: stringStyle ??
          dartCodeViewerThemeData.stringStyle ??
          _defaultStringStyle,
      backgroundColor: backgroundColor ??
          dartCodeViewerThemeData.backgroundColor ??
          Theme.of(context).colorScheme.background,
      copyButtonText: copyButtonText ??
          dartCodeViewerThemeData.copyButtonText ??
          _defaultCopyButtonText,
      showCopyButton: showCopyButton ??
          dartCodeViewerThemeData.showCopyButton ??
          _defaultShowCopyButton,
      height: height ??
          dartCodeViewerThemeData.height ??
          MediaQuery.of(context).size.height,
      width: width ??
          dartCodeViewerThemeData.width ??
          MediaQuery.of(context).size.width,
    );

    return DartCodeViewerTheme(
      data: dartCodeViewerThemeData,
      child: _DartCodeViewerPage(
        codifyString(data, dartCodeViewerThemeData),
      ),
    );
  }

  InlineSpan codifyString(
    String content,
    DartCodeViewerThemeData dartCodeViewerThemeData,
  ) {
    final textSpans = <TextSpan>[];
    final codeSpans = DartSyntaxPreHighlighter().format(content);
    // Converting CodeSpan to TextSpan by first converting to a string and then TextSpan.
    for (final span in codeSpans) {
      textSpans.add(stringToTextSpan(span.toString(), dartCodeViewerThemeData));
    }
    return TextSpan(children: textSpans);
  }

  TextSpan stringToTextSpan(
    String string,
    DartCodeViewerThemeData dartCodeViewerThemeData,
  ) {
    return TextSpan(
      style: () {
        final String? styleString =
            RegExp(r'codeStyle.\w*').firstMatch(string)?.group(0);
        final dartCodeViewerTheme = dartCodeViewerThemeData;

        switch (styleString) {
          case 'codeStyle.baseStyle':
            return dartCodeViewerTheme.baseStyle;
          case 'codeStyle.numberStyle':
            return dartCodeViewerTheme.numberStyle;
          case 'codeStyle.commentStyle':
            return dartCodeViewerTheme.commentStyle;
          case 'codeStyle.keywordStyle':
            return dartCodeViewerTheme.keywordStyle;
          case 'codeStyle.stringStyle':
            return dartCodeViewerTheme.stringStyle;
          case 'codeStyle.punctuationStyle':
            return dartCodeViewerTheme.punctuationStyle;
          case 'codeStyle.classStyle':
            return dartCodeViewerTheme.classStyle;
          case 'codeStyle.constantStyle':
            return dartCodeViewerTheme.constantStyle;
          default:
            return dartCodeViewerTheme.baseStyle;
        }
      }(),
      text: () {
        final textString = RegExp('\'.*\'').firstMatch(string)?.group(0);
        final subString = textString!.substring(1, textString.length - 1);
        return decodeString(subString);
      }(),
    );
  }

  /// Read raw string as regular String. Converts Unicode characters to actual
  /// numbers.
  String decodeString(String string) {
    return string
        .replaceAll(r'\u000a', '\n')
        .replaceAll(r'\u0027', '\'')
        .replaceAll(r'\u0009', '\t')
        .replaceAll(r'\u0022', '"');
  }
}

class _DartCodeViewerPage extends StatelessWidget {
  const _DartCodeViewerPage(this.code);
  final InlineSpan code;

  @override
  Widget build(BuildContext context) {
    final _richTextCode = code;
    final _plainTextCode = _richTextCode.toPlainText();

    void _showSnackBarOnCopySuccess(dynamic result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to Clipboard'),
        ),
      );
    }

    void _showSnackBarOnCopyFailure(Object exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failure to copy to clipboard: $exception'),
        ),
      );
    }

    return SelectableText.rich(
      TextSpan(
        text: "",
        children: [_richTextCode],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     if (DartCodeViewerTheme.of(context).showCopyButton!)
    //       ElevatedButton(
    //         onPressed: () async {
    //           await Clipboard.setData(ClipboardData(text: _plainTextCode))
    //               .then(_showSnackBarOnCopySuccess)
    //               .catchError(_showSnackBarOnCopyFailure);
    //         },
    //         child: DartCodeViewerTheme.of(context).copyButtonText,
    //       ),
    //     Expanded(
    //         child: SingleChildScrollView(
    //             child: SelectableText.rich(
    //       TextSpan(
    //         text: "",
    //         children: [_richTextCode],
    //         style: TextStyle(fontWeight: FontWeight.bold),
    //       ),
    //       textDirection: TextDirection.ltr,
    //     ))),
    //   ],
    // );
  }
}
