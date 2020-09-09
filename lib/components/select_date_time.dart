import 'package:estagio_app/components/button.dart';
import 'package:estagio_app/utils/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDateTime extends StatefulWidget {
  final Function _dateTimeSelected;
  final DateTime initialDate;

  SelectDateTime(this._dateTimeSelected, {this.initialDate});

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  var _nameController = new TextEditingController();
  final DateUtils dateUtils = new DateUtils();
  var _selectedDate = DateTime.now();
  var _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 50,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDateField(),
              _buildTimeField(),
              _buildNameField(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTimeField() {
    return GestureDetector(
      onTap: () => _selectTime(),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 225,
        height: 45,
        alignment: Alignment.center,
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              _selectedTimeFormatted(),
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }

  _buildDateField() {
    return GestureDetector(
      onTap: () => _selectDate(),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 225,
        height: 45,
        alignment: Alignment.center,
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              dateUtils.formatDate("dd/MM/yyyy", _selectedDate.toString()),
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }

  _buildNameField() {
    return Container(
      width: 225,
      height: 45,
      child: TextField(
        controller: _nameController,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            hintText: "Nome",
            hintStyle: TextStyle(
              height: .9,
              color: Colors.grey,
            )),
      ),
    );
  }

  _selectDate() async {
    print(widget.initialDate);
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale("pt", "BR"),
      initialDate: widget.initialDate != null ? widget.initialDate : _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.secondary,
            accentColor: Theme.of(context).colorScheme.secondary,
            colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.secondary),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  _selectTime() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  _selectedTimeFormatted() {
    var date = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    return dateUtils.formatDate("HH:mm", date.toString());
  }

  _buildButtons() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Button(
            Text("Cancelar"),
            () => Navigator.pop(context),
            primary: false,
          ),
          SizedBox(
            width: 20,
          ),
          Button(
            Text("Salvar"),
            () => widget._dateTimeSelected(_selectedDate, _selectedTime, _nameController.text),
            primary: true,
          ),
        ],
      ),
    );
  }
}
