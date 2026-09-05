import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Magazine",
      debugShowCheckedModeBanner: false,
      home: PageAccueil(),
    );
  }
}


class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magazine Infos"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),

        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu), onPressed: () {},
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.search),
              color: Colors.white,
          )],
      ),
      body: Center(
        child:  Image(
            image: AssetImage("assets/images/newspaper.jpg")
        ),

      ),
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text("Click", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

