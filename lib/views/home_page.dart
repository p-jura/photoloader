import 'package:bloc_multi_provider/bloc/bottom_bloc.dart';
import 'package:bloc_multi_provider/bloc/top_bloc.dart';
import 'package:bloc_multi_provider/models/constants.dart';
import 'package:bloc_multi_provider/views/app_bloc_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TopBloc>(
            create: (_) => TopBloc(
              waitBeforeLoading: const Duration(seconds: 3),
              urls: myPhotos,
            ),
          ),
          BlocProvider<BottomBloc>(
            create: (_) => BottomBloc(
              waitBeforeLoading: const Duration(seconds: 3),
              urls: myPhotos,
            ),
          )
        ],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: const [
            AppBlocView<TopBloc>(),
            AppBlocView<BottomBloc>(),
          ],
        ),
      ),
    );
  }
}
