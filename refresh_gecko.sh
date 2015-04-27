#!/bin/bash -x

DEVICE_NAME="flame"
BASE_DIR="/home/edwardchen/"
B2G_DIR="${BASE_DIR}/B2G"
GECKO_DIR="${BASE_DIR}/moz-gecko/mozilla-central"
IMAGES_DIR="${BASE_DIR}/images"
PROD="$(date +%y%m%d.%H.%M)"


# Merged changeset
MERGED_CHANGESET="
a6f037b538ed
"

#38e4719e71af

# 100 commits changeset
ALL_CHANGESET="
0f87f9d002c1
fabdf209d813
182fc9215d27
d47db7a17a2e
c7e7edea57c0
b36599b3df09
e815a6d601eb
77d19984fec7
eba034ecc128
869fb4fbada0
dd5baaca1e27
5a2adc165563
a40e2eeacf5a
63a17819ae94
37e5dfcc7674
6d131234e4d3
aa8f7229e2f5
2d11ab76ee6b
8698f3b5a1b5
b81f215db168
c3b4fc516509
3a36bc50398e
9bfda2f52e82
722169be8e14
0dc8aa096aca
9870579b8ea9
252f2c47f271
9201029f4d48
9ad5627c881d
dc0d932d2ecf
14c3ad8f6146
132b8377fb88
394aac76bf61
d1c55bb95e67
ce2241501510
a7384e567922
5336ba11be5d
ec68d1b95880
7c79302f32de
54be9bcdacd9
1b7345f206df
0e1056fb8804
d34e894a9ea2
787d202e63e4
8248339059d1
8c25582fc776
d91343f88f11
114d75337bed
88534cb4094a
ec1efe1d6f42
bab6997a3bf8
adba768607dc
99cbc6cca7df
1476b32400da
cf22f1909e1f
83b51c132519
f842d2ba5600
d6bdb55ff8bc
079ea32ad2b2
c46a5fd52909
f72f98ab8a3a
89ab4694b906
497f46d20ddd
f38152ce1255
ad130e07458d
3cfdd4c2d83b
feda8ca8f832
7345338634ab
615f118f2787
b878c753fbe7
7a7a248c492f
af81a26dae60
d7b40d5a4577
f8d8f84fc7bf
efe76955cea5
babd56077826
7c4059ebfcf7
d590c1f472b2
0bec74187553
b3040e65bab9
aa30a76266dd
a3cd2f1b3e33
f15260f6fa3e
c39414ca483a
1515b55fc761
68e641adcfb6
4bedf918aa45
b52cf00c286b
14e79b1c87cb
8f4943a9ad69
fcb33cbbe1d2
42a50f81f29d
85f601fa7b46
e19c170e727f
a31fe829631e
40a5dd69da69
a20b290d8c86
48171dc1a535
02cac0756bc1
a0db598f71a5
"


for i in $MERGED_CHANGESET; do

 # Switch hg revisions (Gecko's changeset)
 cd ${GECKO_DIR}
 hg update -r ${i}

 # Build gecko
 cd ${B2G_DIR}
 rm -rf objdir-gecko
 ./build.sh gecko -j4
 #echo "build success and start packing"

 # Copy gecko build to images folder ....
 cp -R ${B2G_DIR}/objdir-gecko/dist/b2g*.gz /home/edwardchen/images/
 cd ${IMAGES_DIR}
 mv b2g*.gz b2g_${i}.tar.gz
 #rename 's/(.*)$/new.$1/' original.filename
done




# system flame image: out/target/product/flame/system.img
# out/target/product/flame/system.img+out/target/product/flame/obj/PACKAGING/recovery_patch_intermediates/recovery_from_boot.p maxsize=385363968 blocksize=135168 total=193965785 reserve=3919872

