SRC_DOMAIN="cartoon,photo,sketch"
SRC_DOMAIN="art_painting,photo,sketch"
SRC_DOMAIN="art_painting,cartoon,sketch"
SRC_DOMAIN="art_painting,cartoon,photo"

PORT=$2
MEMO="source"

for SEED in 2021 2021 2022
do
    CUDA_VISIBLE_DEVICES=3,4 python main_adacontrast.py train_source=true learn=source \
    seed=${SEED} port=${PORT} memo=${MEMO} project="pacs" \
    data.data_root="/mnt/data/" data.workers=8 \
    data.dataset="pacs" data.source_domains="[${SRC_DOMAIN}]" data.target_domains="[art_painting,cartoon,photo,sketch]" \
    learn.epochs=100 \
    model_src.arch="resnet18" \
    optim.lr=2e-4
done