import 'package:activite1/service/database_manager.dart';
import 'package:activite1/modele/redacteur.dart';
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
      theme: ThemeData(primarySwatch: Colors.pink, useMaterial3: true),
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
          icon: Icon(Icons.menu),
          onPressed: () {},
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      body: const RedacteurInterface(),
      backgroundColor: Colors.white,
    );
  }
}

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  List<Redacteur> _redacteurs = [];

  @override
  void initState() {
    super.initState();
    _chargerRedacteurs();
  }

  Future<void> _chargerRedacteurs() async {
    final liste = await DatabaseManager.instance.getAllRedacteur();
    setState(() => _redacteurs = liste);
  }

  Future<void> _ajouterRedacteur() async {
    final nom = _nomController.text.trim();
    final prenom = _prenomController.text.trim();
    final email = _emailController.text.trim();

    if (nom.isEmpty || prenom.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tous les champs sont obligatoires")),
      );
      return;
    }

    try {
      final redacteur = Redacteur.sansId(
        nom: nom,
        prenom: prenom,
        email: email,
      );

      await DatabaseManager.instance.insertRedacteur(redacteur);

      _nomController.clear();
      _prenomController.clear();
      _emailController.clear();

      await _chargerRedacteurs();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Rédacteur ajouté avec succès")),
        );
      }
    } catch (e) {
      print("ERREUR : $e");

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
      }
    }
  }

  Future<void> _modifierRedacteur(Redacteur redacteur) async {
    final nomController = TextEditingController(text: redacteur.nom);
    final prenomController = TextEditingController(text: redacteur.prenom);
    final emailController = TextEditingController(text: redacteur.email);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Modifier Rédacteur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(labelText: 'Nouveau Nom'),
              ),
              TextField(
                controller: prenomController,
                decoration: const InputDecoration(labelText: 'Nouveau Prénom'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Nouvel Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Annuler',style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () async {
                final miseAJour = Redacteur(
                  id: redacteur.id,
                  nom: nomController.text.trim(),
                  prenom: prenomController.text.trim(),
                  email: emailController.text.trim(),
                );
                await DatabaseManager.instance.updateRedacteur(miseAJour);
                if (dialogContext.mounted) Navigator.of(dialogContext).pop();
                await _chargerRedacteurs();
              },
              child: const Text('Enregistrer', style: TextStyle(color: Colors.green),),
            ),
          ],
        );
      },
    );
  }

  Future<void> _supprimerRedacteur(Redacteur redacteur) async {
    final confirme = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text(
            'Voulez-vous vraiment supprimer ${redacteur.prenom} ${redacteur.nom} ?',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Annuler')),
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Supprimer')),
          ],
        );
      },
    );

    if (confirme == true) {
      await DatabaseManager.instance.deleteRedacteur(redacteur.id!);
      await _chargerRedacteurs();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nomController,
            decoration: InputDecoration(labelText: 'Nom'),
          ),
          TextField(
            controller: _prenomController,
            decoration: InputDecoration(labelText: 'Prénom'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'email'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.redAccent,
                ),
              ),
              onPressed: _ajouterRedacteur,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Ajouter un rédacteur",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _redacteurs.length,
              itemBuilder: (context, index) {
                final redacteur = _redacteurs[index];
                return Card(
                  margin: EdgeInsets.only(top: 15),
                  child: ListTile(
                    title: Text('${redacteur.prenom} ${redacteur.nom}'),
                    subtitle: Text(redacteur.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _modifierRedacteur(redacteur),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _supprimerRedacteur(redacteur),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
