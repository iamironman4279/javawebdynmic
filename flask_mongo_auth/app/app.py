from flask import Flask, render_template, request, redirect, url_for
from flask_pymongo import PyMongo

app = Flask(__name__)
app.config['MONGO_URI'] = 'mongodb://mongo:27017/testdb'
mongo = PyMongo(app)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # Retrieve username and password from the form
        input_username = request.form['username']
        input_password = request.form['password']

        # Query the database to find a user with the given username and password
        user = mongo.db.users.find_one({'username': input_username, 'password': input_password})

        # Check if the user exists in the database
        if user:
            return redirect(url_for('home'))
        else:
            return render_template('login.html', error='Invalid credentials')

    return render_template('login.html', error=None)

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        # Perform registration logic (insert user into the database)
        # For simplicity, let's assume a single 'users' collection in MongoDB
        users = mongo.db.users
        existing_user = users.find_one({'username': request.form['username']})
        if existing_user is None:
            users.insert_one({'username': request.form['username'], 'password': request.form['password']})
            return redirect(url_for('login'))
        else:
            return render_template('register.html', error='Username already exists')
    return render_template('register.html', error=None)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
