##============#
## FUNCTIONS ##
#============##

# ターミナルでpcolorを実行すると色の一覧を出力する
function pcolor() {
    for ((f=0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d#\e[m" $f $f
        if [[ $f%8 -eq 7 ]] then
            print "\n"
        fi
    done
    echo
}

function ffind() {
        find . -regex ".*\.\(php\|phtml\|ini\|inc\|html\|js\|css\|sql\|ext\|conf\)" | xargs grep -Hn $1 > find.txt
}

