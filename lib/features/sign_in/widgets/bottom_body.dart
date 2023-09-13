part of '../sign_in_screen.dart';

final class _SignInScreenBodyWidget extends StatelessWidget {
  const _SignInScreenBodyWidget();

  @override
  Widget build(BuildContext context) {
    final SignInViewModel viewModel = context.read<SignInViewModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log In',
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: context.normalValue * 1.5),
        CustomTextFormFieldWidget(
          controller: viewModel.emailController,
          hintText: 'Email',
          validator: ValidatorService.instance.checkEmail,
        ),
        SizedBox(height: context.normalValue),
        CustomTextFormFieldWidget(
          controller: viewModel.passwordController,
          hintText: '••••••••••',
          isObscureText: context.select<SignInViewModel, bool>((value) => value.isObscure),
          suffixIcon: GestureDetector(
            onTap: viewModel.setObscureOrNot,
            child: const Icon(CupertinoIcons.eye_fill, color: Colors.grey),
          ),
          validator: ValidatorService.instance.checkPassword,
        ),
        SizedBox(height: context.normalValue),
        CustomButtonWidget(
          text: 'Sign In',
          onPressed: () async {
            await viewModel.login().then((value) {
              if (value.isRight()) {
                GoRouterService.instance.goRouter.pushReplacementNamed(RouteNames.home.name);
              } else {
                print('Error: ${value.asLeft()}');
              }
            });
          },
          textColor: context.colors.onPrimary,
        ),
        SizedBox(
          height: context.lowValue * .5,
        ),
        Text(
          'Forgot Password',
          style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 12),
        ),
        SizedBox(
          height: context.normalValue * 1.5,
        ),
        Align(
          child: Text.rich(
            TextSpan(
              text: "Don't have an account?\t\t",
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: context.colors.primary, fontSize: 14),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.pushNamed(RouteNames.signUp.name);
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
    );
  }
}
