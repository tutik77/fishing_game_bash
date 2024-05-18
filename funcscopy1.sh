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

    total_catch=0
    keymax=""
    max_count=0

    for ((i=0; i<$n; i++)); do
        count=${fish_counts[${kinds[i]}]}
        if [[ $count -ne 0 ]]; then
            echo "${kinds[$i]} - $count штук."
            total_catch=$((total_catch + count))
        fi
    done

    if [[ $total_catch == 0 ]]; then
        echo "Улова нет"
        exit
    fi

    echo "Вот ваш улов за сеанс ⭡"
    exit

    for key in ${fish_count[@]}; do
        if [[ ${fish_count[$key]} -ge $max_count ]]; then
        max_count=${fish_count[$key]}
        keymax=$key
    fi

    if [[ $max_count -ne 0 ]]; then
    echo "Вид рыбы, который наиболее часто попадался: $key. Вы словили $max_count рыб этого вида"
    echo "Т.к. Альберт Андреевич сказал сделать возможным писать своих рыб, рецепты отменяются. Простите, я не знаю как готовить рагу из синего кита"

}


