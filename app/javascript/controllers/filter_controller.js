import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { playerId: Number }
  static targets = ['age_min', 'age_max', 'value_min', 'value_max', 'position', 'form', 'table'];

  connect() {
    console.log(this.age_minTarget.value)
  }
  update() {
    const teamUrl = `/players/${this.playerIdValue}?`
    fetch(teamUrl + new URLSearchParams({
      age_min: this.age_minTarget.value,
      age_max: this.age_maxTarget.value,
      value_min: this.value_minTarget.value,
      value_max: this.value_maxTarget.value,
      position: this.positionTarget.value,
    }), { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        document.querySelectorAll('table')[1].outerHTML = data
      })
  }
}
