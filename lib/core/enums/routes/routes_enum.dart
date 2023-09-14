enum RouteNames {
  signIn('/'),
  signUp('/signUp'),
  main('/main'),
  createPost('/createPost'),
  personalInformation('/personalInformation');

  const RouteNames(this.path);
  final String path;
}
