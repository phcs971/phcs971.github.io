import 'package:flutter/material.dart';

import '../../locators.dart';
import '../../models/models.dart';
import '../basepage/basepage.dart';

class NewProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final project = Project.create();
    final nav = locator<NavigationService>();
    return BasePage(children: [
      //Title
      SliverAppBar(
        primary: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Novo Projeto",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          tooltip: "Voltar",
          onPressed: nav.pop,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: "Criar",
            onPressed: () {},
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      //Body
      SliverToBoxAdapter(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //Titulo
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) {
                      if (v == null || v == "") return "Adicione o título";
                      return null;
                    },
                    onSaved: (v) => project.title = v,
                    decoration: InputDecoration(
                      labelText: "Título",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Descricao
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: null,
                    validator: (v) {
                      if (v == null || v == "") return "Adicione a descrição";
                      return null;
                    },
                    onSaved: (v) => project.description = v,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    ], index: -1);
  }
}
