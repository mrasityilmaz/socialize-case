enum RouteNames {
  signIn('/'),
  signUp('/signUp'),
  main('/main'),
  createPost('/createPost'),
  editProfile('/editProfile'),
  personalInformation('/personalInformation');

  const RouteNames(this.path);
  final String path;
}
