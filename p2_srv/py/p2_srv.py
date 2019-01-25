# -*- coding: utf-8 -*-

from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import SocketServer
import json
import socket
import p2_cap_login

P2_USR_NAME = 'duzong'
P2_BID_CNT = '6'

P2_HOST = '127.0.0.1'
P2_PORT = 8000
P2_SRV_TRADE = '172.245.79.163'

P2_CAPACHA = '/captcha/login'

URL_WEB_SVC = '/webwcf/BidCmd.svc/WebCmd'

class P2_SrvWeb(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        
    def do_GET(self):
        self._set_headers()
        self.wfile.write(json.dumps({'hello': 'p2', 'url': self.path}))
        # as web server
        
    def do_POST(self):
        if self.path.lower() == URL_WEB_SVC.lower():
            self._set_headers()

            # refuse non-json 
            if self.headers.getheader('Content-Type') != 'application/json':
                print 'post data not json'
                self.send_response(400)
                self.end_headers()
                return
                
            if 'https' in self.headers.get('Referer'):
                proto = 'https'
                port = 443
            else:
                proto = 'http'
                port = 80
                
            host = self.headers.get('Host')
            
            post_len = int(self.headers.getheader('Content-Length'))
            bidcli_msg = json.loads(self.rfile.read(post_len))
            
            if bidcli_msg['method'] == 'getimagecode':
                uid = p2_cap_login.get_uid()
                data = uid + ',' + proto +'://' + host + P2_CAPACHA + '/' + uid + '.png'

            elif bidcli_msg['method'] == 'login':
                data = {
                    'tradeserver': [
                        {
                        'host': host,
                        #'server': P2_SRV_TRADE,
                        'server': '47.96.39.148',
                        'port': '8300'
                        }
                    ],
                    'webserver': [
                        {
                            'server': host,
                            'port': port
                        }
                    ],
                    'clientid': '4e08d34a-3468-42d9-8460-88195f8c1956',
                    'name': P2_USR_NAME,
                    'bidcount': P2_BID_CNT,
                    'date': 'Unlimited',
                    'b': '6d18dd0d-2e8c-452d-8463-92a8b2971b1a'
                }
            
            self.wfile.write(json.dumps({
                'response': {
                    'responsecode': 0,
                    'responsemsg': 'Success',
                    'data': data
                },
                'requestid': '1546173926698',
                'servertime': '20181230204526'
            }));

def run_srvweb(server_class = HTTPServer, handler_class = P2_SrvWeb, port = P2_PORT):
    server_address = (P2_HOST, port)
    httpd = server_class(server_address, handler_class)
    
    print 'serving at {0}:{1}'.format(P2_HOST, port)
    httpd.serve_forever()
    
def run_srvtrade(self):
    pass

if __name__ == "__main__":
    from sys import argv
    
    if len(argv) == 2:
        run_srvweb(port = int(argv[1]))
    else:
        run_srvweb()
