import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({required this.text, super.key, this.style = CustomTextStyleEnum.s15w500, this.textColor});

  final String text;
  final CustomTextStyleEnum style;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyLarge?.copyWith(color: textColor, fontSize: style.size.toDouble(), fontWeight: style.fontWeight),
    );
  }
}
