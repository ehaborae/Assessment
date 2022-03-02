
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:demo/core/util/cubit/cubit.dart';
import 'package:demo/core/util/cubit/state.dart';


class MainScaffold extends StatelessWidget {
  final Widget scaffold;

  const MainScaffold({
    Key? key,
    required this.scaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Directionality(
          textDirection: MainCubit.get(context).isRtl
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: scaffold,
        );
      },
    );
  }
}
