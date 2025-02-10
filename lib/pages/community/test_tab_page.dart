import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TestTabPage extends StatefulWidget {
  const TestTabPage({super.key});

  @override
  State<TestTabPage> createState() => _TestTabPageState();
}

class _TestTabPageState extends State<TestTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TestTabPage"),),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        //mainAxisSpacing: 4,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) => Container(
          height: 20.0*index,
          decoration: BoxDecoration(
            color: (index%2==1)?Colors.green:Colors.redAccent,
            border: Border.all(color: Colors.black),
          ),

          child: Center(
            child: Text('Item $index'),
          ),
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      ),
    );

  }
}
