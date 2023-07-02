class NavigationConstants {
  const NavigationConstants._();

  // path
  static const loginPath = '/login';
  static const homePath = '/';
  static const itemDetailPath = '/detail/:$userIdPathParam';
  static const searchPath = '/search';
  static const myPagePath = '/my-page';
  static const registerAccountPath = '/register-account';

  // name
  static const loginName = 'login';
  static const homeName = 'home';
  static const itemDetailName = 'itemDetail';
  static const searchName = 'search';
  static const myPageName = 'myPage';
  static const registerAccountName = 'registerAccount';

  // Path params
  static const userIdPathParam = 'userId';

  // Query params
  static const emailQueryParam = 'email';
}
