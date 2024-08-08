import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final void Function(String? billNo, String? orderNo, String? orderStatus) onApply;

  const FilterScreen({Key? key, required this.onApply}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedFamilyMember;
  String? selectedOrderStatus;
  final billController = TextEditingController();
  final orderController = TextEditingController();

  final List<String> familyMembers = ['All', 'Bhargav Dobariya', 'Durlabhbhai'];
  final List<String> orderStatuses = [
    'All', 'Pending', 'Confirmed', 'Completed', 'Shipped', 'Ready For Pickup', 'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.59,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 20),
                child: Text(
                  'Filters',
                  style: TextStyle(
                    color: Color(0xff0039a6),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(thickness: 0.7, color: Colors.grey),
              SizedBox(height: 5),
              TextFormField(
                controller: billController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87, width: 2),
                  ),
                  labelText: 'Bill Number',
                  labelStyle: TextStyle(
                    color: Color(0xff164175),
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: orderController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87, width: 2),
                  ),
                  labelText: 'Order Number',
                  labelStyle: TextStyle(color: Color(0xff164175), fontSize: 18),
                ),
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedFamilyMember,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87, width: 2),
                  ),
                  labelText: 'Family Member',
                  labelStyle: TextStyle(color: Color(0xff164175), fontSize: 18),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFamilyMember = newValue;
                  });
                },
                items: familyMembers.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedOrderStatus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87, width: 2),
                  ),
                  labelText: 'Order Status',
                  labelStyle: TextStyle(color: Color(0xff164175), fontSize: 18),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOrderStatus = newValue;
                  });
                },
                items: orderStatuses.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          billController.clear();
                          orderController.clear();
                          selectedFamilyMember = null;
                          selectedOrderStatus = null;
                        });
                        widget.onApply(null, null, null); // Pass nulls to reset filters
                        Navigator.pop(context); // Pop the current screen
                      },
                      icon: Icon(Icons.refresh, color: Color(0xff164175)),
                      label: Text('Reset', style: TextStyle(color: Color(0xff164175))),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xff164175),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.black45),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.onApply(
                          billController.text.isNotEmpty ? billController.text : null,
                          orderController.text.isNotEmpty ? orderController.text : null,
                          selectedOrderStatus,
                        );
                        Navigator.pop(context); // Pop the current screen
                      },
                      icon: Icon(Icons.search, color: Colors.white),
                      label: Text('Apply', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff164175),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
