import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['input', 'list', 'default', 'form'];

  connect() {
    // console.log(this.inputTarget);
    // console.log(this.listTarget);
    console.log(this.formTarget.action);

  }

  search() {
    const url = `/search?query=${this.inputTarget.value}`

    // using fetch to send this to our Rails controller
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        // the Rails controller gives us back that partial but as a string
        // data == movie lists partial

        // old list of movies is replaced by the new filtered partial
        this.listTarget.outerHTML = data
      })
  }
}
