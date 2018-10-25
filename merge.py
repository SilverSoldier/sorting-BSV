import os

n = 4
inp = open("OEMergeX.bsv", 'r').read().split('\n')
while n >= 4:
    outfile = open("OEMerge" + str(n) + ".bsv", 'w')
    out = []
    for line in inp:
        change = line.replace("X", str(n)).replace("Y", str(n/2))
        out.append(change)
    out = "\n".join(out)
    outfile.write(out)
    n /= 2
