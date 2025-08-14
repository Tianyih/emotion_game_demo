import 'package:flutter/material.dart';

enum TherapistVoice { male, female }

class TherapistChoiceDialog extends StatefulWidget {
  const TherapistChoiceDialog({super.key});

  @override
  State<TherapistChoiceDialog> createState() => _TherapistChoiceDialogState();
}

class _TherapistChoiceDialogState extends State<TherapistChoiceDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  TherapistVoice? _selectedVoice;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectVoice(TherapistVoice voice) {
    setState(() {
      _selectedVoice = voice;
    });
  }

  void _confirmChoice() {
    if (_selectedVoice != null) {
      Navigator.of(context).pop(_selectedVoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Material(
          color: Colors.black.withOpacity(0.7 * _opacityAnimation.value),
          child: Center(
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: screenSize.width * 0.85,
                constraints: const BoxConstraints(maxWidth: 380),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue[50]!,
                      Colors.purple[50]!,
                    ],
                  ),
                  border: Border.all(color: Colors.blue[300]!, width: 2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Icon(
                      Icons.psychology,
                      size: 50,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Choose your AI therapist',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ICELAND',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Voice options
                    Row(
                      children: [
                        Expanded(
                          child: _buildVoiceOption(
                            TherapistVoice.male,
                            'Male',
                            Icons.man,
                            Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildVoiceOption(
                            TherapistVoice.female,
                            'Female',
                            Icons.woman,
                            Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Confirm button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _selectedVoice != null ? _confirmChoice : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedVoice != null
                              ? Colors.blue[600]
                              : Colors.grey[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          _selectedVoice != null
                              ? 'Start Session'
                              : 'Select a voice',
                          style: const TextStyle(
                            fontFamily: 'ICELAND',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVoiceOption(
    TherapistVoice voice,
    String label,
    IconData icon,
    MaterialColor color,
  ) {
    bool isSelected = _selectedVoice == voice;

    return GestureDetector(
      onTap: () => _selectVoice(voice),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color[100] : Colors.white,
          border: Border.all(
            color: isSelected ? color[600]! : Colors.grey[300]!,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color[200]!.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? color[700] : Colors.grey[600],
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'ICELAND',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? color[700] : Colors.grey[700],
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color[600],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Selected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
