# To run in project root
# https://github.com/rsennrich/subword-nmt#best-practice-advice-for-byte-pair-encoding-in-nmt

# Learning joint vocab: option 1
# cat {train_file}.L1 {train_file}.L2 | subword-nmt learn-bpe -s {num_operations} -o {codes_file}
# subword-nmt apply-bpe -c {codes_file} < {train_file}.L1 | subword-nmt get-vocab > {vocab_file}.L1
# subword-nmt apply-bpe -c {codes_file} < {train_file}.L2 | subword-nmt get-vocab > {vocab_file}.L2

# # Learning joint vocab: option 2
# # subword-nmt learn-joint-bpe-and-vocab --input {train_file}.L1 {train_file}.L2 -s {num_operations} -o {codes_file} --write-vocabulary {vocab_file}.L1 {vocab_file}.L2
src_train_file=data/en-es/tatoeba_100k.en-es.en
tgt_train_file=data/en-es/tatoeba_100k.en-es.es
num_operations_in_thou=8
num_operations=${num_operations_in_thou}000
codes_file=assets/${num_operations_in_thou}k.subword.joint.en-es
src_vocab_file=assets/${num_operations_in_thou}k.subword.vocab.en-es.en
tgt_vocab_file=assets/${num_operations_in_thou}k.subword.vocab.en-es.es

subword-nmt learn-joint-bpe-and-vocab \
    --input $src_train_file $tgt_train_file \
    -s $num_operations \
    -o $codes_file \
    --write-vocabulary $src_vocab_file $tgt_vocab_file

# apply bpe
subword-nmt apply-bpe -c $codes_file --vocabulary $tgt_vocab_file --vocabulary-threshold 50 < $tgt_train_file > $tgt_train_file.${num_operations_in_thou}k.bpe
subword-nmt apply-bpe -c $codes_file --vocabulary $src_vocab_file --vocabulary-threshold 50 < $src_train_file > $src_train_file.${num_operations_in_thou}k.bpe