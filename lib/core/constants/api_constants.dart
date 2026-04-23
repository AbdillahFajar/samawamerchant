  class ApiConstants {
    static const String baseUrl = 'http://192.168.1.10:8081/v1'; //URL Backend

    //Auth Endpoints
    static const String verifyToken = '/auth/verify-token';

    //Product Endpoints
    static const String products = '/products';

    //Cart Endpoints
    static const String cart = '/cart';

    //Orders Endpoint for All Users
    static const String orders = '/orders';

    //Checkout Endpoint
    static const String checkout = '/orders/checkout';

    //Orders Endpoint for Admin (Merchant) Only.
    static const String adminOrders = '/admin/orders';
    
    //Timeout
    static const int connectTimeout = 15000;
    static const int receiveTimeout = 15000;
  }