import 'package:flutter/material.dart';

/// O AnimatedSwitcher troca dinamicamente entre dois widgets distintos de forma animada.
/// Quando o filho muda (detectado pela sua 'key' ou tipo), ele cruza as animações (crossfade por padrão).
/// Permite definir transições customizadas de entrada e saída, substituindo lógicas complexas de navegação.
/// É a melhor escolha para alterar ícones de botões dinamicamente ou alternar cards de status.
class AnimatedSwitcherDemo extends StatefulWidget {
  const AnimatedSwitcherDemo({super.key});
  @override
  State<AnimatedSwitcherDemo> createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  bool _isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedSwitcher (Extra)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              // Faz a troca usando um efeito de escala (padrão é apenas fade)
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: _isFirst
                  ? Container(
                      key: const ValueKey(1), // Key importante para o Flutter identificar a mudança
                      width: 150, height: 150, color: Colors.blue,
                    )
                  : Container(
                      key: const ValueKey(2),
                      width: 150, height: 150, color: Colors.red,
                      child: const Icon(Icons.star, size: 50, color: Colors.white),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _isFirst = !_isFirst),
              child: const Text('Trocar Widget'),
            ),
          ],
        ),
      ),
    );
  }
}
