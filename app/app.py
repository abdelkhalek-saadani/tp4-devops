from flask import Flask, jsonify
import numpy as np

app = Flask(__name__)

@app.route('/', methods=['GET'])
def get_data():
    response = {
        'data': 'Hello World!'
    }
    return jsonify(response)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)