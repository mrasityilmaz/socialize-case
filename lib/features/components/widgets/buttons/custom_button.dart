import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';

final class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({super.key, this.onPressed, this.child, this.buttonColor, this.textColor, this.text, this.textStyle, this.isExpanded = true, this.size})
      : assert(child != null || text != null, 'You must provide either child or text');
  final void Function()? onPressed;
  final CustomTextStyleEnum? textStyle;
  final Widget? child;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final bool isExpanded;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                fixedSize: size ?? const Size(kMinInteractiveDimension, kMinInteractiveDimension * .9),
                backgroundColor: buttonColor ?? context.theme.primaryColor,
                minimumSize: size ?? const Size.fromHeight(kMinInteractiveDimension * .9),
                shape: RoundedRectangleBorder(borderRadius: context.borderRadiusLow),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: child ??
                  Text(
                    text ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: textStyle?.size.toDouble() ?? 16,
                      fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
                      color: textColor ?? context.colors.background,
                    ),
                  ),
            ),
          ),
        ],
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: size ?? const Size(kMinInteractiveDimension, kMinInteractiveDimension * .9),
          minimumSize: size ?? const Size.fromHeight(kMinInteractiveDimension * .9),
          backgroundColor: buttonColor ?? context.theme.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: context.borderRadiusLow),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: child ??
            Text(
              text ?? '',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: textStyle?.size.toDouble() ?? 16,
                fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
                color: textColor ?? context.colors.background,
              ),
            ),
      );
    }
  }
}
