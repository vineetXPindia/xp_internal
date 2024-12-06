import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

Widget configureCustomDropDown(double screenWidth, List<String> lookupNames,
    String hintText, void Function(String) onSelect) {
  return DropdownSearch<String>(
    // selectedItem: selectedCustomer,
    items: (String filter, LoadProps? loadProps) async {
      // Here you can filter the customers based on the input
      return lookupNames
          .where((customer) =>
              customer.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    },
    onChanged: (value) {
      onSelect(value.toString());
      // setState(() {
      //   selectedCustomer = value;
      // });
    },
    popupProps: PopupProps.menu(
      menuProps: MenuProps(
        margin: EdgeInsets.only(top: -55),
        backgroundColor: Colors.white,
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      fit: FlexFit.tight,
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
        ),
      ),
    ),
    decoratorProps: DropDownDecoratorProps(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            screenWidth * 0.04,
          ),
        ),
      ),
    ),
  );
}

Widget originDestinationDropdown(
  double screenWidth,
  List<String> lookupNames,
  String hintText,
  void Function(String) onSelect,
  void Function(String) onTextChanged,
) {
  return DropdownSearch<String>(
    // selectedItem: selectedCustomer,
    items: (String filter, LoadProps? loadProps) async {
      // Here you can filter the customers based on the input
      return lookupNames
          .where((value) => value.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    },
    onChanged: (value) {
      onSelect(value.toString());
      // setState(() {
      //   selectedCustomer = value;
      // });
    },
    popupProps: PopupProps.menu(
      menuProps: MenuProps(
        margin: EdgeInsets.only(top: -55),
        backgroundColor: Colors.white,
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      fit: FlexFit.tight,
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        onChanged: (value) {
          onTextChanged(value); // Call the text change callback
        },
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
        ),
      ),
    ),
    decoratorProps: DropDownDecoratorProps(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            screenWidth * 0.04,
          ),
        ),
      ),
    ),
  );
}

Widget buildDropdown(double screenHeight, double screenWidth,
    List<String> dataList, IconData iconData, String hint) {
  return Row(
    children: [
      Icon(iconData),
      SizedBox(
        width: screenWidth * 0.025,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        child: DropdownMenu<String>(
          menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all(
                Colors.white), // Dropdown menu background color
            padding: MaterialStateProperty.all(
              EdgeInsets.only(top: -screenHeight * 0.1),
            ),
          ),
          width: screenWidth * 0.825,
          menuHeight: 200,
          // controller: controller,
          dropdownMenuEntries: dataList
              .map((e) => DropdownMenuEntry(value: e, label: e))
              .toList(),
          onSelected: (value) {},
          enabled: true,
          enableSearch: true,
          hintText: hint,
          enableFilter: true,
          requestFocusOnTap: true,
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none, // Removes the outline
            enabledBorder: InputBorder.none, // Removes the border when enabled
            focusedBorder: InputBorder.none, // Removes the border when focused
            contentPadding: EdgeInsets.only(left: screenWidth * 0.03),
          ),
        ),
      ),
    ],
  );
}
// Widget dateSelector(double screenHeight, double screenWidth){
//   return Row(
//     children: [
//       Icon(Icons.calendar_month_rounded),
//       SizedBox(
//         width: screenWidth * 0.02,
//       ),
//       Expanded(
//         child: GestureDetector(
//           onTap: () {
//             _selectDate(context);
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.01),
//             child: AbsorbPointer(
//               child: TextField(
//                 controller: _dateController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.circular(screenWidth * 0.05),
//                     borderSide: BorderSide.none,
//                   ),
//                   hintText: 'Select Date',
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
