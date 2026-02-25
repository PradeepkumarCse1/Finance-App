abstract class OnboardingEvent {}

/// when page is swiped manually
class PageChangedEvent extends OnboardingEvent {
  final int index;
  PageChangedEvent(this.index);
}

/// Next button pressed
class NextPageEvent extends OnboardingEvent {}

/// Back button pressed
class PreviousPageEvent extends OnboardingEvent {}