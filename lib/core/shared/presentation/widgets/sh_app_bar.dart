import 'package:flutter/material.dart';
import 'package:smart_home/core/theme/sh_icons.dart';

class ShAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onOpenDrawer;

  const ShAppBar({required this.onOpenDrawer});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Hero(
        tag: "app-bar-icon-1",
        child: Material(
          type: MaterialType.transparency,
          child: IconButton(
            onPressed: onOpenDrawer,
            icon:  const Icon(SHIcons.menu),
          ),
        ),
      ),
      actions: [
        Hero(
          tag: "app-bar-icon-2",
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearch());
              },
              icon:  const Icon(SHIcons.search),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize =>  const Size(double.infinity, kToolbarHeight);
}

class CustomSearch extends SearchDelegate{

  List? Room = [
    "kitchen","bedroom","livingroom"
  ] ;
  List? filtreRoom ;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){query="";}, icon: Icon(SHIcons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(onPressed: (){close(context, null);}, icon: Icon(SHIcons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("result $query",style: TextStyle(fontSize: 14,color: Colors.black));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query==""){return ListView.builder(
        itemCount: Room!.length,
        itemBuilder:(context,i){
          return InkWell(onTap: (){
            showResults(context);
          },
            child: Card(
              child:Padding( padding:const EdgeInsets.all(16),
                  child: Text("${Room![i]}",style: TextStyle(fontSize: 14,color: Colors.black),)),
            ),);
        });
    }else{
      filtreRoom = Room!.where((element)=>element.contains(query)).toList();
      return ListView.builder(
          itemCount: filtreRoom!.length,
          itemBuilder:(context,i){
            return InkWell(onTap: (){
              showResults(context);
            },
              child: Card(
                child:Padding( padding:const EdgeInsets.all(16),
                    child: Text("${filtreRoom![i]}",style: TextStyle(fontSize: 14,color: Colors.black),)),
              ),);
          });
    }
  }

}