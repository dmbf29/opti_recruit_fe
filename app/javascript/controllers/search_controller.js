import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['input', 'list', 'default', 'form'];

  connect() {
  }

  update() {
    const teamUrl = `/teams/search?query=${this.inputTarget.value}`

    fetch(teamUrl, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data
      })
  }

  clear() {
    this.inputTarget.value = ''
  }
}
