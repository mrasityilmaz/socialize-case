enum RouteNames {
  signIn('/'),
  signUp('/signUp'),
  home('/home'),
  personalInformation('/personalInformation');

  const RouteNames(this.path);
  final String path;
}
