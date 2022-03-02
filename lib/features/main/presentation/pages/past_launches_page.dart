import 'package:demo/core/util/cubit/cubit.dart';
import 'package:demo/features/main/presentation/widgets/next_launch_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/cubit/state.dart';
import '../widgets/past_launches_item.dart';

class PastLaunchesPage extends StatelessWidget {
  const PastLaunchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'All Past Launches',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: MainCubit.get(context).pastLaunches.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => PastLaunchesItem(
                      model: MainCubit.get(context).pastLaunches[index]),
                  itemCount: MainCubit.get(context).pastLaunches.length,
                )
              : const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}
