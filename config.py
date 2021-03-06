from enum import Enum, unique
import cx_Oracle

HTTP_OK = 200  # 请求成功,并且处理无错误
HTTP_Created = 201  # 已创建。成功请求并创建了新的资源
HTTP_Accepted = 202  # 已接受。已经接受请求，但未处理完成
HTTP_Partial_Content = 206  # 部分内容。服务器成功处理了部分GET请求
HTTP_NO_Content = 204

# 400
HTTP_Bad_Request = 400  # 客户端请求的语法错误，服务器无法理解
HTTP_Unauthorized = 401  # 请求要求用户的身份认证
HTTP_Forbidden = 403  # 服务器理解请求客户端的请求，但是拒绝执行此请求
HTTP_NotFound = 404  # 没找到

# 500
HTTP_Server_Error = 500  # 服务器内部错误，无法完成请求

save_db_path = 'db'

replace_threshold = 0.6

errors = {
    'UserAlreadyExistsError': {
        'message': "A user with that username already exists.",
        'status': 409,
    },
    'ResourceDoesNotExist': {
        'message': "A resource with that ID no longer exists.",
        'status': 410,
        'extra': "Any extra information you want.",
    },
    'sqlalchemy.exc.IntegrityError': {
        'message': "your commit is wrong",
        'status': HTTP_Server_Error,
        'extra': "IntegrityError"
    },
    'IntegrityError': {
        'message': "your commit is wrong",
        'status': HTTP_Server_Error,
        'extra': "IntegrityError"
    }
}
dsn = cx_Oracle.makedsn("ora11g", 1522, service_name="orcl.cs.cityu.edu.hk")


def init_stu_oracle_conns():
    global stu_oracle_conns
    stu_oracle_conns = dict()  # Students' oracle connection pool
    print("Global students' oracle connection pool is initialized")


@unique
class type_submit(Enum):
    all_right = 0
    error_spelling = 1
    error_result = 2
    error_syntax = 3


def get_shortage_error_dic(name):
    return {'msg': 'required %s parameter' % (name,)}


def get_common_error_dic(msg):
    return {'msg': msg}, HTTP_Bad_Request


def get_except_error(e, state=HTTP_Bad_Request):
    return {'msg': str(e)}, state


def RunSqlScript(conn, scriptName, **kwargs):
    cursor = conn.cursor()
    sqlFile = open(scriptName)
    try:
        cursor.execute("drop table dept")
        cursor.execute("drop table salgrade")
        cursor.execute("drop table emp")
        cursor.execute("drop table MY_EMP")
    except Exception as e:
        print(e.__str__())
        print("Table not exists!")
    for line in sqlFile:
        # print(line)
        # print(line.strip('\n').strip(';'))
        cursor.execute(line.strip('\n').strip(';'))


def RunMultiLineSql(conn, sql):
    cur = conn.cursor()
    sqls = sql.spilt('\n')
    for line in sqls:
        cur.execute(line.strip('\n').strip(';'))
    return cur
