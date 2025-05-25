from flask import Flask, jsonify
import subprocess
import shlex

app = Flask(__name__)

@app.route('/run_filestream', methods=['GET'])
def run_filestream():
    command = "nohup sudo python3 -m FileStream > /tmp/opt/jellyfin/FileStream_bot_output.log 2>&1 &"
    
    try:
        process = subprocess.Popen(shlex.split(command), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return jsonify({"message": "FileStream bot started!", "pid": process.pid})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5018, debug=True)
