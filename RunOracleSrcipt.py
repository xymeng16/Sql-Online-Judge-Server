def RunSqlScript(conn, scriptName, **kwargs):
    cursor = conn.cursor()
    sqlFile = open(scriptName)
    for line in sqlFile:
        print(line)
        print(line.strip('\n').strip(';'))

        cursor.execute(line.strip('\n').strip(';'))
