
function ffn () {
  find "${2:-.}" -name "*$1*"
}

function ffext () {
  find "${2:-.}" -name "*.$1"
}

function day-of-2024 () {
    local today last_day_of_2023 diff one_day_seconds
    one_day_seconds=86400
    today="$(date +%s)" # in epoch seconds
    last_day_of_2023="$(date +%s -d 20231231)" # in epoch seconds
    diff=$(((today - last_day_of_2023) / one_day_seconds))

    echo "Day of 2024: $diff"
}
