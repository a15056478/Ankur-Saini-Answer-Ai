part of 'internet_connectivity_bloc.dart';

sealed class InternetConnectivityState extends Equatable {
  const InternetConnectivityState();
}

final class InternetConnectivityStatusChecking
    extends InternetConnectivityState {
  @override
  List<Object?> get props => [];
}

final class InternetConnectivityNoInternet extends InternetConnectivityState {
  @override
  List<Object?> get props => [];
}

final class InternetConnectivityStableConnection
    extends InternetConnectivityState {
  @override
  List<Object?> get props => [];
}
