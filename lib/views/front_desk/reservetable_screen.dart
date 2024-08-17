import 'package:flutter/material.dart';
import 'package:restaurant_manager/components/named_date_input_field.dart';
import 'package:restaurant_manager/components/named_input_field.dart';
import 'package:restaurant_manager/components/action_button.dart';
import 'package:restaurant_manager/constants/colour_constants.dart'; // Assuming you have this

class ReserveTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Reserve Table 12'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reservation Details
              Text(
                'Reservation Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Flexible(
                    child: NamedDateInputField(
                      titleText: 'Date',
                      onPressed: () {
                        // Handle date selection
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: NamedInputField(
                      titleText: 'Time',
                      onChanged: (value) {
                        // Handle time input
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              NamedInputField(
                titleText: 'Number of customers',
                onChanged: (value) {
                  // Handle number of customers input
                },
              ),
              SizedBox(height: 30.0),
              // Customer Details
              Text(
                'Customer Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Flexible(
                    child: NamedInputField(
                      titleText: 'First Name',
                      onChanged: (value) {
                        // Handle first name input
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: NamedInputField(
                      titleText: 'Last Name',
                      onChanged: (value) {
                        // Handle last name input
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Flexible(
                    child: NamedInputField(
                      titleText: 'Phone number',
                      onChanged: (value) {
                        // Handle phone number input
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: NamedInputField(
                      titleText: 'Email',
                      onChanged: (value) {
                        // Handle email input
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Center(
                child: ActionButton(
                  btnText: 'Submit',
                  onTap: () {
                    // Handle form submission
                  },
                  width: 200.0,
                  height: 50.0,
                  btnColor: ColourConstants.gamboge, // Match button color to the design
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
