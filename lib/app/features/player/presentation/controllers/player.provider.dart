// Provedor que expõe a instância do seu serviço de player
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/player.service.dart';

final playerServiceProvider = Provider<PlayerService>((ref) {
  // Caso seu PlayerService precise ser instanciado ou lido de outra camada:
  return PlayerService(); 
});