import 'package:flutter/material.dart';

import '../utils/contents.dart';

class OrderStatusView extends StatefulWidget {
  final String status;
  final Function(String) onStatusChanged;
  const OrderStatusView({Key? key, required this.status, required this.onStatusChanged}) : super(key: key);

  @override
  State<OrderStatusView> createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends State<OrderStatusView> {
  late String radioGroupStatusValue;
  @override
  void initState() {
    radioGroupStatusValue = widget.status;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Row(
            children: [
              Radio<String>(
                value: OrderStatus.pending,
                groupValue: radioGroupStatusValue,
                onChanged: (value) {
                  setState(() {
                    radioGroupStatusValue = value!;
                  });
                  widget.onStatusChanged(radioGroupStatusValue);
                },
              ),
              const Text(OrderStatus.pending)
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: OrderStatus.processing,
                groupValue: radioGroupStatusValue,
                onChanged: (value) {
                  setState(() {
                    radioGroupStatusValue = value!;
                  });
                  widget.onStatusChanged(radioGroupStatusValue);
                },
              ),
              const Text(OrderStatus.processing)
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: OrderStatus.delivered,
                groupValue: radioGroupStatusValue,
                onChanged: (value) {
                  setState(() {
                    radioGroupStatusValue = value!;
                  });
                  widget.onStatusChanged(radioGroupStatusValue);
                },
              ),
              const Text(OrderStatus.delivered)
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: OrderStatus.cancelled,
                groupValue: radioGroupStatusValue,
                onChanged: (value) {
                  setState(() {
                    radioGroupStatusValue = value!;
                  });
                  widget.onStatusChanged(radioGroupStatusValue);
                },
              ),
              const Text(OrderStatus.cancelled)
            ],
          ),
        ],
      ),
    );
  }
}
