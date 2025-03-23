from flask import Flask, request, jsonify, redirect
import requests
import re

app = Flask(__name__)

def extract_video_url(base_url):
    supported_domains = [
        "https://vcloud.lol/",
        "https://hubcloud.dad/",
        "https://reviewsbuddy.in/"
    ]
    
    default_domain = next((d for d in supported_domains if d in base_url), supported_domains[0])

    headers = {
        'Referer': default_domain,
        'User-Agent': 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36'
    }

    try:
        # Get the first page response
        initial_response = requests.post(base_url, headers=headers).text

        # Extract next page URL
        base_match = re.search(r"var\s+url\s*=\s*'(https?:\/\/[^\s]+)'", initial_response)
        if not base_match:
            return None  # URL not found

        next_page_url = base_match.group(1)

        # Get second page response
        response = requests.get(next_page_url, headers=headers).text

        # Extract the final video URL
        video_match = re.search(r"https:\/\/pub[^\s\"']+", response)
        if video_match:
            return video_match.group(0).replace("\"", "")

        return None  # Video URL not found

    except Exception as e:
        print(f"Error: {e}")
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
    app.run(host='0.0.0.0', port=5016, debug=True)
