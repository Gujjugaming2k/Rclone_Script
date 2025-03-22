from flask import Flask, request, jsonify, redirect
import requests
import re

app = Flask(__name__)

def extract_video_url(base_url):
    default_domain = "https://streamtape.com/"
    headers = {
        'Referer': default_domain,
        'User-Agent': 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36'
    }
    
    try:
        response = requests.get(base_url, headers=headers).text
        regex_pattern = r"document\.getElementById\(['\"]captchalink['\"]\)\.innerHTML\s*=\s*['\"]([^'\"]+)['\"].*?\+\s*\(['\"]([^'\"]+)['\"]\)\.substring\(\d+\);"
        match = re.search(regex_pattern, response)
        
        if match:
            video_url = "https:" + match.group(1) + match.group(2)[4:]
            return video_url
        else:
            return None
    except Exception as e:
        return None

@app.route('/get_video', methods=['GET'])
def get_video():
    base_url = request.args.get('base_url')
    
    if not base_url:
        return jsonify({"error": "Missing 'base_url' parameter"}), 400
    
    video_url = extract_video_url(base_url)
    if video_url:
        return jsonify({"video_url": video_url, "message": "This link is only valid for your current IP."})
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
    app.run(host='0.0.0.0', port=5014, debug=True)
