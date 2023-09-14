import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({required this.text, super.key, this.style = CustomTextStyleEnum.s15w500, this.textColor, this.maxLines = 1, this.overflow = TextOverflow.ellipsis});

  final String text;
  final CustomTextStyleEnum style;
  final Color? textColor;
  final int maxLines;

  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyLarge?.copyWith(color: textColor, fontSize: style.size.toDouble(), fontWeight: style.fontWeight),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
