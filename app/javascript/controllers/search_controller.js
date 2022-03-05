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

    const playerUrl = `/players/search?query=${this.inputTarget.value}`
    fetch(playerUrl, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.insertAdjacentHTML('beforeend', '<li><hr class="dropdown-divider"></li>')
        this.listTarget.insertAdjacentHTML('beforeend', data)
      })
  }

  clear() {
    this.inputTarget.value = ''
  }
}
