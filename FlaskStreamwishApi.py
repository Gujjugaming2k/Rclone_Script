from flask import Flask, request, jsonify, redirect
import requests
from bs4 import BeautifulSoup
import re
import ast

app = Flask(__name__)

def extract_video_url(base_url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36'
    }
    try:
        response = requests.get(base_url, headers=headers).text
        
        # Extract initial video URL
        initial_regex = r'file:"([^"]+)"'
        initial_match = re.search(initial_regex, response)
        
        if initial_match:
            return initial_match.group(1)
        
        # Fetch and parse the initial response
        soup = BeautifulSoup(response, 'html.parser')
        js_code = next((script.string for script in soup.find_all('script') if script.string and "eval(function(p,a,c,k,e,d)" in script.string), "")
        
        # Extract and clean the JS code
        encoded_packed = re.sub(r"eval\(function\([^)]+\)\{[^}]+\}\(|.split\('\|'\)\)\)", '', js_code)
        data = ast.literal_eval(encoded_packed)

        # Base-36 conversion helper function
        def to_base_36(n):
            return '' if n == 0 else to_base_36(n // 36) + "0123456789abcdefghijklmnopqrstuvwxyz"[n % 36]

        # Extract values from packed data
        p, a, c, k = data[0], int(data[1]), int(data[2]), data[3].split('|')

        # Replace placeholders with corresponding values
        for i in range(c):
            if k[c - i - 1]:
                p = re.sub(r'\b' + to_base_36(c - i - 1) + r'\b', k[c - i - 1], p)

        # Get final video URL
        video_url = re.search(r'file:"([^"]+)', p).group(1)
        return video_url
    except Exception as e:
        return None

@app.route('/get_video', methods=['GET'])
def get_video():
    base_url = request.args.get('base_url')
    
    if not base_url:
        return jsonify({"error": "Missing 'base_url' parameter"}), 400
    
    video_url = extract_video_url(base_url)
    if video_url:
        return jsonify({"video_url": video_url, "message": "Use 'Referer: https://rapidplayers.com' and a User-Agent to access."})
    else:
        return jsonify({"error": "Failed to extract video URL."}), 500

@app.route('/redirect_video', methods=['GET'])
def redirect_video():
    base_url = request.args.get('base_url')
    
    if not base_url:
        return jsonify({"error": "Missing 'base_url' parameter"}), 400
    
    video_url = extract_video_url(base_url)
    if video_url:
        return redirect(video_url)
    else:
        return jsonify({"error": "Failed to extract video URL."}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5015, debug=True)
