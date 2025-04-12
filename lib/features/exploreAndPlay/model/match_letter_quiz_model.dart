class BengaliLetterQuestion {
  final String letter; // Correct letter (question)
  final List<String> options; // 4 options (1 correct, 3 wrong)

  BengaliLetterQuestion({
    required this.letter,
    required this.options,
  });
}


//sample data
List<BengaliLetterQuestion> letterQuestions = [
  BengaliLetterQuestion(letter: 'অ', options: ['অ', 'আ', 'ই', 'উ']),
  BengaliLetterQuestion(letter: 'আ', options: ['আ', 'ঈ', 'এ', 'উ']),
  BengaliLetterQuestion(letter: 'ই', options: ['ই', 'ঈ', 'অ', 'ঋ']),
  BengaliLetterQuestion(letter: 'ঈ', options: ['ঈ', 'উ', 'ও', 'আ']),
  BengaliLetterQuestion(letter: 'উ', options: ['উ', 'ঋ', 'এ', 'অ']),
  BengaliLetterQuestion(letter: 'ঊ', options: ['ঊ', 'উ', 'ও', 'ঈ']),
  BengaliLetterQuestion(letter: 'ঋ', options: ['ঋ', 'ই', 'ঊ', 'অ']),
  BengaliLetterQuestion(letter: 'এ', options: ['এ', 'ও', 'ঊ', 'আ']),
  BengaliLetterQuestion(letter: 'ঐ', options: ['ঐ', 'এ', 'আ', 'ঈ']),
  BengaliLetterQuestion(letter: 'ও', options: ['ও', 'ঐ', 'অ', 'উ']),
  BengaliLetterQuestion(letter: 'ঔ', options: ['ঔ', 'ও', 'ঈ', 'এ']),

  BengaliLetterQuestion(letter: 'ক', options: ['ক', 'খ', 'গ', 'ঘ']),
  BengaliLetterQuestion(letter: 'খ', options: ['খ', 'ক', 'ঘ', 'ঙ']),
  BengaliLetterQuestion(letter: 'গ', options: ['গ', 'ঘ', 'খ', 'চ']),
  BengaliLetterQuestion(letter: 'ঘ', options: ['ঘ', 'গ', 'ঙ', 'ছ']),
  BengaliLetterQuestion(letter: 'ঙ', options: ['ঙ', 'ঘ', 'চ', 'ক']),

  BengaliLetterQuestion(letter: 'চ', options: ['চ', 'ছ', 'জ', 'ঝ']),
  BengaliLetterQuestion(letter: 'ছ', options: ['ছ', 'চ', 'ঝ', 'ঞ']),
  BengaliLetterQuestion(letter: 'জ', options: ['জ', 'ঝ', 'ছ', 'ট']),
  BengaliLetterQuestion(letter: 'ঝ', options: ['ঝ', 'জ', 'ঞ', 'ঠ']),
  BengaliLetterQuestion(letter: 'ঞ', options: ['ঞ', 'ঝ', 'চ', 'ড']),

  BengaliLetterQuestion(letter: 'ট', options: ['ট', 'ঠ', 'ড', 'ঢ']),
  BengaliLetterQuestion(letter: 'ঠ', options: ['ঠ', 'ট', 'ঢ', 'ণ']),
  BengaliLetterQuestion(letter: 'ড', options: ['ড', 'ঢ', 'ট', 'ত']),
  BengaliLetterQuestion(letter: 'ঢ', options: ['ঢ', 'ড', 'ঠ', 'ন']),
  BengaliLetterQuestion(letter: 'ণ', options: ['ণ', 'ন', 'ত', 'ট']),

  BengaliLetterQuestion(letter: 'ত', options: ['ত', 'থ', 'দ', 'ধ']),
  BengaliLetterQuestion(letter: 'থ', options: ['থ', 'ত', 'ধ', 'ন']),
  BengaliLetterQuestion(letter: 'দ', options: ['দ', 'ধ', 'ত', 'ব']),
  BengaliLetterQuestion(letter: 'ধ', options: ['ধ', 'দ', 'থ', 'ভ']),
  BengaliLetterQuestion(letter: 'ন', options: ['ন', 'ণ', 'ত', 'য']),

  BengaliLetterQuestion(letter: 'প', options: ['প', 'ফ', 'ব', 'ভ']),
  BengaliLetterQuestion(letter: 'ফ', options: ['ফ', 'প', 'ভ', 'ম']),
  BengaliLetterQuestion(letter: 'ব', options: ['ব', 'ভ', 'প', 'য']),
  BengaliLetterQuestion(letter: 'ভ', options: ['ভ', 'ব', 'ফ', 'র']),
  BengaliLetterQuestion(letter: 'ম', options: ['ম', 'ভ', 'ন', 'ল']),

  BengaliLetterQuestion(letter: 'য', options: ['য', 'র', 'ল', 'শ']),
  BengaliLetterQuestion(letter: 'র', options: ['র', 'ল', 'য', 'ষ']),
  BengaliLetterQuestion(letter: 'ল', options: ['ল', 'শ', 'র', 'স']),
  BengaliLetterQuestion(letter: 'শ', options: ['শ', 'স', 'ল', 'হ']),
  BengaliLetterQuestion(letter: 'ষ', options: ['ষ', 'শ', 'হ', 'র']),
  BengaliLetterQuestion(letter: 'স', options: ['স', 'শ', 'হ', 'ল']),
  BengaliLetterQuestion(letter: 'হ', options: ['হ', 'স', 'ষ', 'য']),

  BengaliLetterQuestion(letter: 'ড়', options: ['ড়', 'ঢ়', 'ক', 'গ']),
  BengaliLetterQuestion(letter: 'ঢ়', options: ['ঢ়', 'ড়', 'ট', 'ড']),
  BengaliLetterQuestion(letter: 'য়', options: ['য়', 'য', 'র', 'ল']),
  BengaliLetterQuestion(letter: 'ৎ', options: ['ৎ', 'ত', 'ট', 'থ']),
  BengaliLetterQuestion(letter: 'ং', options: ['ং', 'ঙ', 'ন', 'ম']),
  BengaliLetterQuestion(letter: 'ঃ', options: ['ঃ', 'হ', 'ঃ', 'ং']),
  BengaliLetterQuestion(letter: 'ঁ', options: ['ঁ', 'ং', 'ঃ', 'ম']),
];


