from flask      import Flask, render_template, request, jsonify
from subprocess import call
import json

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/lights', methods = ['POST'])
def lights():
    content = request.get_json()

    red = orange = green = "0"
    if content["red"] == 1:
        red = "1"
    if content["orange"] == 1:
        orange = "1"
    if content["green"] == 1:
        green = "1"
    call(["/usr/bin/clewarecontrol", red, orange, green])
    return jsonify({"status": 0})

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=80)
