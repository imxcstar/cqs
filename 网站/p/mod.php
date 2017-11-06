<?php

class Mymod
{
    public function ckey($s)
    {
        return md5(uniqid(mt_rand().md5($s), true));
    }
}
