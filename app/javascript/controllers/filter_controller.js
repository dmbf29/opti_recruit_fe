import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { playerId: Number }
  static targets = ['age_min', 'age_max', 'value_min', 'value_max', 'position', 'form', 'table'];

  update() {
    console.log(this.age_minTarget.value)
    const teamUrl = `/players/${this.playerIdValue}?`
    fetch(teamUrl + new URLSearchParams({
      age_min: this.age_minTarget.value === '' ? 0 : this.age_minTarget.value,
      age_max: this.age_maxTarget.value === '' ? 99 : this.age_maxTarget.value,
      value_min: this.value_minTarget.value === '' ? 0 : this.value_minTarget.value * 1000000,
      value_max: this.value_maxTarget.value === '' ? 999999999 : this.value_maxTarget.value * 1000000,
      position: this.positionTarget.value,
    }), { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        document.querySelectorAll('table')[1].outerHTML = data
      })
  }
}
