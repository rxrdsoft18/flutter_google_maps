part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GpsPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  const GpsPermissionEvent({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });
}
