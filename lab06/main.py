import psycopg2 as pg

# SELECT * FROM pg_stat_activity;

# SELECT pg_terminate_backend( pid ) FROM pg_stat_activity WHERE pid <> pg_backend_pid( ) AND datname = 'db_olympic';

def scalar_request(cursor, conn):
    cursor.execute('select count(*) from athletes')
    data = cursor.fetchall()
    print('Колличество атлетов за всё время проведения олим. игр:', data[0][0])


def joins_request(cursor, conn):
    cursor.execute(
        'select * ' + 
        'from medal as m join athletes as a on m.id = a.id ' +
        'join games as g on m.idgame = g.idgame'
    )
    for el in cursor.fetchmany(size=5): print(el)


# вывести индкс, id атлета и кол-во медалей
def cte_request(cursor, conn):
    cursor.execute(
        'WITH person_medal(id, count_medal) AS ( ' +
            'SELECT id, COUNT(medal) as count_medal ' +
            'FROM medal ' +
            'WHERE medal IS NOT NULL ' +
            'GROUP BY id ' +
            'ORDER BY COUNT(medal) desc ' +
        ') ' +
        'SELECT row_number() OVER ()  AS num, id, count_medal ' +
        'FROM person_medal;'
    )
    for el in cursor.fetchall(): print(el)


 # список созданных мною таблиц
def metadata_request(cursor, conn):
    cursor.execute('SELECT tablename ' +
    'FROM pg_tables ' +
    'WHERE schemaname = %(type)s', {"type":"public"})
    print('Список таблиц "public":')
    for el in cursor.fetchall(): print(el[0])


def scalar_lab03(cursor, conn):
    print("5й по суммарному зачёту медалей:")
    cursor.execute('select get_name_by_best_count_medal(%s)', ("6"))
    data = cursor.fetchall()
    print(data[0][0])


def manyoper_lab03(cursor, conn):
    print("сравнение со средними данными:")
    cursor.execute('select * from compar_avr_params()')
    for el in cursor.fetchall(): print(el)


def proc_lab03(cursor, conn):
    print("добавить 5 первых строк таблицы games в games_buffer")
    cursor.execute('call curproc(%s)', ("3"))
    conn.commit()


def system_func(cursor, conn):
    cursor.execute('select version()')
    print('Версия PostgreSQL:')
    print(cursor.fetchall()[0][0])


def create_table(cursor, conn):
    cursor.execute(
        'create table if not exists python_games( ' +
        'idgame integer, ' +
        'city varchar, ' +
        'year integer, ' +
        'season varchar ' +
        ')'
    )
    conn.commit()
    print("таблица создана")


def insert_python_games(cursor, conn):
    cursor.execute(
        'insert into python_games ' +
        'select * ' +
        'from games ' +
        'limit %s', ("5") 
    )
    conn.commit()
    print("вставка обработана")


def print_menu():
    print('\n1 - Выполнить скалярный запрос;')
    print('2 - Выполнить запрос с несколькими соединениями (JOIN);')
    print('3 - Выполнить запрос с ОТВ (CTE) и оконными функциями;')
    print('4 - Выполнить запрос к метаданным;')
    print('5 - Вызвать скалярную функцию (написанную в третьей лабораторной работе);')
    print('6 - Вызвать многооператорную или табличную функцию (написанную в третьей лабораторной работе);')
    print('7 - Вызвать хранимую процедуру (написанную в третьей лабораторной работе);')
    print('8 - Вызвать системную функцию или процедуру;')
    print('9 - Создать таблицу в базе данных, соответствующую тематике БД;')
    print('10 - Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT или COPY.')
    print('\n0 - Выход\n')


def menu(list_func):
    conn = pg.connect(dbname='db_olympic', user='postgres', 
                  password='paw.toporkov', host='localhost')
    cursor = conn.cursor()

    while True:
        print_menu()
        data = int(input('Введите пункт меню: '))
        print('\n')
        if not data:
            break
        elif data in range(1, 11):
            list_func[data - 1](cursor, conn)
        else:
            continue
    
    cursor.close()
    conn.close()




list_func = [
    scalar_request, 
    joins_request,
    cte_request,
    metadata_request,
    scalar_lab03,
    manyoper_lab03,
    proc_lab03,
    system_func,
    create_table,
    insert_python_games
]

print()
menu(list_func)



