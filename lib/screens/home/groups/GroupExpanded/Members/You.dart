import 'package:flutter/material.dart';

class YouInGroup extends StatefulWidget {
  var data;
  YouInGroup({required this.data});

  @override
  State<YouInGroup> createState() => _YouInGroupState();
}

class _YouInGroupState extends State<YouInGroup> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(wt * 0.03, ht * 0.01, wt * 0.03, 0),
      child: Container(
        padding: EdgeInsets.fromLTRB(wt * 0.05, 0, 0, 0),
        width: wt,
        height: ht * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.data['name'],
                style: TextStyle(fontSize: 20),
              ),
            ),
            Spacer(),
            widget.data['isAdmin']
                ? Padding(
                    padding: EdgeInsets.only(right: wt * 0.03),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "admin",
                          style: TextStyle(color: Colors.green),
                        )),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(right: wt * 0.0),
              child: widget.data['locEnabled']
                  ? Icon(Icons.location_on)
                  : Icon(Icons.location_off),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
