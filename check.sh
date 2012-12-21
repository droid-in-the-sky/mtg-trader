wget -O current-magic-excel.txt.new http://classic.magictraders.com/pricelists/current-magic-excel.txt
diff -q current-magic-excel.txt.new current-magic-excel.txt
if [[ $? != 0 ]]; then
    echo "UPDATING!"
    cp current-magic-excel.txt current-magic-excel.txt.old
    cp current-magic-excel.txt.new current-magic-excel.txt
    ./converter.lua
else
    echo "UP-TO-DATE!"
fi
