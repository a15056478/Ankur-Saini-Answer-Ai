import 'dart:async';

import 'package:answers_ai/common/theme_text.dart';
import 'package:answers_ai/presentation/blocs/internet%20connectivity/internet_connectivity_bloc.dart';
import 'package:answers_ai/presentation/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  late StreamSubscription<InternetStatus> _subscription;
  late InternetConnectivityBloc _internetConnectivityBloc;

  get developer => null;

  @override
  void initState() {
    super.initState();
    _internetConnectivityBloc =
        BlocProvider.of<InternetConnectivityBloc>(context);
    _subscription = InternetConnection().onStatusChange.listen((event) {
      _internetConnectivityBloc.add(InternetStatusUpdated(result: event));
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetConnectivityBloc, InternetConnectivityState>(
      listener: (context, state) {
        if (state is InternetConnectivityNoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
              content: Text(
                'No Internet',
                style: ThemeText.s12w500White,
              ),
            ),
          );
        }
        if (state is InternetConnectivityStableConnection) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(milliseconds: 500),
              content: Text(
                'Internet connected',
                style: ThemeText.s12w500White,
              ),
            ),
          );
        }
      },
      child: const LoginPage(),
    );
  }
}
