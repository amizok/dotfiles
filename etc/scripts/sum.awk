#!/usr/bin/env awk -f

{
    sum[$1]+=$2
};

END {
    for (key in sum) {
        print key, sum[key]
    }
}

