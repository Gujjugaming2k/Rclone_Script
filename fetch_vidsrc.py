from flask import Flask, redirect, jsonify
import requests

app = Flask(__name__)

# Base URL for fetching data
BASE_URL = "https://vidsrc.vflix.xyz/vidsrc/"

# Headers for the request
HEADERS = {
    "Referer": "https://embed.su/",
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Accept": "*/*"
}

@app.route('/fetch_and_redirect/<int:id>', methods=['GET'])
def fetch_and_redirect(id):
    # Construct the full URL with the provided ID
    data_url = f"{BASE_URL}{id}"
    
    # Fetch data from the constructed URL
    response = requests.get(data_url, headers=HEADERS)
    
    # Check if request was successful
    if response.status_code == 200:
        data = response.json()
        
        # Extract the first URL in the "sources" list
        if 'sources' in data and len(data['sources']) > 0:
            source_url = data['sources'][0]['url']
            
            # Redirect to the source URL
            return redirect(source_url)
        else:
            return jsonify({"error": "No sources found"}), 404
    else:
        return jsonify({"error": "Failed to fetch data"}), response.status_code

if __name__ == '__main__':
    # Run Flask app on a custom port, e.g., 8080
    app.run(debug=True, port=5012)
