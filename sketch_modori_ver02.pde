// Drawing program with undo/redo (OOP version)
// Press CTRL+Z to undo, CTRL+SHIFT+Z to redo

// We need these to know if CTRL/SHIFT are pressed
// 変数を定義(型が真偽のもの)
// 関数keyPressedで定義されているが、Ctrlを押したときTrueになる
boolean controlDown = false;
// 関数keyPressedで定義されているが、Shiftを押したときTrueになる
boolean shiftDown = false;

// クラスUndoからインスタンスundoを作成する？作成はしない
// クラスUndoの変数を扱うために、自作クラスでも型の宣言をする必要がある
// クラスとは、たい焼きの型で、インスタンスとは、たい焼き本体のこと
Undo undo;

// 関数setupを作成
void setup() {
  // 500*500のサイズのウィンドウを作成
  // 座標の頂点は左上で、右が+x、下が+y
  size(500, 500);
  // ウィンドウの背景の明るさ(白黒)を0から255で設定
  background(255);
  // クラスUndoを作成する。そのときクラスUndoの引数levelsに10を代入する。
  undo = new Undo(10);
}

// 関数drawを作成　毎フレームごとに実行する
void draw() {
  // Our two line drawing program
  // 変数mousePressedはマウスが押されていたらTrueになる
  if (mousePressed)
    // lineは始点と終点を直線で繋いで書く関数　始点は始めの2個の引数。終点は後の2個の引数。
    // mouseで現在のx,yが代入されている。pmouseで前のフレームのx,yが代入されている。
    line(mouseX, mouseY, pmouseX, pmouseY);
}

// 関数mouseReleasedを作成
// 関数mouseReleasedはマウスが離れたときに呼び出される関数
void mouseReleased() {
  // Save each line we draw to our stack of UNDOs
  undo.takeSnapshot();
}

// 関数keyPressedを作成
// 戻り値のない関数をvoid型という　任意時点で関数から抜けるためにreturnを使う
// returnで毎回抜けて、キーが押されたらkeyPressed関数の最初から処理を実行させるようにする
// そのため、キーを離したときの処理(keyReleased関数)が必要になる
// keyPressed関数はキーが押されるたびに呼び出される関数
void keyPressed() {
  // Remember if CTRL or SHIFT are pressed or not(訳:CtrlやShiftを押しているか押していないかを記憶させる)
  // keyはprocessingに用意されているグローバル変数　キーの種類を自動で格納してくれる
  // keyは文字列でなく文字を格納している　if (key == “A”)はエラー
  // key変数だけでほぼすべてのキーが判別できる　しかしShiftやctrlは判別できないから一度CODEDで判別する
  // CODEDはkeyの中身が特殊キーか判別してくれる
  // keyは最後に押されたキーを表す文字
  if (key == CODED) {
    // keyCodeは最後に押されたキーを表すキーコード
    // processingではkeyCodeは大文字でも小文字でも同じ数字を返す
    if (keyCode == CONTROL)
      controlDown = true;
    if (keyCode == SHIFT)
      shiftDown = true;
    return;
    // ここまでがkeyが真のときの処理
  }

  // 同時押しされているときの処理
  // Check if we pressed CTRL+Z or CTRL+SHIFT+Z(訳:CtrlとZやCtrlとShiftとZを押しているか押していないか)
  if (controlDown) {
    // keyCodeは数字のはずなのにstr型のZで場合分けして大丈夫なの?
    if (keyCode == 'Z') {
      if (shiftDown)
        // CtrlとShiftとZが押されているときの処理
        undo.redo();
      else
        // それ以外のときの処理。つまりCtrlとZが押されているが、Shiftが押されていないときの処理
        undo.undo();
    }
    return;
  }
  // Check if we pressed the S key
  // もし押されたキーがSのとき、png画像として保存する
  // もしかしてCtrl押さなくても保存できる?
  if (key=='s') {
    // saveFrame(フォーマット)でウィンドウの状態が保存される。
    // 任意の文字(image)+####(自動で連番に)+拡張子
    saveFrame("image####.png");
  }
}

// 関数keyReleasedを作成
// keyReleased関数はキーから指が離れたときに呼び出される関数
// 新たにキーを押したらkeyPressed関数が実行されるが、毎回returnで抜けているから、途中で離したときの処理ができる
void keyReleased() {
  // Remember if CTRL or SHIFT are pressed or not
  if (key == CODED) {
    if (keyCode == CONTROL)
      controlDown = false;
    if (keyCode == SHIFT)
      shiftDown = false;
  }
}

