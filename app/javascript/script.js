  let slideIndex = 0;
  showSlides();

  function showSlides() {
    // スライドの要素を取得
    const slides = document.querySelectorAll(".slide.fade");
    
    // slideIndexを1増やす（次のスライドに進む）
    slideIndex++;
    
    // スライドの数よりもslideIndexが大きくなった場合、最初のスライドに戻る
    if (slideIndex > slides.length) {
      slideIndex = 1;
    }
    
    // 現在のスライドを表示（opacityを1に設定）
    slides[slideIndex - 1].style.opacity = "1";
    
    // 1つ前のスライドを非表示（opacityを0に設定）
    slides[slideIndex - 2 < 0 ? slides.length - 1 : slideIndex - 2].style.opacity = "0";
    
    // 一定時間（6000ミリ秒＝6秒）後に再度showSlides関数を呼び出す（次のスライドに進むための処理）
    setTimeout(showSlides, 6000); 
  }