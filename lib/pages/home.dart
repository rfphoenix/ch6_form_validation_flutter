import 'package:flutter/material.dart';
import 'package:starter_project/models/orders.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  Order _order = Order();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Espresso', labelText: 'Item'),
                    validator: (value) => _validateItemRequired(value),
                    onSaved: (value) => _order.item = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '3',
                      labelText: 'Quantity',
                    ),
                    validator: (value) => _validateItemCount(value),
                    onSaved: (newValue) =>
                        _order.quantity = int.tryParse(newValue),
                  ),
                  Divider(
                    height: 32.0,
                  ),
                  RaisedButton(
                    onPressed: () => _submitOrder(),
                    child: Text('Save'),
                    color: Colors.lightGreen,
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  String _validateItemRequired(String value) {
    return value.isEmpty ? 'Item Required' : null;
  }

  String _validateItemCount(String value) {
    int _valueAsInteger = value.isEmpty ? 0 : int.tryParse(value);
    return _valueAsInteger == 0 ? 'At least one Item is required' : null;
  }

  void _submitOrder() {
    if (_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();
      print('Order Item: ${_order.item}');
      print('Order Quantity: ${_order.quantity}');
    }
  }
}
