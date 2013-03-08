mkdir -p "./v1.1"

cp -R ../Resources/data/stage/bg/bg4.tmx "./v1.1"

cp -R ../Resources/data/stage/s31/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s32/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s33/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s34/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s35/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s36/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s37/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s38/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s39/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s310/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s311/*.tmx "./v1.1"
cp -R ../Resources/data/stage/s312/*.tmx "./v1.1"

cd "./v1.1"
zip "zprlp.zip" *
cd ..
