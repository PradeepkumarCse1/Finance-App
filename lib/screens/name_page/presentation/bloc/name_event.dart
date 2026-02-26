abstract class NameEvent {}

class NameChanged extends NameEvent {
  final String name;

  NameChanged(this.name);
}

class NameSubmitted extends NameEvent {}   // ✅ Added