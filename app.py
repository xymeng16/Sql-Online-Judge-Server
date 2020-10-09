from flask import Flask
from flask_restful import Api
import flask_cors
from exts import db
import exts
from resources.adminSession import AdminSession
from resources.studentSession import StudentSession
from resources.schemas import Schema, SchemaList
from resources.table import Table, TableList
from resources.rows import Rows, RowsList
from resources.students import StudentList, Students
from resources.question import QuestionList, Questions
from resources.answer import AnswerList, Answers
from resources.segmentation import Segmentation, SegmentationList
from resources.submit import SubmitList, Submits
from resources.stats import CorrectRate, Stats, CheckResult

import config

app = Flask(__name__)
api = Api(app, errors=config.errors)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/sql_online_judge'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)
flask_cors.CORS(app)


@app.route('/')
def hello_world():
    return 'Hello World!'


api.add_resource(Students, '/student/<string:student_id>')
api.add_resource(StudentList, '/student')

api.add_resource(AdminSession, '/session/admin')
api.add_resource(StudentSession, '/session/student')

api.add_resource(Schema, '/schema/<int:schema_id>')
api.add_resource(SchemaList, '/schema')

api.add_resource(Table, '/schema/<int:idSchema>/table/<int:table_id>')
api.add_resource(TableList, '/schema/<int:idSchema>/table')

api.add_resource(Rows, '/table/<int:idTable>/rows/<int:rows_id>')
api.add_resource(RowsList, '/table/<int:idTable>/rows')

api.add_resource(Questions, '/question/<int:question_id>')
api.add_resource(QuestionList, '/question')

api.add_resource(Answers, '/question/<int:idQuestion>/answer/<int:answer_id>')
api.add_resource(AnswerList, '/question/<int:idQuestion>/answer')

api.add_resource(Segmentation, '/answer/<int:idAnswer>/segment/<int:segmentation_id>')
api.add_resource(SegmentationList, '/answer/<int:idAnswer>/segment')

api.add_resource(Submits, '/student/<int:idStudent>/submit/<int:submit_id>')
api.add_resource(SubmitList, '/submit', '/question/<int:idQuestion>/submit',
                 '/question/<int:idQuestion>/student/<int:idStudent>/submit')

api.add_resource(CorrectRate, '/question/<int:question_id>/correct_rate')
api.add_resource(Stats, '/question/<int:question_id>/stats')
api.add_resource(CheckResult, '/check_result/<int:submit_id>')

if __name__ == '__main__':
    config.init_stu_oracle_conns()
    exts.init_oracle()
    app.run(debug=True)
