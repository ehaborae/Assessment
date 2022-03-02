import 'package:demo/core/util/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/models/launch_model.dart';
import '../../../../core/util/constants.dart';
import '../pages/launch_details_page.dart';

class NextLaunchItem extends StatelessWidget {
  const NextLaunchItem({Key? key, required this.model}) : super(key: key);

  final LaunchModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        navigateTo(
            context,
            LaunchDetailsPage(
              launchId: model.id,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(
          0.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: HexColor(blue),
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: Text(
                'keep following the next launch',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: HexColor(black),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Image(
                  image: NetworkImage(model.links.patch.large),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time remain: ${MainCubit.get(context).getTimeRemain(time: model.date_unix)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Launch name: ${model.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
