import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:personales/blocs/blocs.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(const GpsState(isGpsPermissionGranted: false,isGpsEnabled: false)) {
    on<GpsPermissionEvent>((event, emit) {
      return emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted
      ));
    });

    _init();
  }

  Future<void> _init() async {
    await _checkGpsStatus();
  }
  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = ( event.index == 1) ? true : false;
      print("service status: $isEnabled");
    });

    return isEnable;
  }

  @override
  Future<void> close() {
    // TODO: Limpiar serviceStatusStream
    return super.close();
  }
}
