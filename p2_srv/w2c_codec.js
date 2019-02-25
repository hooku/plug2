const pcapp = require('pcap-parser');
const w2c_class_14 = require('./w2c_class_14');
const path = require('path');
const fs = require('fs');
const gunzip = require('gunzip-file');
const pcap = require('pcap');
const netmask = require('netmask').Netmask;
const datetime = require('node-datetime');

var xxteacode = "ji!@p!a";
var class_14 = new w2c_class_14(xxteacode.substr(2,5));

test_dec = class_14.XxteaDecode('uBcAruIhUM39xKi+/vmDS6D0o4K4KxpFMThKIzV223A95nOan7FaDguegWbWtASOKV8KXeAxVgV3mHTjZTXBtJHQVMBmQA/z70Bqf5a33bSq3fAHm7spNdhTEmXiNT9Y5BDixqGo8t2tIfXFW6FPHdmLrLqECgv02MuRqe/l4rIIsidX3j9uYNRXicGEeThipiwdC46nAtqpgWiqjDTqQWe7bcSu6A0EdOkKSbQD7UrX1fCc5vTLVJsSj9dWXfdRRtzwZZJWbvRBNbHa7k6SlPIAPCbQ/qRNfQzai1Wf1LbpGZTtLDctYGE995w69dyfsSCx27EvtrDktlfueRcsAL5SSA2oJqvHssc3fLBdE1FF0iyrxrXykatUa6rZ+u8rwHE1PG3G8MGZwVKSVSBzvj5mWIsK7Y4x4EX8XlGwBp79IORoRUO3Ey2eOP65Zlz3X/BNhmAXNvxOhu7m+uVMwjYlEQ/wdJSBdEWqxiPGN41votVOitSN9vwl68UtElZnxGeDO7uphSe6POLp+oH27h0bUZl2JMoLJGJMtc4DCVdWMmMhxWGy+s/m/jgGuItw7z1v64syUT6lhiVFh0mAORRthZ6gWUwRUVuN9/qftDZcTsP2GcIjqEWOY802GkMlkh0tAJ2cs7/sjWwOAwIGOA==');
test_enc = class_14.XxteaEncode('{"response":{"responsecode":0,"responsemsg":"","data":{"bidamount":"93300","bidnumber":"54295335","bidtime":"2017-11-18 11:29:55.914","msg":"出价入列，\n您处于第630033位，630033，629121","bidcount":0,"type":1,"requestid":"54295335.f112948248","code":0,"dealtime":"0001-01-01 00:00:00.000"}},"requestid":"54295335.f112948248","servertime":"20171118113006"}');

//console.log(test_dec);
//console.log(test_enc);

var args = process.argv.slice(2);

if (args.length > 0) {
    var cap_file = args[0];
    var tmp_file = '_tmp.pcap';
    var serv_ip_mask = '180.0.0.0/8';
    var serv_tcp_port = 8300;
    
    fs.stat(cap_file, function(err, stat) {
        if(err == null) {
            var cap_file_ext = path.extname(cap_file);
            
            if (cap_file_ext == '.gz') {
                gunzip(cap_file, tmp_file, () => {
                    cap_file = tmp_file;
                    console.log('gunzip done! ' + cap_file);
                    pkt_parse(cap_file);
                    fs.unlinkSync(cap_file);
                });
            } else {
                pkt_parse(cap_file);
            }
        } else {
            console.log(cap_file + ' not exist!');
        }
    });
}

function pkt_parse(cap_file) {
    try {
        var unknown_pkt = 0;
        
        var parser = pcapp.parse(path.join(__dirname, cap_file));
        parser.on('packet', function(raw_packet) {
            //console.log(raw_packet.header);
            //console.log(raw_packet.data);

            raw_packet.data.pcap_header = { link_type: 'LINKTYPE_ETHERNET'};
            
            var server_block = new netmask(serv_ip_mask);
            var packet = pcap.decode.packet(raw_packet.data);
            
            //console.log(packet);
            if (packet.link.ip.protocol_name == 'TCP' &&
                ((packet.link.ip.tcp.sport == serv_tcp_port) || (packet.link.ip.tcp.dport == serv_tcp_port))) {
                var data = packet.link.ip.tcp.data;
            
                if (typeof data !== 'undefined' && data) {
                    //console.log(data);
                    
                    // if byte3 non zero, then 
                    if (data[2] > 0) {
                        var date = new Date(0);
                        date.setUTCSeconds(raw_packet.header.timestampSeconds);
                        var ndt = datetime.create(date);
                        var ts = ndt.format('Y-m-d H:M:S') + '.' + Math.floor(raw_packet.header.timestampMicroseconds/1000/100);
                        
                        if (server_block.contains(packet.link.ip.daddr)) {
                            direction = 'C->S';
                        } else if (server_block.contains(packet.link.ip.saddr)) {
                            direction = 'S->C';
                        }
                        
                        console.log('[' + ts + ', ' + direction + ']');
                        
                        var clean_data = data.slice(22);
                        var xx_raw = clean_data.toString('utf8');
                        var xx = xx_raw.replace(/[^\x20-\x7E]/g, "");
                        
                        try {
                            var xx_dec = class_14.XxteaDecode(xx);
                            console.log(xx_dec);
                        } catch (e) {
                            console.log('Cannot decode');
                            unknown_pkt ++;
                        }
                    }
                }
            }
        });
        
        parser.on('end', function() {
            console.log('==Parse finish==');
            console.log('Unknown pkt=' + unknown_pkt);
        });
    } catch (e) {
        console.log(e);
    }
}
