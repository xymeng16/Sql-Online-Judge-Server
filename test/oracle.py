import cx_Oracle

cx_Oracle.init_oracle_client(lib_dir=r"D:\Dropbox\Courses\TA\CS3402\lab\instantclient_19_8")
dsn = cx_Oracle.makedsn("ora11g", 1522, service_name="orcl.cs.cityu.edu.hk")
conn = cx_Oracle.connect("xianmeng5", "Mxy970207", dsn)
cur = conn.cursor()
rows = cur.execute("SELECT owner, table_name FROM all_tables")
for row in rows:
    print(row)