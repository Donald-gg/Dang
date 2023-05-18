import { DBank } from '../../declarations/DBank'
async function checkBal() {
  const currentAmount = await DBank.checkBalance()
  document.querySelector('#value').innerText = currentAmount.toFixed(2);
}

window.onload = checkBal
const button = document.querySelector('#submit-btn')
async function callContract(e) {
  e.preventDefault()
  const topUpAmount = parseFloat(e.target.topUp.value)
  const withdrawAmount = parseFloat(e.target.withdraw.value)
  if (!isNaN(topUpAmount)) {
    button.setAttribute('disabled', 'true')
    await DBank.topUp(topUpAmount)

  }
  if (!isNaN(withdrawAmount)) {
    button.setAttribute('disabled', 'true')
    await DBank.withdraw(withdrawAmount)
  }

  await DBank.compound()
  document.querySelector('form').reset()
  button.removeAttribute('disabled')
  checkBal()

}

document.querySelector('form').addEventListener('submit', callContract)