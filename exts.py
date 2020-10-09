from flask_sqlalchemy import SQLAlchemy
import cx_Oracle

db = SQLAlchemy()


def init_oracle():
    cx_Oracle.init_oracle_client(lib_dir=r"D:\Dropbox\Courses\TA\CS3402\lab\instantclient_19_8")
