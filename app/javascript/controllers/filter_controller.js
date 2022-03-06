import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['min', 'max', 'form', 'table', 'filters'];

  update() {
    const teamUrl = `/players/${'?id?'}search?query=${'???'}`
    fetch(teamUrl, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.filtersTarget.innerHTML = data.filters
        this.tabaleTarget.innerHTML = data.table
      })
  }
}
