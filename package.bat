rem this is probably not what you want to use, unless your setup is identical to mine

rm -r dist
mkdir dist
mkdir dist\fused
cp -r C:/love/dist/* ./dist/fused/
cd built
bash -c "zip -r ../dist/knyttr.love ./*"
cd ../dist/fused
cat ../knyttr.love >> love.exe
mv love.exe knyttR.exe
cd ..
zip -r knyttr.zip fused
cd ..