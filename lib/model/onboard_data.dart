class Onboarding {
  final String title;
  final String subtitle;
  final String image;

  Onboarding({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

List<Onboarding> onboardingContents = [
  Onboarding(
    title: 'Track Your Health',
    subtitle: 'Many amazing tools will help you\nto track your health everyday',
    image: 'assets/images/onboarding/track_health.png',
  ),
  Onboarding(
    title: 'Looking Food Properties',
    subtitle:
        'Browsing the properties of thousand\nfood from all over the world',
    image: 'assets/images/onboarding/search_food.png',
  ),
  Onboarding(
    title: 'Workout At Home',
    subtitle:
        'Maintaining good health should be\nthe primary focus of everyone',
    image: 'assets/images/onboarding/workout.png',
  ),
];
