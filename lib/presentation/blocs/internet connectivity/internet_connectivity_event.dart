part of 'internet_connectivity_bloc.dart';

sealed class InternetConnectivityEvent extends Equatable {
  const InternetConnectivityEvent();
}

class InternetStatusUpdated extends InternetConnectivityEvent {
  final InternetStatus result;

  const InternetStatusUpdated({required this.result});
  @override
  List<Object?> get props => [result.name];
}
