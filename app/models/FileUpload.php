<?php
namespace app\models;

use yii;
use yii\base\Model;

class FileUpload extends Model {
    static public function uploadFile($user) {
        if (!empty($_FILES)) {
            $tempPath = $_FILES['file']['tmp_name'];
            $uploadDict = Yii::$app->getBasePath() . DIRECTORY_SEPARATOR . 'web\uploads' . DIRECTORY_SEPARATOR;
            $uuid=FileUpload::create_guid();
            $uploadName = $user.'$' . $uuid.'$' . $_FILES['file']['name'];
            $uploadPath = $uploadDict . $uploadName;
            move_uploaded_file($tempPath, $uploadPath);
            $answer=$uploadName;
        } else {
            $answer=false;
        }
        return $answer;
    }

   static public function delFile($fileNameArr){
       $fileDict = Yii::$app->getBasePath() . DIRECTORY_SEPARATOR . 'web\uploads' . DIRECTORY_SEPARATOR;
       foreach($fileNameArr as $fileName){
           $file=$fileDict.$fileName;
           unlink($file);
       }
        return true;
   }

    private static function create_guid(){
        $microTime = microtime();
        list($a_dec, $a_sec) = explode(" ", $microTime);
        $dec_hex = dechex($a_dec* 1000000);
        $sec_hex = dechex($a_sec);
        FileUpload::ensure_length($dec_hex, 5);
        FileUpload::ensure_length($sec_hex, 6);
        $guid = "";
        $guid .= $dec_hex;
        $guid .= FileUpload::create_guid_section(3);
        $guid .= '-';
        $guid .= FileUpload::create_guid_section(4);
        $guid .= '-';
        $guid .= FileUpload::create_guid_section(4);
        $guid .= '-';
        $guid .= FileUpload::create_guid_section(4);
        $guid .= '-';
        $guid .= $sec_hex;
        $guid .= FileUpload::create_guid_section(6);
        return $guid;
    }

    private static function ensure_length(&$string, $length){
        $strlen = strlen($string);
        if($strlen < $length)
        {
            $string = str_pad($string,$length,"0");
        }
        else if($strlen > $length)
        {
            $string = substr($string, 0, $length);
        }
    }

    private static function create_guid_section($characters){
        $return = "";
        for($i=0; $i<$characters; $i++)
        {
            $return .= dechex(mt_rand(0,15));
        }
        return $return;
    }
}