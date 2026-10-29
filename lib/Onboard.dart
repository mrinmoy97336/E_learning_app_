import 'package:flutter/material.dart';

const Color navy = Color(0xFF030912);
const Color blue = Color(0xFF176BFF);
const Color lightBlue = Color(0xFFF1FCFE);
const Color mutedBlue = Color(0xFF597899);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'tag': 'LEARN WITHOUT LIMITS',
      'title': 'Your Learning,\nYour Way.',
      'description':
          'Discover courses designed around your goals and build skills for your future.',
      'icon': Icons.auto_stories_rounded,
      'color': Color(0xFF176BFF),
      'number': '01',
    },
    {
      'tag': 'YOUR PERSONAL AI TUTOR',
      'title': 'Learn Smarter\nwith AI.',
      'description':
          'Get instant answers, simplify difficult topics, and learn at your own pace.',
      'icon': Icons.psychology_alt_rounded,
      'color': Color(0xFF7557FF),
      'number': '02',
    },
    {
      'tag': 'YOUR FUTURE STARTS HERE',
      'title': 'Small Steps,\nBig Success.',
      'description':
          'Track your progress, complete lessons, and turn your learning goals into reality.',
      'icon': Icons.rocket_launch_rounded,
      'color': Color(0xFF00A88F),
      'number': '03',
    },
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LearningHomePage(),
        ),
      );
    }
  }

  void _skip() {
    _controller.animateToPage(
      _slides.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentPage];

    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: navy,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'LearnHub',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: navy,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      _currentPage == 2 ? 'Almost there' : 'Skip',
                      style: const TextStyle(
                        color: mutedBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _slides[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),

                        Expanded(
                          flex: 11,
                          child: LearningIllustration(
                            color: item['color'] as Color,
                            icon: item['icon'] as IconData,
                            number: item['number'] as String,
                            page: index,
                          ),
                        ),

                        const SizedBox(height: 24),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            item['tag'] as String,
                            style: TextStyle(
                              color: item['color'] as Color,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.3,
                            ),
                          ),
                        ),

                        const SizedBox(height: 17),

                        Text(
                          item['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 35,
                            height: 1.12,
                            letterSpacing: -1.3,
                            fontWeight: FontWeight.w900,
                            color: navy,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            item['description'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.7,
                              color: mutedBlue,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? blue
                              : const Color(0xFFD3E0EE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == 2
                                ? 'Get Started'
                                : 'Continue',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward_rounded, size: 21),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.verified_user_outlined,
                        size: 15,
                        color: mutedBlue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Learn at your own pace, anytime.',
                        style: TextStyle(
                          fontSize: 12,
                          color: mutedBlue.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LearningIllustration extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String number;
  final int page;

  const LearningIllustration({
    super.key,
    required this.color,
    required this.icon,
    required this.number,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F2FF),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            left: 25,
            child: _bubble(Icons.star_rounded, color, 35),
          ),
          Positioned(
            top: 65,
            right: 28,
            child: _bubble(Icons.auto_awesome, Colors.orange, 30),
          ),
          Positioned(
            bottom: 42,
            left: 25,
            child: _bubble(Icons.circle, Colors.white, 18),
          ),
          Positioned(
            bottom: 65,
            right: 25,
            child: _bubble(Icons.bolt_rounded, color, 34),
          ),

          Container(
            width: 205,
            height: 225,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.13),
                  blurRadius: 35,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.11),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(icon, size: 55, color: color),
                ),
                const SizedBox(height: 18),
                Text(
                  page == 0
                      ? 'Explore Courses'
                      : page == 1
                          ? 'AI Assistant'
                          : 'Your Progress',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: index == 0 ? 27 : 17,
                      height: 5,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? color
                            : const Color(0xFFE2EAF2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 38,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: navy.withValues(alpha: 0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    page == 1
                        ? Icons.auto_awesome
                        : page == 2
                            ? Icons.trending_up_rounded
                            : Icons.check_circle_rounded,
                    color: const Color(0xFF83D9FF),
                    size: 19,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    page == 0
                        ? 'Courses for you'
                        : page == 1
                            ? 'Ask AI anything'
                            : 'Keep it up!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 20,
            right: 20,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: color.withValues(alpha: 0.7),
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(IconData icon, Color color, double size) {
    return Container(
      width: size + 12,
      height: size + 12,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, color: color, size: size),
    );
  }
}

class LearningHomePage extends StatelessWidget {
  const LearningHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: blue,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to LearnHub!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: navy,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your learning journey starts here.',
                style: TextStyle(color: mutedBlue, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
