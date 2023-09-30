import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/quantum_src/qcircuit.dart';
import 'package:quantum_app_summer_2023/src/quantum_src/qgate_builder.dart';
import 'package:quantum_app_summer_2023/src/quantum_src/utils.dart';
import 'package:quantum_app_summer_2023/src/quantum_src/qmemory_space.dart';

class VisualizationController extends GetxController {
  final selectedValueQuantum = '4'.obs;
  final selectedValueType = 'Probabilities'.obs;
  final quantumCount = 4.obs;
  final List gridItems = <Widget>[].obs;
  final List rowGate = <ThreeValue>[].obs;
  final List states = <String>[].obs;
  List data = <ChartData>[].obs;
  List dataProb = <double>[].obs;
  List dataAmpl = <double>[].obs;
  List dataState = <String>[].obs;

  void generateQuantumStates() {
    states.clear();
    data.clear();
    clearAllData();
    final int numStates = 1 << quantumCount.value;

    for (int i = 0; i < numStates; i++) {
      String state = '';
      for (int j = 0; j < quantumCount.value; j++) {
        if ((i & (1 << j)) == 0) {
          state = '0' + state;
        } else {
          state = '1' + state;
        }
      }
      states.add(state);
      data.add(ChartData(state, 0.00));
    }
    update();
  }

  void updateItemCount(String value) {
    quantumCount.value = int.parse(value);
    selectedValueQuantum.value = value;
    generateQuantumStates();
    update();
  }

  void updateType(String value) {
    selectedValueType.value = value;
    update();
  }

  void buildAndExecuteCircuit() {
    clearAllData();
    final circuit =
        QCircuit(QGateBuilder.get(int.parse(selectedValueQuantum.value)));

    for (var element in rowGate.cast<ThreeValue>()) {
      if (element.getValue1 == 1) {
        circuit.hadamard(element.getValue2);
        print("circuit.hadamard(${element.getValue2})");
      } else if (element.getValue1 == 2) {
        circuit.not(element.getValue2);
        print("circuit.not(${element.getValue2})");
      } else if (element.getValue1 == 3) {
        circuit.pauliY(element.getValue2);
        print("circuit.pauliY(${element.getValue2})");
      } else if (element.getValue1 == 4) {
        circuit.pauliZ(element.getValue2);
        print("circuit.pauliZ(${element.getValue2})");
      } else if (element.getValue1 == 5) {
        circuit.phaseS(element.getValue2);
        print("circuit.phaseS(${element.getValue2})");
      } else if (element.getValue1 == 6) {
        circuit.phaseT(element.getValue2);
        print("circuit.phaseT(${element.getValue2})");
      }
    }

    final qmem = QMemorySpace.zero(circuit.size);
    circuit.execute(qmem);

    print('Final states');
    print(' * amplitudes:    ${amplInfo(qmem, fractionDigits: 2)}');
    print(' * probabilities: ${probInfo(qmem, fractionDigits: 2)}');

    List<String> entries = probInfo(qmem, fractionDigits: 2).split(', ');
    for (String entry in entries) {
      List<String> parts = entry.split(' (');
      String state = parts[0];
      String percentage = parts[1].replaceAll(' %)', '');
      print("State: $state: Percentage: $percentage");
      dataState.add(state);
      dataProb.add(double.parse(percentage));
    }

    List<String> entries2 = amplInfo(qmem, fractionDigits: 2).split(', ');
    for (String entry in entries2) {
      List<String> parts = entry.split(' (');
      String state = parts[0];
      String amplitudeValue = parts[1].replaceAll(')', '');
      if (amplitudeValue.contains('i')) {
        amplitudeValue = amplitudeValue.replaceAll('i', '');
      }
      print("State: $state: Amplitude: $amplitudeValue");
      dataState.add(state);
      dataAmpl.add(double.parse(amplitudeValue));
    }
    changeTypeData();
    update();
  }

  void changeTypeData() {
    for (var element in data.cast<ChartData>()) {
      var x = element.getX;
      if (dataState.contains(x)) {
        int index = dataState.indexOf(x);
        element.y = (selectedValueType.value == "Probabilities")
            ? dataProb[index]
            : dataAmpl[index];
      } else {
        element.y = 0.00;
      }
    }
  }

  void clearGridList() {
    gridItems.clear();
    update();
  }

  void clearRowGate() {
    rowGate.clear();
    update();
  }

  void clearAllData() {
    dataState.clear();
    dataProb.clear();
    dataAmpl.clear();
    update();
  }
}

class ThreeValue {
  int value1;
  int value2;
  int value3;

  ThreeValue(this.value1, this.value2, this.value3);

  int get getValue1 {
    return value1;
  }

  int get getValue2 {
    return value2;
  }

  int get getValue3 {
    return value3;
  }
}

class ChartData {
  ChartData(this.x, this.y);

  String x;
  double y;

  String get getX {
    return x;
  }

  double get getY {
    return y;
  }

  set setX(String x_) {
    x = x_;
  }

  set setY(double y_) {
    y = y_;
  }
}
