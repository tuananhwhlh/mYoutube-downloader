import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shared--redirect"
export default class extends Controller {
  connect() {
    console.log(this.element.dataset.url)
    window.location.href = this.element.dataset.url
  }
}
