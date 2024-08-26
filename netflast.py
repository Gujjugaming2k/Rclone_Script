from flask import Flask, request, Response
import requests
import re

app = Flask(__name__)

@app.route('/proxy')
def proxy():
    # Get the original URL from the query string
    url = request.args.get('url')
    if not url:
        return "No URL provided", 400

    # Fetch the .m3u8 file content
    headers = {
        'Referer': 'https://pcmirror.cc/',  # Replace with the actual referer
    }
    response = requests.get(url, headers=headers, stream=True, verify=False)
    if response.status_code != 200:
        return f"Failed to fetch URL: {response.status_code}", response.status_code

    # Extract the base URL for segments from the original URL
    base_path = re.sub(r'/[^/]+\.m3u8$', '', url)

    # Rewrite the .m3u8 content to use absolute URLs for segments
    content = response.text
    content = re.sub(r'(\n#EXTINF:[\d.]+,\n)([\w_]+\.\w+)', lambda m: f'{m.group(1)}{base_path}/{m.group(2)}', content)

    # Return the modified content with the same status code and content type
    return Response(content, status=response.status_code, content_type=response.headers.get('Content-Type'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
