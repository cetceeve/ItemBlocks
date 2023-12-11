from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return app.send_static_file('index.html')

if __name__ == '__main__':  # pragma: no cover
    app.run(host='0.0.0.0', port=8080)
