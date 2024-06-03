import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:recipe/basedata/basedata.dart';
import 'package:recipe/mystate/counter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:recipe/widgets/mycards.dart';
import 'package:recipe/widgets/mytext.dart';

import '../mystate/cart_store.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Counter counter = Counter();
  Basedata basedata = Basedata();



  @override
  Widget build(BuildContext context) {

    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: MyTextView(
          data: 'Home',
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/cartpage');
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: badges.Badge(
                badgeContent: Observer(builder: (_)=>MyTextView(data: '${cartStore.cartItems.length}',color: Colors.white,),),
                child: const Icon(Icons.shopping_cart_outlined,color: Colors.white,),
              ),
            ),
          )
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: basedata.recipes.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryContainer(title: basedata.recipes[index]);
          }
      ),
    );
  }
}
