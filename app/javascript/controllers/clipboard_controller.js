import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  copyToClipboard() {
    var copyText = document.getElementById("link_generated").innerHTML;

    navigator.clipboard.writeText(copyText);

    alert("Link copiado para área de transferência.");
  }

}
