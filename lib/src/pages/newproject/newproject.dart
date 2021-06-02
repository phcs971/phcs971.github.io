import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../locators.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../components/components.dart';
import '../basepage/basepage.dart';

class NewProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final project = Project.create();
    final nav = locator<NavigationService>();
    List<File>? gallery = [];
    void save() async {
      final form = formKey.currentState!;
      if (form.validate()) {
        form.save();
        await locator<FirestoreService>().createProjeto(project, gallery!);
        nav.pop();
      }
    }

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
            onPressed: save,
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
                  //Status e Datas
                  FormField<Map<String, dynamic>>(
                    initialValue: {"status": null, "start": null, "end": null},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (map) {
                      project.status = map!['status'];
                      project.start = map['start'];
                      project.end = map['end'];
                    },
                    validator: (map) {
                      Status? status = map!['status'];
                      DateTime? start = map['start'];
                      DateTime? end = map['end'];
                      switch (status) {
                        case Status.tostart:
                          return null;
                        case Status.wip:
                          if (start == null) return "Data de início";
                          return null;
                        case Status.paused:
                          if (start == null) return "Data de início";
                          return null;
                        case Status.closed:
                          if (start == null) return "Data de início";
                          if (end == null) return "Data de finalização";
                          return null;
                        default:
                          return "Selecione o Status";
                      }
                    },
                    builder: (field) {
                      Status? status = field.value!['status'];
                      DateTime? start = field.value!['start'];
                      DateTime? end = field.value!['end'];
                      return Column(
                        children: [
                          DropdownButtonFormField<Status>(
                            value: status,
                            items: Status.values
                                .map((st) => DropdownMenuItem<Status>(
                                      value: st,
                                      child: Text(kStatusToString[st]!),
                                    ))
                                .toList(),
                            onChanged: (v) =>
                                field.didChange({"status": v, "start": start, "end": end}),
                            decoration: InputDecoration(
                              labelText: "Status",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          if (field.value!['status'] != null &&
                              field.value!['status'] != Status.tostart)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        border: Border.all(color: Theme.of(context).primaryColor),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: start ?? DateTime.now(),
                                            firstDate: DateTime(2001, 07, 09),
                                            lastDate: DateTime.now().add(Duration(days: 365)),
                                            initialDatePickerMode: DatePickerMode.year,
                                          ).then((v) {
                                            if (v is DateTime)
                                              field.didChange(
                                                  {"status": status, "start": v, "end": end});
                                          });
                                        },
                                        title: Text(
                                            DateFormat("MM/yyyy").format(start ?? DateTime.now())),
                                        subtitle: Text("Início"),
                                        trailing: Icon(
                                          MaterialCommunityIcons.clock_start,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (field.value!['status'] == Status.closed) ...[
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.0),
                                          border: Border.all(color: Theme.of(context).primaryColor),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: end ?? DateTime.now(),
                                              firstDate: DateTime(2001, 07, 09),
                                              lastDate: DateTime.now().add(Duration(days: 365)),
                                              initialDatePickerMode: DatePickerMode.year,
                                            ).then((v) {
                                              if (v is DateTime)
                                                field.didChange(
                                                    {"status": status, "start": start, "end": v});
                                            });
                                          },
                                          title: Text(
                                              DateFormat("MM/yyyy").format(end ?? DateTime.now())),
                                          subtitle: Text("Fim"),
                                          trailing: Icon(
                                            MaterialCommunityIcons.clock_end,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            )
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  //Causa
                  DropdownButtonFormField<Cause>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: project.cause,
                    items: Cause.values
                        .map((cause) => DropdownMenuItem<Cause>(
                              value: cause,
                              child: Text("Projeto ${kCauseToString[cause]}"),
                            ))
                        .toList(),
                    onChanged: (v) => project.cause = v,
                    onSaved: (v) => project.cause = v,
                    validator: (v) {
                      if (v == null) return "Selecione a Causa";
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Causa",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //isOther
                  SwitchFormField(
                    onSaved: (v) => project.isOther = !(v ?? true),
                    initialValue: true,
                    title: "Principal",
                  ),
                  SizedBox(height: 10),
                  //Cor Principal
                  ColorPickerFormField(
                    title: "Cor Principal",
                    initialValue: Colors.green,
                    onSaved: (v) => project.mainColor = v,
                  ),
                  SizedBox(height: 10),
                  //Cor de Fundo
                  ColorPickerFormField(
                    title: "Cor do Fundo",
                    initialValue: Colors.white,
                    onSaved: (v) => project.backgroundColor = v,
                  ),
                  SizedBox(height: 10),
                  //Techs
                  FormField<List<ProjectTech>>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: [],
                    validator: (v) {
                      if (v!.isEmpty) return "Adicione as Tecnologias";
                      return null;
                    },
                    onSaved: (v) => project.techs = v,
                    builder: (field) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Tecnologias"),
                              trailing: PopupMenuButton<ProjectTech>(
                                onSelected: (v) => field.didChange([...field.value!, v]),
                                icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                                itemBuilder: (context) => ProjectTech.values
                                    .where((tech) => !field.value!.contains(tech))
                                    .map((tech) => PopupMenuItem<ProjectTech>(
                                          child: Text(kTechToString[tech]!),
                                          value: tech,
                                        ))
                                    .toList(),
                              ),
                            ),
                            if (field.value!.length != 0)
                              Container(
                                height: 48,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: field.value!.length,
                                  padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: GestureDetector(
                                        onLongPress: () {
                                          field.didChange(field.value!
                                              .where((tech) => field.value!.indexOf(tech) != index)
                                              .toList());
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Theme.of(context).primaryColor,
                                          child: Icon(
                                            kTechToIcon[field.value![index]],
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  //Links
                  FormField<List<Link>>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: [],
                    validator: (v) {
                      if (!v!.every((l) => l.url != null)) return "Arrume os Links";
                      return null;
                    },
                    onSaved: (v) => project.links = v,
                    builder: (field) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Links"),
                              trailing: PopupMenuButton<LinkType>(
                                onSelected: (v) =>
                                    field.didChange([...field.value!, Link.create(v)]),
                                icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                                itemBuilder: (context) => LinkType.values
                                    .map((link) => PopupMenuItem<LinkType>(
                                          child: Text(kLinkToString[link]!),
                                          value: link,
                                        ))
                                    .toList(),
                              ),
                            ),
                            if (field.value!.length != 0)
                              ...field.value!.map(
                                (link) => Padding(
                                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
                                  child: TextFormField(
                                    initialValue: link.url,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (v) {
                                      if (v == null || v == "") return "Link Inválido";
                                      return null;
                                    },
                                    onChanged: (v) {
                                      final links = field.value!;
                                      links[links.indexOf(link)] = Link(v, link.type);
                                      field.didChange(links);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        kLinkToIcon[link.type],
                                      ),
                                      suffix: GestureDetector(
                                        child: Icon(Icons.cancel, color: Colors.red),
                                        onTap: () {
                                          final links = field.value!;
                                          links.remove(link);
                                          field.didChange(links);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  //Galeria
                  FormField<List<File>>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: gallery,
                    validator: (v) {
                      if (!v!.every((i) => i.path != "")) return "Arrume os Items";
                      return null;
                    },
                    onSaved: (v) => gallery = v,
                    builder: (field) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Galeria"),
                              trailing: PopupMenuButton<ImageSource>(
                                onSelected: (v) async {
                                  final picker = ImagePicker();
                                  final img = await picker.getImage(source: v);
                                  if (img != null) {
                                    final image = await ImageCropper.cropImage(
                                      sourcePath: img.path,
                                      androidUiSettings: AndroidUiSettings(
                                        toolbarTitle: "Editar Imagem",
                                        toolbarColor: Colors.white,
                                        toolbarWidgetColor: Theme.of(context).primaryColor,
                                        statusBarColor: Colors.white,
                                        activeControlsWidgetColor: Colors.white,
                                      ),
                                    );
                                    if (image != null) field.didChange([...field.value!, image]);
                                  }
                                },
                                icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                                itemBuilder: (context) => ImageSource.values
                                    .map((source) => PopupMenuItem<ImageSource>(
                                          child: Text(kImageSourceToString[source]!),
                                          value: source,
                                        ))
                                    .toList(),
                              ),
                            ),
                            if (field.value!.length != 0)
                              Container(
                                height: 100,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: field.value!.length,
                                  padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: GestureDetector(
                                        onLongPress: () {
                                          field.didChange(field.value!
                                              .where((item) => field.value!.indexOf(item) != index)
                                              .toList());
                                        },
                                        child: Image.file(File(field.value![index].path)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ], index: -1);
  }
}
