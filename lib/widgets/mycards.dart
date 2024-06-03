import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/basedata/basedata.dart';
import 'package:recipe/basedata/formatter.dart';
import 'package:recipe/db/products.dart';
import 'package:recipe/pages/recipespage.dart';
import 'package:recipe/widgets/mytext.dart';

import '../mystate/cart_store.dart';
class CategoryContainer extends StatefulWidget {
  String title;
  CategoryContainer({required this.title,super.key});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
  ];

  Color randomColor = Colors.white;

  void getRandomColor() {
    final Random random = Random();
    final int index = random.nextInt(colors.length);
    setState(() {
      randomColor = colors[index];
    });
  }

  @override
  void initState() {
    getRandomColor();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Recipespage(recipe: widget.title)));
      },
      child: Card(
        color: randomColor,
        child: Center(child: MyTextView(data: widget.title,color: Colors.white,fontsize: 15,fontWeight: FontWeight.bold,)),
      ),
    );
  }
}

//recipe list

class RecipeCards extends StatefulWidget {
  Product recipe;
  RecipeCards({required this.recipe,super.key});

  @override
  State<RecipeCards> createState() => _RecipeCardsState();
}

class _RecipeCardsState extends State<RecipeCards> {
  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    return Stack(
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    widget.recipe.image,
                  ),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Basedata.basecolor.withOpacity(0.45),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Center(child: MyTextView(data: widget.recipe.title,fontWeight: FontWeight.bold,fontsize: 15,color: Colors.white,maxlines: 2,)),
                      Center(child: MyTextView(data: "Ksh ${MyFormatter.formatNumber(widget.recipe.price.toString())}",fontWeight: FontWeight.bold,fontsize: 15,color: Colors.white,maxlines: 2,))
                    ],
                  )
              )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FloatingActionButton(
            heroTag: "${widget.recipe.thid}",
            onPressed: (){
              cartStore.addToCart(widget.recipe);
            },
            child: const Icon(Icons.add_shopping_cart_sharp),
          ),
        )
      ],
    );
  }
}


class EmptyDataWidget extends StatelessWidget {
  final String message;

  EmptyDataWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}