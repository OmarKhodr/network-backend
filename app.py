from flask import Flask, request, jsonify
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


#APPLICATION
@app.route('/application', methods=['POST'])
def add_application():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO application(student_id,company_id,submission_date,status) VALUES (%s, %s, %s, %s)", (json['student_id'], json['company_id'], json['submission_date'], json['status']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/application', methods=['DELETE'])
def delete_application():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM application where id = %s " , (json['id']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/application', methods = ['PATCH'])
def update_application():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("Update application SET status = %s WHERE id = %s ", ([json['id']]))
    mysql.connection.commit()
    cur.close()
    return 'success'


#COMPANY
@app.route('/company', methods=['POST'])
def add_company():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO company (`company_name`, `location`, `number_of_employees`, `company_address`, `field`, `phone_number`, `company_email`) VALUES (%s, %s, %s, %s, %s, %s, %s)", (json['company_name'], json['location'], json['number_of_employees'], json['company_address'], json['field'], json['phone_number'], json['company_email']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/company', methods=['DELETE'])
def delete_company():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM company where company_id = %s" , (json['company_id']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/company', methods = ['PATCH'])
def update_company():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("Update company SET company_name = %s WHERE company_id = %s", ([json['company_name'], json['company_id']]))
    mysql.connection.commit()
    cur.close()
    return 'success'


#REPRESENTATIVE
@app.route('/representative', methods=['POST'])
def add_representative():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO representative VALUES (%s, %s, %s, %s, %s)", (json['company_id'], json['email'], json['phone_number'], json['rep_name'], json['positions']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/representative', methods=['DELETE'])
def delete_representative():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM representative where company_id = %s and email = %s" , (json['company_id'], json['email']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/representative', methods = ['PATCH'])
def update_representative():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("Update representative SET rep_name = %s WHERE company_id = %s and email = %s", ([json['rep_name'], json['company_id'], json['email']]))
    mysql.connection.commit()
    cur.close()
    return 'success'


#REVIEW
@app.route('/review', methods=['POST'])
def add_review():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO review (company_id, student_id, original_poster, activity, overall_rating, recommend_rating, interview_rating, offer_reception, subject, body) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (json['company_id'], json['student_id'], json['original_poster'], json['activity'], json['overall_rating'], json['recommend_rating'], json['interview_rating'], json['offer_reception'], json['subject'], json['body']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/review', methods=['DELETE'])
def delete_review():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM review where review_id = %s" , (json['review_id']))
    mysql.connection.commit()
    cur.close()
    return 'success'

@app.route('/review', methods = ['PATCH'])
def update_review():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("Update review SET body = %s WHERE review_id = %s", ([json['body'], json['review_id']]))
    mysql.connection.commit()
    cur.close()
    return 'success'




## Complex Queries ##

# Get all Students who applied to a certain Company with GPA of >= 85
@app.route('/complex1', methods = ['POST'])
def get_First_Query():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute(
        "Select name, GPA from (Select id, name, GPA from network.degree INNER JOIN (Select student_id as id, name from network.student INNER JOIN (Select * from network.application where company_id = (Select company_id from network.company where company_name = %s)) as MyCompany on MyCompany.student_id = network.student.id) as MyStudents on MyStudents.id = network.degree.student_id) as Result where Result.GPA >= %s", ([[json['company']], json['GPA']])
    )
    res = []
    for row in cur:
        res.append(row)
    return jsonify(res)

# Get all job openings with a salary offering of more than 10,000$
@app.route('/complex2', methods = ['POST'])
def get_Second_Query():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("SELECT company_name, job_name, amount FROM jobposition inner join company on jobposition.company_id=company.company_id  inner join salary on jobposition.job_id=salary.job_id WHERE amount > %s", ([json['amount']]))
    res = []
    for row in cur:
        res.append(row)
    return jsonify(res)

# Get all job openings with an "intern" term in the description from murex
@app.route('/complex3', methods = ['POST'])
def get_Third_Query():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("SELECT company_name, job_name FROM jobposition inner join company on jobposition.company_id=company.company_id WHERE job_name like '%intern%' ")
    res = []
    for row in cur:
        res.append(row)
    return jsonify(res)

# get all students in CSE major with a graduation date before 2025
@app.route('/complex4', methods = ['POST'])
def get_fourth_Query():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("SELECT s.id, s.name FROM student s JOIN degree d ON s.id=d.student_id WHERE dateOfGraduation <= \'2026-01-01\' AND major='CSE'")
    res = []
    for row in cur:
        res.append(row)
    return jsonify(res)
