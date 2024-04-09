function cost() {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const taxValue = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = taxValue;
    const salesProfit = document.getElementById("profit");
    const profitValue = inputValue - taxValue;
    salesProfit.innerHTML = profitValue;
  })
}

window.addEventListener('turbo:load', cost)