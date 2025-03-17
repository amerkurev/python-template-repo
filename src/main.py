import json
import urllib.parse

from http.server import HTTPServer, BaseHTTPRequestHandler


class EchoHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        # Parse URL and query parameters
        parsed_path = urllib.parse.urlparse(self.path)
        query_params = urllib.parse.parse_qs(parsed_path.query)

        # Create response data
        response_data = {'path': parsed_path.path, 'query_params': query_params, 'headers': dict(self.headers.items())}

        # Send response
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(response_data, indent=2).encode('utf-8'))


def run_server(host='0.0.0.0', port=8000):
    server = HTTPServer((host, port), EchoHandler)
    print(f'Echo server running at http://{host}:{port}')
    server.serve_forever()


if __name__ == '__main__':
    run_server()
