import os

n = int(raw_input("Number of integers: "))
sort = open("OESortX.bsv", 'r').read().split('\n')
merge = open("OEMergeX.bsv", 'r').read().split('\n')
sort_outfile = open("OESort" + str(n) + ".bsv", 'w')
merge_outfile = open("OEMerge" + str(n) + ".bsv", 'w')
while n >= 4:
    sort_out = []
    for line in sort:
        change = line.replace("X", str(n)).replace("Y", str(n/2))
        sort_out.append(change)
    sort_out = "\n".join(sort_out)
    sort_outfile.write(sort_out)

    merge_out = []
    for line in merge:
        change = line.replace("X", str(n)).replace("Y", str(n/2))
        out.append(change)
    merge_out = "\n".join(merge_out)
    merge_outfile.write(merge_out)

    n /= 2

