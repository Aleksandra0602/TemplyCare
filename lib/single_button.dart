import 'package:flutter/material.dart';
import 'package:temp_app_v1/screens/real_temperature_screen.dart';

class SingleButton extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  SingleButton(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx, String id){
    if(id == 'a1'){
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return RealTemperatureScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context, id),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
