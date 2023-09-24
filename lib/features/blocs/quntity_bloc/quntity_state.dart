part of 'quntity_bloc.dart';

class QuntityState extends Equatable {
  const QuntityState({required this.qty});

  final int qty;

  @override
  List<Object> get props => [qty];
}
