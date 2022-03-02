import 'package:demo/core/util/constants.dart';
import 'package:demo/core/util/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/cubit/state.dart';

class LaunchDetailsPage extends StatefulWidget {
  const LaunchDetailsPage({Key? key, required this.launchId}) : super(key: key);
  final String launchId;

  @override
  State<LaunchDetailsPage> createState() => _LaunchDetailsPageState();
}

class _LaunchDetailsPageState extends State<LaunchDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit.get(context).getLaunch(id: widget.launchId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: MainCubit.get(context).launchModel != null
                ? Text(
                    MainCubit.get(context).launchModel!.name,
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                  )
                : null,
          ),
          body: MainCubit.get(context).launchModel != null
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image(
                            height: MediaQuery.of(context).size.height / 3,
                            image: NetworkImage(MainCubit.get(context)
                                .launchModel!
                                .links
                                .patch
                                .large),
                          ),
                        ),
                        const Divider(height: 16),
                        Text(
                          'Launch',
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              'Name',
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                            ),
                            space10Horizontal,
                            Expanded(
                              child: Text(
                                MainCubit.get(context).launchModel!.name,
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        space5Vertical,
                        Row(
                          children: [
                            Text(
                              'Date',
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                            ),
                            space10Horizontal,
                            Expanded(
                              child: Text(
                                MainCubit.get(context).formatTime(parsedTime: MainCubit.get(context).launchModel!.date_unix),
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        space5Vertical,
                        Row(
                          children: [
                            Text(
                              'Launchpad',
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                            ),
                            space10Horizontal,
                            Expanded(
                              child: Text(
                                MainCubit.get(context).launchModel!.date_utc,
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Launch video',
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                            ),
                            IconButton(
                              onPressed: () {
                                MainCubit.get(context).launchURL(
                                    url: MainCubit.get(context)
                                        .launchModel!
                                        .links
                                        .webcast);
                              },
                              icon: const Image(
                                image: AssetImage('assets/images/download.png'),
                              ),
                            ),
                          ],
                        ),
                        if (MainCubit.get(context).rocketModel != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(height: 16),
                              Text(
                                'Rocket',
                                style: Theme.of(context).textTheme.bodyText2,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Height',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    maxLines: 1,
                                  ),
                                  space10Horizontal,
                                  Expanded(
                                    child: Text(
                                      '${MainCubit.get(context).rocketModel!.height.meters.toString()} Meters',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              space5Vertical,
                              Row(
                                children: [
                                  Text(
                                    'Diameter',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    maxLines: 1,
                                  ),
                                  space10Horizontal,
                                  Expanded(
                                    child: Text(
                                      '${MainCubit.get(context).rocketModel!.diameter.meters.toString()} Meters',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              space5Vertical,
                              Row(
                                children: [
                                  Text(
                                    'Mass',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    maxLines: 1,
                                  ),
                                  space10Horizontal,
                                  Expanded(
                                    child: Text(
                                      '${MainCubit.get(context).rocketModel!.mass.kg.toString()} KG',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (MainCubit.get(context).payloadModel != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(height: 16),
                              Text(
                                'Payload',
                                style: Theme.of(context).textTheme.bodyText2,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Name',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    maxLines: 1,
                                  ),
                                  space10Horizontal,
                                  Expanded(
                                    child: Text(
                                      MainCubit.get(context).payloadModel!.name,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              space5Vertical,
                              Row(
                                children: [
                                  Text(
                                    'Type',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    maxLines: 1,
                                  ),
                                  space10Horizontal,
                                  Expanded(
                                    child: Text(
                                      MainCubit.get(context).payloadModel!.type,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              : const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}
