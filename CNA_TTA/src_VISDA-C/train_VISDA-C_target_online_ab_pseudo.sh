SEED=2021
SRC_MODEL_DIR="/opt/tta/CNA_TTA/output/VISDA-C/source/"

PORT=10014
MEMO="VISDAC_online_fix_pseudo"
SUB_MEMO="V2_online_fix_pseudo"

for PSEUDO in 1 2 3 6 10 20 40
do
    CUDA_VISIBLE_DEVICES=4,5 python ../main_adacontrast.py \
    seed=2021 port=${PORT} memo=${MEMO} sub_memo=${SUB_MEMO}_${PSEUDO} project="VISDA-C" \
    data.data_root="/mnt/data" data.workers=8 \
    data.dataset="VISDA-C" data.source_domains="[train]" data.target_domains="[validation]" \
    learn.epochs=1 \
    learn=targetv1.yaml \
    learn.num_neighbors=${PSEUDO} \
    ckpt_path=False \
    model_src.arch="resnet101" \
    model_tta.src_log_dir=${SRC_MODEL_DIR} \
    optim.time=1 \
    optim.lr=2e-4 
done