import "package:flutter/material.dart";

void main() => runApp(MainApp());


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      title: 'Simple Interest Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: SimpleInterestForm()
      ),
    );
  }
}

class SimpleInterestForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterestFormState();
  }
}

class _SimpleInterestFormState extends State<SimpleInterestForm> {
  var _currencies = ['Rupees', 'Dollar', 'Euro', 'Pound', 'Others'];
  var _selectedCurrency = '';
  var _displaySimpleInterestResult = '';
  final double _minimumPadding = 10.0;

  @override
  void initState() {
    super.initState();
    _selectedCurrency = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
            child: TextField(
              controller: principalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter the principal value',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
            child: TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Rate of the interest',
                hintText: 'In percentage (%)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            )
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: timeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    hintText: 'Time in years',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),
              Container(width: 5 * _minimumPadding,),
              Expanded(
                child:DropdownButton<String>(
                  items: _currencies.map((currency) {
                    return DropdownMenuItem<String> (
                      value: currency,
                      child: Text(currency)
                    );
                  }).toList(),
                  value: _selectedCurrency,
                  onChanged: (newValueSelected) {
                    _onDropdownItemSelected(newValueSelected);
                  },
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: _minimumPadding),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    elevation: 5.0,
                    child: Text("Calculate"),
                    onPressed: () {
                      setState(() {
                      _displaySimpleInterestResult = _calculatePressedAndReturnResult();
                      });
                    },
                  ),
                ),
                Container(width: 2 * _minimumPadding),
                Expanded(
                  child: RaisedButton(
                    elevation: 5.0,
                    child: Text("Reset"),
                    onPressed: () {
                      _reset();
                    },
                  ),
                )
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.all(_minimumPadding),
            child: Text(_displaySimpleInterestResult),
          )
        ],
      ),
    );
  }

  void _onDropdownItemSelected(selectedValue) {
    setState(() {
      _selectedCurrency = selectedValue;
    });
  }

  String _calculatePressedAndReturnResult() {
    double p = double.parse(principalController.text);
    double r = double.parse(rateController.text);
    double t = double.parse(timeController.text);
    double simpleInterest = (p*t*r)/100;

    return 'After $t years, your investment will be worth $simpleInterest $_selectedCurrency';
  }

  void _reset() {
    setState(() {
      principalController.text = '';
      rateController.text = '';
      timeController.text = '';
      _selectedCurrency = 'Rupees';
      _displaySimpleInterestResult = '';
    });
  }

}

