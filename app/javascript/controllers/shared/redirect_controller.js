import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shared--redirect"
export default class extends Controller {
  connect() {
    window.location.href = this.element.dataset.url
  }
}
