import 'package:flutter/material.dart';
import 'package:savethedate/ui/survey/widgets/likertscalequestion.dart';

class Attachmentstyle extends StatefulWidget {
  const Attachmentstyle({super.key});

  @override
  State<Attachmentstyle> createState() => AttachmentstyleState();
}

class AttachmentstyleState extends State<Attachmentstyle> {
  final Map<int, int> responses = {}; // questionIndex → selectedValue

  final List<String> attachmentQuestions = [
    "I feel confident that other people will be there for me when I need them.",
    "I prefer to depend on myself rather than other people.",
    "I prefer to keep to myself.",
    "Achieving things is more important than building relationships.",
    "Doing your best is more important than getting on with others.",
    "If you’ve got a job to do, you should do it no matter who gets hurt.",
    "It’s important to me that others like me.",
    "I find it hard to make a decision unless I know what other people think.",
    "My relationships with others are generally superficial.",
    "Sometimes I think I am no good at all.",
    "I find it hard to trust other people.",
    "I find it difficult to depend on others.",
    "I find that others are reluctant to get as close as I would like.",
    "I find it relatively easy to get close to other people.",
    "I find it easy to trust others.",
    "I feel comfortable depending on other people.",
    "I worry that others won’t care about me as much as I care about them.",
    "I worry about people getting too close.",
    "I worry that I won’t measure up to other people.",
    "I have mixed feelings about being close to others.",
    "I wonder why people would want to be involved with me.",
    "I worry a lot about my relationships.",
    "I wonder how I would cope without someone to love me.",
    "I feel confident about relating to others.",
    "I often feel left out or alone.",
    "I often worry that I do not really fit with other people.",
    "Other people have their own problems, so I don’t bother them with mine.",
    "If something is bothering me, others are generally aware and concerned.",
    "I am confident that other people will like and respect me.",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                const Text(
                  "Attachment Style",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text("Attachment Style Questions"),
                            content: const Text(
                              "These questions are based on the Attachment Style Questionnaire - Short Form (ASQ-SF), developed by Alexander et al. (2001). They are backed by research and help assess relationship patterns.",
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Got it"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...List.generate(attachmentQuestions.length, (index) {
              return LikertScaleQuestion(
                question: '${index + 1}. ${attachmentQuestions[index]}',
                selectedValue: responses[index],
                onChanged: (value) {
                  setState(() {
                    responses[index] = value ?? -1;
                  });
                },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Save or evaluate results
                print(responses);
              },
              child: const Text("Save Responses"),
            ),
          ],
        ),
      ),
    );
  }
}
