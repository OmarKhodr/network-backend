from flask import Flask, request
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'lobster'
app.config['MYSQL_DB'] = 'network'

mysql = MySQL(app)

@app.route('/student', methods=['POST'])
def hello_world():
    json = request.json
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO student(SSN, email, name, address, phone) VALUES (%s, %s, %s, %s, %s)", (int(json['SSN']), json['email'], json['name'], json['address'], json['phone']))
    mysql.connection.commit()
    cur.close()
    return 'success'