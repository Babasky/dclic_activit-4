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

class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bienvenue au Magazine Infos",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),

          const Text(
            "L'information en un clic",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: const Text("Magazine Infos est un magazine numérique qui propose "
        "des informations, des actualités et des contenus variés "
        "pour permettre aux lecteurs de rester informés simplement "
        "et rapidement.",
        style: TextStyle(
          fontSize: 14,
          height: 1.5,)
        )
    );
  }
}

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(
                Icons.phone,
                color: Colors.pink,
                size: 30,
              ),
            const SizedBox(height: 5),
            const Text("TEL", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 14),)
            ],
          ),
          Column(
            children: [
              const Icon(
                Icons.email,
                color: Colors.pink,
                size: 30,
              ),
              const SizedBox(height: 5),
              const Text(
                "MAIL",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Column(
            children: [
              const Icon(
                Icons.share,
                color: Colors.pink,
                size: 30,
              ),
              const SizedBox(height: 5),
              const Text(
                "PARTAGE",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/rub1.jpg',
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/rub2.jpg',
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
      ),
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
      body: Column(
        children: [
          Image(image: AssetImage("assets/images/newspaper.jpg")),
          PartieTitre(),
          PartieTexte(),
          PartieIcone(),
          PartieRubrique()
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

