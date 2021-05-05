from flask import Flask, request
from flask_mysqldb import MySQL
from flask_cors import CORS

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'scout is on saturday'
app.config['MYSQL_DB'] = 'network'
CORS(app)
mysql = MySQL(app)


# STUDENT #

@app.route('/student', methods=['POST'])
def add_student():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO student(SSN, email, name, address, phone) VALUES (%s, %s, %s, %s, %s)", (int(json['SSN']), json['email'], json['name'], json['address'], json['phone']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/student', methods=['DELETE'])
def delete_student():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM student where id = %s", [json['id']])
    mysql.connection.commit()
    cur.close()
    return 'success'




# COURSE #

@app.route('/course', methods=['POST'])
def add_course():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO course(name, student_id) VALUES (%s, %s)", (json['name'], int(json['student_id'])))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/course', methods=['DELETE'])
def delete_course():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM course where name = %s", [json['name']])
    mysql.connection.commit()
    cur.close()
    return 'success'




# ALUMNI #

@app.route('/alumni', methods=['POST'])
def add_alumni():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO alumni(student_id, yearsOfExperience, openToJob, currentJob) VALUES (%s, %s, %s, %s)", (int(json['student_id']), int(json['yearsOfExperience']), int(json['openToJob']), json['currentJob']))
    mysql.connection.commit()
    cur.close()
    return 'success'




# DEGREE #

@app.route('/degree', methods=['POST'])
def add_degree():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO degree(major, student_id, type , GPA , dateOfGraduation) VALUES (%s, %s, %s, %s, %s)", (json['major'], int(json['student_id']), json['type'], int(json['GPA']), json['dateOfGraduation']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/degree', methods=['DELETE'])
def delete_degree():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM degree where student_id = %s", [json['student_id']])
    mysql.connection.commit()
    cur.close()
    return 'success'



# SKILL #

@app.route('/skill', methods=['POST'])
def add_skill():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO skill(student_id, name) VALUES (%s, %s)", (int(json['student_id']), json['name']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/skill', methods=['DELETE'])
def delete_skill():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM skill where student_id = %s AND name = %s", (json['student_id'], json["name"]))
    mysql.connection.commit()
    cur.close()
    return 'success'