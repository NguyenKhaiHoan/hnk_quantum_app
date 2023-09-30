import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/controller/visualization_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VisualizationQCircuit extends StatefulWidget {
  const VisualizationQCircuit({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<VisualizationQCircuit> createState() => _VisualizationQCircuitState();
}

const List<Item> _items = [
  Item(
      uid: 1,
      url: 'assets/images/1.png',
      name: "The Hadamard gate",
      imageProvider: AssetImage('assets/images/1.png'),
      description:
          "The H, or Hadamard, gate rotates the states ∣0⟩ and ∣1⟩ to ∣+⟩ and ∣−⟩, respectively."),
  Item(
      uid: 2,
      url: 'assets/images/2.png',
      name: "The NOT gate",
      imageProvider: AssetImage('assets/images/2.png'),
      description:
          "The NOT gate, also known as the Pauli X gate, flips the ∣0⟩ state to ∣1⟩, and vice versa. The NOT gate is equivalent to RX for the angle π or to HZH."),
  Item(
      uid: 3,
      url: 'assets/images/3.png',
      name: "The Pauli Y gate",
      imageProvider: AssetImage('assets/images/3.png'),
      description:
          "The Pauli Y gate is equivalent to Ry for the angle π. It is equivalent to applying X and Z, up to a global phase factor."),
  Item(
      uid: 4,
      url: 'assets/images/4.png',
      name: "The Pauli Z gate",
      imageProvider: AssetImage('assets/images/4.png'),
      description:
          "The Pauli Z gate acts as identity on the ∣0⟩ state and multiplies the sign of the ∣1⟩ state by -1. It therefore flips the ∣+⟩ and ∣−⟩ states. In the +/- basis, it plays the same role as the NOT gate in the ∣0⟩/∣1⟩ basis."),
  Item(
      uid: 5,
      url: 'assets/images/5.png',
      name: "The S gate",
      imageProvider: AssetImage('assets/images/5.png'),
      description:
          "The S gate applies a phase of i to the ∣1⟩ state. It is equivalent to RZ for the angle π/2. Note that S=P(π/2)."),
  Item(
      uid: 6,
      url: 'assets/images/6.png',
      name: "The T gate",
      imageProvider: AssetImage('assets/images/6.png'),
      description:
          "The T gate is equivalent to RZ for the angle π/4. Fault-tolerant quantum computers will compile all quantum programs down to just the T gate and its inverse, as well as the Clifford gates."),
];
final GlobalKey _draggableKey = GlobalKey();

class _VisualizationQCircuitState extends State<VisualizationQCircuit> {
  final visualizationController = Get.put(VisualizationController());
  // Timer? _timer;
  late List<Customer> _people;
  late TooltipBehavior _tooltip;
  final items = ['1', '2', '3', '4'];
  final type = ['Statevector', 'Probabilities'];
  int itemCount = ((Get.width - 40) / 80).ceil() - 2;

  @override
  void initState() {
    super.initState();
    _people = List.generate(itemCount * 4, (index) => Customer());
    visualizationController.generateQuantumStates();
    _tooltip = TooltipBehavior(
      enable: true,
      header: visualizationController.selectedValueType.value == "Probabilities"
          ? "Probabilities"
          : "Amplitude",
    );
  }

  void _itemDroppedOnCustomerCart(
      {required Item item,
      required Customer customer,
      required int listIndex}) {
    setState(() {
      if (customer.items.isEmpty) {
        customer.items.add(item);
        visualizationController.rowGate.add(ThreeValue(
            customer.items.first.uid, listIndex % itemCount, listIndex));
      }
    });
  }

  void clearAllGridItems() {
    for (var customer in _people) {
      customer.items.clear();
    }
    visualizationController.gridItems.clear();
    visualizationController.rowGate.clear();
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
                background: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        'Quantum',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
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
              const Text(
                  "Design quantum circuits using basic operations such as H, NOT, Y, Z, S, T to display the probabilities and states of the qubits after executing the circuits.")
            ]),
          )),
          SliverToBoxAdapter(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Visualization',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(
                              () => DropdownButton<String>(
                                value: visualizationController
                                    .selectedValueQuantum.value,
                                onChanged: (String? newValue) {
                                  visualizationController
                                      .updateItemCount(newValue!);
                                  clearAllGridItems();
                                  setState(() {
                                    _buildChart();
                                  });
                                },
                                items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 42,
                                underline: const SizedBox(),
                              ),
                            )),
                        TextButton.icon(
                          icon: const Icon(Icons.restore),
                          onPressed: () => {
                            clearAllGridItems(),
                            visualizationController.clearGridList(),
                            visualizationController.clearRowGate(),
                          },
                          label: const Text("Reset"),
                        )
                      ],
                    )
                  ],
                ),
                Obx(
                  () => _buildPeopleGrid(
                      visualizationController.quantumCount.value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                          () => DropdownButton<String>(
                            value:
                                visualizationController.selectedValueType.value,
                            onChanged: (String? newValue) {
                              visualizationController.updateType(newValue!);
                              visualizationController.changeTypeData();
                              setState(() {
                                _tooltip = TooltipBehavior(
                                  enable: true,
                                  header: visualizationController
                                              .selectedValueType.value ==
                                          "Probabilities"
                                      ? "Probability"
                                      : "Amplitude",
                                );
                              });
                            },
                            items: type.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 42,
                            underline: const SizedBox(),
                          ),
                        )),
                    Container(
                      width: 100,
                      child: GradientButton(
                          onPressed: () {
                            visualizationController.buildAndExecuteCircuit();
                            setState(() {
                              _buildChart();
                            });
                          },
                          widget: const Text("Execute")),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildChart()
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPeopleGrid(int itemCount) {
    visualizationController.clearGridList();
    for (int i = 0; i < itemCount; i++) {
      visualizationController.gridItems.add(_buildRowWithDivider("q[$i]", i));
    }

    return Container(
      height: 380,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: visualizationController.gridItems
            .map((widget) => Container(child: widget))
            .toList(),
      ),
    );
  }

  Widget _buildRowWithDivider(String label, int listIndex) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 35,
          child: Center(
            child: Text(label),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Divider(
                color: Colors.grey,
              ),
              _buildHorizontalListView(listIndex),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalListView(int listIndex) {
    final startIndex = listIndex * itemCount;
    final endIndex = startIndex + itemCount;
    final peopleSubset = _people.sublist(startIndex, endIndex);

    return Container(
      height: 95, // Đặt chiều cao cố định cho từng ListView ngang
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final customer = peopleSubset[index];
          return _buildPersonWithDropZone(customer, index, listIndex);
        },
      ),
    );
  }

  Widget _buildPersonWithDropZone(Customer customer, int index, int listIndex) {
    final hasItems = customer.items.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: DragTarget<Item>(
            builder: (context, candidateItems, rejectedItems) {
              final highlighted = !hasItems && candidateItems.isNotEmpty;
              return Stack(
                children: [
                  CustomerCart(
                    hasItems: hasItems,
                    highlighted: highlighted,
                    customer: customer,
                  ),
                  if (hasItems)
                    Positioned(
                      top: -13,
                      right: -14,
                      child: IconButton(
                        icon: Icon(
                          Icons.info_rounded,
                          size: 25,
                          color: Get.isDarkMode ? whiteColor : darkColor,
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                            backgroundColor:
                                Get.isDarkMode ? darkColor : whiteColor,
                            barrierDismissible: false,
                            title: "Information",
                            titleStyle: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            content: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 5),
                              child: Column(
                                children: [
                                  Container(
                                      height: 150,
                                      width: 150,
                                      child: Center(
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  image: AssetImage(customer
                                                      .items.first.url))),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(customer.items.first.description),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: OutlinedButton(
                                            onPressed: () => Get.back(),
                                            child: const Text("Close")),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GradientButton(
                                          onPressed: () {
                                            _removeItemFromCustomerCart(
                                                customer,
                                                customer.items.first,
                                                listIndex);

                                            Get.back();
                                          },
                                          widget: const Text("Delete"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
            onAccept: (item) {
              if (!hasItems) {
                _itemDroppedOnCustomerCart(
                    item: item, customer: customer, listIndex: listIndex);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return Obx(() => SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: visualizationController.selectedValueType.value ==
                        "Probabilities"
                    ? 100
                    : 1,
                interval: visualizationController.selectedValueType.value ==
                        "Probabilities"
                    ? 10
                    : 0.1),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<ChartData, String>>[
              BarSeries<ChartData, String>(
                  dataSource: visualizationController.data.cast<ChartData>(),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: visualizationController.selectedValueType.value ==
                          "Probabilities"
                      ? const Color.fromRGBO(8, 142, 255, 1)
                      : const Color.fromRGBO(187, 49, 72, 1))
            ]));
  }

  void _removeItemFromCustomerCart(
      Customer customer, Item item, int listIndex) {
    setState(() {
      if (customer.items.isNotEmpty) {
        visualizationController.rowGate
            .cast<ThreeValue>()
            .removeWhere((element) => element.getValue3 == listIndex);
        customer.items.remove(item);
      }
    });
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  SectionHeaderDelegate();

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Get.isDarkMode ? darkColor : whiteColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      width: Get.width - 40,
      child: _buildMenuList(),
    );
  }

  Widget _buildMenuList() {
    return Row(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _items.map((item) => _buildMenuItem(item: item)).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Operations",
            style: Get.textTheme.bodyLarge,
          ),
        )
      ],
    );
  }

  Widget _buildMenuItem({
    required Item item,
  }) {
    return LongPressDraggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoProvider: item.imageProvider,
      ),
      child: MenuListItem(
        photoProvider: item.imageProvider,
      ),
    );
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class CustomerCart extends StatefulWidget {
  const CustomerCart({
    super.key,
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Customer customer;
  final bool highlighted;
  final bool hasItems;

  @override
  State<CustomerCart> createState() => _CustomerCartState();
}

class _CustomerCartState extends State<CustomerCart> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: widget.highlighted ? 1.075 : 0.9,
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.highlighted ? Colors.grey : Colors.transparent,
          ),
          child: Visibility(
            visible: widget.hasItems,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: Column(
              children: [
                // Hiển thị món ăn được kéo vào
                ...widget.customer.items.map((item) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12), // Đặt giá trị để bo tròn ảnh
                    child: Image(
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      image: item.imageProvider,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ));
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  });

  final String name;
  final String price;
  final ImageProvider photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  height: isDepressed ? 90 : 100,
                  width: isDepressed ? 90 : 100,
                  child: Image(
                    image: photoProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 80,
          width: 80,
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image: photoProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class Item {
  const Item({
    required this.uid,
    required this.name,
    required this.url,
    required this.imageProvider,
    required this.description,
  });
  final int uid;
  final String name;
  final String url;
  final ImageProvider imageProvider;
  final String description;
}

class Customer {
  Customer({
    List<Item>? items,
  }) : items = items ?? [];

  final List<Item> items;
}
