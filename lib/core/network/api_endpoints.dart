class ApiEndpoints {
  // Base
  static const String baseImageUrl = 'http://10.0.2.2:5000';
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  // ========== AUTH ==========
  static const String login = '/rider/login';
  static const String register = '/rider/signup';
  static const String registerWithDocuments = '/rider/register-with-documents';
  static const String me = '/rider/profile';

  // ========== RIDER STATS ==========
  static const String earnings = '/rider/earnings';
  static const String history = '/rider/history';

  // ========== ORDERS ==========
  static const String availableOrders = '/rider/available-orders';
  static const String myOrders = '/rider/my-orders';
  static const String orders = '/rider/orders';

  // Dynamic (use with orderId)
  static String acceptOrder(String orderId) => '/rider/orders/$orderId/accept';
  static String pickupOrder(String orderId) => '/rider/orders/$orderId/pickup';
  static String verifyDelivery(String orderId) =>
      '/rider/orders/$orderId/verify-delivery';

  // ========== RIDER STATUS ==========
  static const String availability = '/rider/availability';
  static const String updateLocation = '/rider/location';

  //--dashboard
  static const String dashboard = "";
  static const String riderProfile = "/riders/profile";
  static const String riderEarnings = "/riders/earnings";
  static const String riderHistory = "/riders/history";
}
