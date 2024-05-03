import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_connectivity_event.dart';
part 'internet_connectivity_state.dart';

class InternetConnectivityBloc
    extends Bloc<InternetConnectivityEvent, InternetConnectivityState> {
  InternetConnectivityBloc() : super(InternetConnectivityStatusChecking()) {
    on<InternetStatusUpdated>((event, emit) {
      if (event.result == InternetStatus.connected) {
        emit(InternetConnectivityStableConnection());
      } else {
        emit(InternetConnectivityNoInternet());
      }
    });
  }
}
