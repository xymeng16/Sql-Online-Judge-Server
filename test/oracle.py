import cx_Oracle
from config import RunSqlScript

cx_Oracle.init_oracle_client(lib_dir=r"D:\Dropbox\Courses\TA\CS3402\lab\instantclient_19_8")
dsn = cx_Oracle.makedsn(host="ora11g.cs.cityu.edu.hk", port=1522, service_name="orcl.cs.cityu.edu.hk")
conn = cx_Oracle.connect("xianmeng5", "Mxy970207", dsn)
cur = conn.cursor()
# # cur.execute("insert into test values(4)")
# rows = cur.execute("SELECT * from test")
# for row in rows:
#     print(row)
# RunSqlScript(conn, 'D:\\Code\\Sql-Online-Judge-Server\\sql\\Lab1Data.sql')
cur.execute("CREATE TABLE MY_EMP2 AS SELECT * FROM EMP")