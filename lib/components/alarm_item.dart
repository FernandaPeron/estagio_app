import 'package:estagio_app/entity/alarm_entity.dart';
import 'package:flutter/material.dart';

class AlarmItem extends StatefulWidget {
  final alarm;

  AlarmItem(this.alarm);

  @override
  _AlarmItemState createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                dateUtils.formatDate(
                    "HH:mm", dateUtils.timeOfDayToDate(widget.alarm.time).toString()),
                style: TextStyle(
                  fontSize: 24,
                  height: 2,
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    dateUtils.formatDate(
                        "d MMM, ", widget.alarm.date.toString()),
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    widget.alarm.description,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              )
            ],
          ),
          Switch(
            value: widget.alarm.enabled,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (value){
              setState(() {
                widget.alarm.enabled = value;
              });
            },
            activeTrackColor: Colors.white,
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
