from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/run_filestream', methods=['GET'])
def run_filestream():
    command = "sudo python3 -m FileStream"
    working_dir = "/opt/FileStreamBot/"

    try:
        # Run command from specified directory and capture output
        process = subprocess.Popen(
            command,
            shell=True,
            cwd=working_dir,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True
        )
        output, _ = process.communicate(timeout=30)  # Adjust timeout as needed
        return jsonify({"message": "FileStream executed.", "output": output})
    except subprocess.TimeoutExpired:
        process.kill()
        return jsonify({"error": "FileStream timed out."}), 504
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/run_ftp', methods=['GET'])
def run_ftp():
    command = "grep 'Generated random admin password' /workspaces/php_server.log | awk -F': ' '{print $2}'"
    
    try:
        # Run command in shell to use pipes and awk
        output = subprocess.check_output(command, shell=True, text=True).strip()
        return jsonify({"message": f"*Admin Password:* `{output}`"})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": "Failed to retrieve password", "details": e.output}), 500
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5018, debug=True)
