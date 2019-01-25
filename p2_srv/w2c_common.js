"use strict";

class class_w2c
{
    to_uint(num)
    {
         return (num >>> 0);
    }

    join_buffer(buff1, buff2)
    {
        return Buffer.concat([buff1, buff2], buff1.length + buff2.length);
    }
}

module.exports = class_w2c;
