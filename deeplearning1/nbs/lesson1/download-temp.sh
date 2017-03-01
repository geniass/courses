export DATA_ORIG_DIR=/input
export DATA_DIR=/output
cd $DATA_DIR

cp -R $DATA_ORIG_DIR/train $DATA_DIR/
cp -R $DATA_ORIG_DIR/test $DATA_DIR/

mkdir valid
mkdir results
mkdir -p sample/train
mkdir -p sample/test
mkdir -p sample/valid
mkdir -p sample/results
mkdir -p test/unknown

# move 2000 files to validation
cp `find $DATA_ORIG_DIR/train -type f | shuf -n 2000` valid/

# copy 200 files for the sample training dataset
cp `find $DATA_ORIG_DIR/train -type f | shuf -n 200` sample/train
# sample validation dataset
cp `find $DATA_DIR/valid -type f | shuf -n 50` sample/valid

# rearrange data files
rearrange () {
    mkdir cats
    mkdir dogs
    mv cat.*.jpg cats/
    mv dog.*.jpg dogs/
}

cd $DATA_DIR/sample/train
rearrange

cd $DATA_DIR/sample/valid
rearrange

cd $DATA_DIR/train
rearrange

cd $DATA_DIR/valid
rearrange

cd $DATA_DIR/test
mv *.jpg unknown/
