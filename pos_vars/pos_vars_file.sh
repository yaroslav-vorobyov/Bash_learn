#!/usr/bin/env bash
# Поиск по шаблону в операциях подстановки параметров # ## % %%.

var1=file.test.txt
pattern1=file*.  # * (символ шаблона), означает любые символы между file и .

echo
echo "Script_name = $0"
echo "Число символов в ${var1} = ${#var1}" # Число символов в file.test.txt = 13
echo

echo "-= Поиск с начала строки, pattern1 подан как переменная =-"
echo "var1 = $var1"         # var1 = file.test.txt
echo '${var1} =' "${var1}"	# ${var1} = file.test.txt	(альтернативный вариант)
echo "pattern1 = $pattern1"	# pattern1 = file*.    (между 'file' и '.' могут быть любые символы)
echo
echo '${var1#$pattern1}    =' "${var1#$pattern1}"       # ${var1#$pattern1} = test.txt
# Наименьшая подстрока, удаляются первые 5 символов file.test.txt
#                                 ^^^^^^           |-----|
echo '${var1##$pattern1}   =' "${var1##$pattern1}"      # ${var1##$pattern1} = txt
# Наибольшая подстрока, удаляются первые 10 символов file.test.txt
#                                 ^^^^^^            |----------|

echo
## эксперимент без переменной pattern1, паттерн подан напрямую
echo "-= Поиск с начала строки, pattern1 подан напрямую =-"
echo '${var1#$'$pattern1'}      =' "${var1#file*.}"     # ${var1#$a*c} = 
echo '${var1##$'$pattern1'}     =' "${var1##file*.}"    # ${var1##$a*c} = 
echo
echo "=========================================================="
echo

echo "-= Поиск с конца строки, pattern2 подан как переменная =-"
pattern2=.*                 # всё, что после .
echo "var1 = $var1"         # var1 = file.test.txt
echo "pattern2 = $pattern2"	# pattern2 = .*
echo

echo '${var1%$pattern2}    =' "${var1%$pattern2}"       # ${var1%pattern2} = file.test
# Наименьшая подстрока, удаляются последние 4 символа file.test.txt
#                                 ^^^^^^^^^                   |----|
echo '${var1%%$pattern2}   =' "${var1%%$pattern2}"      # ${var1%%pattern2} = file
# Наибольшая подстрока, удаляются последние 9 символов file.test.txt
#                                 ^^^^^^^^^               |---------|
echo

# Запомните, # и ## используются для поиска с начала строки,
#            % и %% используются для поиска с конца строки.

## эксперимент без переменной pattern2, паттерн подан напрямую
echo "-= Поиск с конца строки, pattern2 подан напрямую =-"
echo '${var1%$'$pattern2'}          =' "${var1%.*}"     # ${var1%.*} = file.test
echo '${var1%%$'$pattern2'}         =' "${var1%%.*}"    # ${var1%.*} = file
echo

exit 0
