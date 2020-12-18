
function ffn () {
  find "${2:-.}" -name "*$1*"
}

function ffext () {
  find "${2:-.}" -name "*.$1"
}
