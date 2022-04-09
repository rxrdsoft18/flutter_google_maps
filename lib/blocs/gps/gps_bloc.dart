import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';

part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription;

  GpsBloc()
      : super(const GpsState(
            isGpsPermissionGranted: false, isGpsEnabled: false)) {
    on<GpsPermissionEvent>((event, emit) {
      return emit(state.copyWith(
          isGpsEnabled: event.isGpsEnabled,
          isGpsPermissionGranted: event.isGpsPermissionGranted));
    });

    _init();
  }

  Future<void> _init() async {
    final isEnabled = await _checkGpsStatus();

    add(
      GpsPermissionEvent(
          isGpsEnabled: isEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted),
    );
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      print("service status: $isEnabled");
      add(
        GpsPermissionEvent(
            isGpsEnabled: isEnabled,
            isGpsPermissionGranted: state.isGpsPermissionGranted),
      );
    });

    return isEnable;
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
