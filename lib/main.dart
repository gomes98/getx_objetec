import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/user_controller.dart';

void main() {
  // insere instantaneo
  // Get.put<UserController>(UserController());
  // insere somente quando for solicitado
  Get.lazyPut<UserController>(() => UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Campo de nome
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                ),

                // Botão para salvar o nome
                ElevatedButton(
                  onPressed: () {
                    userController.setUserName(nameController.text);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),

            // Espaçamento
            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Campo de idade
                Expanded(
                  child: TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      labelText: 'Idade',
                    ),
                  ),
                ),

                // Botão para salvar a idade
                ElevatedButton(
                  onPressed: () {
                    userController.setUserAge(int.parse(ageController.text));
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),

            // Espaçamento
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                // nevagação padrão
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const DataScreen();
                //     },
                //   ),
                // );
                final result = await Get.to(() => DataScreen());
                print(result);
              },
              child: const Text('Tela de dados'),
            ),
          ],
        ),
      ),
    );
  }
}

class DataScreen extends GetView<UserController> {
  DataScreen({
    Key? key,
  }) : super(key: key);

  TextStyle commonStyle() => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );
  final nameController = TextEditingController();
  // final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Apresentação do nome
            Obx(
              () => Text(
                'Nome: ${controller.user.value.name}',
                style: commonStyle(),
              ),
            ),
            // Apresentação da idade
            Obx(
              () => Text(
                'idade: ${controller.user.value.age}',
                style: commonStyle(),
              ),
            ),
            // GetX<UserController>(
            //   builder: (controller) {
            //     return Text(
            //       'Nome: ${controller.user.value.name}',
            //       style: commonStyle(),
            //     );
            //   },
            // ),
            // GetX<UserController>(
            //   builder: (controller) {
            //     return Text(
            //       'idade: ${controller.user.value.age}',
            //       style: commonStyle(),
            //     );
            //   },
            // )

            // Text(
            //   'idade: ',
            //   style: commonStyle(),
            // ),
            Expanded(
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Valor de retorno',
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  child: const Text("Voltar"),
                  onPressed: () {
                    String v = nameController.text;
                    Get.back(result: v);
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
