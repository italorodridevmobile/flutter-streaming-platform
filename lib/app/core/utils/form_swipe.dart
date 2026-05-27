import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_crise/components/text.component.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../design_system/colors/colors.dart';

abstract class LiquidStep extends Widget {
  bool validate();
}

class SmartLiquidForm extends StatefulWidget {
  final LiquidController liquidSwipeController;
  final List<LiquidStep> steps;
  final VoidCallback onFinish;
  final String labelButtonFinish;

  const SmartLiquidForm({
    super.key,
    required this.liquidSwipeController,
    required this.steps,
    required this.onFinish,
    required this.labelButtonFinish,
  });

  @override
  State<SmartLiquidForm> createState() => _SmartLiquidFormState();
}

class _SmartLiquidFormState extends State<SmartLiquidForm> {
  int _currentStep = 0;

  void _handleNext() {
    // Verifica a validação do step atual antes de prosseguir
    if (widget.steps[_currentStep].validate()) {
      if (_currentStep < widget.steps.length - 1) {
        widget.liquidSwipeController.animateToPage(page: _currentStep + 1);
      } else {
        widget.onFinish();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, preencha todos os campos obrigatórios."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          LiquidSwipe(
            pages: widget.steps,
            liquidController: widget.liquidSwipeController,
            disableUserGesture:
                true, // Bloqueia swipe manual para forçar validação
            onPageChangeCallback: (index) =>
                setState(() => _currentStep = index),
          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  ButtonStylizedComponent(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    borderRadius: 100,
                    onPressed: () {
                      widget.liquidSwipeController.animateToPage(
                        page: _currentStep - 1,
                      );
                    },
                    label: TextComponent(
                      value: "Voltar",
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    color: AppColor.primary,
                  ),

                const Spacer(),
                ButtonStylizedComponent(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  borderRadius: 100,
                  onPressed: () {
                    _handleNext();
                  },
                  label: TextComponent(
                    value: _currentStep == widget.steps.length - 1
                        ? widget.labelButtonFinish
                        : "Próximo",
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  color: AppColor.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
