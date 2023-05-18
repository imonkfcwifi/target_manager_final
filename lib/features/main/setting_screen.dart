import 'package:flutter/material.dart';
import 'package:target_manager/constants/gaps.dart';

class InfoBox extends StatefulWidget {
  const InfoBox({Key? key}) : super(key: key);

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
  bool click = true;
  void trans() {
    setState(() {
      click = !click;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: trans,
                  child: click
                      ? const Icon(Icons.language)
                      : const Icon(Icons.abc)),
              Text(
                click
                    ? '타겟 매니저 Beta 1.0 활용법'
                    : 'How to use Target Manager 1.0 Beta',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                click
                    ? "1. 타겟 매니저는 1부터 10까지로 이루어진 NumberPad로 구성되어있습니다."
                    : "1. The target manager consists of a NumberPad from 1 to 10.",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "2. NumberPad를 눌러 슈팅을 기록하고 '저장' 버튼을 눌러 '슈팅기록' 에 기록할 수 있습니다."
                    : "2. Press the NumberPad to record the shot and press the 'Save' button to record it in the 'Shooting History",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "3. NumberPad를 1초가량 길게 누를 시 누른 NumberPad 만큼 점수와 횟수가 차감됩니다."
                    : "3. If you press and hold the NumberPad for about 1 second, the score and number of times will be deducted by the numberPad you pressed.",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "4. NumberPad에서 '점수 취소' 를 누를 시 최근 기록된 점수와 횟수가 자동 차감됩니다."
                    : "4. If you press 'Cancel Score' on the NumberPad, the most recently recorded score and number of times will be automatically deducted.",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "5. '슈팅기록'의 ListTile을 우측 혹은 좌측으로 가볍게 밀면 Data가 지워집니다. "
                    : "5. Lightly push the ListTile of 'Shooting History' to the right or left to erase the data.",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "6. '슈팅기록'은 등록한 순으로 부터 표시됩니다."
                    : "6. 'Shooting record' is displayed from the order of registration.",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "7. 간소화를 위해 슈팅 기록도중 다른 창(슈팅기록, 튜토리얼) 으로 이동시 '슈팅하기' 페이지가 자동으로 초기화 됩니다. 유의바랍니다."
                    : "7. For simplicity, the 'Shooting' page is automatically initialized when moving to another window (Shooting History, Tutorial) during shooting history of shooting. Please keep that in mindful.",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "8. 주간, 월간 비교기능은 아직 없습니다.\n(서버 사면 추가예정)"
                    : "8. There is no weekly or monthly comparison function yet.\n (will be added if i buy a server)",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "9. 최근 전공공부로 바빠서 업데이트가 늦어질 수 있습니다, 카톡으로 피드백 받습니다!! 카톡 아이디 : nohyung"
                    : "9. The update may be delayed because I've been busy studying my major recently, so I'm getting feedback on devimonkfcwifi@gmail.com",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Text(
                click
                    ? "이 앱은 어떤 경로로도 수익을 창출하지 않습니다.\nmade by 사회복무요원 노우현"
                    : "This app doesn't generate revenue through any channels.\nmade by imonkfcwifi",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
