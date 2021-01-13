import peewee as pw
from playhouse.postgres_ext import *


conn = pw.PostgresqlDatabase(
    'db_olympic', 
    user='postgres', 
    password='paw.toporkov',
    host='localhost'
)
cursor = conn.cursor()


# объявим классы для работы с таблицами базы данных
class Base(pw.Model):
    class Meta:
        database = conn


class Athletes(Base):
    id = pw.IntegerField(column_name='id', primary_key=True)
    name = pw.TextField(column_name='name')
    sex = pw.TextField(column_name='sex')
    age = pw.IntegerField(column_name='age')
    height = pw.DoubleField(column_name='height')
    weight = pw.DoubleField(column_name='weight')
    noc = pw.TextField(column_name='noc')
    sport = pw.TextField(column_name='sport')

    class Meta:
        tablename = 'athletes'

class Medal(Base):
    id = pw.IntegerField(column_name='id')
    idgame = pw.IntegerField(column_name='idgame')
    sport = pw.TextField(column_name='sport')
    event = pw.TextField(column_name='event')
    medal = pw.TextField(column_name='medal')

    class Meta:
        tablename = 'medal'


class Games_json_data(Base):
    class Meta:
        tablename = 'games_json_data'
    
    idgame = pw.IntegerField(column_name='idgame', primary_key=True)
    info_game =  JSONField(column_name='info_game')


# 1.1
def from_req():
    return (
        Athletes.select()
    )


# 1.2
def where_req():
    return (
        Athletes.select()
                .where(Athletes.age > 30)
    )


# 1.3
def order_by_req():
    return (
        Medal.select()
             .order_by(Medal.id.desc())
    )


# 1.4
def group_by_req():
    return (
        Medal.select(
                Medal.id, 
                pw.fn.COUNT(Medal.medal).alias("count_medal")
            ).group_by(Medal.id)
    )


# 1.5
def having_on_req():
    return (
        Medal.select(
                Medal.id, 
                pw.fn.COUNT(Medal.medal).alias("count_medal")
            ).group_by(Medal.id)
             .having(pw.fn.COUNT(Medal.medal) > 0)
    )

# 2
def json_read():
    return (
        Games_json_data.select(Games_json_data.info_game["city"].alias("city"))
    )

def json_update():
    (Games_json_data.update(info_game={'city': 'MosRu'})
                    .where(Games_json_data.info_game["city"] == "St. Louis")).execute()


def json_insert():
    Games_json_data.insert(idgame=37, info_game={"city": "night city2"}).execute()


# 3
def single_req():
    return (
        Medal.select(
                Medal.id, 
                pw.fn.COUNT(Medal.event).alias("count_events")
            ).group_by(Medal.id)
    )


def multy_table_req():
    return (
        Medal.select(
                Medal.id, 
                (Athletes.name).alias("name"),
                Medal.event
            ).join(Athletes, on=(Medal.id == Athletes.id))
             .group_by(Medal.id, Athletes.name, Medal.event)
    )


def insert_data_req():
    (
        Athletes.insert(
            id=136000,
            name='Ups;(',
            sex='M',
            age=33,
            height=176,
            weight=86,
            noc='ALB',
            sport="Football Men's Football"
        )
    ).execute()


def del_data_req():
    (
        Athletes.delete()
                .where(Athletes.id == 136000)
    ).execute()


def upload_data_req():
    (
        Athletes.update(name="Lexa")
                .where(Athletes.id == 136000)
    ).execute()

def call_my_proc(cursor):
    cursor.execute('call curproc(11)')


#json_update()
json_insert()
#del_data_req()
#call_my_proc(cursor)
# data = multy_table_req()
# print(data, end='\n\n')
# for el in data.dicts()[:10]:
#     print(el)

cursor.close()
conn.close()