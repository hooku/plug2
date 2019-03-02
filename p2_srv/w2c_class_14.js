"use strict";

var w2c_class_45 = require('./w2c_class_45');
var w2c_class_46 = require('./w2c_class_46');

var class_45 = new w2c_class_45();
var class_46 = new w2c_class_46();

/*package package_1
{
    import flash.utils.ByteArray;
    import package_15.class_45;
    import package_15.class_46;*/
    
    /*public */class class_14
    {
         
        constructor(param1)
        {
            this.key_147 = new Buffer(param1);
        }
        
//        /*private var name_6:String = "gfheru3";*/
//        
//        /*private */var key_147/*:ByteArray*/;
//        
//        /*private var key_151:String = "abcd";*/
//        
//        private var decode3_1_75:Object;
//        
//        private var decode:Object;
//        
//        /*private var a_147:Array;*/
//        
//        /*private */var input_147/*:String*/ = "This is a regular string";
//        
//        /*private */var input_149/*:String*/;
//        
//        /*public */function class_14(param1/*:String*/)
//        {
//            /*this.key_147 = new ByteArray();*/
//            /*this.decode3_1_75 = new Object();*/
//            /*this.decode = new Object();*/
//            /*this.a_147 = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".split("");*/
//            /*this.*/input_149 = /*this.*/a_148(/*this.*/input_147);
//            /*super();*/
//            /*this.key_147.writeMultiByte(param1.substr(2,5),"utf-8");*/
//            key_147 = new Buffer(param1.substr(2,5));
//        }
        
        /*public function */XxteaEncode(param1/*:String*/)/* : String*/
        {
            /*var _loc2_:ByteArray = new ByteArray();*/
            /*_loc2_.writeMultiByte(class_46.method_56(param1),"utf-8");*/
            var _loc2_ = new Buffer(class_46.method_56(param1.toString('utf-8')));
            var _loc3_/*:ByteArray*/ = class_45.method_57(_loc2_,this.key_147);
            var _loc4_/*:String*/ = class_46.method_58(_loc3_);
            return _loc4_;
        }
        
        /*public function */XxteaDecode(param1/*:String*/)/* : String*/
        {
            var _loc2_/*:ByteArray*/ = class_46.method_59(param1);
            var _loc3_/*:ByteArray*/ = class_45.method_60(_loc2_,this.key_147);
            var _loc4_/*:String*/ = _loc3_.toString();
            var _loc5_/*:String*/ = class_46.decode(_loc4_);
            return _loc5_;
        }
               
        /*public function */decode3_1_1(param1/*:String*/)/* : String*/
        {
            var _loc4_/*:Number*/ = NaN;
            var _loc5_/*:Number*/ = NaN;
            var _loc6_/*:Number*/ = NaN;
            var _loc7_/*:Number*/ = NaN;
            var _loc8_/*:Number*/ = NaN;
            var _loc2_/*:Array*/ = param1.split("");
            _loc4_ = _loc2_.length;
            if((_loc5_ = _loc4_ % 7) != 0)
            {
                _loc4_ = _loc4_ + 7 - _loc5_;
            }
            /*var _loc9_:Array = new Array(_loc4_);*/
            var _loc9_ = [];
            _loc8_ = _loc4_ / 7;
            _loc6_ = 0;
            while(_loc6_ < 7)
            {
                _loc7_ = 0;
                while(_loc7_ < _loc8_)
                {
                    if(_loc6_ * _loc8_ + _loc7_ < _loc2_.length)
                    {
                        _loc9_[_loc6_ + _loc7_ * 7] = _loc2_[_loc6_ * _loc8_ + _loc7_];
                    }
                    else
                    {
                        _loc9_[_loc6_ + 7 * _loc7_] = " ";
                    }
                    _loc7_++;
                }
                _loc6_++;
            }
            while(_loc9_[_loc4_ - 1] == " ")
            {
                _loc4_--;
            }
            var _loc10_/*:String*/ = "";
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
                _loc10_ = _loc10_ + _loc9_[_loc6_];
                _loc6_++;
            }
            return _loc10_;
        }
        
//        private function a_148(param1/*:String*/)/* : String*/
//        {
//            return /*this.*/a_155(param1,/*this.*/decode3_1_75);
//        }
//        
//        private function a_156(param1/*:String*/)/* : String*/
//        {
//            return /*this.*/a_155(param1,/*this.*/decode);
//        }
//        
//        private function a_155(param1/*:String*/, param2/*:Object*/)/* : String*/
//        {
//            var _loc5_/*:String*/ = null;
//            var _loc6_/*:String*/ = null;
//            var _loc3_/*:String*/ = "";
//            var _loc4_/*:int*/ = 0;
//            while(_loc4_ < param1.length)
//            {
//                _loc5_ = param1.charAt(_loc4_);
//                _loc6_ = param2[_loc5_];
//                if(_loc6_)
//                {
//                    _loc3_ = _loc3_ + _loc6_;
//                }
//                else
//                {
//                    _loc3_ = _loc3_ + _loc5_;
//                }
//                _loc4_++;
//            }
//            return _loc3_;
//        }
    }
/*}*/

module.exports = class_14;
