// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/cronometroBotao.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Container(
      color: store.estaTrabalhando() ? Colors.red : Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            store.estaTrabalhando() ? 'Hora de Trabalhar' : 'Hora de Descansar',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 25),
          Text(
            '${store.minutos.toString().padLeft(2, '0')}: ${store.segundos.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 120,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 25),
          Observer(
              builder: (_) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      if (!store.iniciado)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CronometroBotao(
                            texto: 'Iniciar',
                            icone: Icons.play_arrow,
                            click: store.iniciar,
                          ),
                        ),
                      if (store.iniciado)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CronometroBotao(
                            texto: 'Parar',
                            icone: Icons.pause,
                            click: store.parar,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CronometroBotao(
                          texto: 'Reiniciar',
                          icone: Icons.refresh,
                          click: store.reiniciar,
                        ),
                      )
                    ],
                  ))
        ],
      ),
    );
  }
}
