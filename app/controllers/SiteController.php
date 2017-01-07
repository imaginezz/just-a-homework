<?php

namespace app\controllers;

use Yii;
use yii\web\Controller;
use app\models\Admin;

class SiteController extends Controller {

    public $layout = false;

    private $actionInfo;
    private $nextInfo;
    private $renderInfo;
    private $renderParamInfo = [];

    private $cookieInfo = null;

    public function actions() {
        return [
            'errorHandler' => [
                'errorAction' => 'site/error',
            ]
        ];
    }

    public function actionIndex() {
        $request = Yii::$app->request;
        $this->actionInfo = $request->post('action');
        $this->nextInfo = $request->post('next');
        $this->dealAction();
        $this->dealNext();
        $this->dealUserInfo();
        return $this->render($this->renderInfo . '.tpl', $this->renderParamInfo);
    }

    public function actionLogin() {
        return $this->render('user.tpl', [
            'model' => 'Login',
            'next' => 'index',
            'token' => Yii::$app->request->csrfToken,
            'isLogin' => false,
        ]);
    }

    public function actionRegister() {
        return $this->render('user.tpl', [
            'model' => 'Register',
            'next' => 'Login',
            'token' => Yii::$app->request->csrfToken,
            'isLogin' => false,
        ]);
    }

    public function actionProfile() {
        $isLogin = $this->dealUserInfo();
        if ($isLogin) {
            $this->renderParamInfo = array_merge($this->renderParamInfo, [
                'isProfile' => true,
            ]);
            return $this->render('profile.tpl', $this->renderParamInfo);
        } else {
            return $this->render('user.tpl', [
                'model' => 'Login',
                'next' => 'index',
                'token' => Yii::$app->request->csrfToken,
                'isLogin' => false,
            ]);
        }
    }

    private function dealAction() {
        $request = Yii::$app->request;
        switch ($this->actionInfo) {
            case 'Register':
                $userName = $request->post('username');
                $passWd = $request->post('passwd');
                if (!$this->doRegister($userName, $passWd)) {
                    $this->nextInfo = 'error';
                };
                break;
            case 'Login':
                $userName = $request->post('username');
                $passWd = $request->post('passwd');
                if (!$this->doLogin($userName, $passWd)) {
                    $this->nextInfo = 'error';
                }
                break;
            case 'Logout':
                $this->doLogout();
                break;
        }
    }

    private function dealNext() {
        switch ($this->nextInfo) {
            case 'error':
                $this->renderInfo = 'error';
                break;
            case 'Register':
                $this->renderInfo = 'user';
                $this->renderParamInfo = [
                    'model' => 'Register',
                    'next' => 'Login',
                    'token' => Yii::$app->request->csrfToken,
                ];
                break;
            case 'Login':
                $this->renderInfo = 'user';
                $this->renderParamInfo = [
                    'model' => 'Login',
                    'next' => 'index',
                    'token' => Yii::$app->request->csrfToken,
                ];
                break;
            case 'index':
            default:
                $this->renderInfo = 'index';
                $this->dealIndex();
                break;
        }
    }

    private function dealIndex() {
        $display = [];
        $admin = Admin::find()->all();
        foreach ($admin as $v) {
            $disImgs = json_decode($v->admin_img);
            if (count($disImgs) > 0) {
                $disImg = $disImgs[0];
            } else {
                $disImg = 'headimg.jpg';
            }
            $disInfo = [
                'name' => $v->admin_name,
                'id' => $v->admin_id,
                'img' => $disImg,
            ];
            array_push($display, $disInfo);
        }
        $display = ['display' => $display];
        $this->renderParamInfo = array_merge($this->renderParamInfo, $display);
    }

    private function dealUserInfo() {
        $cookies = Yii::$app->request->cookies;
        $session = Yii::$app->session;
        if ((($cookie = $cookies->get('loginCookie')) !== null) || ($this->cookieInfo)) {
            if ($this->cookieInfo) {
                $adminIdEncode = $this->cookieInfo['value'];
            } else {
                $adminIdEncode = $cookie->value;
            }
            if ($adminIdEncode) {
                if ($session->has($adminIdEncode)) {
                    $adminId = $session->get($adminIdEncode);
                    $admin = Admin::find()->where([
                        'admin_id' => $adminId,
                    ])->one();
                    $adminName = $admin['admin_name'];
                    $this->renderParamInfo = array_merge($this->renderParamInfo, [
                        'token' => Yii::$app->request->csrfToken,
                        'isLogin' => true,
                        'userName' => $adminName,
                    ]);
                    return true;
                }
            }
        }
        $this->renderParamInfo = array_merge($this->renderParamInfo, [
            'token' => Yii::$app->request->csrfToken,
            'isLogin' => false,
        ]);
        return false;
    }

    private function doRegister($userName, $passWd) {
        try {
            $defaultInfo = Yii::$app->params['defaultInfo'];
            $admin = new Admin();
            $admin->admin_name = $userName;
            $admin->admin_pass = $passWd;
            $admin->admin_score = json_encode($defaultInfo['score']);
            $admin->admin_class = json_encode($defaultInfo['class']);
            $admin->admin_img = json_encode($defaultInfo['img']);
            $admin->admin_url = json_encode($defaultInfo['url']);
            $admin->admin_file = json_encode($defaultInfo['file']);
            $admin->save();
        } catch (\Exception $e) {
            $this->renderParamInfo = [
                'errorStr' => 'The user has been registed',
            ];
            return false;
        }
        return true;
    }

    private function doLogin($userName, $passWd) {
        $admin = Admin::find()->where([
            'admin_name' => $userName,
            'admin_pass' => $passWd,
        ])->one();
        if ($admin) {
            $session = Yii::$app->session;
            $cookies = Yii::$app->response->cookies;
            $adminId = $admin['admin_id'];
            $adminIdEncode = md5($adminId);
            $session->set($adminIdEncode, $adminId);
            $this->cookieInfo = [
                'name' => 'loginCookie',
                'value' => $adminIdEncode,
            ];
            $cookies->add(new \yii\web\Cookie($this->cookieInfo));
            return true;
        }
        $this->renderParamInfo = [
            'errorStr' => 'user or password error',
        ];
        return false;
    }

    private function doLogout() {
        $session = Yii::$app->session;
        $cookies = Yii::$app->request->cookies;
        if (($cookie = $cookies->get('loginCookie')) !== null) {
            $adminIdEncode = $cookie->value;
            if ($adminIdEncode) {
                $session->remove($adminIdEncode);
                $cookies = Yii::$app->response->cookies;
                $cookies->remove('loginCookie');
            }
        }
    }

    public function actionError() {
        return $this->render('error.tpl', [
            'errorStr' => 'Fatal Error !',
            'isLogin' => false,
            'token' => Yii::$app->request->csrfToken,
        ]);
    }

    public function actionDetail() {
        $request = Yii::$app->request;
        $userId = $request->get('id');
        $this->dealUserInfo();
        $admin = Admin::find()->where([
            'admin_id' => $userId,
        ])->one();
        if(!$admin){
            $this->renderParamInfo =array_merge($this->renderParamInfo, [
                'errorStr' => 'No user !',
            ]);
            return $this->render('error.tpl', $this->renderParamInfo);
        }
        return $this->render('detail.tpl', $this->renderParamInfo);
    }
}
