import 'package:flutter/material.dart';
import 'package:my_pharmacy/widget/app_drawer.dart';

class Tips extends StatelessWidget {
  List<String> tips = [
    'Don\’t drink sugar calories',
    'Eat nuts',
    'Avoid processed junk food (eat real food instead)',
    'Don\’t fear coffee',
    'Eat fatty fish',
    'Get enough sleep',
    'Take care of your gut health with probiotics and fiber',
    'Drink some water, especially before meals',
    'Don\’t overcook or burn your meat',
    'Avoid bright lights before sleep',
    'Take vitamin D3 if you don\’t get much sun exposure',
    'Eat vegetables and fruits',
    'Make sure to eat enough protein',
    'Do some cardio',
    'Don\’t smoke or do drugs, and only drink in moderation',
    'Use extra virgin olive oil',
    'Minimize your sugar intake',
    'Don\’t eat a lot of refined carbs',
    'Don\’t fear saturated fat',
    'Lift heavy things',
    'Avoid artificial trans fats',
    'Use plenty of herbs and spices',
    'Take care of your relationships',
    'Track your food intake every now and then',
    'If you have excess belly fat, get rid of it',
    'Don’t go on a diet',
    'Eat eggs, yolk and all',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PhramAppDrawer(),
      appBar: AppBar(
        title: Text('Drugs List'),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  child: ListTile(
                    title: Text(tips[index],),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red,
                      child: Text('${index + 1}',style: TextStyle(fontSize: 24),),
                    ),
                  ),
                ),
              );
            },
            itemCount: tips.length,
          )),
    );
  }
}
