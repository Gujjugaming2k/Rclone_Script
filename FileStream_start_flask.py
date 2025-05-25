from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/run_filestream', methods=['GET'])
def run_filestream():
    command = "nohup sudo python3 -m FileStream > /tmp/opt/jellyfin/FileStream_bot_output.log 2>&1 &"
    process = subprocess.Popen(command, shell=True)
    return jsonify({"message": "FileStream bot started!", "pid": process.pid})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5018)
