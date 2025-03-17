import json
import unittest.mock
from main import EchoHandler


def test_echo_handler_get():
    mock_headers = unittest.mock.MagicMock()
    mock_headers.items.return_value = [('User-Agent', 'test-agent'), ('Host', 'localhost')]

    test_path = '/test?param1=value1&param2=value2'

    mock_wfile = unittest.mock.MagicMock()
    mock_wfile.write = unittest.mock.MagicMock()

    handler = unittest.mock.MagicMock(spec=EchoHandler)
    handler.path = test_path
    handler.headers = mock_headers
    handler.wfile = mock_wfile

    EchoHandler.do_GET(handler)

    handler.send_response.assert_called_once_with(200)
    handler.send_header.assert_called_once_with('Content-Type', 'application/json')
    handler.end_headers.assert_called_once()

    call_args = mock_wfile.write.call_args[0][0]
    response_data = json.loads(call_args.decode('utf-8'))

    assert response_data['path'] == '/test'
    assert response_data['query_params'] == {'param1': ['value1'], 'param2': ['value2']}
    assert response_data['headers'] == {'User-Agent': 'test-agent', 'Host': 'localhost'}
