import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    required this.controller,
    required this.hintText,
    super.key,
    this.autofillHints,
    this.textStyle = CustomTextStyleEnum.s15w500,
    this.hintTextStyle = CustomTextStyleEnum.s15w500,
    this.textColor,
    this.hintTextColor = Colors.grey,
    this.labelTextColor,
    this.isFill = true,
    this.fillColor,
    this.borderColor = Colors.grey,
    this.isDense,
    this.hintTextAlign,
    this.isObscureText,
    this.enabled,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.onTapOutside,
    this.readOnly,
    this.expands,
    this.contentPad,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.enableInteractiveSelection,
    this.inputFormatter,
    this.autoCorrect,
    this.onFocused,
    this.onSubmitted,
    this.textInputAction,
    this.textInputType,
    this.textCapitalization,
  });

  final Iterable<String>? autofillHints;
  final TextEditingController controller;
  final String hintText;
  final CustomTextStyleEnum? textStyle;
  final CustomTextStyleEnum? hintTextStyle;

  final Color? textColor;
  final Color? hintTextColor;

  final Color? labelTextColor;
  final bool? isFill;
  final Color? fillColor;
  final Color? borderColor;
  final bool? isDense;

  final TextAlign? hintTextAlign;

  final bool? isObscureText;

  final bool? enabled;
  final void Function(String)? onChanged;

  final void Function()? onTap;
  final int? maxLines;
  final int? maxLength;

  final void Function()? onTapOutside;

  final bool? readOnly;
  final bool? expands;

  final EdgeInsetsGeometry? contentPad;
  final BorderRadius? borderRadius;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool? enableInteractiveSelection;
  final List<TextInputFormatter>? inputFormatter;
  final bool? autoCorrect;

  final void Function(bool)? onFocused;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    const double height = 36;

    return Focus(
      onFocusChange: (value) {
        onFocused?.call(value);
      },
      child: Container(
        height: expands == true ? null : (height + (contentPad != null ? contentPad!.vertical : 8)),
        constraints: BoxConstraints.tightFor(height: expands == true ? null : (height + (contentPad != null ? contentPad!.vertical : 8))),
        decoration: BoxDecoration(
          border: borderColor != null ? Border.all(color: borderColor!.withOpacity(.5)) : null,
          borderRadius: borderRadius ?? context.borderRadiusLow,
          color: (isFill == true ? fillColor : Colors.transparent),
        ),
        padding: contentPad ?? (const EdgeInsets.symmetric(horizontal: 12) + const EdgeInsets.only(bottom: 7, top: 8)),
        child: Center(
          child: Row(
            children: [
              if (prefixIcon != null) prefixIcon!,
              if (prefixIcon != null)
                SizedBox(
                  width: context.lowValue * .5,
                ),
              Expanded(
                child: TextField(
                  onTapOutside: (event) {
                    if (onTapOutside != null) {
                      onTapOutside!();
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();

                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    }
                  },
                  autofocus: true,
                  autofillHints: autofillHints,
                  autocorrect: autoCorrect == true,
                  controller: controller,
                  enabled: enabled,
                  enableInteractiveSelection: enableInteractiveSelection,
                  inputFormatters: inputFormatter,
                  keyboardType: textInputType,
                  maxLength: maxLength,
                  maxLines: expands == true ? null : maxLines,
                  minLines: expands == true ? null : 1,
                  expands: expands == true,
                  readOnly: readOnly ?? false,
                  onChanged: onChanged,
                  onTap: onTap,
                  obscureText: isObscureText ?? false,
                  obscuringCharacter: '*',
                  onSubmitted: (value) {
                    onSubmitted?.call(value);
                  },
                  style: context.textTheme.labelSmall?.copyWith(fontSize: textStyle?.size.toDouble(), fontWeight: textStyle?.fontWeight, color: textColor),
                  textCapitalization: textCapitalization ?? TextCapitalization.none,
                  textInputAction: textInputAction ?? TextInputAction.next,
                  textAlign: hintTextAlign ?? TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    counterText: expands == true ? null : '',
                    isCollapsed: true,
                    hintText: hintText,
                    hintStyle: context.textTheme.labelSmall?.copyWith(fontSize: hintTextStyle?.size.toDouble(), fontWeight: hintTextStyle?.fontWeight, color: hintTextColor?.withOpacity(.5)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (suffixIcon != null)
                SizedBox(
                  width: context.lowValue * .5,
                ),
              if (suffixIcon != null) suffixIcon!,
            ],
          ),
        ),
      ),
    );
  }
}
