import 'package:demo/core/util/constants.dart';
import 'package:demo/core/util/cubit/cubit.dart';
import 'package:demo/core/util/cubit/state.dart';
import 'package:demo/core/util/widgets/asset_svg.dart';
import 'package:demo/features/main/presentation/pages/past_launches_page.dart';
import 'package:demo/features/main/presentation/widgets/next_launch_item.dart';
import 'package:demo/features/main/presentation/widgets/past_launches_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/util/widgets/main_scaffold.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: AssetSvg(
                imagePath: 'spacex',
                size: 30.0,
                color: HexColor(black),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                return MainCubit.get(context).getNextLaunch();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: HexColor(greyWhite),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      child: MainCubit.get(context).nextLaunchModel != null
                          ? NextLaunchItem(
                              model: MainCubit.get(context).nextLaunchModel!)
                          : const Center(child: CupertinoActivityIndicator()),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0.0,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          navigateTo(context, const PastLaunchesPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Past Launches',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: HexColor(black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MainCubit.get(context).pastLaunches.isNotEmpty
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 2,
                      child: MainCubit.get(context).pastLaunches.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => PastLaunchesItem(
                                  model: MainCubit.get(context)
                                      .pastLaunches[index]),
                              itemCount:
                                  MainCubit.get(context).pastLaunches.length,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: HexColor(greyWhite),
                              ),
                              margin: const EdgeInsetsDirectional.only(
                                start: 16.0,
                                top: 4.0,
                                bottom: 4.0,
                              ),
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Center(
                                  child: CupertinoActivityIndicator()),
                            ),
                    ),
                    space90Vertical,
                    space90Vertical,
                    space60Vertical,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
