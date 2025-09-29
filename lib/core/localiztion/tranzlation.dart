import 'package:flutter/material.dart';

class MyTranslation {
  // Map of supported languages
  static final Map<String, Map<String, String>> _translations = {
    'en': {
      'hello': 'Hello',
      'home': 'Home',
      'toggle_language': 'Toggle Language',

      // OnBoarding texts
      'onboarding_choose_product': 'Choose Product',
      'onboarding_choose_product_desc':
          'We have a lot of products for you\nChoose what you want and we will deliver it to you',

      'onboarding_easy_payment': 'Easy & Safe Payment',
      'onboarding_easy_payment_desc':
          'Easy check out with a safe payment method\nWe will deliver your product as soon as possible',

      'onboarding_fast_delivery': 'Fast Delivery',
      'onboarding_fast_delivery_desc':
          'We will deliver your product as soon as possible\nJust wait and we will deliver it to you',
    },
    'ar': {
      'hello': 'مرحبا',
      'home': 'الرئيسية',
      'toggle_language': 'تغيير اللغة',

      // OnBoarding texts
      'onboarding_choose_product': 'اختر المنتج',
      'onboarding_choose_product_desc':
          'لدينا العديد من المنتجات لك\nاختر ما تريد وسنسلمه لك',

      'onboarding_easy_payment': 'دفع سهل وآمن',
      'onboarding_easy_payment_desc':
          'إتمام الدفع بطريقة آمنة وسهلة\nسنقوم بتسليم منتجك في أسرع وقت ممكن',

      'onboarding_fast_delivery': 'توصيل سريع',
      'onboarding_fast_delivery_desc':
          'سنقوم بتسليم منتجك في أسرع وقت ممكن\nفقط انتظر وسنسلمه لك',
    },
  };

  final Locale locale;

  MyTranslation(this.locale);

  String tr(String key) {
    return _translations[locale.languageCode]?[key] ?? key;
  }
}
