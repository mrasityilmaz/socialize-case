import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    required this.controller,
    required this.hintText,
    required this.validator,
    super.key,
    this.autofillHints,
    this.textStyle = CustomTextStyleEnum.s15w500,
    this.hintTextStyle = CustomTextStyleEnum.s15w500,
    this.errorTextStyle = CustomTextStyleEnum.s14w500,
    this.textColor,
    this.hintTextColor = Colors.grey,
    this.errorTextColor,
    this.labelTextColor,
    this.isFill = true,
    this.fillColor,
    this.borderColor = Colors.grey,
    this.isDense,
    this.hintTextAlign,
    this.nextFocusNode,
    this.isObscureText,
    this.focusNode,
    this.enabled,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.label,
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

  final CustomTextStyleEnum? errorTextStyle;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? errorTextColor;
  final Color? labelTextColor;
  final bool? isFill;
  final Color? fillColor;
  final Color? borderColor;
  final bool? isDense;

  final TextAlign? hintTextAlign;
  final FocusNode? nextFocusNode;
  final bool? isObscureText;

  final FocusNode? focusNode;
  final bool? enabled;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  final void Function()? onTap;
  final int? maxLines;
  final int? maxLength;
  final String? label;
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
    return FormField<String?>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      builder: (FormFieldState<String?> field) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Focus(
              onFocusChange: (value) {
                onFocused?.call(value);
              },
              child: Container(
                height: expands == true ? null : (36 + (contentPad != null ? contentPad!.vertical : 8)),
                constraints: BoxConstraints.tightFor(height: expands == true ? null : (36 + (contentPad != null ? contentPad!.vertical : 8))),
                decoration: BoxDecoration(
                  border: field.hasError && !field.isValid
                      ? Border.all(color: errorTextColor ?? Colors.red.shade700)
                      : borderColor != null
                          ? Border.all(color: borderColor!.withOpacity(.5))
                          : null,
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
                              focusNode?.unfocus();
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                            }
                          },
                          onSubmitted: (value) {
                            if (nextFocusNode != null) {
                              FocusScope.of(context).requestFocus(nextFocusNode);
                            } else {
                              FocusScope.of(context).nextFocus();
                            }
                            onSubmitted?.call(value);
                          },
                          autofillHints: autofillHints,
                          autocorrect: autoCorrect == true,
                          controller: controller,
                          enabled: enabled,
                          enableInteractiveSelection: enableInteractiveSelection,
                          focusNode: focusNode,
                          inputFormatters: inputFormatter,
                          keyboardType: textInputType,
                          maxLength: maxLength,
                          maxLines: expands == true ? null : maxLines,
                          minLines: expands == true ? null : 1,
                          expands: expands == true,
                          readOnly: readOnly ?? false,
                          obscureText: isObscureText ?? false,
                          onChanged: (String? str) => {
                            field.didChange(str),
                            if (onChanged != null && str != null) onChanged!(str),
                          },
                          onTap: onTap,
                          style: context.textTheme.labelSmall?.copyWith(fontSize: textStyle?.size.toDouble(), fontWeight: textStyle?.fontWeight, color: textColor),
                          textCapitalization: textCapitalization ?? TextCapitalization.none,
                          textInputAction: textInputAction ?? TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 4),
                            isCollapsed: true,
                            counterText: expands == true ? null : '',
                            hintText: hintText,
                            hintStyle: context.textTheme.labelSmall?.copyWith(fontSize: hintTextStyle?.size.toDouble(), fontWeight: hintTextStyle?.fontWeight, color: hintTextColor?.withOpacity(.5)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (suffixIcon != null) ...[
                        SizedBox(
                          width: context.lowValue * .5,
                        ),
                        suffixIcon!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (field.hasError && !field.isValid) ...[
              SizedBox(height: context.lowValue * .5),
              Padding(
                padding: context.paddingLowLeft * .5,
                child: Text(
                  field.errorText ?? ' ',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: errorTextStyle?.size.toDouble(),
                    fontWeight: errorTextStyle?.fontWeight,
                    color: errorTextColor ?? Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
