import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'fitness_tracker': 'Fitness Tracker',
      'steps': 'Steps',
      'calories_burned': 'Calories Burned',
      'kcal': 'kcal',
      'of_goal': 'of goal',
    },
  };
}
