import sqlite3
from sqlite3 import Error
import os


def create_connection(db_file):
    """ create a database connection to a SQLite database """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except Error as e:
        print(e)
    finally:
        if conn:
            print(conn)
            conn.close()


if __name__ == '__main__':
    print(os.getcwd())
    create_connection(r"..\db\pythonsqlite.db")