class AppConstant {
  AppConstant._();
  static const String baseUrl = 'https://api/shopwave.com';

  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  static const String tokenKey = 'auth-key';
  static const String userIdKey = 'user_id';

  static const String loginRoute = '/login';
  static const String logoutRoute = '/logout';
  static const String productsRoute = '/products';
  static const String productRoute = '/product';
  static const String orderRoute = '/orders';
  static const String profileRoute = '/profile';
}
