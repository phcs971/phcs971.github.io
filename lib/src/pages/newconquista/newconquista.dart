import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:portifolio/src/components/components.dart';

import '../../locators.dart';
import '../../models/models.dart';
import '../basepage/basepage.dart';

class NewConquistaPage extends StatelessWidget {
  Future<PickedFile> cropImage(String path, BuildContext context) async {
    final result = await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Editar Imagem",
        toolbarColor: Colors.white,
        toolbarWidgetColor: Theme.of(context).primaryColor,
        statusBarColor: Colors.white,
        activeControlsWidgetColor: Colors.white,
      ),
    );
    return PickedFile(result!.path);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final conq = Conquista.create();
    final nav = locator<NavigationService>();
    PickedFile? image;

    void save() async {
      final form = formKey.currentState!;
      if (form.validate()) {
        form.save();
        await locator<FirestoreService>().createConquista(conq, File(image!.path));
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
          "Nova Conquista",
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
                    onSaved: (v) => conq.title = v,
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
                    onSaved: (v) => conq.description = v,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //...
                  Row(
                    children: [
                      //Data
                      Flexible(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Theme.of(context).primaryColor),
                          ),
                          child: FormField<DateTime>(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (v) {
                              if (v == null) return "Adicione a data";
                              return null;
                            },
                            onSaved: (v) => conq.date = v,
                            initialValue: DateTime.now(),
                            builder: (field) {
                              return ListTile(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: field.value!,
                                    firstDate: DateTime(2001, 07, 09),
                                    lastDate: DateTime.now().add(Duration(days: 365)),
                                    initialDatePickerMode: DatePickerMode.year,
                                  ).then((v) {
                                    if (v is DateTime) field.didChange(v);
                                  });
                                },
                                title: Text(
                                  DateFormat("MM/yyyy").format(field.value!),
                                ),
                                trailing: Icon(
                                  Icons.calendar_today,
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      //Is Other
                      Flexible(
                        flex: 5,
                        child: SwitchFormField(
                            onSaved: (v) => conq.isOther = !(v ?? true),
                            initialValue: true,
                            title: "Principal"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //Image
                  FormField<PickedFile>(
                    initialValue: image,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) {
                      if (v == null) return "Adicione a foto";
                      return null;
                    },
                    onSaved: (v) => image = v,
                    builder: (field) {
                      final picker = ImagePicker();
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () async {
                                  PickedFile? image =
                                      await picker.getImage(source: ImageSource.camera);
                                  if (image != null) {
                                    image = await cropImage(image.path, context);
                                    field.didChange(image);
                                  }
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.photo_library,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () async {
                                  PickedFile? image =
                                      await picker.getImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    image = await cropImage(image.path, context);
                                    field.didChange(image);
                                  }
                                },
                              ),
                              title: Center(child: Text("Foto")),
                            ),
                            if (field.value != null)
                              AspectRatio(
                                aspectRatio: 3 / 2,
                                child: Image.file(File(field.value!.path)),
                              ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ], index: -1);
  }
}
