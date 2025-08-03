import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String nome = '';
  DateTime? dataNascimento;
  String? sexo;
  String mensagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextField(
              decoration: InputDecoration(labelText: 'Nome Completo'),
              onChanged: (valor) {
                nome = valor;
              },
            ),

            SizedBox(height: 16),

            ElevatedButton(
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
                  'Data escolhida: ${dataNascimento!.day}/${dataNascimento!.month}/${dataNascimento!.year}',
                ),
              ),

            SizedBox(height: 16),

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

            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                if (nome.isEmpty || dataNascimento == null || sexo == null) {
                  setState(() {
                    mensagem = 'Preencha todos os campos.';
                  });
                  return;
                }

                int idade = DateTime.now().year - dataNascimento!.year;

                DateTime hoje = DateTime.now();
                if (hoje.month < dataNascimento!.month ||
                    (hoje.month == dataNascimento!.month && hoje.day < dataNascimento!.day)) {
                  idade--;
                }

                if (idade >= 18) {
                  setState(() {
                    mensagem = 'Cadastro permitido!';
                  });
                } else {
                  setState(() {
                    mensagem = 'Você precisa ter mais de 18 anos.';
                  });
                }
              },
              child: Text('Enviar'),
            ),

            SizedBox(height: 16),
            Text(mensagem),
          ],
        ),
      ),
    );
  }
}
