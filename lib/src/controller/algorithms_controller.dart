import 'dart:math' as math;
import 'dart:ui';
import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';

class AlgorithmController extends GetxController {
  final nController = TextEditingController();
  final result = ''.obs;
  final solutionType = ''.obs;
  final executionTime = ''.obs;
  final aValues = <int>[].obs;
  final kValues = <int>[].obs;
  final hasData = false.obs;
  final description = <Widget>[].obs;
  final description2 = <Widget>[].obs;
  final current_step = 0.obs;
  final length_steps = 1.obs;
  final showSteps = false.obs;

  void stepTapped(int step) {
    current_step.value = step;
  }

  void toggleShowSteps() {
    showSteps.value = !showSteps.value;
  }

  void stepContinue() {
    if (current_step.value < mySteps.length - 1) {
      current_step.value += 1;
    }
  }

  void stepCancel() {
    if (current_step.value > 0) {
      current_step.value -= 1;
    }
  }

  var mySteps = <DynamicStep>[
    const DynamicStep(
      title: Text("Default Step"),
      content: Text("This is the default step content."),
    ),
  ].obs;

  void updateAlgorithmDescriptionStep(
      {required Widget title, required Widget content}) {
    mySteps.add(DynamicStep(
        title: title,
        content: Align(
          alignment: Alignment.topLeft,
          child: content,
        )));
    update();
  }

