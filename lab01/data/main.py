import csv

with open("./nation1.csv", "r") as fr, open("./nation.csv", "w") as fw:
    reader = csv.reader(fr)
    writer = csv.writer(fw)

    for row in reader:
        curRow = [row[0]] + list(map(lambda el: el.replace("NA", ""), row[1:]))
        writer.writerow(curRow)
