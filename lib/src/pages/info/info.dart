import 'package:flutter/material.dart';

import '../basepage/basepage.dart';
import '../base.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key key}) : super(key: key);

  static const pad = const EdgeInsets.symmetric(horizontal: 15);

  int age() {
    final now = DateTime.now();
    int idade = now.year - 2002;
    if (now.isAfter(DateTime(now.year, 7, 9))) idade++;
    return idade;
  }

  Widget buildTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(height: 5, color: Theme.of(context).primaryColor),
          Container(height: 5),
          Container(
            height: 50,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: Text(
              title.toUpperCase(),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText(String text, [bool isBold = false]) {
    return Padding(
      padding: pad,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildList(List<String> texts) {
    return Padding(
      padding: pad,
      child: Column(
        children: texts
            .map((v) => Text(
                  "\u2022 $v \u2022",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ))
            .toList(),
      ),
    );
  }

  Widget buildSpace() => SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder((context, info) {
      bool fullScreen = info.localWidgetSize.width > 700;
      List<Widget> topPart = [
        Padding(
          padding: pad,
          child: CircleAvatar(
            radius: 72,
            backgroundColor: Theme.of(context).primaryColor,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/qb1.jpg'),
            ),
          ),
        ),
        SizedBox(height: 10, width: 10),
        Padding(
          padding: pad,
          child: Column(
            crossAxisAlignment: fullScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Text(
                "Pedro Henrique Cordeiro Soares",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: fullScreen ? TextAlign.start : TextAlign.center,
              ),
              Text(
                """
Brasileiro \u2022 Solterio \u2022 ${age()} anos \u2022 09/07/2001
Rua Rosa Kaint Nadolny, 225, Ap. 1701, Campo Comprido, 81200-525, Curitiba/PR
(41) 99987-7804 \u2022 phcs.971@gmail.com""",
                textAlign: fullScreen ? TextAlign.start : TextAlign.center,
              ),
            ],
          ),
        ),
      ];
      return BasePage(
        children: [
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  if (fullScreen) Row(children: topPart, mainAxisSize: MainAxisSize.min),
                  if (!fullScreen) ...topPart,
                  SizedBox(height: 10),
                  ////
                  buildTitle("Áreas de Atuação", context),
                  buildText("Engenharia Mecatrônica e Automação"),
                  buildText("Programação Python e Flutter"),
                  ////
                  buildTitle("Formação Acadêmica", context),
                  buildText(
                    "Graduação em Engenharia Mecatrônica - PUC-PR (Curitiba) - Início em 2019",
                    true,
                  ),
                  buildList(["IRA Atual - 9,495"]),
                  buildSpace(),
                  buildText("Dupla Diplomação de Ensino Médio", true),
                  buildList([
                    "Brasileiro - Colégio Dom Bosco Batel - 2018",
                    "Americano - Keystone National High School - 2018",
                    "Grade Point Average (GPA): 3,86/4,00"
                  ]),
                  ////
                  buildTitle("Experiências Profissionais", context),
                  buildText("Dod Vision - Estagiário | Março à Julho de 2019", true),
                  buildList([
                    "Suporte e Manutenção de Plataforma Web (Dashboard)",
                    "Desenvolvimento e Manutenção de Hardware (Raspberry Pi 3)",
                    "Rotina de Testes em Software e Hardware",
                    "Implementação de Melhorias de Software",
                    "Teste de Desempenho no Campo",
                    "Desenvolvimento back-end (Python)",
                  ]),
                  buildSpace(),
                  buildText("Theguyal – Desenvolvedor Web | Abril à Maio de 2020", true),
                  buildList([
                    "Desenvolvimento de Website (React.js)",
                    "Atualização contínua do site",
                    "Deploy e Manutenção do site (Netlify)",
                  ]),
                  buildSpace(),
                  buildText("Eletrofrio – Desenvolvedor Mobile | Junho à Agosto de 2020", true),
                  buildList([
                    "Desenvolvimento de Aplicação Mobile Multiplataforma (Flutter)",
                    "Teste de Funcionalidades e Widgets",
                  ]),
                  ////
                  buildTitle("Qualificações e Conquistas", context),
                  buildText("1º Lugar Geral – Vestibular de Verão PUC-PR 2018/2019"),
                  buildText("1º Lugar em Engenharia Mecânica – Vestibular de Verão UP 2018/2019"),
                  buildSpace(),
                  buildText(
                      "SAT (Exame Educacional Padronizado nos EUA): 1400/1600 – Percentil: 93%"),
                  buildSpace(),
                  buildText(
                      "Certificado de Potencial de Inovação no Hackathon de Sustentabilidade 2019 PUCPR"),
                  ////
                  buildTitle("Idiomas", context),
                  buildText("Inglês", true),
                  buildList(["Fluente (Diploma de Ensino Médio Americano)"]),
                  buildSpace(),
                  buildText("Espanhol", true),
                  buildList(["Boa compreensão e leitura"]),
                  ////
                  buildTitle("Habilidades e Competências", context),
                  buildText("Alta capacidade lógica e de reconhecimento de padrões"),
                  buildSpace(),
                  buildText(
                      "Habilidades de Cálculo (ENEM 2018: 957,9 – Matemática e Suas Tecnologias)"),
                  buildSpace(),
                  buildText(
                      "Proatividade, automotivação, autodidata comprovado, trabalho em equipe e liderança"),
                  ////
                  buildTitle("Informática", context),
                  buildText("Cursos", true),
                  buildList([
                    "Python 3 Tutorial Course – SoloLearn.com – Jan/2019",
                    "C++ Tutorial Course – SoloLearn.com – Jan/2019",
                    "Learn Flutter & Dart to Build iOS & Android Apps – Udemy – 2019/2020",
                    "Semana OmniStack 11.0 – RocketSeat – Mar, 2020",
                  ]),
                  buildSpace(),
                  buildText("Experiências", true),
                  buildList([
                    "Uso pessoal e escolar com conhecimentos intermediários de Pacote Office, Camtasia Studio 8 e paint.net",
                    "Uso profissional de Python, Github, VS Code, Firebase e Linux",
                    "Desenvolvimento de aplicativos multiplataformas via Flutter",
                    "Experiência com Business Logic of Component",
                    "Acostumado a práticas de Desenvolvimento Ágil",
                  ]),
                  ////
                  buildTitle("Informações Complementares", context),
                  buildText(
                      "Selecionado por 16 universidades dos Estados Unidos, baseado somente no sucesso acadêmico do Ensino Médio"),
                  buildSpace(),
                  buildText(
                      "Atleta de Futebol Americano – Formado com honras pela Brown Spiders Football School – 2017 e 2018 – 300 horas"),
                  buildSpace(),
                  buildText("Programador, trader, músico e enxadrista no tempo livre"),
                ],
              ),
            ),
          ),
        ],
        index: 2,
      );
    });
  }
}
