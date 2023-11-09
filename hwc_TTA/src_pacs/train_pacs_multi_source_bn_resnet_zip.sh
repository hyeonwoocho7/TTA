# SRC_DOMAIN="cartoon,photo,sketch"
# SRC_DOMAIN="art_painting,photo,sketch"
# SRC_DOMAIN="art_painting,cartoon,sketch"
# SRC_DOMAIN="art_painting,cartoon,photo"
SRC_DOMAINS=(cartoon,photo,sketch)
PORT=10017
MEMO="multi_source_resnet50"

for SEED in 2022 2023
do  
    for i in "${!SRC_DOMAINS[@]}"
    do
        CUDA_VISIBLE_DEVICES=5,6 python ../main_adacontrast.py train_source=true learn=source \
        seed=${SEED} port=${PORT} memo=${MEMO} project="pacs" \
        data.data_root="/mnt/data/" data.workers=8 \
        data.dataset="pacs" data.source_domains="[[${SRC_DOMAINS[i]}]]" data.target_domains="[art_painting,cartoon,photo,sketch]" \
        data.batch_size=32 \
        learn.epochs=300 \
        model_src.arch="resnet50" \
        optim.time=1 \
        optim.lr=2e-4
    done
done