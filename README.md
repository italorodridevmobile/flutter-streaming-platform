# 🎬 ItMax — Streaming App Mobile

### Desenvolvido por developer Italo Rodri.

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter)
![Riverpod](https://img.shields.io/badge/Riverpod-State%20Management-purple?style=for-the-badge)
![FastAPI](https://img.shields.io/badge/FastAPI-Python-green?style=for-the-badge&logo=fastapi)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%26%20Core-orange?style=for-the-badge&logo=firebase)

---

# ✨ Sobre o Projeto

O **ItMax** é uma plataforma de streaming mobile inspirada na experiência premium do HBO Max.

O aplicativo foi desenvolvido utilizando:

- Flutter
- Riverpod
- Firebase
- FastAPI

---

# 🚀 Tecnologias Utilizadas

## 📱 Mobile
- Flutter & Dart
- Riverpod
- Firebase Auth
- Dio / HTTP
- Cached Network Image

## 🖥️ Backend
- Python
- FastAPI
- Firebase Services

---

# 📁 Estrutura do Projeto

```plaintext
lib/
 ├── app/
 │   ├── core/
 │   ├── features/
 │   └── design_system/
 ├── main.dart
 └── firebase_options.dart
```

---

# 🧪 Testes

Executar testes:

```bash
flutter test
```

Analisar qualidade do código:

```bash
flutter analyze
```

---

# ▶️ Executando o Projeto

Instalar dependências:

```bash
flutter pub get
```

Executar aplicação:

```bash
flutter run
```

Executar em modo release:

```bash
flutter run --release
```

---

# 🌐 Backend FastAPI

Rodar servidor local:

```bash
python -m poetry run uvicorn main:app --app-dir src --reload
```

Rodar na rede privada:

```bash
python -m poetry run uvicorn main:app --app-dir src --reload --host 0.0.0.0
```

---

# 📱 Funcionalidades

- ✅ Login Firebase
- ✅ Catálogo de Filmes
- ✅ Carrossel de Destaques
- ✅ Consumo de API REST
- ✅ Cache de Imagens
- ✅ Arquitetura Escalável

---

# 👨‍💻 Autor

## DEV Italo Rodri.

Desenvolvedor Full Stack focado em:

- Flutter
- Riverpod
- FastAPI
- Firebase
- Arquitetura Mobile

---

# 📄 Licença

Projeto desenvolvido para fins de estudo e portfólio.