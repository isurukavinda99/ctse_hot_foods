import 'package:flutter/material.dart';

class BurgerCard extends StatefulWidget {
  final String name;
  final String price;
  final VoidCallback onDelete;
  final ValueChanged<int> onQuantityChange;

  BurgerCard({
    Key key,
    this.name,
    this.price,
    this.onDelete,
    this.onQuantityChange,
  }) : super(key: key);

  @override
  _BurgerCardState createState() => _BurgerCardState();
}

class _BurgerCardState extends State<BurgerCard> {
  int _selectedQuantity = 1;

  void _incrementQuantity() {
    setState(() {
      _selectedQuantity++;
    });
    widget.onQuantityChange(_selectedQuantity);
  }

  void _decrementQuantity() {
    if (_selectedQuantity > 1) {
      setState(() {
        _selectedQuantity--;
      });
      widget.onQuantityChange(_selectedQuantity);
    }
  }

  void _handleQuantityChange(int value) {
    setState(() {
      _selectedQuantity = value;
    });
    widget.onQuantityChange(_selectedQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\Rs.${widget.price}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: TextButton(
                          onPressed: _incrementQuantity,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[400]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        _selectedQuantity.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: TextButton(
                          onPressed: _decrementQuantity,
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[400]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