  void runShorAlgorithm() {
    aValues.clear();
    kValues.clear();
    mySteps.clear();

    hasData.value = true;
    current_step.value = 0;
    length_steps.value = 0;

    final rnd = math.Random.secure();

    int p = 0, q = 0;
    final stopwatch = Stopwatch()..start();
    final n = int.tryParse(nController.text);
    if (n == null || n <= 1) {
      Get.snackbar(
          'Invalid Input', 'Please enter a valid integer greater than 1.');
      return;
    }

    if (n % 2 == 0) {
      p = n ~/ 2;
      q = 2;
      stopwatch.stop();
      final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
      final elapsedTime = Duration(milliseconds: elapsedMilliseconds);

      executionTime.value = 'Elapsed time: $elapsedTime';
      result.value = '$n = $p × $q';
      solutionType.value = "Solution by: Classical";

      updateAlgorithmDescriptionStep(
          title: Text("Check N is even number"),
          content: RichText(
            text: TextSpan(style: Get.textTheme.bodyMedium, children: [
              WidgetSpan(
                  child: Math.tex(
                    "N = $n",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(
                  text: " is even number, so\n",
                  style: Get.textTheme.bodyMedium),
              WidgetSpan(
                  child: Math.tex(
                    "p = $n / 2 = $p",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(text: " and ", style: Get.textTheme.bodyMedium),
              WidgetSpan(
                  child: Math.tex(
                    "q = $n / $p = $q",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                  alignment: PlaceholderAlignment.middle),
            ]),
          ));
      return;
    }

    if (isPrime(n)) {
      p = n;
      q = 1;
      stopwatch.stop();
      final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
      final elapsedTime = Duration(milliseconds: elapsedMilliseconds);

      executionTime.value = 'Elapsed time: $elapsedTime';
      result.value = '$n = $p × $q';
      solutionType.value = "Solution by: Classical";

      updateAlgorithmDescriptionStep(
          title: Text("Check N is prime", style: Get.textTheme.bodyMedium),
          content: RichText(
            text: TextSpan(children: [
              WidgetSpan(
                  child: Math.tex(
                    "N = $n",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(text: " is prime, so ", style: Get.textTheme.bodyMedium),
              WidgetSpan(
                  child: Math.tex(
                    "p = $p",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(text: " and ", style: Get.textTheme.bodyMedium),
              WidgetSpan(
                  child: Math.tex(
                    "q = $q",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                  alignment: PlaceholderAlignment.middle),
            ]),
          ));
      return;
    }

    int k = findPowerK(n);
    if (k > 1) {
      p = math.pow(n, 1 / k).toInt();
      q = n ~/ p;
      stopwatch.stop();
      final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
      final elapsedTime = Duration(milliseconds: elapsedMilliseconds);

      executionTime.value = 'Elapsed time: $elapsedTime';
      result.value = '$n = $p × $q';
      solutionType.value = "Solution by: Classical";

      updateAlgorithmDescriptionStep(
          title: Text("Check N is the power of a prime"),
          content: Wrap(
            direction: Axis.vertical,
            runSpacing: 5,
            spacing: 5,
            children: [
              Text("Find smallest k that satisfies 2 conditions",
                  style: Get.textTheme.bodyMedium),
              RichText(
                  text: TextSpan(style: Get.textTheme.bodyMedium, children: [
                TextSpan(text: "   • "),
                WidgetSpan(
                  child: Math.tex(
                    "2 <= k <= log_3N",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                )
              ])),
              RichText(
                  text: TextSpan(style: Get.textTheme.bodyMedium, children: [
                TextSpan(text: "   • "),
                WidgetSpan(
                  child: Math.tex(
                    "N^{1/k}",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                )
              ])),
              Text("is a integer.", style: Get.textTheme.bodyMedium),
              Text("k = $k is satified. So, N is the power of a prime",
                  style: Get.textTheme.bodyMedium)
            ],
          ));

      updateAlgorithmDescriptionStep(
          title: Text("Compute p and q", style: Get.textTheme.bodyMedium),
          content: Wrap(
            direction: Axis.vertical,
            runSpacing: 5,
            spacing: 5,
            children: [
              Text("Since k exists, so", style: Get.textTheme.bodyMedium),
              Math.tex(
                "p = N^{1/k}",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
              Math.tex(
                "p = $n^{1/$k}",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
              Math.tex(
                "p = $n^{${1 / k}}",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
              Math.tex(
                "p = $p",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "and ", style: Get.textTheme.bodyMedium),
                WidgetSpan(
                  child: Math.tex(
                    "q = N / p = $n / $p = $q",
                    mathStyle: MathStyle.display,
                    textStyle: TextStyle(fontSize: 17),
                  ),
                )
              ]))
            ],
          ));
      return;
    }

    while (true) {
      description.clear();
      description2.clear();
      final a = 2 + rnd.nextInt(n - 2);

      updateAlgorithmDescriptionStep(
        title: Text("Choose a random a in the range (2, N - 2)",
            style: Get.textTheme.bodyMedium),
        content: Math.tex(
          "a = $a",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(fontSize: 17),
        ),
      );

      int gcdValue = gcd(a, n);
      updateAlgorithmDescriptionStep(
          title: Text("Calculate gcd(a, N)", style: Get.textTheme.bodyMedium),
          content: Wrap(
            spacing: 5,
            runSpacing: 5,
            direction: Axis.vertical,
            children: List.generate(
                description.length,
                (index) => Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: description[index],
                    )),
          ));

      if (gcdValue != 1) {
        p = gcdValue;
        q = n ~/ p;
        stopwatch.stop();
        final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
        final elapsedTime = Duration(milliseconds: elapsedMilliseconds);

        executionTime.value = 'Elapsed time: $elapsedTime';
        result.value = '$n = $p × $q';
        solutionType.value = "Solution by: Classical";

        updateAlgorithmDescriptionStep(
            title: Text("Compute p and q"),
            content: Wrap(
              direction: Axis.vertical,
              runSpacing: 5,
              spacing: 5,
              children: [
                Math.tex(
                  "p = \gcd(a, N) = \gcd($a, $n) = $p",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
                Math.tex(
                  "q = N / p = $n / $p = $q",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
              ],
            ));
        return;
      }

      int r = orderFinding(a, n);
      updateAlgorithmDescriptionStep(
          title: Text("Find r"),
          content: Wrap(
            spacing: 5,
            runSpacing: 5,
            direction: Axis.vertical,
            children: List.generate(
                description2.length,
                (index) => Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: description2[index],
                    )),
          ));

      if (r % 2 == 0) {
        continue;
      }

      p = gcd(math.pow(a, r / 2).toInt() - 1, n);
      if (p != 1) {
        q = n ~/ p;

        updateAlgorithmDescriptionStep(
            title: Text("Compute p and q"),
            content: Wrap(
              direction: Axis.vertical,
              runSpacing: 5,
              spacing: 5,
              children: [
                Math.tex(
                  "p = \gcd(a^{r/2} - 1, N)",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
                Math.tex(
                  "p = \gcd($a^{$r/2} - 1, $n)",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
                Math.tex(
                  "p = \gcd($a^{${r / 2}} - 1, $n)",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
                Math.tex(
                  "p = \gcd(${math.pow(a, r / 2).toInt()} - 1, $n)",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
                Math.tex(
                  "p = \gcd(${math.pow(a, r / 2).toInt() - 1}, $n)",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
                Math.tex(
                  "p = $p",
                  mathStyle: MathStyle.display,
                  textStyle: TextStyle(fontSize: 17),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: "and ", style: Get.textTheme.bodyMedium),
                  WidgetSpan(
                    child: Math.tex(
                      "q = N / p = $n / $p = $q",
                      mathStyle: MathStyle.display,
                      textStyle: TextStyle(fontSize: 17),
                    ),
                  )
                ]))
              ],
            ));

        stopwatch.stop();
        final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
        final elapsedTime = Duration(milliseconds: elapsedMilliseconds);

        executionTime.value = 'Elapsed time: $elapsedTime';
        result.value = '$n = $p × $q';
        solutionType.value = "Solution by: Classical";
        return;
      }
    }
  }

  int gcd(int a, int b) {
    description.clear();
    description.add(RichText(
        text: TextSpan(children: [
      TextSpan(text: "The value of ", style: Get.textTheme.bodyMedium),
      WidgetSpan(
        child: Math.tex(
          "a = $a, b = $b",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(fontSize: 17),
        ),
      )
    ])));
    description.add(RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "Start process with condition ",
          style: Get.textTheme.bodyMedium),
      WidgetSpan(
        child: Math.tex(
          "a ≠ 0:",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(fontSize: 17),
        ),
      )
    ])));
    bool flag = true;
    int a_temp = a, b_temp = b;
    while (a != 0) {
      var t = a;
      if (flag) {
        description.add(RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Assign the value of ", style: Get.textTheme.bodyMedium),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                "a = $a",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
            TextSpan(
                text: " to the temp \nvariable.",
                style: Get.textTheme.bodyMedium),
          ]),
        ));
      }
      a = b % a;
      if (flag) {
        description.add(RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Calculate the new value of\n",
                style: Get.textTheme.bodyMedium),
            WidgetSpan(
              child: Math.tex(
                "a = b / a = $b / $t = $a",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
          ]),
        ));
      }
      b = t;
      if (flag) {
        description.add(RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Assign temp variable value to ",
                style: Get.textTheme.bodyMedium),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                "b = $b",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
          ]),
        ));
      }
      flag = false;
      if (a == 0) {
        description.add(RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Repeat the process... Finish with ",
                style: Get.textTheme.bodyMedium),
            WidgetSpan(
              child: Math.tex(
                "a = $a, b = $b",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
          ]),
        ));
      }
    }

