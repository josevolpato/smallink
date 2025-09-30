export function copyToClipboard() {
  var copyText = document.getElementById("link_generated").innerHTML;

  navigator.clipboard.writeText(copyText);

  alert("Link copiado para área de transferência.");
}
