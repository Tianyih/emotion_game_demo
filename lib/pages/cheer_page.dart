import 'package:candycrush/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../model/inventory.dart';
import '../utils/optimized_image.dart';

class CheerPage extends StatefulWidget {
  const CheerPage({super.key});

  @override
  State<CheerPage> createState() => _CheerPageState();
}

class _CheerPageState extends State<CheerPage> {
  String? _selectedAnswer;

  final List<Map<String, String>> _options = [
    {'key': 'a', 'value': 'capable'},
    {'key': 'b', 'value': 'intelligent'},
    {'key': 'c', 'value': 'grounded'},
    {'key': 'd', 'value': 'resourceful'},
  ];

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _submitAnswer() async {
    if (_selectedAnswer == null) return;

    // Add helper to inventory
    await InventoryService.addItem(InventoryService.helperItem);

    // Show reward popup
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF13102F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Yes! You are $_selectedAnswer, and you allow yourself to grow at your own pace.',
                  style: TextStyle(
                    fontFamily: 'ICELAND',
                    fontSize: 34,
                    color: Colors.yellow[300],
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here is your reward, a Helper. It can get rid of all your obstacles!',
                  style: TextStyle(
                    fontFamily: 'ICELAND',
                    fontSize: 28,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: OptimizedImage(
                      imagePath: 'assets/images/items/helper.jpg',
                      fit: BoxFit.cover,
                      errorWidget: Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.help,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  // Navigate back to home page, clearing all previous routes
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'ICELAND',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: OptimizedDecorationImage.getDecorationImage(
          imagePath: 'assets/images/background/cheer_background.png',
          fit: BoxFit.cover,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Back button in top left corner
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            // Navigate back to home page, clearing all previous routes
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false,
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Title text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Fill in the blank to cheer yourself up!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'ICELAND',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Question container with semi-transparent background
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 40.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(
                              0x8013102F), // Semi-transparent #13102F
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Question text
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'ICELAND',
                                  fontSize: 50,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(text: 'I trust that I am a '),
                                  TextSpan(
                                    text: '___',
                                    style: TextStyle(
                                      color: Colors.yellow[300],
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const TextSpan(
                                      text:
                                          ' person, and I allow myself to grow at my own pace.'),
                                ],
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Options
                            ..._options.map((option) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () =>
                                        _selectAnswer(option['value']!),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 24.0),
                                      decoration: BoxDecoration(
                                        color:
                                            _selectedAnswer == option['value']
                                                ? Colors.yellow[300]
                                                    ?.withOpacity(0.3)
                                                : Colors.transparent,
                                        border: Border.all(
                                          color: _selectedAnswer ==
                                                  option['value']
                                              ? Colors.yellow[300]!
                                              : Colors.white.withOpacity(0.5),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${option['key']}. ${option['value']}',
                                        style: TextStyle(
                                          fontFamily: 'ICELAND',
                                          fontSize: 36,
                                          color:
                                              _selectedAnswer == option['value']
                                                  ? Colors.yellow[300]
                                                  : Colors.white,
                                          fontWeight:
                                              _selectedAnswer == option['value']
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),

                            const SizedBox(height: 40),

                            // Submit button
                            if (_selectedAnswer != null)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submitAnswer,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow[300],
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontFamily: 'ICELAND',
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // 添加底部间距，确保内容不会被遮挡
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