    description.add(RichText(
      text: TextSpan(children: [
        TextSpan(text: "The result is ", style: Get.textTheme.bodyMedium),
        WidgetSpan(
          child: Math.tex(
            "\gcd($a_temp, $b_temp) = $b",
            mathStyle: MathStyle.display,
            textStyle: TextStyle(fontSize: 17),
          ),
        ),
      ]),
    ));
    return b;
  }

  int orderFinding(int N, int a) {
    // Returns the smallest r such that a^r = 1 mod N. Notice that this is a naive classic implementation and is exponentially slower than the quantum version invented by Peter Shor
    var i = 1;
    var ai = a % N;
    description2.clear();
    description2.add(RichText(
        text: TextSpan(children: [
      TextSpan(text: 'Inital value of ', style: Get.textTheme.bodyMedium),
      WidgetSpan(
        child: Math.tex(
          "i = 1, ai = a \mod N = ${ai}",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(fontSize: 17),
        ),
      ),
    ])));
    description2.add(RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Start process with condition ',
          style: Get.textTheme.bodyMedium),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Math.tex(
          "ai ≠ 1",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(fontSize: 17),
        ),
      ),
    ])));
    bool flag = true;

    while (ai != 1) {
      i += 1;
      if (flag) {
        description2.add(RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Increase the i value by 1: ",
                style: Get.textTheme.bodyMedium),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                "i = i + 1 = $i",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
          ]),
        ));
      }
      int temp = ai;
      ai = (ai * a) % N;
      if (flag) {
        description2.add(RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Calculate the new value of ",
                style: Get.textTheme.bodyMedium),
          ]),
        ));
        description2.add(RichText(
          text: TextSpan(children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                "ai = (ai * a) \mod N = ($temp * $a) \mod $N = $ai",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
          ]),
        ));
      }
      flag = false;
      if (ai == 1) {
        description2.add(RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Repeat the process... Finish with ",
                style: Get.textTheme.bodyMedium),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                "ai = $ai",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
          ]),
        ));
      }
    }
    description2.add(RichText(
        text: TextSpan(children: [
      TextSpan(text: 'Smallest r such that ', style: Get.textTheme.bodyMedium),
      WidgetSpan(
        child: Math.tex(
          "a^r ≡ 1 (mod N)",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(fontSize: 17),
        ),
      ),
      TextSpan(text: " is: ", style: Get.textTheme.bodyMedium),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Math.tex(
          "$i",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(fontSize: 17),
        ),
      ),
    ])));
    i % 2 == 0
        ? description2.add(RichText(
            text: TextSpan(children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                "r",
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: 17),
              ),
            ),
            TextSpan(
                text: " is even. Choose a random a again.",
                style: Get.textTheme.bodyMedium),
          ])))
        : null;
    return i;
  }

  bool isPrime(int N) {
    // Returns if N is prime or not. Notice that this is not optimal, there is faster primality testing algorithms e.g. Miller-Rabin
    if (N == 2) {
      return true;
    }
    if (N % 2 == 0 || N <= 1) {
      return false;
    }

    for (int i = 3; i * i <= N; i += 2) {
      if (N % i == 0) {
        return false;
      }
    }

    return true;
  }

  int findPowerK(int N) {
    // Returns the smallest k > 1 such that N**(1/k) is an integer, or 1 if there is no such k.
    int upperBound = (math.log(N) / math.log(3)).toInt();

    for (int k = 2; k <= upperBound; k++) {
      int p = math.pow(N, 1 / k).toInt();
      if (math.pow(p, k).toInt() == N) {
        return k;
      }
    }

    return 1;
  }
}
