fin = open("text", 'r')

fout = open("words_for_essay", 'w')

a = fin.read()
l = len(a)
for i in range(l):
    if a[i].isalpha() or a[i] == ' ' or a[i] == '\n':
        fout.write(a[i])

fin.close()
fout.close()
