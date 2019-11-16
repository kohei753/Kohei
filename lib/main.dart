import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/popular_lunch.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  //Lunch lunch;
  @override
  _MyAppState createState() => _MyAppState();
}

/* ホーム的なやつ（いじるな） */
class _MyAppState extends State<MyApp> {
  //Lunch _lunch ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: pdfSet(),
    );
  }
}

/* pdfを取得するやつ */
class pdfSet extends StatefulWidget {
  @override
  pdfSetState createState() => pdfSetState();
}

class pdfSetState extends State<pdfSet> {

  List<String> dasi_menu = [
    'とろろ昆布のすまし汁',
    '沢煮椀',
    'かきたま汁',
    '鮭のごまみそ鍋',
    'ほうとう',
    'そうめんすまし汁',
    'けんちん汁',
    'かぼちゃ団子汁',
    '卵とわかめのすまし汁',
    'すり身汁',
    'くじら汁',
  ]; //  出汁を使用したメニュー

  List<String> dasi_image = [
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/A1tororo.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B2sawaniwan.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B2kakitamajiru.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B3sakenogomamisonabe.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B4houtou.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B5soumen.JPG',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B6kenchin.jpg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C1kabochadango.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C2tamagowakame.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C3surimijiru.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C4kujirajiru.jpeg',
  ];

  List<String> dasi_recipe = [
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/A1tororokonbu.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B2sawaniwan.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B2kakitamajiru.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B3sakegomamiso.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B4houtou.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B5soumen.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B6kenchin.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/C1kabochadango.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/C2tamagowakamesumashijiru.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/C3surimijiru.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/C4kujirajiru.pdf',
  ];

  var original_menu = [
    'いかの磯辺揚げ',
    '千草焼き',
    '鮭のごま風味揚げ',
    'ぶりとなすのたたき風',
    'ぶりの南蛮煮',
    '春採り昆布の佃煮、くじらの竜田揚げ',
    'どさんこ汁',
    'ぶり甘酢あん',
    '春愛しい',
    'かに飯',
  ]; //  調理場自慢のオリジナルメニュー

  var original_image = [
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/A1ikaisobe.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/A3chigusayaki.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B1sakegoma.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B3buritonautataki.jpg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B5burinanban.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/B6harutorikujira.jpg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C1dosankojiru.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C3buriamazuan.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C4haruitoshii.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C4kanimeshi.jpeg',
  ];
  var original_recipe = [
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/A1ikanoisobeage.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/A3chigusayaki.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B1sakegoma.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B3burinasutataki.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B5burinonanbanni.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/B6konbukujira.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/C1dosankojiru.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/C3buriamazuan.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/C4haruitosii.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/C4kanimeshi.pdf',
  ];

  var oven_menu = [
    'ブリの豆板醤焼き',
    'お好み焼き風卵焼き',
    'かんたんミートローフ',
    'タンドリーチキン',
    'たら西京焼き',
    'おろしソース',
    'ホタテと鮭のバターしょうゆ焼き',
    '鮭のちゃんちゃん焼き',
    '鶏肉のハーブパン粉焼き',
    'ブリの薬味焼き',
    '豆腐の肉みそ焼き',
    '豆のカレーチーズ焼き',
    'ホタテのトマトソース焼き',
    'たらチーズ焼き',
    '豆腐入りハンバーグ(きのこソース)',
    '鱈カレーチーズ焼き',
    '鮭生姜焼き',
    'ブリの洋風ソースかけ',
    '鮭のごまみそ焼き',
    'ブリ五香焼き',
    'お月見団子',
    'なすのミートグラタン',
  ]; //  スチームコンベクションオーブンを利用したメニュー

  var oven_image = [
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon01.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon02.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon03.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon04.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon05.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon06.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon07.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon08.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon09.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon10.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon11.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon12.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon13.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon14.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon15.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon16.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon17.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon18.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon19.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon19.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon21.jpeg',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/thumb/stecon22.jpeg',
  ];

  var oven_recipe = [
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon1-2.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon1-2.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon3-4.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon3-4.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon5-6.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon5-6.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon7-8.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon7-8.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon9-10.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon9-10.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon11-12.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon11-12.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon13-14.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon13-14.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon15-16.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon15-16.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon17-18.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon17-18.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon19-20.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon19-20.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon21.pdf',
    'https://www.city.hakodate.hokkaido.jp/docs/2016012500108/files/stecon22.pdf',
  ];


  List<List<String>> allMenuName = [];
  List<List<String>> allMenuImage = [];

  List<List<String>> allMenuURL = [];
  List<List<String>> allMenuPath = [];

  //List<File> filePath = [];
  //lunch = widget.lunch;
  //  todo 児童考案メニューも忘れずに

  @override
  void initState() {
    super.initState();

    allMenuName = [dasi_menu, original_menu, oven_menu];
    allMenuImage = [dasi_image, original_image, oven_image];
    allMenuURL = [dasi_recipe, original_recipe, oven_recipe];
    allURLGet();
    //print(allMenuPath.toList());
  }

  void allURLGet() {
    for(var i = 0; i < allMenuURL.length; i++) {
      List<String> filePath = [];
      for (var j = 0; j < allMenuURL[i].length; j++) {
        getFileFromUrl(allMenuURL[i][j], j, i).then((f){
          filePath.add(f.path);
          filePath.sort();
        });
      }
      allMenuPath.add(filePath);
    }
  }

  Future<File> getFileFromUrl(String url, int counterMenu, int counterPath) async {
    int count = 0;
      try {
        var data = await http.get(url);
        var bytes = data.bodyBytes;
        var dir = await getApplicationDocumentsDirectory();
        //print(dir.path);
        if(counterMenu > 9) {
          count = 1;
          counterPath = count * 10 - counterMenu;
        }
        File file =
        File("${dir.path}/mypdfonline_menu_${counterPath.toString()}_${count.toString()}_${counterMenu.toString()}.pdf");

        File urlFile = await file.writeAsBytes(bytes);
        return urlFile;
      } catch (e) {
        throw Exception("Error opening url file");
      }
  }

  Widget _gridList(List<String> menu, List<String> image, int pathCount) {
    //final Size size = MediaQuery.of(context).size;
    return GridView.count(
      crossAxisCount: 2,
      //  画面の幅を何個で割るかって話
      mainAxisSpacing: 0.0,
      //  縦のセル同士の隙間の大きさ
      crossAxisSpacing: 0.0,
      //  横のセル同士の隙間の大きさ
      childAspectRatio: 1.30,
      //  セルの縦幅の調整
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: List.generate(menu.length, (int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print(allMenuPath[pathCount][index]);
            if (allMenuPath[pathCount][index] != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PdfViewPage(path: allMenuPath[pathCount][index])));
            }
          },
          child: Card(
            child: Column(children: <Widget>[
              Text(
                menu[index], //  献立名
                style: TextStyle(fontSize: 12.0), //  料理名の長い料理が悪さしない絶妙な文字サイズ
              ),
              Image.network(image[index],), //  献立の写真
            ]),
          ),
        );
      }),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text('出汁だよ'),
          _gridList(allMenuName[0], allMenuImage[0], 0),
          Text('オリジナルだよ'),
          //_gridList(allMenuName[1], allMenuImage[0], 1),
          Text('オーブンだよ'),
          //_gridList(allMenuName[2], allMenuImage[2], 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("人気給食"),
      ),
      body: _buildBody(),
    );
  }
}

/* pdfを表示するところ */
class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Document"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage - 1}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage + 1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }
}
