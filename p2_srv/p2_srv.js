const P2_SRV_VER = '1.0';

const P2_DBG_LEVEL = 2;

const P2_USR_NAME = 'duzong';
const P2_BID_CNT = '6';

const P2_HOST = '127.0.0.1';
const P2_PORT = 8000;
const P2_SRV_TRADE = '172.245.79.163';

const P2_CAPACHA = '/captcha/login';

const URL_WEB_SVC = '/webwcf/BidCmd.svc/WebCmd';

var p2_cap_login = require('./p2_cap_login');


var Log_Type = Object.freeze({"INFO": 0, "WARN": 1, "ERR": 2});

function Logger() {
    const COLOR_RESET = '\x1b[0m';
    const COLOR_FG_RED = '\x1b[31m';
    const COLOR_FG_GREEN = '\x1b[32m';
    const COLOR_FG_YELLOW = '\x1b[33m';
    const COLOR_FG_WHITE = '\x1b[37m';
    
    this.log = function(data, type) {
        var color = '';
        var date, time;
        
        if (typeof type !== 'undefined') {
            switch (type) {
                case Log_Type.WARN:
                    color = COLOR_FG_YELLOW;
                    break;
                case Log_Type.ERR:
                    color = COLOR_FG_RED;
                    break;
                case Log_Type.INFO:
                default:
                    color = COLOR_FG_WHITE;
                    break;
            }
        }
        
        date = new Date();
        time = date.toTimeString().split(' ')[0];
        
        console.log('[' + color + time + COLOR_RESET + '] ' + data);
    }
}

var logger = new Logger();

const http = require('http');
const server = http.createServer((req, resp) => {
    var resp_body = '';
    
    resp.writeHead(200, {'content-type': 'application/json'});
    
    if (req.method === 'GET') {
        
    } else if (req.method === 'POST') {
        if (req.headers['content-type'] == 'application/json') {
            var data = '';
            
            logger.log(req.url);
            if (req.url == URL_WEB_SVC) {
                var req_body = '';
                var proto, port, host;
                
                req.on('data', function(req_data) {
                    req_body += req_data;
                });
                req.on('end', function() {
                    logger.log(req_body);
                    
                    cli_msg = JSON.parse(req_body);
                    
                    if (req.headers['referer'].indexOf('https') !== -1) {
                        proto = 'https';
                        port = 443;
                    } else {
                        proto = 'http';
                        port = 80;
                    }
                    
                    host = req.headers['host'];
                    
                    if (cli_msg.method === 'getimagecode') {
                        uid = p2_cap_login.get_uid();
                        data = uid + ',' + proto +'://' + host + P2_CAPACHA + '/' + uid + '.png';
                        logger.log(data);
                    } else if (cli_msg.method === 'login') {
                        data = {
                            'tradeserver': [
                                {
                                    'host': host,
                                    /*'server': P2_SRV_TRADE,*/
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
                        };
                    }
                    
                    resp_json = {
                        'response': {
                            'responsecode': 0,
                            'responsemsg': 'Success',
                            'data': data
                        },
                        'requestid': '1546173926698',
                        'servertime': '20181230204526'
                    };
                    
                    resp_body = JSON.stringify(resp_json);
                    logger.log(resp_body);
                    resp.end(resp_body);
                });
            }          
        }
        else {
            resp_body = 'post data not json';
            return;
        }
    }
});

server.listen(P2_PORT, P2_HOST, () => {
    logger.log(`P2_SRV ${P2_SRV_VER}`, Log_Type.WARN);
    logger.log(`Server running at http://${P2_HOST}:${P2_PORT}/`);
});
