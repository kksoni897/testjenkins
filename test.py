from flask import Flask
import gunicorn
app = Flask(__name__)


@app.route('/')
def hello():
    return "Hello World!!!!, krishna is here!"

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=9020, threaded=True)
