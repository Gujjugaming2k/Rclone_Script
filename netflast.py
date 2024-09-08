from flask import Flask, request, Response
import requests
import re
from urllib.parse import urljoin

app = Flask(__name__)

def rewrite_m3u8_content(content, base_url):
    # Ensure all segment URLs in the .m3u8 content are absolute
    def replace_relative_urls(match):
        relative_url = match.group(2)
        return f"{match.group(1)}{urljoin(base_url, relative_url)}"
    
    # Regex to find and replace relative URLs in .m3u8 content
    content = re.sub(r'(\n#EXTINF:[\d.]+,\n)([\w_]+\.\w+)', lambda m: replace_relative_urls(m), content)
    return content

@app.route('/proxy_dual_eng')
def proxy_dual_eng():
    # Get the video and two audio URLs from the query string
    video_url = request.args.get('video_url')
    audio_url1 = request.args.get('audio_url1')
    audio_url2 = request.args.get('audio_url2')
    
    if not video_url or not audio_url1 or not audio_url2:
        return "Video or audio URLs not provided", 400

    # Define the referer header
    referer_header = 'https://iosmirror.cc/'  # Replace with the actual referer URL

    # Fetch the video .m3u8 file content with the Referer header
    video_response = requests.get(video_url, headers={'Referer': referer_header}, stream=True, verify=False)
    if video_response.status_code != 200:
        return f"Failed to fetch video URL: {video_response.status_code}", video_response.status_code

    # Fetch the audio .m3u8 file content with the Referer header
    audio_response1 = requests.get(audio_url1, headers={'Referer': referer_header}, stream=True, verify=False)
    if audio_response1.status_code != 200:
        return f"Failed to fetch audio URL1: {audio_response1.status_code}", audio_response1.status_code

    audio_response2 = requests.get(audio_url2, headers={'Referer': referer_header}, stream=True, verify=False)
    if audio_response2.status_code != 200:
        return f"Failed to fetch audio URL2: {audio_response2.status_code}", audio_response2.status_code

    # Rewrite the video and audio playlists to include full URLs
    video_content = rewrite_m3u8_content(video_response.text, video_url.rsplit('/', 1)[0])
    audio_content1 = rewrite_m3u8_content(audio_response1.text, audio_url1.rsplit('/', 1)[0])
    audio_content2 = rewrite_m3u8_content(audio_response2.text, audio_url2.rsplit('/', 1)[0])

    # Save the rewritten playlists
    with open('video.m3u8', 'w') as video_file:
        video_file.write(video_content)

    with open('audio1.m3u8', 'w') as audio_file1:
        audio_file1.write(audio_content1)

    with open('audio2.m3u8', 'w') as audio_file2:
        audio_file2.write(audio_content2)

    # Create a master .m3u8 playlist that references the video and audio playlists
    master_playlist = (
        "#EXTM3U\n"
        "#EXT-X-VERSION:3\n"
        "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID=\"audio\",LANGUAGE=\"hin\",NAME=\"Hindi\",DEFAULT=YES,AUTOSELECT=YES,URI=\"https://netflix.vflix.xyz/audio_proxy?url=" + audio_url1 + "\"\n"
        "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID=\"audio\",LANGUAGE=\"Eng\",NAME=\"Eng\",DEFAULT=NO,AUTOSELECT=YES,URI=\"https://netflix.vflix.xyz/audio_proxy?url=" + audio_url2 + "\"\n"
        "#EXT-X-STREAM-INF:BANDWIDTH=800000,AUDIO=\"audio\"\n"
        "https://netflix.vflix.xyz/video_proxy?url=" + video_url + "\n"
    )

    # Return the master playlist with references to the video and audio playlists
    response_content = Response(master_playlist, status=200, content_type='application/vnd.apple.mpegurl')
    return response_content

@app.route('/proxy_dual')
def proxy_dual():
    # Get the video and audio URLs from the query string
    video_url = request.args.get('video_url')
    audio_url = request.args.get('audio_url')
    
    if not video_url or not audio_url:
        return "Video or audio URL not provided", 400

    # Define the referer header
    referer_header = 'https://iosmirror.cc/'  # Replace with the actual referer URL

    # Fetch the video .m3u8 file content with the Referer header
    video_response = requests.get(video_url, headers={'Referer': referer_header}, stream=True, verify=False)
    if video_response.status_code != 200:
        return f"Failed to fetch video URL: {video_response.status_code}", video_response.status_code

    # Fetch the audio .m3u8 file content with the Referer header
    audio_response = requests.get(audio_url, headers={'Referer': referer_header}, stream=True, verify=False)
    if audio_response.status_code != 200:
        return f"Failed to fetch audio URL: {audio_response.status_code}", audio_response.status_code

    # Rewrite the video and audio playlists to include full URLs
    video_content = rewrite_m3u8_content(video_response.text, video_url.rsplit('/', 1)[0])
    audio_content = rewrite_m3u8_content(audio_response.text, audio_url.rsplit('/', 1)[0])

    # Save the rewritten playlists
    with open('video.m3u8', 'w') as video_file:
        video_file.write(video_content)

    with open('audio.m3u8', 'w') as audio_file:
        audio_file.write(audio_content)

    # Create a master .m3u8 playlist that references both video and audio playlists
    master_playlist = (
        "#EXTM3U\n"
        "#EXT-X-VERSION:3\n"
        "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID=\"audio\",NAME=\"Hindi\",DEFAULT=YES,AUTOSELECT=YES,URI=\"https://netflix.vflix.xyz/audio_proxy?url=" + audio_url + "\"\n"
        "#EXT-X-STREAM-INF:BANDWIDTH=800000,AUDIO=\"audio\"\n"
        "https://netflix.vflix.xyz/video_proxy?url=" + video_url + "\n"
    )

    # Return the master playlist with references to the video and audio playlists
    response_content = Response(master_playlist, status=200, content_type='application/vnd.apple.mpegurl')
    return response_content

@app.route('/video_proxy')
def video_proxy():
        # Get the original URL from the query string
    url = request.args.get('url')
    if not url:
        return "No URL provided", 400

    # Fetch the .m3u8 file content
    headers = {
        'Referer': 'https://iosmirror.cc/',  # Replace with the actual referer
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

@app.route('/audio_proxy')
def audio_proxy():
        # Get the original URL from the query string
    url = request.args.get('url')
    if not url:
        return "No URL provided", 400

    # Fetch the .m3u8 file content
    headers = {
        'Referer': 'https://iosmirror.cc/',  # Replace with the actual referer
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

@app.route('/proxy')
def proxy():
    # Get the original URL from the query string
    url = request.args.get('url')
    if not url:
        return "No URL provided", 400

    # Fetch the .m3u8 file content
    headers = {
        'Referer': 'https://iosmirror.cc/',  # Replace with the actual referer
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
    app.run(host='0.0.0.0', port=9812)
