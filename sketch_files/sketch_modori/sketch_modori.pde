// Drawing program with undo/redo (OOP version)
// Press CTRL+Z to undo, CTRL+SHIFT+Z to redo

// We need these to know if CTRL/SHIFT are pressed
// 変数を定義(型が真偽のもの)
// 関数keyPressedで定義されているが、Ctrlを押したときTrueになる
boolean controlDown = false;
// 関数keyPressedで定義されているが、Shiftを押したときTrueになる
boolean shiftDown = false;

// クラスUndoからインスタンスundoを作成する？
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

// 関数drawを作成
void draw() {
  // Our two line drawing program
  // 変数mousePressedはマウスが押されていたらTrueになる
  if (mousePressed)
    // lineは始点と終点を直線で繋いで書く関数　始点は始めの2個の引数。終点は後の2個の引数。
    // mouseで現在のx,yが代入されている。pmouseで前のフレームのx,yが代入されている。
    line(mouseX, mouseY, pmouseX, pmouseY);
}

// 関数mouseReleasedを作成
void mouseReleased() {
  // Save each line we draw to our stack of UNDOs
  undo.takeSnapshot();
}

// 関数keyPressedを作成
void keyPressed() {
  // Remember if CTRL or SHIFT are pressed or not(訳:CtrlやShiftを押しているか押していないかを記憶させる)
  // 
  if (key == CODED) {
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
  if (key=='s') {
    saveFrame("image####.png");
  }
}

// 関数keyReleasedを作成
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
  // undoStepsは関数takeSnapshotで代入している。
  int undoSteps=0, redoSteps=0;  
  // ここは何をしているの？
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
    undoSteps = min(undoSteps+1, images.amount-1);
    // each time we draw we disable redo
    redoSteps = 0;
    images.next();
    images.capture();
  }
  
  // 関数undoを作成　パブリックだからクラス外から使うことができる。
  public void undo() {
    if(undoSteps > 0) {
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
  int amount, current;
  // 変数imgを定義　型を画像用のPImage型にする(.jpgや.pngを代入できる)
  // そのとき、imgにリスト(別名:配列)を格納できるように[]をつけておく
  // リストとは、複数の値を代入できる変数のこと。普通なら変数には1つの値しか格納できないが、それを拡張して複数代入できる。
  // 例:imgに[1, 3, 2, 5]とか入っている
  PImage[] img;
  // クラスCircImgCollectionのインスタンスを作成するときの初期値として、amount, imgを設定
  // imgはamountに依存しているからインスタンスを生成するときは実質amountを設定するだけでいい
  // インスタンスを作成するとき、引数として整数型の変数amountOfImagesを渡す必要がある
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
      // 関数createImageって何？始めから使える関数？
      // ウィンドウを作った時点で、widthにウィンドウの横、heightにウィンドウの縦が代入されている。
      img[i] = createImage(width, height, RGB);
      img[i] = get();
    }
  }
  void next() {
    current = (current + 1) % amount;
  }
  void prev() {
    current = (current - 1 + amount) % amount;
  }
  void capture() {
    img[current] = get();
  }
  void show() {
    image(img[current], 0, 0);
  }}
