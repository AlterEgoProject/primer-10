// 共振モデル
int FRAME_RATE = 60;

float[] wave; // 波の配列
int wave_len = 1024;
int basal_len = 10; // 球の数
float min_freq = 1; // 最小振動数
float max_freq = 10; // 最大振動数
float k_resist = 0.001; // 抵抗係数

float x_wave; // 描画用
float x_basal;  // 描画用

float s = 0; // サインカーブ用
float fr = 2*PI/FRAME_RATE; // 角速度の定数(サインカーブ用)

BasilarMembrane bm;

void setup(){
  frameRate(FRAME_RATE);
  size(512, 400, P2D);
  wave = new float[wave_len];
  x_wave = float(width)/(wave_len);
  x_basal = float(width)/(basal_len);
  bm = new BasilarMembrane(basal_len, min_freq, max_freq, FRAME_RATE, k_resist);
}


void draw(){
  background(0);
  System.arraycopy(wave, 0, wave, 1, wave.length-1);
  
  // 例 サインカーブ
  s+=1;
  wave[0] = 50*sin(fr*s); // 周波数1の波
  //wave[0] = 50 * sin(5*fr*s); // 周波数nの波
  //wave[0] = 50*( sin(3*fr*s)+sin(5*fr*s)+sin(8*fr*s) ); // 合成波
  
  stroke(255);
  // 入力値の描画
  for(int i=0; i < wave.length - 1; i++){ line(x_wave*i, 100 + wave[i], x_wave*(i+1), 100 + wave[i+1]); }
  
  float[] wave0 = new float[1]; // 現状1データずつ
  wave0[0] = wave[0];
  
  bm.oscillate(wave0);
  
  // 球の描画
  for(int i=0; i < basal_len; i++){ ellipse(x_basal*i+x_basal/2, bm.resonance[i].x + 300, 10, 10); }
}
