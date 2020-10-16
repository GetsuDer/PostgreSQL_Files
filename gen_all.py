import random
from random import choice as r
import json

places_num = 1000
directs_num = 30 * 1000
entrants_num = 20 * 100

cities = open("city", 'r').read().split()
place_type = ['Университет', 'Академия', 'Институт', 'Колледж']
place_name = open("place_names").read().split()
info = ['Лучшее место в мире', 'Вековые традиции', 'Квалифицированные преподаватели', 'Огромная нагрузка', 'Бессонные ночи', 'Возможность страдать', 'Знакомство с наукой', 'Вкусный гранит']

places = []
for ident in range(1, places_num + 1):
    place = [ident, random.choice(cities), random.choice(info), random.choice(place_type) + " имени " + random.choice(place_name)] 
    ident += 1
    places.append(place)



fout = open("places_out", 'w')
for place in places:
    for ind in range(len(place)):
        fout.write(str(place[ind]))
        if (ind != len(place) - 1):
            fout.write(';')
    fout.write('\n')

fout.close()

# направления

duration = ['12', '18', '24', '30', '48', '54', '60', '66', '72']
spec_name = open("spec_names", 'r').read().split('\n')

def exams():
    res = []
    num = random.randint(1, 3)
    while len(res) != num:
        ex_id = random.randint(1, 15)
        if not ex_id in res:
            res.append(ex_id)
    return res

direcs = []
for ident in range(1, directs_num + 1):
    direc = [ident, r(spec_name), r(duration), random.randint(1, places_num), random.randint(10, 500), exams()]
    direcs.append(direc)

fout = open("dir_out", 'w')
for i in direcs:
    fout.write(str(i[0]) + ';')
    fout.write(i[1] + ';')
    fout.write(i[2] + ';')
    fout.write(str(i[3]) + ';')
    fout.write(str(i[4]) + ';')
    fout.write('{')
    for j in range(len(i[5])):
        fout.write(str(i[5][j]))
        if j != len(i[5]) - 1:
            fout.write(',')
    fout.write('}\n')
fout.close()

# Студенты
names_w = open("names_w", 'r').read().split()
names_m = open("names_m", 'r').read().split()
second_names_w = open("second_names_w", 'r').read().split()
second_names_m = open("second_names_m", 'r').read().split()
third_names_w = open("third_names_w", 'r').read().split()
third_names_m = open("third_names_m", 'r').read().split()

def name():
    if (random.randint(0, 1)) == 1:
        return r(second_names_m) + ' ' + r(names_m) + ' ' + r(third_names_m)
    return r(second_names_w) + ' ' + r(names_w) + ' ' + r(third_names_w)

aps_id = 1
def aps():
    global aps_id
    res = []
    num = random.randint(3, 7)
    for i in range(num):
        res.append(aps_id)
        aps_id += 1
    return res
    

def exams():
    res = dict()
    num = random.randint(1, 15)
    for i in range(1, num + 1):
        res[i] = random.randint(40, 101)
    return res

word = open("words_for_essay", 'r').read().split()

def essay():
    res = ""
    num = random.randint(10, 50)
    for i in range(num):
        res = res + r(word) + ' '
    return res

entrants = []
for ident in range(1, entrants_num + 1):
    entrant = [ident, name(), exams(), aps(), essay()]
    entrants.append(entrant)


fout = open("entrants_out", 'w')
for entrant in entrants:
    fout.write(str(entrant[0]) + ';')
    fout.write(entrant[1] + ';')
    fout.write(json.dumps(entrant[2]) + ';') 
    fout.write('{')
    for i in range(len(entrant[3])):
        fout.write(str(entrant[3][i]))
        if (i != len(entrant[3]) - 1):
            fout.write(',')
    fout.write('};')
    fout.write(entrant[4] + '\n')
fout.close()

def find_entr(ident):
    for i in entrants:
        if ident in i[3]:
            return i[0]
    return -1

def make_dirs(ent):
    has = set(entrants[ent - 1][2].keys())
    while (True):
        dir_id = random.randint(1, directs_num)
        need = set(direcs[dir_id - 1][5])
        if need.issubset(has):
            return dir_id
    return -1

def score(ent, dirs):
    s = 0
    for i in direcs[dirs - 1][5]:
        s += entrants[ent - 1][2][i]
    return s

def date():
    return str(random.randint(1, 30)) + '/06/2020';

apps = []
for ident in range(1, aps_id):
    ent = find_entr(ident)
    if (ent == -1):
        print('error')
    dirs = make_dirs(ent)
    app = [ident, ent, dirs, date(), score(ent, dirs)]
    apps.append(app)

fout = open("applications_out", 'w')
for app in apps:
    fout.write(str(app[0]) + ';')
    fout.write(str(app[1]) + ';')
    fout.write(str(app[2]) + ';')
    fout.write(app[3] + ';')
    fout.write(str(app[4]) + '\n')
fout.close()
