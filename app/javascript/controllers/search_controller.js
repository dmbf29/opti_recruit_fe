import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['input', 'list', 'default'];

  connect() {
    console.log(this.inputTarget);
    console.log(this.listTarget);
    console.log(this.defaultTarget);
  }
}
