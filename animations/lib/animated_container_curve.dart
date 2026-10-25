import 'package:flutter/material.dart';

/// Aqui utilizamos o AnimatedContainer, mas introduzimos o conceito de Curves (Curvas).
/// As curvas definem a aceleração da animação, permitindo efeitos como saltos ou lentidão no início.
/// Mudar a curva altera drasticamente a percepção de peso e física do objeto animado.
/// É uma forma poderosa de deixar a interface mais natural e agradável.
class AnimatedContainerCurve extends StatefulWidget {
  const AnimatedContainerCurve({super.key});
  @override
  State<AnimatedContainerCurve> createState() => _AnimatedContainerCurveState();
}

class _AnimatedContainerCurveState extends State<AnimatedContainerCurve> {
  bool _isLarge = false;
  Curve _selectedCurve = Curves.easeInOut; // Curva padrão inicial

  final Map<String, Curve> _curves = {
    'easeInOut': Curves.easeInOut,
    'bounceIn': Curves.bounceIn,
    'elasticOut': Curves.elasticOut,
    'decelerate': Curves.decelerate,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer/size/Curve')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<Curve>(
            value: _selectedCurve,
            items: _curves.entries.map((entry) {
              return DropdownMenuItem(value: entry.value, child: Text(entry.key));
            }).toList(),
            onChanged: (Curve? newCurve) {
              if (newCurve != null) setState(() => _selectedCurve = newCurve);
            },
          ),
          const SizedBox(height: 50),
          Center(
            child: GestureDetector(
              onTap: () => setState(() => _isLarge = !_isLarge),
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: _selectedCurve, // Aplica a curva selecionada
                width: _isLarge ? 250.0 : 100.0,
                height: _isLarge ? 250.0 : 100.0,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
