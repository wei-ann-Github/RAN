# run in proj root.
src_filename=data/en-es/tatoeba_100k.en-es.en.8k.bpe
tgt_filename=data/en-es/tatoeba_100k.en-es.es.8k.bpe
src_vocab=assets/8k.subword.vocab.en-es.en
tgt_vocab=assets/8k.subword.vocab.en-es.es
src_vocab_size=8000
tgt_vocab_size=8000
target_dir=data_bin

if [ ! -d $target_dir ]; then
    mkdir $target_dir
fi

python scripts/binarize_data.py \
    --train $src_filename $tgt_filename \
    --vocab $src_vocab $tgt_vocab \
    --vocab-size $src_vocab_size $tgt_vocab_size \
    --vocab-min-freq 2 2 \
    --target-dir $target_dir \
