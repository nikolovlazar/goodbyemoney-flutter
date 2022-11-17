// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:goodbye_money/types/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ReportBug extends WidgetWithTitle {
  const ReportBug({super.key}) : super(title: "Report a bug");

  @override
  Widget build(BuildContext context) {
    return const ReportBugContent();
  }
}

class ReportBugContent extends StatefulWidget {
  const ReportBugContent({super.key});

  @override
  _ReportBugContentState createState() => _ReportBugContentState();
}

class _ReportBugContentState extends State<ReportBugContent> {
  late TextEditingController _titleController;
  late TextEditingController _whatHappenedController;
  late TextEditingController _whatShouldveHappenedController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late String lastReportedEventId;

  bool get canSendFeedback {
    var lastEventId = Sentry.lastEventId.toString();
    return lastEventId != "00000000000000000000000000000000" &&
        lastEventId != lastReportedEventId;
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
    _whatHappenedController = TextEditingController(text: '');
    _whatShouldveHappenedController = TextEditingController(text: '');
    _nameController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    lastReportedEventId = '';
  }

  Future<void> sendFeedback() async {
    var title = _titleController.text;
    var whatHappened = _whatHappenedController.text;
    var whatShouldveHappened = _whatShouldveHappenedController.text;
    var name = _nameController.text;
    var email = _emailController.text;
    var sentryId = Sentry.lastEventId;

    final userFeedback = SentryUserFeedback(
      eventId: sentryId,
      comments: '''
        Title: $title
        ==============================================
        What Happened: $whatHappened
        ==============================================
        What Should've Happened: $whatShouldveHappened
      ''',
      email: email,
      name: name,
    );

    await Sentry.captureUserFeedback(userFeedback);
    lastReportedEventId = sentryId.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
            onPressed: () => Navigator.pop(context)),
        middle: const Text("Report a bug",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Column(
          children: [
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                CupertinoFormRow(
                  helper: null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Title",
                    maxLines: 1,
                    controller: _titleController,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 28, 30),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              children: [
                CupertinoFormRow(
                  helper: null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "What happened?",
                    maxLines: 5,
                    controller: _whatHappenedController,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 28, 30),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              children: [
                CupertinoFormRow(
                  helper: null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "What should've happened?",
                    maxLines: 5,
                    controller: _whatShouldveHappenedController,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 28, 30),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              children: [
                CupertinoFormRow(
                  helper: null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Name",
                    maxLines: 1,
                    controller: _nameController,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 28, 30),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                CupertinoFormRow(
                  helper: null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Email",
                    maxLines: 1,
                    controller: _emailController,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 28, 30),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: CupertinoButton(
                onPressed: canSendFeedback ? sendFeedback : null,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                color: CupertinoTheme.of(context).primaryColor,
                disabledColor:
                    CupertinoTheme.of(context).primaryColor.withAlpha(100),
                borderRadius: BorderRadius.circular(10),
                pressedOpacity: 0.7,
                child: Text(
                  "Send",
                  style: TextStyle(
                    color: canSendFeedback
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(100, 255, 255, 255),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
