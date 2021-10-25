import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    console.log("hello from stimulus")
  }
  static targets = ["query", "results"];


  list() {
    console.log("submit")
    const value = this.queryTarget.value

    fetch(`/?query=${value}`, {
      headers: { accept: 'application/json'}
    }).then((response) => response.json())
    .then(data => {
      var customerHTML = "";
      var customerArray = Object.values(data)[0];
      customerArray.forEach(customer => {
        customerHTML += this.customerTemplate(customer)
      });
       this.resultsTarget.innerHTML = customerHTML;
    });
  }

  customerTemplate(customer) {
    return `<div class="card-customer">
      <div class='card-customer-title'>
        <h2>${customer.restaurant_name}</h2>
      </div>
      <div class="card-customer-infos">
        <h2>${customer.first_name} ${customer.last_name}</h2>
        <p> ${customer.email} </p>
        <p class="card-infos-address"> ${customer.address}</p>
      </div>
    </div>`
  }
}