// クラスUndoを作成
class Undo {
  // Number of currently available undo and redo snapshots
  // 変数を定義(型は整数)　型を定義すると同時に0を代入しておく
  // undoStepsは関数takeSnapshotで代入して使われている。
  int undoSteps=0, redoSteps=0;
  // ここは何をしているの？　CircImgCollectionという型のimagesっていう変数を定義している?　初期値設定の前に型を定義していいの?
  // 型の宣言をしている　自作クラスでも変数を使いたいなら宣言する必要がある
  CircImgCollection images;
  // クラスUndoからインスタンスを生成するとき、インスタンスが持つ初期値を以下で設定する
  // クラスUndoからインスタンスundoを作るとき、引数として整数型の変数levelsをインスタンスに渡す必要がある
  Undo(int levels) {
    // 初期値としてimagesを設定
    // imagesはインスタンスで、もとになるクラスはCircImgCollection
    // クラスCircImgCollectionを作成するとき、引数としてlevelsを渡す
    images = new CircImgCollection(levels);
  }

  // 関数takeSnapshotを作成　パブリックだからクラス外から使うことができる。
  public void takeSnapshot() {
    // 2つの値を比較して小さい方をundoStepsに格納する
    undoSteps = min(undoSteps+1, images.amount-1);
    // each time we draw we disable redo
    redoSteps = 0;
    images.next();
    images.capture();
  }

  // 関数undoを作成　パブリックだからクラス外から使うことができる。
  public void undo() {
    if(undoSteps > 0) {
      // i++はi=i+1の省略形
      undoSteps--;
      redoSteps++;
      images.prev();
      images.show();
    }
  }

  // 関数redoを作成
  // publicをつけると、クラスの外部から参照することができるようになる。
  // スコープの問題。後で調べる。
  public void redo() {
    if(redoSteps > 0) {
      undoSteps++;
      redoSteps--;
      images.next();
      images.show();
    }
  }
}


// クラスCircImgCollectionを作成
class CircImgCollection {
  // 整数型の変数を定義
  // Javaとしてインスタンス変数(クラスレベルの変数)のintは定義したときに0が格納される
  // インスタンス変数じゃなくても0が格納される?
  int amount, current;
  // 変数imgを定義　型を画像用のPImage型にする(.jpgや.pngを代入できる)
  // そのとき、imgにリスト(別名:配列)を格納できるように[]をつけておく
  // リストとは、複数の値を代入できる変数のこと。普通なら変数には1つの値しか格納できないが、それを拡張して複数代入できる。
  // 例:imgに[1, 3, 2, 5]とか入っている
  PImage[] img;
  // クラスCircImgCollectionのインスタンスを作成するときの初期値として、amount, imgを設定
  // imgはamountに依存しているからインスタンスを生成するときは実質amountを設定するだけでいい
  // インスタンスを作成するとき、引数として整数型の変数amountOfImagesを渡す必要がある
  // amountがamountOfImagesに依存しているから、実質の変数はamountOfImagesの1つだけ
  CircImgCollection(int amountOfImages) {
    amount = amountOfImages;

    // Initialize all images as copies of the current display
    // 変数imgにPImage型のリストを代入する。リストに格納できる値の数はamount
    // 例:PImage[3]ならPImageには[2, 5, 3]とか値が3つ入っている
    img = new PImage[amount];
    // 整数型の変数iを定義して、iがamountより小さい間ずっと繰り返す。
    // 一度繰り返すたびにiを1ずつ増やす。i++はi=i+1の省略形
    for (int i=0; i<amount; i++) {
      // imgのi+1番目の値に代入する。リストの最初が0番から割り振られているから。
      // 例:変数aaa = [a, b, c]で、aaa[1]としたとき、参照する値は1番目のaかと思いきや、aは0番目扱いなので、bになる。
      // 関数createImageは画像を作る関数　ウィンドウの大きさとフォーマットを渡す必要がある
      // ウィンドウを作った時点で、widthにウィンドウの横、heightにウィンドウの縦が代入されている。
      // つまりRGBで同じ大きさのウィンドウを作成してimgリストのi番に格納する
      img[i] = createImage(width, height, RGB);
      // そしてウィンドウの現在の状態をimgリストのi番に格納しておく　一時保存的な
      img[i] = get();
    }
    // ここまでが初期動作
  }

  void next() {
    // PImageのリストのどこにウィンドウ状態を一時保存するか、番地を調整する
    // リスト数はamountしかないからamountのmod(余り)にする
    // 一時保存する番地を1つ進める
    // amountの最後まで使ったら、最初を破棄するように最初に格納し直す
    current = (current + 1) % amount;
  }
  void prev() {
    // 一時保存する番地を1つ戻す
    // 番地がマイナスになっていくのも面倒だから、範囲をamountに収めるためにamount分足す
    current = (current - 1 + amount) % amount;
  }
  void capture() {
    img[current] = get();
  }
  void show() {
    // image(画像ファイル名, x, y);は、座標(x, y)を左上にして画像を表示する
    image(img[current], 0, 0);
  }
}
