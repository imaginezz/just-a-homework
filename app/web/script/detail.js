'use strict';
var app = angular.module('appDetail', []);
var urlBase = 'index.php?r=api/action';
app.controller('detailController', function ($scope, $http) {
    $scope.Score = [];
    $scope.Class = [];
    $scope.Imgs = [];
    $scope.Url = [];
    $scope.Files = [];
    $scope.FileNames = [];
    $scope.getInfo = function (type) {
        var id=getQueryString('id');
        $http.post(urlBase, {
            type: type,
            action: 'getInfo',
            id:getQueryString('id')
        }).then(function (response) {
            console.log(response.data.info);
            switch (type) {
                case 'score':
                    $scope.Score = JSON.parse(response.data.info);
                    break;
                case 'class':
                    $scope.Class = JSON.parse(response.data.info);
                    break;
                case 'img':
                    $scope.Imgs = JSON.parse(response.data.info);
                    break;
                case 'url':
                    $scope.Url = JSON.parse(response.data.info);
                    break;
                case 'file':
                    $scope.Files = JSON.parse(response.data.info);
                    genFileName();
                    break;
            }
        }, function (response) {
            console.log(response);
        });
    };
    var genFileName = function () {
        for (var i in $scope.Files) {
            var fileSplit = $scope.Files[i].split('$');
            var fileName = fileSplit[2];
            $scope.FileNames.push(fileName);
        }
    };
    var getQueryString = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);  //获取url中"?"符后的字符串并正则匹配
        var context = "";
        if (r != null)
            context = r[2];
        reg = null;
        r = null;
        return context == null || context == "" || context == "undefined" ? "" : context;
    };
    $scope.getInfo('score');
    $scope.getInfo('class');
    $scope.getInfo('img');
    $scope.getInfo('url');
    $scope.getInfo('file');
});
