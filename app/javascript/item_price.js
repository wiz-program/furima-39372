window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const tax = 0.1
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    addTaxDom.innerHTML = Math.floor(inputValue * tax)
    profit.innerHTML = `${inputValue - Math.floor(inputValue * tax)}`
  })
});