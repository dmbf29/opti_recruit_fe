import { Controller } from "@hotwired/stimulus";
window.bootstrap = require('bootstrap/dist/js/bootstrap.bundle.js');

export default class extends Controller {

  connect() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
  }

}
