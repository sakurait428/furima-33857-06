function count (){
  const ItemPrice  = document.getElementById("item-price");
  ItemPrice.addEventListener("keyup", () => {
    const priceVal = ItemPrice.value;
    // 入力された数値を定義
    const AddTaxPrice = document.getElementById("add-tax-price"); 
    // 販売手数料を表示させるIDを取得
    const Profit = document.getElementById("profit");
    // 販売利益を表示させるIDを取得
    const AddTaxPriceNum = Math.floor(priceVal * 0.1);
    // 消費税の計算、小数点の切り捨て
    const ProfitNum = priceVal - AddTaxPriceNum
    // 販売利益の計算
    AddTaxPrice.innerHTML = `${AddTaxPriceNum}`;
    // 販売手数料をHTMLへ送る
    Profit.innerHTML = `${ProfitNum}`;
    // 販売利益をHTMLへ送る
  });
}

window.addEventListener('load', count);