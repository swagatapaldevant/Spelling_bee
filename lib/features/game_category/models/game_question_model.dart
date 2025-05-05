class GameQuestion {
  final String question;
  final List<String> options;
  final String answer;

  GameQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });
}


final Map<int, List<GameQuestion>> gameQuestions = {
  0: [
    GameQuestion(
      question: "Match the letter with sound 'A'",
      options: ["অ", "আ", "ই", "উ"],
      answer: "অ",
    ),
    GameQuestion(
      question: "Find the correct spelling for 'Apple'",
      options: ["অ্যাপেল", "আপেল", "অপেল", "অপেল্ল"],
      answer: "আপেল",
    ),
  ],
  1: [
    GameQuestion(
      question: "Spell 'Cat'",
      options: ["ক্যাট", "কেট", "কেট্ট", "ক্যেট"],
      answer: "ক্যাট",
    ),
  ],
  2: [
    GameQuestion(
      question: "Which letter comes after ক?",
      options: ["খ", "ঘ", "গ", "চ"],
      answer: "খ",
    ),
  ],
  3: [
    GameQuestion(
      question: "Match the letter with sound 'A'",
      options: ["অ", "আ", "ই", "উ"],
      answer: "অ",
    ),
    GameQuestion(
      question: "Find the correct spelling for 'Apple'",
      options: ["অ্যাপেল", "আপেল", "অপেল", "অপেল্ল"],
      answer: "আপেল",
    ),
  ],
  4: [
    GameQuestion(
      question: "Match the letter with sound 'A'",
      options: ["অ", "আ", "ই", "উ"],
      answer: "অ",
    ),
    GameQuestion(
      question: "Find the correct spelling for 'Apple'",
      options: ["অ্যাপেল", "আপেল", "অপেল", "অপেল্ল"],
      answer: "আপেল",
    ),
  ],
  // Add more games similarly...
};
