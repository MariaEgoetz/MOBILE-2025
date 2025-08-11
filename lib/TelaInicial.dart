import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  
  String mensagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrossel de Formulários')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          height: 300, // Altura fixa para o carrossel
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Número de cards, ajuste se quiser mais
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: MicroFormCard(),
              );
            },
          ),
        ),
      ),
    );
  }
}
//micro formulario
class MicroFormCard extends StatefulWidget {
  @override
  _MicroFormCardState createState() => _MicroFormCardState();
}

class _MicroFormCardState extends State<MicroFormCard> {
  String nome = '';
  DateTime? dataNascimento;
  String? sexo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue[50], // Cor bonitinha
      child: SizedBox(
        width: 250, // Largura de cada card
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (valor) {
                  nome = valor;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
                onPressed: () async {
                  DateTime? escolhida = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (escolhida != null) {
                    setState(() {
                      dataNascimento = escolhida;
                    });
                  }
                },
                child: Text('Data de Nascimento'),
              ),
              if (dataNascimento != null)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Data: ${dataNascimento!.day}/${dataNascimento!.month}/${dataNascimento!.year}',
                  ),
                ),
              SizedBox(height: 12),
              DropdownButton<String>(
                hint: Text('Selecionar Sexo'),
                value: sexo,
                items: ['Homem', 'Mulher'].map((opcao) {
                  return DropdownMenuItem(value: opcao, child: Text(opcao));
                }).toList(),
                onChanged: (valor) {
                  setState(() {
                    sexo = valor;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
