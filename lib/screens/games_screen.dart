import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../core/app_theme.dart';
import '../providers/progress_provider.dart';
import '../providers/language_provider.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final language = Provider.of<LanguageProvider>(context);

    final games = [
      {
        'id': 'matching',
        'icon': '🎯',
        'title': language.isArabic ? 'مطابقة الحروف' : 'Letter Matching',
        'description': language.isArabic 
            ? 'طابق الحرف مع الصورة المناسبة'
            : 'Match the letter with the correct picture',
        'color': AppColors.primary,
        'score': progress.gameScores[0],
      },
      {
        'id': 'memory',
        'icon': '🃏',
        'title': language.isArabic ? 'لعبة الذاكرة' : 'Memory Game',
        'description': language.isArabic
            ? 'أوجد زوج الحرف والصورة'
            : 'Find the letter and picture pairs',
        'color': AppColors.blue,
        'score': progress.gameScores[1],
      },
      {
        'id': 'word_builder',
        'icon': '🧩',
        'title': language.isArabic ? 'ترتيب الحروف' : 'Word Builder',
        'description': language.isArabic
            ? 'رتب الحروف لتكوين كلمة'
            : 'Arrange the letters to form a word',
        'color': AppColors.accent,
        'score': progress.gameScores[2],
      },
      {
        'id': 'letter_tracing',
        'icon': '✏️',
        'title': language.isArabic ? 'تتبع الحروف' : 'Letter Tracing',
        'description': language.isArabic
            ? 'ارسم الحرف بإصبعك'
            : 'Trace the letter with your finger',
        'color': AppColors.purple,
        'score': progress.gameScores[3],
      },
      {
        'id': 'quiz',
        'icon': '📝',
        'title': language.isArabic ? 'اختبار سريع' : 'Quick Quiz',
        'description': language.isArabic
            ? 'أجب عن الأسئلة بسرعة'
            : 'Answer the questions quickly',
        'color': AppColors.orange,
        'score': progress.gameScores[4],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          language.isArabic ? '🎮 الألعاب' : '🎮 Games',
        ),
        backgroundColor: AppColors.blue,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return _buildGameCard(
              icon: game['icon'] as String,
              title: game['title'] as String,
              description: game['description'] as String,
              color: game['color'] as Color,
              score: game['score'] as int,
              onTap: () {
                // هنا سيتم إضافة منطق كل لعبة
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      language.isArabic
                          ? '🚧 جاري تطوير هذه اللعبة'
                          : '🚧 This game is under development',
                    ),
                    backgroundColor: color,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildGameCard({
    required String icon,
    required String title,
    required String description,
    required Color color,
    required int score,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // أيقونة اللعبة
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  icon,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // معلومات اللعبة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '⭐',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${score}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.star_border,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // زر التشغيل
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}