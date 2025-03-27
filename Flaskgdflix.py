from flask import Flask, request, jsonify, redirect
import requests
from bs4 import BeautifulSoup

app = Flask(__name__)

def extract_mkv_url(url):
    response = requests.get(url)
    if response.status_code != 200:
        return None
    
    soup = BeautifulSoup(response.text, 'html.parser')
    
    # Find the anchor tag with class 'btn btn-success'
    download_link = soup.find('a', class_='btn btn-success')
    
    if download_link and 'href' in download_link.attrs:
        return download_link['href']
    return None

@app.route('/get_video', methods=['GET'])
def get_mkv():
    base_url = request.args.get('base_url')
    
    if not base_url:
        return jsonify({"error": "Missing 'base_url' parameter"}), 400
    
    mkv_url = extract_mkv_url(base_url)
    if mkv_url:
        return jsonify({"mkv_url": mkv_url, "message": "MKV link extracted successfully."})
    else:
        return jsonify({"error": "Failed to extract MKV URL."}), 500

@app.route('/redirect_video', methods=['GET'])
def redirect_mkv():
    base_url = request.args.get('base_url')
    
    if not base_url:
        return jsonify({"error": "Missing 'base_url' parameter"}), 400
    
    mkv_url = extract_mkv_url(base_url)
    if mkv_url:
        return redirect(mkv_url)
    else:
        return jsonify({"error": "Failed to extract MKV URL."}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5017, debug=True)
