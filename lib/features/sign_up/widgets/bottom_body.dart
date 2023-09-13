part of '../sign_up_screen.dart';

final class _SignUpScreenBodyWidget extends StatelessWidget {
  const _SignUpScreenBodyWidget();

  @override
  Widget build(BuildContext context) {
    final SignUpViewModel viewModel = context.read<SignUpViewModel>();
    return SafeArea(
      child: Padding(
        padding: context.paddingNormalHorizontal * 2 + context.paddingNormalTop * 2 + context.paddingLowBottom,
        child: Form(
          key: viewModel.formKey,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: context.paddingMediumVertical,
                child: FractionallySizedBox(
                  widthFactor: .7,
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    'assets/logos/SOCIALIZE.svg',
                  ),
                ),
              ),
              Text(
                'Create a new account',
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'Please put your information below to create a new account.',
                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: context.colors.onBackground.withOpacity(.5)),
              ),
              SizedBox(height: context.normalValue * 1.5),
              CustomTextFormFieldWidget(
                validator: (p0) {
                  if (p0 != null && p0.length < 10 || p0 == null) {
                    return 'Fullname must be at least 10 characters';
                  }
                  return null;
                },
                controller: viewModel.fullnameController,
                hintText: 'Fullname',
              ),
              SizedBox(height: context.normalValue),
              CustomTextFormFieldWidget(
                validator: (p0) {
                  if (p0 != null && p0.length < 3 || p0 == null) {
                    return 'Username must be at least 3 characters';
                  }
                  return null;
                },
                controller: viewModel.usernameController,
                hintText: 'Username',
              ),
              SizedBox(height: context.normalValue),
              CustomTextFormFieldWidget(
                controller: viewModel.emailController,
                hintText: 'Email',
                validator: ValidatorService.instance.checkEmail,
              ),
              SizedBox(height: context.normalValue),
              CustomTextFormFieldWidget(
                controller: viewModel.passwordController,
                hintText: '••••••••••',
                isObscureText: context.select<SignUpViewModel, bool>((value) => value.isObscure),
                suffixIcon: GestureDetector(
                  onTap: viewModel.setObscureOrNot,
                  child: const Icon(CupertinoIcons.eye_fill, color: Colors.grey),
                ),
                validator: ValidatorService.instance.checkPassword,
              ),
              SizedBox(height: context.normalValue),
              CustomButtonWidget(
                text: 'Register Now',
                onPressed: () async {
                  viewModel.formKey.currentState?.save();
                  final bool? isValid = viewModel.formKey.currentState?.validate();

                  if (isValid == true) {
                    await viewModel.registerUser().then((value) {
                      if (value) {
                        context.pushReplacementNamed(RouteNames.personalInformation.name);
                      }
                    });
                  }
                },
                textColor: context.colors.onPrimary,
              ),
              SizedBox(
                height: context.normalValue * 1.5,
              ),
              Align(
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account?\t\t',
                    children: [
                      TextSpan(
                        text: 'Join Now',
                        style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: context.colors.primary, fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pop();
                          },
                      ),
                    ],
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onBackground.withOpacity(.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
