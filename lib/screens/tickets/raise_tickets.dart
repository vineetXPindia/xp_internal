import 'package:flutter/material.dart';
import 'package:xp_internal/constants/colors.dart';
import '../home/home.dart';

class RaiseTickets extends StatelessWidget {
  RaiseTickets({super.key});

  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<List<bool>> selectedToggle = ValueNotifier([true, false]);
  final ValueNotifier<String?> selectedPanel = ValueNotifier(null);
  final ValueNotifier<String?> selectedSubPanel = ValueNotifier(null);

  int _countWords(String text) {
    return text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
  }

  String _trimToWordLimit(String text, int wordLimit) {
    List<String> words = text.trim().split(RegExp(r'\s+'));
    return words.take(wordLimit).join(' ');
  }

  final List<String> toggles = ['Raise Ticket', 'Raised Tickets'];
  final List<String> panels = ['Orders', 'Capacity', 'LoadBoard', 'Customers'];
  final List<String> subPanels = ['Sub1', 'Sub2', 'Sub3'];

  @override
  Widget build(BuildContext context) {
    final String title = 'Tickets';
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: newCardBG,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              SizedBox(height: screenHeight * 0.02),
              _buildToggleButtons(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.04),
              ValueListenableBuilder<List<bool>>(
                valueListenable: selectedToggle,
                builder: (context, value, child) {
                  return value[0]
                      ? _buildRaiseTicketForm(screenWidth, screenHeight)
                      : _buildRaisedTicketsList(screenWidth, screenHeight);
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Attach supporting image')],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    child: Text(
                      'Raise Ticket',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons(double screenWidth, double screenHeight) {
    return ValueListenableBuilder<List<bool>>(
      valueListenable: selectedToggle,
      builder: (context, value, child) {
        return ToggleButtons(
          onPressed: (int index) {
            selectedToggle.value = [index == 0, index == 1];
          },
          isSelected: value,
          fillColor: Colors.blue.shade900,
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          constraints: BoxConstraints(
            minWidth: screenWidth * 0.4,
            minHeight: screenHeight * 0.065,
          ),
          children: toggles
              .map((toggleText) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(toggleText,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildRaiseTicketForm(double screenWidth, double screenHeight) {
    return Column(
      children: [
        _buildTextField('Executive Name', screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),
        _buildDropdown('Select Panel', panels, selectedPanel.value,
            (String? newValue) {
          selectedPanel.value = newValue;
        }, screenWidth),
        SizedBox(height: screenHeight * 0.02),
        _buildDropdown(
          'Select Sub Panel',
          subPanels,
          selectedSubPanel.value,
          (String? newValue) {
            selectedSubPanel.value = newValue;
          },
          screenWidth,
        ),
        SizedBox(height: screenHeight * 0.02),
        _buildDescriptionField(screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }

  Widget _buildRaisedTicketsList(double screenWidth, double screenHeight) {
    return Column(
      children: List.generate(
        5,
        (index) => Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text('Ticket #$index'),
            subtitle: Text('Description of Ticket #$index'),
            trailing: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
    double screenWidth,
  ) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: ValueListenableBuilder<String?>(
        valueListenable: selectedPanel,
        builder: (context, value, child) {
          return DropdownButtonFormField<String>(
            value: selectedValue,
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDescriptionField(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: TextField(
        controller: _descriptionController,
        maxLines: 4,
        onChanged: (text) {
          if (_countWords(text) > 300) {
            _descriptionController.text = _trimToWordLimit(text, 300);
            _descriptionController.selection = TextSelection.fromPosition(
              TextPosition(offset: _descriptionController.text.length),
            );
          }
        },
        decoration: InputDecoration(
          hintText: 'Provide Description (max 300 words)',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
