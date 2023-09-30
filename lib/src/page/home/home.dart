import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/controller/profile_controller.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';
import 'package:quantum_app_summer_2023/src/page/algorithm/algorithm_screen.dart';
import 'package:quantum_app_summer_2023/src/page/circuit/quantum_circuit.dart';
import 'package:quantum_app_summer_2023/src/page/game/tic_tac_toe_welcome.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Wrap(
        runSpacing: 10,
        children: [
          TabbarViewItem(
              title: "Shor Algorithms",
              subTitle: "An algorithm that can factorize big ....",
              onPressed: () =>
                  Get.to(AlgorithmScreen(title: "Shor Algorithm"))),
          TabbarViewItem(
              title: "Grover Algorithms",
              subTitle: "An algorithm to solve the unstructured ...",
              onPressed: () {})
        ],
      ),
      Wrap(
        runSpacing: 10,
        children: [
          TabbarViewItem(
              title: "Visualization QCircuit",
              subTitle: "Design and run quantum circuits using ...",
              onPressed: () => Get.to(
                  VisualizationQCircuit(title: "Visualization QCircuit"))),
        ],
      ),
    ];

    TabController _tabController =
        TabController(length: list.length, vsync: this);
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
      appBar: AppBar(
        actions: [
          Image.asset(
            "assets/images/user.png",
            width: 40,
            height: 40,
          ),
          SizedBox(
            width: 20,
          )
        ],
        centerTitle: true,
        title: GradientWidget(
          Text('quantum', style: TextStyle(fontSize: 30)),
        ),
        leading: IconButton(
          onPressed: () {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hello, ",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      FutureBuilder(
                        future: controller.getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              UserModel user = snapshot.data as UserModel;

                              return Text(
                                user.fullName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            } else {
                              return const Center(
                                  child: Text('Something went wrong'));
                            }
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: whiteColor,
                              strokeWidth: 2,
                            ));
                          }
                        },
                      ),
                      Text(" 👋")
                    ],
                  ),
                  Text("Do you like playing game?")
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: Get.width / 2 - 30,
                          height: Get.width / 2 - 30,
                          margin: EdgeInsets.only(bottom: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/tic-tac-toe.jpg',
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(
                                    LineIcons.play,
                                  ).frosted(
                                    blur: 25,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20)),
                                    padding: EdgeInsets.all(8),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () => Get.to(GameScreen(title: "Tic-Tac-Toe")),
                      ),
                      Text("Quantum Tic-tac-toe")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width / 2 - 30,
                        height: Get.width / 2 - 30,
                        margin: EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/hello.png',
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  LineIcons.play,
                                ).frosted(
                                  blur: 25,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20)),
                                  padding: EdgeInsets.all(8),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text("Hello Quantum")
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                            "Let's start your journey to explore quantum topics")
                      ],
                    ),
                  ),
                  Icon(LineIcons.horizontalEllipsis)
                ],
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 15),
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(
                    color: Color.fromRGBO(251, 109, 169, 1), radius: 4),
                isScrollable: true,
                splashFactory: NoSplash.splashFactory,
                labelColor: Get.isDarkMode ? whiteColor : darkColor,
                unselectedLabelColor: Colors.grey,
                labelPadding: EdgeInsets.only(right: 20),
                tabs: <Widget>[
                  Tab(text: 'Algorithms'),
                  Tab(text: 'Circuit'),
                ],
                controller: _tabController,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: TabBarView(controller: _tabController, children: <Widget>[
              Container(
                child: list[0],
              ),
              Container(
                child: list[1],
              )
            ]),
          )),
        ]),
      ),
    );
  }
}

class TabbarViewItem extends StatelessWidget {
  const TabbarViewItem(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: Get.width - 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? darkColor : whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(187, 63, 221, 1),
                          Color.fromRGBO(251, 109, 169, 1),
                          Color.fromRGBO(255, 159, 124, 1)
                        ])),
                    child: Icon(LineIcons.play),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        subTitle,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ],
                  )
                ],
              )),
              Text("Try now"),
            ],
          )),
      onTap: onPressed,
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
