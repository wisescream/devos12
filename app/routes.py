from flask import Blueprint, render_template, request, flash, redirect, url_for
from app.models import User, Post
from app import db

bp = Blueprint('main', __name__)

@bp.route('/')
def index():
    return render_template('index.html')

@bp.route('/dashboard')
def dashboard():
    return render_template('dashboard.html')
# Add this to your existing routes.py
@bp.route('/dashboard')
def dashboard():
    user_count = User.query.count()
    return render_template('dashboard.html', user_count=user_count)

@bp.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        
        # Basic validation
        if not username or not email:
            flash('Username and email are required!', 'error')
        else:
            user = User(username=username, email=email)
            db.session.add(user)
            db.session.commit()
            flash('Registration successful!', 'success')
            return redirect(url_for('main.dashboard'))
    
    return render_template('register.html')

@bp.route('/api/data')
def get_data():
    return {'data': [1, 2, 3, 4, 5]}