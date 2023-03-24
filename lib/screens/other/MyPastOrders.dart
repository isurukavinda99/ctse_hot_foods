import 'package:flutter/material.dart';
import 'package:hot_foods/const/colors.dart';
import 'package:hot_foods/utils/Utill.dart';
import 'package:hot_foods/widgets/CustomNavBar.dart';

import '../../dao/CheckOutDoa.dart';
import '../../model/CheckOurModel.dart';
import '../../model/CheckOurModelView.dart';



class MyPastOrders extends StatefulWidget {
  static const routeName = "/myPastOrders";
  @override
  State<MyPastOrders> createState() => _MyPastOrdersState();
}

class _MyPastOrdersState extends State<MyPastOrders> {
  List<CheckOurModelView> _items = [];

  bool _isLoading = true;

  @override
  void initState() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final items = await CheckOutDao().chekOutList().first;
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading carts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "My Past Order",
                        style: Utill.getTheme(context).headline5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: AppColor.placeholderBg,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),

                    child: Container(
                      height: 300,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              physics: ClampingScrollPhysics(),
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                final rest = _items[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: MyPastOrderCard(
                                    date: rest.date,
                                    name: rest.items.toString(),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(),
          ),
        ],
      ),
    );
  }
}

class MyPastOrderCard extends StatelessWidget {
  const MyPastOrderCard({
    Key key,
    String name,
    String date,
    bool isLast = false,
  })  : _name = name,
        _date = date,
        _isLast = isLast,
        super(key: key);

  final String _name;
  final String _date;
  final bool _isLast;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: _isLast
              ? BorderSide.none
              : BorderSide(
                  color: AppColor.placeholder.withOpacity(0.25),
                ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${_name}",
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            "$_date",
            style: TextStyle(
              color: AppColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
