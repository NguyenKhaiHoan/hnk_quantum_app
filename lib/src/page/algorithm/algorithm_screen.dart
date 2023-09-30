import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/controller/algorithms_controller.dart';
import 'package:unicons/unicons.dart';

class AlgorithmScreen extends StatefulWidget {
  const AlgorithmScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AlgorithmScreen> createState() => _AlgorithmScreenState();
}

class _AlgorithmScreenState extends State<AlgorithmScreen> {
  final AlgorithmController algorithmController =
      Get.put(AlgorithmController());

  @override
  void initState() {
    super.initState();
    if (algorithmController.current_step.value < 0 ||
        algorithmController.current_step.value >
            algorithmController.mySteps.length) {
      setState(() => algorithmController.current_step.value = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
            pinned: true,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                LineIcons.arrowLeft,
                size: 25.0,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  LineIcons.infoCircle,
                  size: 25.0,
                ),
              ),
            ],
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                background: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Quantum',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )),
          ),
          SliverPersistentHeader(
            delegate: SectionHeaderDelegate(),
            pinned: true,
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Description',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text:
                        "Shor's algorithm is an algorithm that can factorize big numbers quickly. For an integer N, Shor's algorithm can find a factor of it in ",
                    style: Get.textTheme.bodyMedium),
                WidgetSpan(
                    child: Math.tex(
                      "O((logN)^3)",
                      mathStyle: MathStyle.display,
                      textStyle: TextStyle(
                          fontSize: 17,
                          color: Get.isDarkMode ? whiteColor : darkColor),
                    ),
                    alignment: PlaceholderAlignment.middle),
                TextSpan(
                    text:
                        " which is an almost exponential speedup over classical algorithms.",
                    style: Get.textTheme.bodyMedium),
              ]))
            ]),
          )),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Obx(() => Visibility(
                    visible: algorithmController.hasData.value,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Text(
                                "Solve",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Obx(() {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        algorithmController.solutionType.value,
                                      ),
                                      TextButton.icon(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              builder: (context) =>
                                                  SingleChildScrollView(
                                                child: Container(
                                                  color: Get.isDarkMode
                                                      ? darkColor
                                                      : whiteColor,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 20,
                                                            left: 20,
                                                          ),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Algoritm Steps",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headlineMedium,
                                                                ),
                                                                TextButton.icon(
                                                                    onPressed:
                                                                        () => Get
                                                                            .back(),
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .close),
                                                                    label: const Text(
                                                                        "Close"))
                                                              ]),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20,
                                                                  left: 20),
                                                          child: Text(
                                                              "The steps are shown specifically below"),
                                                        ),
                                                        Obx(
                                                          () => DynamicStepper(
                                                            type:
                                                                DynamicStepperType
                                                                    .vertical,
                                                            physics:
                                                                const ScrollPhysics(),
                                                            currentStep:
                                                                algorithmController
                                                                    .current_step
                                                                    .value,
                                                            onStepTapped: (step) =>
                                                                algorithmController
                                                                    .stepTapped(
                                                                        step),
                                                            controlsBuilder:
                                                                (context, _) {
                                                              return Row(
                                                                children: <Widget>[
                                                                  GradientWidget(
                                                                      TextButton(
                                                                    onPressed:
                                                                        algorithmController
                                                                            .stepCancel,
                                                                    child: const Text(
                                                                        'Previous'),
                                                                  )),
                                                                  algorithmController
                                                                              .current_step
                                                                              .value !=
                                                                          algorithmController
                                                                              .mySteps
                                                                              .length
                                                                      ? GradientWidget(
                                                                          TextButton(
                                                                          onPressed:
                                                                              algorithmController.stepContinue,
                                                                          child:
                                                                              const Text('Next'),
                                                                        ))
                                                                      : Container(),
                                                                ],
                                                              );
                                                            },
                                                            steps:
                                                                algorithmController
                                                                    .mySteps,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        )
                                                      ]),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            UniconsLine.edit_alt,
                                            size: 20,
                                          ),
                                          label:
                                              const Text("Show step-by-step"))
                                    ],
                                  );
                                })),
                            Center(
                              child: Obx(() {
                                return Card(
                                  color: cardBackgroudColor,
                                  elevation: 4,
                                  margin: const EdgeInsets.all(16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GradientWidget(
                                          Text(
                                            algorithmController.result.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Obx(() {
                                return Text(
                                  algorithmController.executionTime.value,
                                );
                              }),
                            )
                          ],
                        )
                      ],
                    )))),
          ),
        ],
      ),
    );
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  SectionHeaderDelegate();
  final AlgorithmController algorithmController =
      Get.put(AlgorithmController());

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Get.isDarkMode ? darkColor : whiteColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      width: Get.width - 40,
      child: Row(children: [
        Expanded(
          flex: 5,
          child: TextFormField(
            controller: algorithmController.nController,
            decoration: const InputDecoration(labelText: 'Enter number'),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 2,
            child: GradientButton(
                onPressed: algorithmController.runShorAlgorithm,
                widget: const Text("Run")))
      ]),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
