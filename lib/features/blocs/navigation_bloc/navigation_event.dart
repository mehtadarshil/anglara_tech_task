part of 'navigation_bloc.dart';

class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationChange extends NavigationEvent {
  final int newIndex;

  const NavigationChange({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}
