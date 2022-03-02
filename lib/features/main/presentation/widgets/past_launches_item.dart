import 'package:demo/core/util/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/models/launch_model.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/state.dart';
import '../pages/launch_details_page.dart';

class PastLaunchesItem extends StatelessWidget {
  const PastLaunchesItem({Key? key, required this.model}) : super(key: key);
  final LaunchModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Container(
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
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              navigateTo(context, LaunchDetailsPage(launchId: model.id,));
            },
            child: Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Image(
                        image: NetworkImage(model.links.patch.large),
                      ),
                    ),
                  ),
                  space5Vertical,
                  Text(
                    MainCubit.get(context).formatTime(parsedTime: model.date_unix),
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                  ),
                  Text(
                    model.name,
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
