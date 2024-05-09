#!/bin/bash
set -euo pipefail
set -x

if ! which jq > /dev/null; then
  echo 'command jq not found, please install jq'
  exit 1
fi

if [[ -z "${CHAIN_ID:-}" ]]; then
  echo 'CHAIN_ID required'
  exit 1
fi

if [[ -z "${MNEMONIC:-}" ]]; then
  echo 'MNEMONIC required'
  exit 1
fi

jq-i() {
  edit="$1"
  f="$2"
  jq "$edit" "$f" > "${f}.tmp"
  mv "${f}.tmp" "$f"
}

palomad init birdlady --chain-id "$CHAIN_ID"

pushd ~/.paloma/config/
sed -i 's/^keyring-backend = ".*"/keyring-backend = "test"/' client.toml
sed -i 's/^minimum-gas-prices = ".*"/minimum-gas-prices = "0.001ugrain"/' app.toml
sed -i 's/^laddr = ".*:26657"/laddr = "tcp:\/\/0.0.0.0:26657"/' config.toml
jq-i ".chain_id = \"${CHAIN_ID}\"" genesis.json
popd

GR=000000ugrain
KGR="000${GR}"
MGR="000000${GR}"

INIT_AMOUNT="5${MGR}"
INIT_VALIDATION_AMOUNT="10${KGR}"
GENESIS_AMOUNT="1${MGR}"
FAUCET_AMOUNT="3${MGR}"

name="birdlady"
echo "$MNEMONIC" | palomad keys add "$name" --recover

palomad genesis add-genesis-account "$ADDRESS" "$INIT_AMOUNT"
palomad genesis gentx "$name" "$INIT_VALIDATION_AMOUNT" --chain-id "$CHAIN_ID"

init() {
  name="$1"
  address="$2"
  amount="${3:-"$INIT_VALIDATION_AMOUNT"}"

  palomad genesis add-genesis-account "$address" "$amount"

}

init birdpoop2  paloma1maax9vgarw6xl43frw9xhmmdxkaqqykqzsgq96 "$INIT_AMOUNT"
init feather paloma1xq70960ds6892qf8wclfaakgx4p9yd68z6xf8l "$INIT_AMOUNT"
init farfly paloma12lhn0rarcgu85ank9qea2vys4cq8nv02t83nmm "$INIT_AMOUNT"

init faucet paloma167rf0jmkkkqp9d4awa8rxw908muavqgghtw6tn "$FAUCET_AMOUNT"
init community-faucet paloma1qfexe8d6f9lpxtlpk7h9d6tjnkycmusctpl7t7 100000000000ugrain


