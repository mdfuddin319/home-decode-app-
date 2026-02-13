import 'package:get_storage/get_storage.dart';
import '../core/models/product_model.dart';

class LocalStorage {
  static final box = GetStorage();

  // Keys
  static const String _isLoggedIn = 'isLoggedIn';
  static const String _userId = 'userId';
  static const String _userToken = 'userToken';
  static const String _userProfile = 'userProfile';
  static const String _cartItems = 'cartItems';
  static const String _wishlistItems = 'wishlistItems';
  static const String _themeMode = 'themeMode';
  static const String _language = 'language';
  static const String _onboardingCompleted = 'onboardingCompleted';

  // Initialization
  static Future<void> init() async {
    await GetStorage.init();
  }

  // Auth Methods
  static Future<bool> setIsLoggedIn(bool value) async {
    try {
      await box.write(_isLoggedIn, value);
      return true;
    } catch (e) {
      print('Error setting isLoggedIn: $e');
      return false;
    }
  }

  static bool getIsLoggedIn() {
    try {
      return box.read(_isLoggedIn) ?? false;
    } catch (e) {
      print('Error getting isLoggedIn: $e');
      return false;
    }
  }

  static Future<bool> setUserId(int userId) async {
    try {
      await box.write(_userId, userId);
      return true;
    } catch (e) {
      print('Error setting userId: $e');
      return false;
    }
  }

  static int getUserId() {
    try {
      return box.read(_userId) ?? 0;
    } catch (e) {
      print('Error getting userId: $e');
      return 0;
    }
  }

  static Future<bool> setUserToken(String token) async {
    try {
      await box.write(_userToken, token);
      return true;
    } catch (e) {
      print('Error setting userToken: $e');
      return false;
    }
  }

  static String getUserToken() {
    try {
      return box.read(_userToken) ?? '';
    } catch (e) {
      print('Error getting userToken: $e');
      return '';
    }
  }

  static Future<bool> setUserProfile(Map<String, dynamic> profile) async {
    try {
      await box.write(_userProfile, profile);
      return true;
    } catch (e) {
      print('Error setting userProfile: $e');
      return false;
    }
  }

  static Map<String, dynamic>? getUserProfile() {
    try {
      return box.read(_userProfile);
    } catch (e) {
      print('Error getting userProfile: $e');
      return null;
    }
  }

  // Cart Methods
  static Future<bool> setCartItems(List<int> cartItems) async {
    try {
      await box.write(_cartItems, cartItems);
      return true;
    } catch (e) {
      print('Error setting cartItems: $e');
      return false;
    }
  }

  static List<int> getCartItems() {
    try {
      return List<int>.from(box.read(_cartItems) ?? []);
    } catch (e) {
      print('Error getting cartItems: $e');
      return [];
    }
  }

  static Future<bool> clearCart() async {
    try {
      await box.remove(_cartItems);
      return true;
    } catch (e) {
      print('Error clearing cart: $e');
      return false;
    }
  }

  // Wishlist Methods
  static Future<bool> setWishlistItems(List<int> wishlistItems) async {
    try {
      await box.write(_wishlistItems, wishlistItems);
      return true;
    } catch (e) {
      print('Error setting wishlistItems: $e');
      return false;
    }
  }

  static List<int> getWishlistItems() {
    try {
      return List<int>.from(box.read(_wishlistItems) ?? []);
    } catch (e) {
      print('Error getting wishlistItems: $e');
      return [];
    }
  }

  static Future<bool> clearWishlist() async {
    try {
      await box.remove(_wishlistItems);
      return true;
    } catch (e) {
      print('Error clearing wishlist: $e');
      return false;
    }
  }

  // Updated Wishlist Methods for Product objects
  static Future<bool> saveWishlist(List<Product> wishlist) async {
    try {
      final List<Map<String, dynamic>> wishlistJson = wishlist
          .map((product) => product.toJson())
          .toList();
      await box.write(_wishlistItems, wishlistJson);
      return true;
    } catch (e) {
      print('Error saving wishlist: $e');
      return false;
    }
  }

  static Future<List<Product>> getWishlist() async {
    try {
      final List<dynamic>? wishlistJson = box.read(_wishlistItems);
      if (wishlistJson == null) return [];

      final List<Product> wishlist = wishlistJson
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
      return wishlist;
    } catch (e) {
      print('Error getting wishlist: $e');
      return [];
    }
  }

  // Settings Methods
  static Future<bool> setThemeMode(String themeMode) async {
    try {
      await box.write(_themeMode, themeMode);
      return true;
    } catch (e) {
      print('Error setting themeMode: $e');
      return false;
    }
  }

  static String getThemeMode() {
    try {
      return box.read(_themeMode) ?? 'system';
    } catch (e) {
      print('Error getting themeMode: $e');
      return 'system';
    }
  }

  static Future<bool> setLanguage(String language) async {
    try {
      await box.write(_language, language);
      return true;
    } catch (e) {
      print('Error setting language: $e');
      return false;
    }
  }

  static String getLanguage() {
    try {
      return box.read(_language) ?? 'en';
    } catch (e) {
      print('Error getting language: $e');
      return 'en';
    }
  }

  // Onboarding Methods
  static Future<bool> setOnboardingCompleted(bool completed) async {
    try {
      await box.write(_onboardingCompleted, completed);
      return true;
    } catch (e) {
      print('Error setting onboarding completed: $e');
      return false;
    }
  }

  static bool getOnboardingCompleted() {
    try {
      return box.read(_onboardingCompleted) ?? false;
    } catch (e) {
      print('Error getting onboarding completed: $e');
      return false;
    }
  }

  // Clear All Data
  static Future<bool> clearAll() async {
    try {
      await box.erase();
      return true;
    } catch (e) {
      print('Error clearing all data: $e');
      return false;
    }
  }

  // Utility Methods
  static bool hasData(String key) {
    try {
      return box.hasData(key);
    } catch (e) {
      print('Error checking if key exists: $e');
      return false;
    }
  }

  static dynamic read(String key) {
    try {
      return box.read(key);
    } catch (e) {
      print('Error reading key: $e');
      return null;
    }
  }

  static Future<bool> write(String key, dynamic value) async {
    try {
      await box.write(key, value);
      return true;
    } catch (e) {
      print('Error writing to key: $e');
      return false;
    }
  }

  static Future<bool> remove(String key) async {
    try {
      await box.remove(key);
      return true;
    } catch (e) {
      print('Error removing key: $e');
      return false;
    }
  }
}
