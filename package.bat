rem this is probably not what you want to use, unless your setup is identical to mine

rm -r dist knyttr.zip
cp -r C:/love/dist ./
cd built
bash -c "zip -r ../dist/knyttr.love ./*"
cd ../dist
cat knyttr.love >> love.exe
cd ..
zip -r knyttr.zip dist