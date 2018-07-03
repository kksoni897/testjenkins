from flask import Flask,Response
app = Flask(__name__)


@app.route('/test')
def test():
    return Response(status=200)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=9020, threaded=True)
