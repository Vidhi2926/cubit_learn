import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'Logic/myorder_cubit.dart';
import 'Logic/myorder_state.dart';
import 'filter_screen.dart';

class MyOrderScreen extends StatefulWidget {
  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MyorderCubit>().fetchOrders();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<MyorderCubit>().fetchOrders();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilterScreen(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FilterScreen(
          onApply: (billNo, orderNo, orderStatus) {
            BlocProvider.of<MyorderCubit>(context).applyFilter(
              billNo: billNo ?? '',
            );
          },
        );
      },
    );
  }

  Future<void> _checkInternetAndProceed(VoidCallback onSuccess) async {
    final hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No internet connection.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      onSuccess();
    }
  }

  Widget _buildNoDataScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Colors.grey, size: 40),
          SizedBox(height: 20),
          Text(
            'Waiting for your first order',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0039a6),
        title: Text('My Orders', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.of(context).popUntil((route) {
              return route.settings.name == '/login'; // Adjust as needed
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterScreen(context),
          ),
        ],
      ),
      body: BlocBuilder<MyorderCubit, MyorderState>(
        builder: (context, state) {
          if (state is MyorderLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is MyorderLoaded) {
            if (state.orders.isEmpty) {
              return _buildNoDataScreen();
            }

            bool showLoadingIndicator = !state.hasReachedMax;

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!state.hasReachedMax &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  _checkInternetAndProceed(() {
                    context.read<MyorderCubit>().fetchOrders();
                  });
                }
                return false;
              },
              child: ListView.separated(
                controller: _scrollController,
                itemCount: state.orders.length + (showLoadingIndicator ? 1 : 0),
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  if (index >= state.orders.length) {
                    return showLoadingIndicator
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox.shrink();
                  }

                  final order = state.orders[index];
                  Map<String, Color> statusColors = {
                    'Rejected by Customer': Colors.red,
                    'Assigned to Pharmacy': Colors.deepPurple,
                    'Order Confirmed': Colors.blue,
                    'Invoiced': Colors.blueAccent,
                    'Completed': Colors.blueGrey,
                  };

                  Map<String, IconData> statusIcons = {
                    'Rejected by Customer': Icons.cancel,
                    'Assigned to Pharmacy': Icons.hourglass_bottom,
                    'Order Confirmed': Icons.shopping_bag,
                    'Invoiced': Icons.local_shipping,
                    'Completed': Icons.done,
                  };

                  Color containerColor = statusColors[order
                      .orderStatusDisplayText] ?? Colors.grey;
                  IconData iconData = statusIcons[order
                      .orderStatusDisplayText] ?? Icons.help;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bill No. ${order.billNo}', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(order.createdDate, style: TextStyle(
                                fontSize: 14, color: Colors.grey[600])),
                            IntrinsicWidth(
                              child: IntrinsicHeight(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(iconData, color: Colors.white,size: 12,),
                                      SizedBox(width: 8.0),
                                      Text(order.orderStatusDisplayText,
                                          style: TextStyle(color: Colors.white,fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text('Amount: ${order.amount}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          if (state is MyorderError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
