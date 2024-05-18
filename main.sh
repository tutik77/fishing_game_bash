#!/bin/bash
. ./funcs.sh

dir=locations
if [[ ! -d $dir ]]; then
    echo "Нет директории с локациями"
    exit 1
fi

locations=("Речка моя" "Река Амазонка" "Большой Барьерный риф")
declare -A fish_counts

echo "Добро пожаловать на рыбалку! Выберите локацию:"

select location in "${locations[@]}"; do
    if [ -n "$location" ]; then
        echo "Вы выбрали локацию для рыбалки: $location"
        fish_by_loc "$location"
        break
    else
        echo "Пожалуйста, выберите локацию, введя соответствующую цифру"
    fi
done

read -p "Введите 0, если хотите начать рыбалку: " start
if [[ $start != 0 ]]; then
    echo "Вы ввели не 0, остаетесь без рыбалки"
    exit
fi

while true; do
    echo "Удочка заброшена, ждите поклёвки"
    sleep $(random_number 1 3)
    echo "Клюет! У вас есть немного времени, чтобы отреагировать. Напишите что-нибудь в чат и нажмите Enter"
    
    read -t 2 player_action
    if [[ -z "$player_action" ]]; then
        echo "Рыба ушла"
        finish_game
        continue
    fi

    sorvalas=$(random_number 1 20)
    if [[ $sorvalas == 1 ]]; then
        echo "Рыба сорвалась :("
        finish_game
        continue
    fi

    num=$(random_number 0 $((n - 1)))
    random_fish=${kinds[$num]}
    echo "Вы поймали: $random_fish"

    echo "1) Забрать"
    echo "2) Отпустить"
    read -p "Введите цифру: " choice

    if [[ $choice == 1 ]]; then
        if [[ -z "${fish_counts[$random_fish]}" ]]; then
            fish_counts[$random_fish]=1
        else
            ((fish_counts[$random_fish]++))
        fi
    elif [[ $choice != 2 && $choice != 1 ]]; then
        echo "Вы не в состоянии по клавише попасть, так что рыбу вы не заслужили."
    fi

    finish_game
done