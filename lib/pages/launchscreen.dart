import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe/basedata/basedata.dart';
import 'package:recipe/basedata/dbAssistant.dart';
import 'package:recipe/db/products.dart';
import 'package:recipe/mystate/counter.dart';
import 'package:recipe/widgets/mytext.dart';
class Launchscreen extends StatefulWidget {
  const Launchscreen({super.key});

  @override
  State<Launchscreen> createState() => _LaunchscreenState();
}

class _LaunchscreenState extends State<Launchscreen> {
  Basedata basedata = Basedata();
  Counter counter = Counter();
  Dbassistant dbassistant = Dbassistant();
  SnackBar snackBar = const SnackBar(
    content: Text('Problem Internent or With Api Endpoint'),
  );
  fetchdata()async{
    for(int i = 0;i<basedata.recipes.length;i++){
      String recipe = basedata.recipes[i];
      counter.adjust("Setting Up $recipe");
      var data = await basedata.getData("complexSearch/","query=$recipe");
      if(data['results'] != false){
        for(int z = 0;z<data['results'].length;z++){
          var dt = data['results'][z];
          await dbassistant.addproduct(dt['title'], recipe, dt['image'], dt['id']);
        }
      }else{
        failedconnect();
        break;
      }

      if(i == (basedata.recipes.length -1)){
        navigate();
      }
    }
  }

  failedconnect(){
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    navigate();
  }
  navigate(){
    Navigator.pushReplacementNamed(context, '/home');
  }
  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(builder: (_)=>MyTextView(data: counter.value)),
          Center(
            child: LoadingAnimationWidget.dotsTriangle(
              size: 150, color: Basedata.basecolor,
            ),
          )
        ],
      ),
    );
  }
}
