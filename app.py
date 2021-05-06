from flask import Flask, request
from flask_mysqldb import MySQL
from flask_cors import CORS

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'SimonSimon'
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

@app.route('/student', methods = ['PATCH'])
def update_student():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("Update student SET email = %s WHERE id = %s", [json['email'], json['id']])
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
    
@app.route('/degree', methods = ['PATCH'])
def update_degree():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("Update degree SET GPA = %s WHERE student_id = %s", [json['GPA'], json['student_id']])
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




#JOB POSITION  
@app.route('/position', methods=['POST'])
def add_position():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO jobposition VALUES (%s, %s, %s, %s, %s)", (json['job_id'], json['company_id'], json['job_name'], json['location'], json['n_openings']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/position', methods=['DELETE'])
def delete_position():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM jobposition where job_id = %s" , (json['job_id']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/position', methods = ['PATCH'])
def update_position():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("Update jobposition SET job_name = %s WHERE job_id = %s", ([json['job_name'], json['job_id']]))
    mysql.connection.commit()
    cur.close()
    return 'success'



#SALARY
@app.route('/salary', methods=['POST'])
def add_salary():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO salary VALUES (%s, %s, %s, %s, %s)", (json['job_id'], json['amount'], json['bonus'], json['stocks'], json['payment_rate']))
    mysql.connection.commit()
    cur.close()
    return 'success'  

@app.route('/salary', methods=['DELETE'])
def delete_salary():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM salary where job_id = %s and amount = %s" , (json['job_id'], json['amount']))
    mysql.connection.commit()
    cur.close()
    return 'success'



#REQUIREMENTS
@app.route('/requirement', methods=['POST'])
def add_requirement():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO requirement VALUES (%s, %s, %s, %s, %s)", (json['job_id'], json['requirement_name'], json['requirement_type'], json['description'], json['skill_name']))
    mysql.connection.commit()
    cur.close()
    return 'success'  

@app.route('/requirement', methods=['DELETE'])
def delete_requirement():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM requirement where job_id = %s and requirement_name = %s and requirement_type = %s" , (json['job_id'], json['requirement_name'], json['requirement_type']))
    mysql.connection.commit()
    cur.close()
    return 'success'













