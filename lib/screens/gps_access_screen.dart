import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personales/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc,GpsState>(builder: (context,state) {
          print(state);
          return !state.isGpsEnabled ? const _EnabledMessageWidget() : const _AccessButton() ;
        }),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Es necesario acceso al GPS"),
        MaterialButton(
          elevation: 0,
          color: Colors.black,
          shape: const StadiumBorder(),
          splashColor: Colors.transparent,
          onPressed: () {
            // TODO: por hacer
          },
          child: const Text(
            "Solicitar acceso",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class _EnabledMessageWidget extends StatelessWidget {
  const _EnabledMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Debe habilitar el GPS",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
