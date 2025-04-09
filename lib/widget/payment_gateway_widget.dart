import 'dart:async';
import 'package:flutter/material.dart';

class PaymentGatewayWidget extends StatefulWidget {
  final int amount;
  final Function onPaymentComplete;

  const PaymentGatewayWidget({
    Key? key,
    required this.amount,
    required this.onPaymentComplete,
  }) : super(key: key);

  @override
  _PaymentGatewayWidgetState createState() => _PaymentGatewayWidgetState();
}

class _PaymentGatewayWidgetState extends State<PaymentGatewayWidget> {
  int _currentStep = 0;
  bool _isProcessing = false;
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  String _cardHolderName = '';
  String _selectedPaymentMethod = 'credit_card';

  final _formKey = GlobalKey<FormState>();

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isProcessing = true;
      });

      // Simulate payment processing delay
      Timer(Duration(seconds: 2), () {
        setState(() {
          _currentStep = 1;
          _isProcessing = false;
        });

        // Simulate payment verification
        Timer(Duration(seconds: 1), () {
          setState(() {
            _currentStep = 2;
          });

          // Simulate payment completion
          Timer(Duration(seconds: 1), () {
            Navigator.of(context).pop();
            widget.onPaymentComplete();
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Payment header
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Secure Payment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Amount: ₹${widget.amount}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Payment progress indicator
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepIndicator(0, 'Payment'),
              _buildStepConnector(_currentStep >= 1),
              _buildStepIndicator(1, 'Verification'),
              _buildStepConnector(_currentStep >= 2),
              _buildStepIndicator(2, 'Confirmation'),
            ],
          ),
        ),

        // Payment form
        Expanded(
          child: _currentStep == 0 ? _buildPaymentForm() : _buildProcessingView(),
        ),
      ],
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    bool isCompleted = _currentStep > step;
    bool isCurrent = _currentStep == step;

    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : (isCurrent ? Colors.purple : Colors.grey.shade700),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
              '${step + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isCurrent ? Colors.white : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? Colors.green : Colors.grey.shade700,
      margin: EdgeInsets.symmetric(horizontal: 5),
    );
  }

  Widget _buildPaymentForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method Selection
            Text(
              'Select Payment Method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                _buildPaymentMethodItem(
                  'credit_card',
                  'Credit Card',
                  Icons.credit_card,
                ),
                SizedBox(width: 15),
                _buildPaymentMethodItem(
                  'upi',
                  'UPI',
                  Icons.account_balance,
                ),
                SizedBox(width: 15),
                _buildPaymentMethodItem(
                  'net_banking',
                  'Net Banking',
                  Icons.language,
                ),
              ],
            ),
            SizedBox(height: 25),

            // Credit Card Details (show only if credit card is selected)
            if (_selectedPaymentMethod == 'credit_card') ...[
              // Card Number
              Text(
                'Card Number',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '1234 5678 9012 3456',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Colors.grey,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cardNumber = value!;
                },
              ),
              SizedBox(height: 15),

              // Card Holder Name
              Text(
                'Card Holder Name',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'John Doe',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card holder name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cardHolderName = value!;
                },
              ),
              SizedBox(height: 15),

              // Expiry Date and CVV
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey.shade800,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _expiryDate = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '123',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey.shade800,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _cvv = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

            // UPI Details (show only if UPI is selected)
            if (_selectedPaymentMethod == 'upi') ...[
              Text(
                'UPI ID',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 5),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'yourname@upi',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.account_balance,
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter UPI ID';
                  }
                  return null;
                },
              ),
            ],

            // Net Banking Details (show only if Net Banking is selected)
            if (_selectedPaymentMethod == 'net_banking') ...[
              Text(
                'Select Bank',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: 'SBI',
                    dropdownColor: Colors.grey.shade800,
                    style: TextStyle(color: Colors.white),
                    items: ['SBI', 'HDFC', 'ICICI', 'Axis', 'PNB']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ),
              ),
            ],

            SizedBox(height: 25),

            // Save Card option
            if (_selectedPaymentMethod == 'credit_card')
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    fillColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  Text(
                    'Save card for future payments',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),

            SizedBox(height: 25),

            // Payment Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _processPayment,
              child: Text(
                'Pay ₹${widget.amount}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 15),

            // Security Note
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Payments are secure and encrypted',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(String value, String label, IconData icon) {
    bool isSelected = _selectedPaymentMethod == value;

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPaymentMethod = value;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple.withOpacity(0.2) : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.purple : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.purple : Colors.grey,
              ),
              SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingView() {
    String statusText = '';
    Widget statusIcon;

    switch (_currentStep) {
      case 1:
        statusText = 'Verifying payment...';
        statusIcon = CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
        );
        break;
      case 2:
        statusText = 'Payment confirmed!';
        statusIcon = Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 50,
        );
        break;
      default:
        statusText = 'Processing payment...';
        statusIcon = CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
        );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          statusIcon,
          SizedBox(height: 20),
          Text(
            statusText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          if (_currentStep == 0) ...[
            SizedBox(height: 10),
            Text(
              'Please do not close this window',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}