final Map<String, String> letterPronunciations = {
  'অ': 'অ, অকার',
  'আ': 'আ, আকার',
  'ই': 'ই, ইকার',
  'ঈ': 'ঈ, ঈকার',
  'উ': 'উ, উকার',
  'ঊ': 'ঊ, ঊকার',
  'ঋ': 'ঋ, ঋকার',
  'এ': 'এ, একার',
  'ঐ': 'ঐ, ঐকার',
  'ও': 'ও, ওকার',
  'ঔ': 'ঔ, ঔকার',

  'ক': 'ক, যেমন কাক',
  'খ': 'খ, যেমন খাত',
  'গ': 'গ, যেমন গামলা',
  'ঘ': 'ঘ, যেমন ঘর',
  'ঙ': 'ঙ, যেমন আঁচ'

  ,'চ': 'চ, যেমন চাঁদ',
  'ছ': 'ছ, যেমন ছাতা',
  'জ': 'জ, যেমন জাম',
  'ঝ': 'ঝ, যেমন ঝুড়ি',
  'ঞ': 'ঞ, যেমন বাঞ্জ'

  ,'ট': 'ট, যেমন টেবিল',
  'ঠ': 'ঠ, যেমন ঠেলা',
  'ড': 'ড, যেমন ডাল',
  'ঢ': 'ঢ, যেমন ঢোল',
  'ণ': 'ণ, যেমন বর্ণ'

  ,'ত': 'ত, যেমন তলা',
  'থ': 'থ, যেমন থালা',
  'দ': 'দ, যেমন দরজা',
  'ধ': 'ধ, যেমন ধান',
  'ন': 'ন, যেমন নাক'

  ,'প': 'প, যেমন পাতার',
  'ফ': 'ফ, যেমন ফুল',
  'ব': 'ব, যেমন বাড়ি',
  'ভ': 'ভ, যেমন ভাব',
  'ম': 'ম, যেমন মাটি'

  ,'য': 'য, যেমন যুবক',
  'র': 'র, যেমন রাস্তা',
  'ল': 'ল, যেমন লতা',
  'শ': 'শ, যেমন শরীর',
  'ষ': 'ষ, যেমন পুষ্প',
  'স': 'স, যেমন সূর্য',
  'হ': 'হ, যেমন হাওয়া'

  ,'ড়': 'ড়, যেমন গাড়ি',
  'ঢ়': 'ঢ়, যেমন বড়',
  'য়': 'য়, যেমন ময়ূর'

  ,'ৎ': 'ৎ, যেমন কৎ',
  'ং': 'ং, যেমন বাংলা',
  'ঃ': 'ঃ, বিশেষ শব্দ',
  'ঁ': 'ঁ, চাঁদ এর মতো চিহ্ন'
};

