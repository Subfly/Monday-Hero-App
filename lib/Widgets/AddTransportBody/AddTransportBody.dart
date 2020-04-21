import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_screen_app/Themes/AppColors.dart';
import 'package:one_screen_app/Utils/StringUtils.dart';

class TransportInBody extends StatefulWidget {
  @override
  _TransportInBodyState createState() => _TransportInBodyState();
}

class _TransportInBodyState extends State<TransportInBody> {
  String _selectedProvince;
  String _selectedFrom;
  String _selectedTo;
  String _selectedTime;
  String _selectedVehicle;
  Map<String, List<String>> data;
  Map<String, List<String>> dataFromJson(String str) =>
      Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, List<String>>(
          k,
          List<String>.from(
            v.map((x) => x),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DefaultAssetBundle.of(context)
          .loadString("data/province_and_state.json")
          .asStream(),
      builder: (context, snapshot) {
        if (!(snapshot.connectionState == ConnectionState.waiting)) {
          data = dataFromJson(snapshot.data);
          List<String> _provinceData = [];
          List<String> _stateData = [];
          _provinceData.addAll(data.keys);
          if (_selectedProvince != null) {
            _stateData.addAll(data[_selectedProvince]);
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      value: _selectedProvince,
                      hint: Text(
                        SELECT_PROVINCE,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      items: _provinceData
                          .map(
                            (label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedProvince = val;
                          _selectedFrom = null;
                          _selectedTo = null;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: ImageIcon(
                          AssetImage("assets/icons/home.png"),
                          color: ACCENT_COLOR,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      value: _selectedFrom,
                      hint: Text(
                        SELECT_FROM,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      items: _stateData
                          .map(
                            (label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedFrom = val;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: ImageIcon(
                          AssetImage("assets/icons/whereFrom.png"),
                          color: ACCENT_COLOR,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      value: _selectedTo,
                      hint: Text(
                        SELECT_TO,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      items: _stateData
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedTo = val;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: ImageIcon(
                          AssetImage("assets/icons/where.png"),
                          color: ACCENT_COLOR,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      readOnly: true,
                      onTap: () {
                        final _firstDate = DateTime.now();
                        showDatePicker(
                          initialDatePickerMode: DatePickerMode.day,
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: _firstDate,
                          lastDate: DateTime(2030),
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                              primaryColor: PRIMARY_COLOR,
                              accentColor: ACCENT_COLOR,
                            ),
                            child: child,
                          ),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              _selectedTime = value.toIso8601String();
                            });
                          }
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black54,
                          ),
                        ),
                        prefixIcon: ImageIcon(
                          AssetImage("assets/icons/calender.png"),
                          color: ACCENT_COLOR,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: _selectedTime == null
                            ? SELECT_DATE
                            : DateFormat("dd MMMM yyyy").format(
                                DateTime.parse(_selectedTime),
                              ),
                        hintStyle: TextStyle(
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      hint: Text(
                        SELECT_VEHICLE,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      items: [
                        SELECT_VEHICLE,
                        "Araba",
                        "Taksi",
                        "Otobüs",
                        "Metro",
                      ]
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (val) {
                        _selectedVehicle = val;
                      },
                      decoration: InputDecoration(
                        prefixIcon: ImageIcon(
                          AssetImage("assets/icons/car.png"),
                          color: ACCENT_COLOR,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: ACCENT_COLOR,
                        ),
                        label: Text(
                          ADD_NEW_TRANSPORT,
                          style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                splashColor: ACCENT_COLOR,
                minWidth: MediaQuery.of(context).size.width,
                height: 56 * MediaQuery.of(context).size.height / 667,
                child: Text(
                  ADD_TRANSPORTATION_BUTTON,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                color: ACCENT_COLOR,
                onPressed: () {
                  if (Platform.isAndroid) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => AlertDialog(
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Tamam",
                              style: TextStyle(
                                color: ACCENT_COLOR,
                              ),
                            ),
                          ),
                        ],
                        title: Text(ACCEPT_DIALOG_TITLE),
                        content: Text(
                          "Seçilen İl: ${_selectedProvince == null ? "Seçilmedi" : _selectedProvince}\nNereden: ${_selectedFrom == null ? "Seçilmedi" : _selectedFrom}\nNereye: ${_selectedTo == null ? "Seçilmedi" : _selectedTo}\nSeçilen Tarih: ${_selectedTime == null ? "Seçilmedi" : DateFormat("dd MMMM yyyy").format(DateTime.parse(_selectedTime))}\nSeçilen Araç: ${_selectedVehicle == null ? "Seçilmedi" : _selectedVehicle}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Tamam"),
                          ),
                        ],
                        content: Text(
                          "Seçilen İl: ${_selectedProvince == null ? "Seçilmedi" : _selectedProvince}\nNereden: ${_selectedFrom == null ? "Seçilmedi" : _selectedFrom}\nNereye: ${_selectedTo == null ? "Seçilmedi" : _selectedTo}\nSeçilen Tarih: ${_selectedTime == null ? "Seçilmedi" : DateFormat("dd MMMM yyyy").format(DateTime.parse(_selectedTime))}\nSeçilen Araç: ${_selectedVehicle == null ? "Seçilmedi" : _selectedVehicle}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}

class TransportOutBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("This page is intentioanlly left blank."),
    );
  }
}
