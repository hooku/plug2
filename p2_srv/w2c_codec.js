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

test_3_1 = "23,年海性拍\n数\n：\n8低时91成8交23:0务款长3九下25汽.4场\n8育区路层福）山云场\n0部付另已结录001D2市客卖投量参1最9成间:4交5的月月00点手宁8华1.5车东号448馆）11上\n路顶A注8）款：开算查 11,月个车会标：加6低4交：56价\n买200)办续区号商层共0广江（区.号架\n50海68国座：号不结我通，询 9322人额结拍8拍3成0价17位：请受42-到理。淞（业A和号场湾虹1新（空507万.0际1福（办算公网大。 0403非度果卖9卖5交0的1 \n8拍人日日1下成\n虹福广2新（）路口1镇闵层.0（里浦0商0州公理手司上家, 241日营投公额9人7价\n截:第平9卖在～(6列交1路缘场）路百\n4足3路行B新号家店东号业1路司成续网支可0 229上业标布度8数1：最止24均4成009:服付.9湾地\n3联34球）2体2村1乐内成（广）1本交\n站付登,";
test_3_1_u = test_3_1.toString('utf8');
test_3_1_dec = class_14.decode3_1_1(test_3_1_u);

//console.log(test_3_1_dec);

//process.exit();

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
        var pkt_unknown = 0;
        
        var parser = pcapp.parse(cap_file);
        parser.on('packet', function(raw_packet) {
            //console.log(raw_packet.header);
            //console.log(raw_packet.data);

            raw_packet.data.pcap_header = { link_type: 'LINKTYPE_ETHERNET' };
            
            var server_block = new netmask(serv_ip_mask);
            var packet = pcap.decode.packet(raw_packet.data);
            
            //console.log(packet);
            if (packet.link.ip.protocol_name == 'TCP' &&
                ((packet.link.ip.tcp.sport == serv_tcp_port) || (packet.link.ip.tcp.dport == serv_tcp_port))) {
                var data = packet.link.ip.tcp.data;
                
                if ((typeof data !== 'undefined') && data) {
                    //console.log(data);
                    
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

                    var tcp_len = data.readUIntBE(0, 4);
                    
                    var predata;
                    var predata_offset = 16;
                    if (((date.getFullYear() == 2018) && (date.getMonth() <= 9)) || (date.getFullYear() < 2018)) {
                        predata_offset = 4;
                    }
                    
                    if (predata_offset > 0) {
                        predata = data.slice(4, 15);
                    }
                    var id0 = data[predata_offset];
                    var id1 = data[predata_offset + 1];
                    
                    var payload_len = data.readUIntBE(predata_offset + 2, predata_offset + 6);
                    var payload_data = data.slice(predata_offset + 6);
                    var payload_str = payload_data.toString('utf8');

                    var stage = id0 + '-' + id1;
                    
                    if (data.byteLength != tcp_len) {
                        console.log('bad pkt length');
                        console.log('(orig)' + payload_str);
                        pkt_unknown ++;
                    }
                    
                    //console.log(payload_str);
                    var payload_dec = '';

                    try {
                        switch (stage)
                        {
                            case '3-1':
                                payload_dec = class_14.decode3_1_1(payload_str);
                                break;
                            default:
                                payload_dec = class_14.XxteaDecode(payload_str);
                                break;
                        }
                    } catch (e) {
                        console.log('cannot decode');
                        pkt_unknown ++;
                        return;
                    }
                    
                    console.log('(' + stage + ')' + payload_dec);
                }
            }
        });
        
        parser.on('end', function() {
            console.log('==parse finish==');
            console.log('unknown pkt=' + pkt_unknown);
        });
    } catch (e) {
        console.log(e);
    }
}
