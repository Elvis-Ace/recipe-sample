import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:recipe/basedata/basedata.dart';
import 'package:recipe/basedata/formatter.dart';
import 'package:recipe/widgets/buttton.dart';
import 'package:recipe/widgets/mytext.dart';

import '../mystate/cart_store.dart';
import '../widgets/mycards.dart';
import '../widgets/panels.dart';
class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  late ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  double minBound = 0;

  double upperBound = 1.0;

  Basedata basedata = Basedata();

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
          scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Observer(builder: (_)=>MyTextView(data: "(${cartStore.cartItems.length}) Items in Cart",color: Colors.white,),),centerTitle: true,),
          body:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Observer(builder: (_)=>cartStore.cartItems.isEmpty?EmptyDataWidget(message: 'No data available'):ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        cartStore.cartItems[index].image,
                      ),
                      title: Text('${cartStore.cartItems[index].title}'),
                      subtitle: MyTextView(data: '${MyFormatter.formatNumber(cartStore.cartItems[index].price.toString())}',),
                      trailing: IconButton(onPressed: () {
                        cartStore.removeFromCart(cartStore.cartItems[index]);
                      }, icon: Icon(Icons.delete),color: Colors.red,),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: cartStore.cartItems.length,
              ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Observer(builder: (_)=>MyCustomButton(text: 'Buy Now (${cartStore.total})', action: ()async{
                  if(cartStore.cartItems.isEmpty){
                    EasyLoading.showError("No Data For Submission");
                  }else{
                    EasyLoading.show(status: "Placing Order Please Wait");
                    Map<String, dynamic> map = { };
                    for (var product in cartStore.cartItems) {
                      map['id'] = product.id;
                    }
                    var response = await basedata.postData('https://matatu.titan.africa/api/dummy', map);
                    if(response['success']){
                      cartStore.removeAll();
                      EasyLoading.showSuccess("Your Order has been submited  Successfully",duration: Duration(milliseconds: 4000));
                      Future.delayed(Duration(milliseconds: 5000),(){
                        Navigator.pop(context);
                      });
                    }
                  }
                })),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
        MyPanel(scrollController: scrollController, panelController: panelController),

      ],
    );
  }
}
