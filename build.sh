
#CC=gcc ; ExtraFlags="-fopenmp"
CC=clang ; ExtraFlags="-Wno-dollar-in-identifier-extension -fopenmp=libomp"

BaseFlags="-pthread -lpthread -D_POSIX_C_SOURCE=199506L -pedantic -std=c99 -g3 -O3 -lm -oNAR"


echo "Stage -1: Clean"
rm -f NAR src/RuleTable.c

echo "Stage 0: Base"
Src=`ls src/*.c src/*/*.c | xargs`

$CC $Src -DSTAGE=1 -Wall -Wextra -Wformat-security $BaseFlags $ExtraFlags

echo "Stage 1: RuleTable generation"
./NAR NAL_GenerateRuleTable > src/RuleTable.c


echo "Stage 2: Redundant Rebuild"
$CC $Src src/RuleTable.c -DSTAGE=2 $BaseFlags $ExtraFlags



