import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

part 'quntity_event.dart';
part 'quntity_state.dart';

class QuntityBloc extends Bloc<QuntityEvent, QuntityState> {
  final String id;
  QuntityBloc(this.id) : super(QuntityState(qty: GetStorage().read(id) ?? 0)) {
    on<QuntityUpdate>((event, emit) {
      emit(QuntityState(qty: GetStorage().read(id) ?? 0));
    });
  }
}