init "DiElektra | MMS" paloma1tdw23fpnxh2uk3djtteh7eaydymrfgnak3paq3 476304000000ugrain
init VitaValeriya paloma19svt6tkvnu9wcjfwz2daglnxtm0frcavpzeyk2 165063000000ugrain
init paloma.acloud.pp.ua paloma1swa5kcf9cl5dx2ypx0c5r9e5qdfnzp9wq59z2l 214353000000ugrain
init ecamli paloma1qf7np0rp3qutvn08vc6qz0y7ffc02cncpam3a7 356335000000ugrain
init newpan paloma1rvpfhy4fsttmyyk2zualcc3gxwq3c7ap7eas7e 205009000000ugrain
init kubvil paloma1vglwq68encr73tlvcqf94m82j0gt2lefwpz7xw 30621000000ugrain
init "AlxVoy ⚡ ANODE.TEAM" paloma1my3gpyx7sdx7wn4rd0hmng60q9jhykxhfp7jqy 22301000000ugrain
init Validator.run paloma1nlwzcegm7kxg6rpmkqmpl3afvapkyp4ml0f5cm 24284000000ugrain
init salomonval paloma1ljg6ed0pzc3xpqtareyfp6h4fpngs7nw0nnu2j 117151000000ugrain
init "⭐️ PPNV Service ⭐️" paloma15y6l32vlwm4n4p7xztrsf3a7u8xn2r6e3m735k 7951000000ugrain
init NODEJUMPER paloma1kludne80z0tcq9t7j9fqa630fechsjhxhpafac 16091000000ugrain
init catone paloma10y227j9d09pckexy32v2gckerj9a0kcepc7zsh 23172000000ugrain
init wingsnodeteam paloma1j2zvqhxqycxlxj3stnmun8060wfhfw57up40dc 11033000000ugrain
init Midora paloma1zhhwr8gk8pqf9p9eamxnqqstmtszjazwywr285 10949000000ugrain
init Conqueror paloma174l5um5rahquqxlvchyhfeveuue7j8faw7atq7 23302000000ugrain
init Coinstamp paloma1jr353upa2jcg2af20lkq5ch60npk4a3wmcut9q 11493000000ugrain
init mssahin paloma1z9fgzh7mzqgu33pdkxw0dqmqgm9l8exj4nggcp 11622000000ugrain
init SECARD paloma16lez38lgsgu34ka2gq8yee8a862zpgs4rt52xs 10728000000ugrain
init Firstcome paloma1d0py2ucz2jrz69ca5l3pd4dfrmv64r24wu00ja 19568000000ugrain
init Nodes.Guru paloma15gvyk43x406v7kcd4rff5qfutqmcnpj3p4ea9g 10764000000ugrain
init "ERN VENTURES" paloma1am3k7czusdcewv55nhaugu2drn38af9449yxzj 9947000000ugrain
init NakoTurk paloma1sz3zjcyq8cd3e2k9kx6d44s8wnavfsy2gpf0y2 10887000000ugrain
init "MCB | mcbnode" paloma1d3v3jh6l2r23y9kgzdrahx0ev8ez0g8qapsfxs 11057000000ugrain
init kjnodes paloma13uslh0y22ffnndyr3x30wqd8a6peqh255hkzrz 10528000000ugrain
init 41uve12 paloma1c8uxkkz00qn97wsp9um8y3a8wlmrv3c5629jrn 10857000000ugrain
init KingSuper paloma1cs6trg6chgcw0t8dzjx9tup7emctxxtwehg6kq 13529000000ugrain
init beething paloma1p4r04ek0jnngegmw76rpx66xu9ep0kuzrge6jh 9735000000ugrain
init Everstake paloma1sysfu6jw5q7za5t5ddhkjm7uvanvy6nm5ac5j8 10052000000ugrain
init silent paloma1npwku4dmlnfwx9vqjnxzpfvdyxtcqvh3cqcl5x 10000000000ugrain
init panxinyang paloma1aec790r8v55a5kntfmmver0zwvekptggt7n6j2 10009000000ugrain
init mahof paloma1tsu8nthuspe4zlkejtj3v27rtq8qz7q62hx7ae 63172000000ugrain
init igval1 paloma1zz9fnrcpse9fjrq2sjg6rtxhv9z3uyeswyxejx 10001000000ugrain
init azstake paloma17kdfltcu45llx54ue0fvj8m4z9gd3ps4eg7v2n 10515000000ugrain
init "STC Capital" paloma10gsgzpryhkz34u6pdm97kjla8hkx2pwl49ncnu 10015000000ugrain
init Hdmiimdh paloma1hj4lxqp05ntjl6ezu3qn9eyedp5p4fpdwu8gxj 10140000000ugrain
init bellatora paloma1xmm7rf06d3d8l5zmj2jmcjrfftf5kctn9602gt 10733000000ugrain
init nazar_father paloma1s2jzpdfedxqfmttl55f9yvhmpgj738t2qkuaql 11990000000ugrain
init nodepro.xyz paloma1xaelfvaltqr3g7lurvrxtuh4krhmtgw4jxw94z 10024000000ugrain
init Flashneo paloma1n7ypqlhwtygn8aucp6m0wwxn0umeljnlrncpgg 11572000000ugrain
init NoFloat paloma1n3lnqk3mf5seau5rcnf0jysraq2ah73h5vpqed 11050000000ugrain
init byte_master paloma1kqufqd069ewrst92augwrywaagkwyrjs0jkkez 10853000000ugrain
init superjax paloma18tz9pqy2aaadax29xnszyvp805cf0fdpxtmz4h 12142000000ugrain

palomad genesis collect-gentxs