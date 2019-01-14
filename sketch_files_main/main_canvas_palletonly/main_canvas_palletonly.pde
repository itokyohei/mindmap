//3つのウィンドウを宣言
PGraphics canvas, pallet;
// 宣言してから代入　finalこの変数の値を今後変えない
final float golden_ratio = 1.618;
//円の半径の関係性
final float circle_ratio = 0.75;
//いま抽出している色（初期色）
color selectColor = color(0, 0, 0);
//それぞれの辺の長さをとるため、親を変えると連動する
int size_height = 1000; //仕方ない
int lv01_golden = round(size_height*(golden_ratio-1)); // 618
int lv02_golden = round(lv01_golden*(golden_ratio-1)); // 382
int lv03_golden = round(lv02_golden*(golden_ratio-1)); // 236
//
void setup(){
  size(1618, 1000);
  //HSB、何パターンつくるか、彩度、明度
  colorMode(HSB, 360, 100, 100);
  //
  makeWindow();
  //背景色白(0,0,100)、キャンバスウィンドウの背景色を
  makeWindow_setup01(canvas, color(0, 0, 100));
  //makecolorpallet palletウィンドウにカラーパレットを作成する
  makeColorpallet(pallet);

  makeWindow_show();
}
//ウィンドサイズの設定
void makeWindow(){
  canvas = createGraphics(height, height);
  pallet = createGraphics(lv02_golden, lv02_golden);

}
//背景色を作成する関数
void makeWindow_setup01(PGraphics ff, color base_color){
  ff.beginDraw();
  ff.colorMode(HSB, 360, 100, 100);
  ff.background(base_color);
  ff.endDraw();
}

void makeColorpallet(PGraphics gg){
//せんたくした図形の一辺の値をとる
  int squareOneSide = gg.height;
//大きいほうの円の半径の長さ指定
  float large_r = squareOneSide/2;
  //小さいほうの円の半径の値を設定
  float small_r = (large_r)*circle_ratio;

  gg.beginDraw();
  gg.colorMode(HSB, 360, 100, 100);
  //(0,0)で座標を指定
  gg.pushMatrix();
  //中心座標(0,0)をウィンドウの中心に来るように設定
  gg.translate(large_r, large_r);
//draw01 外のカラーパレット、外の背景　draw2　中のカラーパレット　PGraphics ウィンドウを表す型
  makeColorpallet_draw01(gg, large_r, small_r);
  makeColorpallet_draw02(gg, small_r, 0);
  gg.endDraw();
}
void makeColorpallet_draw01(PGraphics gg, float r01, float r02){
  float on_rad = TWO_PI/360;
  gg.noStroke();
  gg.fill(200);
  gg.rect(-r01, -r01, r01*2, r01*2);
  gg.noStroke();
  for(int i = 0; i < 360; i++){
    gg.fill(i, 100, 100);
    //おうぎ形arc(中心座標x,y,直径,直径,何度,～何度)
    gg.arc(0, 0, r01*2, r01*2, i*on_rad, (i+1)*on_rad);
  }
  //中心背景塗りつぶし
  gg.fill(0, 0, 100);
  gg.ellipse(0, 0, r02*2, r02*2);
}
//color_hue 選択されている色の色彩変更
void makeColorpallet_draw02(PGraphics gg, float r02, float color_hue){
  //中の色彩のしきりを50*50で表現
  int separate = 50;
  //分けた1マスの1辺の長さを出している
  float separate_squareOneSide = r02*(1/sqrt(2))*2/separate;

  float start_separate_coordinate = -r02*(1/sqrt(2)); // スタートの座標
  gg.noStroke();
  //i=横 彩度　j=縦 明度
  for(int i = 1; i < separate; i++){
    for(int j = 0; j < separate; j++){
      //0～100の組み合わせ表現を半分のサイズにしている　100種類を50種類にしているから
      float change_saturation = 100*(i+1)/separate;
      float change_brightness = 100*(j+0)/separate;
      //分けた図形のなかをfillで指定した条件で塗りつぶすHSB
      gg.fill(color_hue, change_saturation, 100-change_brightness);
      //分けた小さい正方形の座標をずらしながら書いていく　　+1した理由…枠なしで書いているため隙間が出来る
      gg.rect(start_separate_coordinate + separate_squareOneSide*i, start_separate_coordinate + separate_squareOneSide*j, separate_squareOneSide + 1, separate_squareOneSide + 1); // 縦書いて横に伸ばす
    }
  }
}

//ウィンドウの配置する場所を指定
void makeWindow_show(){
  image(canvas, 0, 0);
  image(pallet, height, lv01_golden);
}

void draw(){
  float gg_pallet_center_x = height + lv02_golden/2;
  float gg_pallet_center_y = lv01_golden + lv02_golden/2;
  //1/sqrt(2))*circle_ratio*lv02_golden/2 pallet内部の正方形の一辺の半分の長さ
  float gg_pallet_squareOneSide = (1/sqrt(2))*circle_ratio*lv02_golden/2;

  if (mousePressed){
    float x = mouseX, y = mouseY;

    // カラーパレットの色相
    if (gg_pallet_center_x - gg_pallet_squareOneSide < x
    && x < gg_pallet_center_x + gg_pallet_squareOneSide
    && gg_pallet_center_y - gg_pallet_squareOneSide < y
    && y < gg_pallet_center_y + gg_pallet_squareOneSide){
    //getそこのデータの色情報を持ってくる　round 四捨五入　マウスで座標を取ると小数もすうちとして取ってしまうため
      selectColor = get(round(x), round(y));
    }

    // カラーパレットの彩度と明度　dist 座標から座標の距離　円の領域指定
    if (circle_ratio*lv02_golden/2 < dist(x, y, gg_pallet_center_x, gg_pallet_center_y)
    && dist(x, y, gg_pallet_center_x, gg_pallet_center_y) < lv02_golden/2)
    {selectColor = get(round(x), round(y));
      pallet.beginDraw();
      //中心座標(0,0)をウィンドウの中心に来るように設定
      pallet.translate(lv02_golden/2, lv02_golden/2);
      //(どのウィンドウに書くかを指定,数値を上の関数と同じにするため,取った色情報の色彩)
      makeColorpallet_draw02(pallet, circle_ratio*lv02_golden/2, hue(selectColor));
      pallet.endDraw();
      image(pallet, height, lv01_golden);
    }

    // キャンバスだけ書けるように条件付け
    if (0 < mouseX && mouseX < 1000 && 0 < mouseY && mouseY < 1000
    && 0 < pmouseX && pmouseX < 1000 && 0 < pmouseY && pmouseY < 1000){
      strokeWeight(10);
      stroke(selectColor);
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
  }

}
