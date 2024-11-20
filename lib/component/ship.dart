import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

class Ship extends SpriteComponent with TapCallbacks {
  late Vector2 tujuan; // untuk menyimpan koordinat tujuan kapal
  late Vector2 arah;  // arah pergerakan kapal
  double speed = 3.0;  // kecepatan kapal (tetap)

  Ship(){
    arah = Vector2(0, 0);
    tujuan = position;
  }
  // @override
  // void onMount() {
  //   arah = Vector2(0, 0); // memberikan nilai awal arah kapal yaitu vektor nol
  //   tujuan = position; // set tujuan awal ke posisi kapal saat ini
  //   super.onMount(); // memanggil metode onMount() dari superclass
  // }

  void setTujuan(DragUpdateInfo info) {
    tujuan = info.eventPosition.global; // mendapatkan posisi tujuan dari event drag
    lookAt(tujuan); // kapal akan menghadap ke tujuan
    angle += pi; // mengubah sudut kapal agar menghadap ke arah tujuan
    arah = tujuan - position;  // menghitung vektor arah kapal dari posisi saat ini menuju tujuan
    arah = arah.normalized();  // memastikan arah kapal terstandarisasi (unit vector)
  }

  @override
  FutureOr<void> onLoad() async {
    // Memuat gambar sprite kapal dari file
    sprite = Sprite(await Flame.images.load("ships/spaceShips_001.png"));
    position = Vector2(100, 100); // menetapkan posisi awal kapal pada koordinat (100, 100)
    angle = -pi / 2; // posisi sudut kapal menghadap ke bawah pada awalnya
    anchor = Anchor.center; // memastikan posisi kapal berpusat pada titik tengahnya
  }

  @override
  void update(double dt) {
    // Mengecek apakah kapal sudah hampir sampai tujuan
    if ((tujuan - position).length < speed) {
      position = tujuan; // jika sudah dekat tujuan, posisi kapal setara dengan tujuan
      arah = Vector2(0, 0); // arah dihentikan (vektor nol)
    }
    // Memastikan kapal bergerak menuju tujuan dengan kecepatan tetap
    position.add(arah * speed);  // mengupdate posisi kapal berdasarkan arah dan kecepatan
    super.update(dt); // memanggil metode update() dari superclass
  }
}
