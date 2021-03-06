"use strict";

const datetime = require('node-datetime');
const net = require('net');
const p2_cap_login = require('./p2_cap_login');

const P2_SRV_VER = '1.0';
const P2_DBG_LEVEL = 2;

const P2_USR_NAME = 'duzong';
const P2_BID_CNT = '6';

const P2_HOST = '127.0.0.1';
const P2_PORT = 8000;
const P2_SRV_TRADE_HOST = '172.245.79.163';
const P2_SRV_TRADE_PORT = 8300;

const P2_CAPACHA = '/captcha/login';

const URL_WEB_SVC = '/webwcf/BidCmd.svc/WebCmd';

const COLOR_RESET = '\x1b[0m';
const COLOR_FG_RED = '\x1b[31m';
const COLOR_FG_GREEN = '\x1b[32m';
const COLOR_FG_YELLOW = '\x1b[33m';
const COLOR_FG_WHITE = '\x1b[37m';

var Log_Type = Object.freeze({"INFO": 0, "WARN": 1, "ERR": 2});

function Logger() {
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

function Util() {
    this.get_server_time = function() {
        var date = new Date();
        var ndt = datetime.create(date);
        var ts = ndt.format('YmdHMS');
        return ts;
    }
}

var logger = new Logger();
var util = new Util();

function P2_Webserver() {
    this.proc = function(req, resp) {
        if (req.url == URL_WEB_SVC) {
            var req_body = '';
            var resp_body = '';
            var proto, port, host;
            var resp_code = 0, resp_msg = 'Success';
            var uid, data = '';
            
            req.on('data', function(req_data) {
                req_body += req_data;
            });
            req.on('end', function() {
                logger.log(req_body);
                
                var cli_msg = JSON.parse(req_body);
                
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
                    var cmd_data = decodeURIComponent(cli_msg.cmd);
                    var cmd_msg = JSON.parse(cmd_data);
                    
                    uid = cmd_msg.request.uniqueid;
                    var imagenumber = p2_cap_login.get_imagenumber(uid);
                    
                    if (imagenumber != cmd_msg.request.imagenumber) {
                        resp_code = 2101;
                        resp_msg = '图像校验码错误';
                    }
                    
                    data = {
                        'tradeserver': [
                            {
                                'server': P2_SRV_TRADE_HOST,
                                /*'server': '47.96.39.148',*/
                                'port': P2_SRV_TRADE_PORT.toString()
                            }
                        ],
                        'webserver': [
                            {
                                'server': host,
                                'port': port
                            }
                        ],
                        'clientid': cmd_msg.request.clientId,
                        'name': P2_USR_NAME,
                        'bidcount': P2_BID_CNT,
                        'date': 'Unlimited',
                        'b': cmd_msg.request.uniqueid
                    };
                }
                
                var resp_json = {
                    'response': {
                        'responsecode': resp_code,
                        'responsemsg': resp_msg,
                        'data': data
                    },
                    'requestid': cli_msg.cmd.requestid,
                    'servertime': util.get_server_time()
                };
                
                resp_body = JSON.stringify(resp_json);
                logger.log(resp_body);
                
                resp.end(resp_body);
            });
        }
    }
    
    this.start = function() {
        const http = require('http');
        const server = http.createServer((req, resp) => {
            resp.writeHead(200, {'content-type': 'application/json'});
            
            if (req.method === 'GET') {
                
            } else if (req.method === 'POST') {
                if (req.headers['content-type'] == 'application/json') {
                    logger.log(req.url);
                    this.proc(req, resp);
                }
                else {
                    logger.log('post data not json', Log_Type.ERR);
                    return;
                }
            }
        });

        server.listen(P2_PORT, P2_HOST, () => {
            logger.log(`Web Server running at http://${P2_HOST}:${P2_PORT}/`);
        });
    }
}

function P2_Tradeserver() {
    var P2_State = Object.freeze({"SEND_POL": 0, "WARN": 1});
    
    this.policyreq = function() {
        resp = '<?xml version="1.0" encoding="utf-8"?><cross-domain-policy><allow-access-from domain="hooku.ml" to-ports="*" /></cross-domain-policy>';
    }
    
    
    this.start = function() {
        var server = net.createServer();
        server.listen(P2_SRV_TRADE_PORT, P2_SRV_TRADE_HOST, () => {
            console.log(`Trade Server running at ${P2_SRV_TRADE_HOST}:${P2_SRV_TRADE_PORT}`);
        });
                
        let sockets = [];

        server.on('connection', function(sock) {
            console.log('CONNECTED: ' + sock.remoteAddress + ':' + sock.remotePort);
            sockets.push(sock);

            sock.on('data', function(data) {
                console.log('DATA ' + sock.remoteAddress + ': ' + data);
                
                sockets.forEach(function(sock, index, array) {
                    sock.write(sock.remoteAddress + ':' + sock.remotePort + " said " + data + '\n');
                });
            });

            sock.on('close', function(data) {
                let index = sockets.findIndex(function(o) {
                    return o.remoteAddress === sock.remoteAddress && o.remotePort === sock.remotePort;
                })
                if (index !== -1)
                    sockets.splice(index, 1);
                console.log('CLOSED: ' + sock.remoteAddress + ' ' + sock.remotePort);
            });
        });
    }
}

logger.log(`P2_SRV ${P2_SRV_VER}`, Log_Type.WARN);
var p2_websrv = new P2_Webserver();
var p2_tradesrv = new P2_Tradeserver();

p2_websrv.start();
p2_tradesrv.start();
