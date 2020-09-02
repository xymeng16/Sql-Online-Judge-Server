from flask_restful import Resource, reqparse, abort, fields, marshal_with, marshal
import models
from exts import db
from common.comm import auth_admin, auth_student
from config import *
from flask import request
from sqlalchemy import text

stats_field = {
    'sid': fields.String,
    'sname': fields.String,
    'correctness': fields.String,
    'submit_id': fields.String
}
results_field = {
    'stu_answer': fields.String,
    'key_answer': fields.String,
    'result': fields.String
}

stats_stmts = ['drop view if exists vtest;',
               'DROP TABLE IF EXISTS vtable;',
               'create table vtable (sid CHAR(10), sname CHAR(255), correctness char(255), submit_id char(10));',
               'create view vtest as select idStudent, student.name,IF(type=\'0\', \'Correct\', \'Incorrect\')'
               ' as correctness, submit.id from submit,student where idQuestion=\'{}\' and student.id=submit.idStudent;',
               'insert ignore into vtable select * from vtest where correctness=\'Correct\';',
               'insert into vtable select * from vtest where correctness=\'Incorrect\';',
               'select * from vtable;']


class Stats(Resource):

    def get(self, question_id=None):
        # if admin is None:
        #     return {}, HTTP_Forbidden
        db.engine.execute(stats_stmts[0])
        db.engine.execute(stats_stmts[1])
        db.engine.execute(stats_stmts[2])
        db.engine.execute(stats_stmts[3].format(str(question_id)))
        db.engine.execute(stats_stmts[4])
        db.engine.execute(stats_stmts[5])
        # stats_proxy = db.engine.execute(stats_stmts[6])
        stats = models.VTable.query.filter_by()
        for row in stats:
            print(row.submit_id)
        data = [marshal(stat, stats_field) for stat in stats]
        return {'data': data}, HTTP_OK


class CorrectRate(Resource):
    @auth_admin()
    def get(self, admin, question_id=None):
        if admin is None:
            return {}, HTTP_Forbidden
        correct_stu_num_stmt = text("select COUNT(DISTINCT idStudent) from submit "
                                    "where submit.type=0 and idQuestion=" + str(question_id))
        correct_stu_num_proxy = db.engine.execute(correct_stu_num_stmt)
        correct_stu_num = int([row[0] for row in correct_stu_num_proxy][0])
        stu_num_stmt = text("select COUNT(DISTINCT idStudent) from submit")
        stu_num_proxy = db.engine.execute(stu_num_stmt)
        stu_num = int([row[0] for row in stu_num_proxy][0])
        return {'rate': correct_stu_num / stu_num}, HTTP_OK


class CheckResult(Resource):

    def get(self, submit_id=None):
        result_proxy = db.engine.execute(text("select answer, correct, result from "
                                              "submit where id=" + str(submit_id)))
        for r in result_proxy:
            return {'answer': r['answer'], 'correct': r['correct'],
                    'result': r['result']}, HTTP_OK
