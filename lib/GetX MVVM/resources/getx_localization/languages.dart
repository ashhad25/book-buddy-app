import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'internet_exception':
          'We are unable to connect to the internet\n Please check your connection',
      'general_exception':
          'We are unable to process your request\n Please try again later',
      'welcome_back': 'Welcome\nBack',
      'login': 'Login',
      'register': 'Register',
      'email_hint': 'Email',
      'username_hint': 'Username',
      'password_hint': 'Password',
      'no_account': 'Don\'t have an account?',
      'already_account': 'Already have an account?',
      'register_now': 'Register Now',
      'login_now': 'Login Now',
      'home_appbar': 'Books List',
    },
    'ur_PK': {'email_hint': 'اپنا ای میل درج کریں۔'},
  };
}
