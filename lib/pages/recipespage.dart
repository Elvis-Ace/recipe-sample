import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:recipe/basedata/basedata.dart';
import 'package:recipe/basedata/dbAssistant.dart';
import 'package:recipe/db/products.dart';
import 'package:recipe/widgets/mycards.dart';
import 'package:recipe/widgets/mytext.dart';
import 'package:badges/badges.dart' as badges;

import '../mystate/cart_store.dart';
class Recipespage extends StatefulWidget {
  String recipe;
  Recipespage({required this.recipe,super.key});

  @override
  State<Recipespage> createState() => _RecipespageState();
}

class _RecipespageState extends State<Recipespage> {
  Basedata basedata = Basedata();
  Dbassistant dbassistant = Dbassistant();
  List<Product> recipes = [];
  bool loading = true;
  getrecipe()async{
    recipes = await dbassistant.products(widget.recipe);
    loading = false;
    setState(() {

    });
  }
  @override
  void initState() {
    getrecipe();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: MyTextView(data: widget.recipe,color: Colors.white,),
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
      body: loading?Center(
        child: LoadingAnimationWidget.dotsTriangle(
          size: 150, color: Basedata.basecolor,
        ),
      ):ListView.builder(itemCount:recipes.length,itemBuilder: (context,index)=>RecipeCards(recipe: recipes[index])),
    );
  }
}
