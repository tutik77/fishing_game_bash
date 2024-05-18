random_number() {
    echo $(shuf -i $1-$2 -n 1)
}
        file="rive.txt"
        filepath="${dir}/${file}"

fish_by_loc() {
    kinds=()
    n=0
    case $1 in 
        "Речка моя")
        file="river.txt"
        filepath="${dir}/${file}"
        if [[ ! -f $filepath ]]; then
            echo "Файла с рыбами из локации $1 не найдено"
            exit 1
        fi ;;
        "Река Амазонка")
        file="amazonka.txt"
        filepath="${dir}/${file}"
        if [[ ! -f $filepath ]]; then
            echo "Файла с рыбами из локации $1 не найдено"
            exit 1
        fi ;;
        "Большой Барьерный риф")
        file="reef.txt"
        filepath="${dir}/${file}"
        if [[ ! -f $filepath ]]; then
            echo "Файла с рыбами из локации $1 не найдено"
            exit 1
        fi ;;
    esac

    while IFS= read -r line; do
        kinds+=("$line")
        ((n++))
    done < "$filepath"
}

finish_game () {

    echo "Хотите продолжить игру? (Y/N)"
        read input

        if [[ "$input" == "Y" || "$input" == "y" ]]; then
            return
        fi
        total_catch=$((kind0 + kind1 + kind2 + kind3 + kind4))
    if [[ $total_catch == 0 ]]; then
        echo "Улова нет"
        exit 1
    fi

    echo "Ваш итоговый улов:"
    for i in {0..4}; do
        var="kind$i"
        if [[ ${!var} -ne 0 ]]; then
            echo "${kinds[$i]} - ${!var} шт."
        fi
    done

    max_catch=0
    max_index=0
    for i in {0..4}; do
        var="kind$i"
        if [[ ${!var} -ge $max_catch ]]; then
            max_catch=${!var}
            max_index=$i
        fi
    done

    echo "Наибольшее количество пойманных рыб относятся к виду ${kinds[$max_index]}."
    echo "Альберт Андреевич сказал, чтоб я брал рыб из файла, но никто не знает, кого туда посадят, поэтому рецепты писать смысла нет."
    exit 1
}