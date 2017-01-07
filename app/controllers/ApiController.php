<?php
namespace app\controllers;

use Yii;
use yii\web\Controller;
use app\models\Admin;
use yii\web\Response;
use app\models\FileUpload;

class ApiController extends Controller {
    public $layout = false;
    public $enableCsrfValidation = false;

    private $errMsg;
    private $isAuth = false;
    private $adminId;

    public function init() {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $this->errMsg = 'general error';
        $this->isAuth = $this->authUser();
    }

    public function actions() {
        return [
            'errorHandler' => [
                'errorAction' => 'api/error',
            ]
        ];
    }

    public function actionError() {
        return ['error' => $this->errMsg];
    }

    public function actionAction() {
        $request = Yii::$app->request;
        $type = $request->post('type');
        $action = $request->post('action');
        $id = $request->post('id');
        if ($this->isAuth&&(!isset($id))) {
            $admin = Admin::findOne($this->adminId);
        } else {
            $admin=Admin::findOne($id);
        }
        switch ($action) {
            case 'updateInfo':
                $info = $request->post('info');
                $ret = $this->dealUpdate($admin, $type, $info);
                break;
            case 'updateFileInfo':
                $info = $request->post('info');
                $ret = $this->dealUpdateFile($admin, $type, $info);
                break;
            case 'getInfo':
                $ret = $this->dealGet($admin, $type);
                break;
            default:
                $ret = ['error' => 'actionError'];
                break;
        }
        return $ret;
    }

    private function authUser() {
        $cookies = Yii::$app->request->cookies;
        $session = Yii::$app->session;
        if (($cookie = $cookies->get('loginCookie')) !== null) {
            $adminIdEncode = $cookie->value;
            if ($adminIdEncode) {
                if ($session->has($adminIdEncode)) {
                    $adminId = $session->get($adminIdEncode);
                    $admin = Admin::find()->where([
                        'admin_id' => $adminId,
                    ])->one();
                    if ($admin) {
                        $this->adminId = $adminId;
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private function dealUpdate(Admin $admin, $type, $info) {
        if (!$this->isAuth) {
            return ['error' => 'Auth Error'];
        }
        $admin['admin_' . $type] = $info;
        $admin->save();
        return true;
    }

    private function dealUpdateFile(Admin $admin, $type, $info) {
        $preFiles = json_decode($this->dealGet($admin, $type)['info']);
        $nowFiles = json_decode($info);
        $delFiles = array_diff($preFiles, $nowFiles);
        FileUpload::delFile($delFiles);
        $this->dealUpdate($admin, $type, $info);
        return true;
    }

    private function dealGet(Admin $admin, $type) {
        $ret = $admin['admin_' . $type];
        return ['info' => $ret];
    }

    public function actionUploadPic() {
        $ret = $this->dealUploads('img');
        return $ret;
    }

    public function actionUploadFile() {
        $ret = $this->dealUploads('file');
        return $ret;
    }

    private function dealUploads($contents) {
        if (!$this->isAuth) {
            return ['error' => 'Auth Error'];
        }
        $uploadName = FileUpload::uploadFile($this->adminId);
        if ($uploadName) {
            $admin = Admin::find()->where([
                'admin_id' => $this->adminId,
            ])->one();
            $fUrls = json_decode($admin['admin_'.$contents]);
            array_push($fUrls, $uploadName);
            $admin['admin_'.$contents]= json_encode($fUrls);
            $admin->save();
            $ret = [
                'success' => 'file upload success',
            ];
        } else {
            $ret = [
                'error' => 'file upload error',
            ];
        }
        return $ret;
    }
}