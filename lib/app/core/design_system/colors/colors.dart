import 'package:flutter/material.dart';

class AppColor {
  // --- PALETA OFICIAL MAX / HBO MAX ---
  
  // O Roxo icônico da marca (usado em botões de destaque, linhas e seleções)
  static const Color primary = Color(0xFF741BF8); 
  static const Color primaryLight = Color(0xFF9E5EFF);
  
  // O Azul profundo característico que compõe o gradiente do fundo e branding
  static const Color secondary = Color(0xFF0213F9); 
  
  // O fundo escuro perfeito para cinema e streaming (substituindo o antigo 17, 17, 17)
  static const Color dark = Color(0xFF060714); 
  static const Color background = Color(0xFF060714);

  // Tons Neutros e Textos
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color neutral1 = Color(0xFF7E818C); // Cinza para textos secundários / Muted
  static const Color neutral2 = Color(0xFF1B1C2A); // Card background / Inputs
  static const Color neutral3 = Color(0xFFFFFFFF);

  // Elementos de Interface
  static const Color button = Color(0xFF741BF8);
  static const Color light = Color(0xFFFFFFFF);

  // --- GRADIENTES OFICIAIS ---
  // Perfeito para usar no Container de degradê da sua LoginPage!
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF9116F6), // Roxo Vibrante
      Color(0xFF5012EC), // Indigo
      Color(0xFF020BF5), // Azul Puro Max
    ],
  );

  // Gradiente de Fundo do app (Inicia roxo discreto no topo e morre no preto no rodapé)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF130934), // Roxo muito escuro
      Color(0xFF060714), // Preto profundo
    ],
  );

  // --- CORES DE STATUS (Mantidas e Ajustadas para o tema Dark) ---
  static const MaterialColor info = MaterialColor(0xFF00985D, <int, Color>{
    500: Color(0xFF00985D),
  });
  static const MaterialColor success = MaterialColor(0xFFB2D14B, <int, Color>{
    500: Color(0xFFB2D14B),
  });
  static const MaterialColor warning = MaterialColor(0xFFF47A20, <int, Color>{
    500: Color(0xFFF47A20),
  });
  static const MaterialColor danger = MaterialColor(0xFFFF616D, <int, Color>{
    500: Color(0xFFFF616D),
  });
}