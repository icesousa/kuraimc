import 'package:flutter/material.dart';

void main() {
  runApp(const KuraImc());
}

class KuraImc extends StatelessWidget {
  const KuraImc({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

double peso = 80;
double altura = 1.80;
double imc = peso / (altura * altura);
String _descricao = 'Normal';
Color _containercolor = Colors.green.shade200;
IconData _iconeImc = Icons.sentiment_very_satisfied_outlined;
Color _fontecolor = Colors.black;
bool visivel = true;

_showDicas(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('REQUER ATENÇÃO MÉDICA'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                  '- Consulte um médico: A primeira etapa para procurar ajuda para a obesidade é marcar uma consulta com um médico.'),
              SizedBox(height: 8),
              Text(
                  '- Considere a terapia comportamental: A terapia comportamental pode ser útil para pessoas com obesidade, especialmente aquelas que têm problemas emocionais ou comportamentais relacionados à alimentação e ao exercício.'),
              SizedBox(height: 8),
              Text(
                  '- Procure grupos de apoio: Grupos de apoio, como os de Comedores Compulsivos Anônimos, podem fornecer uma rede de suporte para pessoas que enfrentam problemas de obesidade.'),
              SizedBox(height: 8),
              Text(
                '- Busque um nutricionista: Um nutricionista pode ajudar a pessoa a entender melhor sua alimentação.',
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                  '- Evite dietas extremas: Dietas extremas, como aquelas que envolvem restrições calóricas muito severas, podem ser perigosas e não sustentáveis ​​a longo prazo')
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}

class _HomePageState extends State<HomePage> {
  buttonHelp() {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      visible: visivel,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(_containercolor)),
            onPressed: () {
              _showDicas(context);
            },
            child: Text(
              'Encontre  ajuda',
              style: TextStyle(
                  color: _fontecolor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            )),
      ),
    );
  }

  _calcularIMC() {
    setState(() {
      imc = peso / (altura * altura);
      if (imc < 18.5) {
        _fontecolor = Colors.black;
        _iconeImc = Icons.sentiment_neutral_outlined;
        _descricao = 'Magreza';
        _containercolor = Colors.yellow.shade300;
        visivel = true;
        return;
      } else if (imc >= 18.5 && imc <= 24.9) {
        _fontecolor = Colors.black;
        _iconeImc = Icons.sentiment_very_satisfied_outlined;
        _containercolor = Colors.green;
        _descricao = 'Normal';
        visivel = false;

        return;
      } else if (imc >= 25.0 && imc <= 29.9) {
        _fontecolor = Colors.black;
        _iconeImc = Icons.sentiment_dissatisfied_outlined;
        _descricao = 'Sobrepeso';
        _containercolor = Colors.orange.shade300;
        visivel = false;
        return;
      } else if (imc >= 30.0 && imc <= 39.9) {
        _fontecolor = Colors.black;
        _iconeImc = Icons.sentiment_very_dissatisfied_outlined;
        _containercolor = Colors.red.shade300;
        _descricao = 'Obeso';
        visivel = true;
        return;
      } else if (imc > 40.0) {
        _iconeImc = Icons.sentiment_very_dissatisfied_outlined;

        _containercolor = Colors.black;
        _fontecolor = Colors.red;
        _descricao = 'Obeso Grave';
        visivel = true;
        return;
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                _iconeImc,
                size: 100,
                color: _containercolor,
              ),
              const SizedBox(height: 24),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _containercolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _descricao,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: _fontecolor),
                    ),
                    Text(
                      '  ${imc.toStringAsFixed(1)}',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: _fontecolor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              buttonHelp(),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green.shade50),
                child: Column(
                  children: [
                    Text(
                      'Peso',
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${peso.toStringAsFixed(2)} kg',
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider.adaptive(
                      activeColor: Colors.teal.shade400,
                      min: 30,
                      max: 200,
                      value: peso,
                      onChanged: (novopeso) {
                        peso = novopeso;
                        _calcularIMC();
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green.shade50),
                child: Column(
                  children: [
                    Text(
                      'Altura',
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${altura.toStringAsFixed(2)} m',
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider.adaptive(
                      activeColor: Colors.teal.shade400,
                      min: 1,
                      max: 2.3,
                      value: altura,
                      onChanged: (novaAltura) {
                        altura = novaAltura;
                        _calcularIMC();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
