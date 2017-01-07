'use strict';
var app = angular.module('appProfile', ['angularFileUpload']);
var urlBase = 'index.php?r=api/action';
app.controller('scoreCtrl', function ($scope, $http) {
    $scope.Score = [];
    ($http.post(urlBase, {
        type: 'score',
        action: 'getInfo'
    }).then(function (response) {
        console.log(response.data.info);
        $scope.Score = JSON.parse(response.data.info);
    }, function (response) {
        console.log(response);
    }));
    $scope.scoreAddFun = function () {
        var scoreObj = {
            'Subject': $scope.subjectAdd,
            'Score': $scope.scoreAdd
        };
        $scope.Score.push(scoreObj);
        $scope.subjectAdd = '';
        $scope.scoreAdd = '';
        $scope.scoreSubmit();
    };
    $scope.scoreDelFun = function ($index) {
        $scope.Score.splice($index, 1);
        $scope.scoreSubmit();
    };
    $scope.scoreSubmit = function () {
        $http.post(urlBase, {
            type: 'score',
            action: 'updateInfo',
            info: JSON.stringify($scope.Score)
        }).then(function (response) {
            console.log(response);
        }, function (response) {
            console.log(response);
        });
    }
});
app.controller('classCtrl', function ($scope, $http) {
    $scope.Class = [];
    ($http.post(urlBase, {
        type: 'class',
        action: 'getInfo'
    }).then(function (response) {
        console.log(response.data.info);
        $scope.Class = JSON.parse(response.data.info);
    }, function (response) {
        console.log(response);
    }));
    $scope.classSubmit = function () {
        $http.post(urlBase, {
            type: 'class',
            action: 'updateInfo',
            info: JSON.stringify($scope.Class)
        }).then(function (response) {
            console.log(response);
        }, function (response) {
            console.log(response);
        });
        console.log($scope.Class);
    };
});
app.controller('imgCtrl', ['$scope', 'FileUploader', '$http', function ($scope, FileUploader, $http) {
    var uploader = $scope.uploader = new FileUploader({
        url: 'index.php?r=api/upload-pic'
    });
    uploader.filters.push({
        name: 'imageFilter',
        fn: function (item /*{File|FileLikeObject}*/, options) {
            var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
            return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
        }
    });
    uploader.onWhenAddingFileFailed = function (item /*{File|FileLikeObject}*/, filter, options) {
        console.info('onWhenAddingFileFailed', item, filter, options);
    };
    uploader.onAfterAddingFile = function (fileItem) {
        console.info('onAfterAddingFile', fileItem);
    };
    uploader.onAfterAddingAll = function (addedFileItems) {
        console.info('onAfterAddingAll', addedFileItems);
    };
    uploader.onBeforeUploadItem = function (item) {
        console.info('onBeforeUploadItem', item);
    };
    uploader.onProgressItem = function (fileItem, progress) {
        console.info('onProgressItem', fileItem, progress);
    };
    uploader.onProgressAll = function (progress) {
        console.info('onProgressAll', progress);
    };
    uploader.onSuccessItem = function (fileItem, response, status, headers) {
        $scope.fileError='';
        console.info('onSuccessItem', fileItem, response, status, headers);
    };
    uploader.onErrorItem = function (fileItem, response, status, headers) {
        $scope.fileError='File Upload Error, please check your file size or change another file.';
        console.info('onErrorItem', fileItem, response, status, headers);
    };
    uploader.onCancelItem = function (fileItem, response, status, headers) {
        console.info('onCancelItem', fileItem, response, status, headers);
    };
    uploader.onCompleteItem = function (fileItem, response, status, headers) {
        console.info('onCompleteItem', fileItem, response, status, headers);
    };
    uploader.onCompleteAll = function () {
        getImgs();
        console.info('onCompleteAll');
    };
    console.info('uploader', uploader);

    $scope.fileError='';

    $scope.Imgs = [];
    var getImgs = function () {
        ($http.post(urlBase, {
            type: 'img',
            action: 'getInfo'
        }).then(function (response) {
            console.log(response.data.info);
            $scope.Imgs = JSON.parse(response.data.info);
        }, function (response) {
            console.log(response);
        }));
    };

    getImgs();
    $scope.imgDelFun = function ($index) {
        $scope.Imgs.splice($index, 1);
        $scope.imgSubmit();
    };
    $scope.imgSubmit = function () {
        $http.post(urlBase, {
            type: 'img',
            action: 'updateFileInfo',
            info: JSON.stringify($scope.Imgs)
        }).then(function (response) {
            console.log(response);
        }, function (response) {
            console.log(response);
        });
    };
}]);

app.controller('personCtrl', ['$scope', 'FileUploader', '$http', function ($scope, FileUploader, $http) {
    var uploader = $scope.uploader = new FileUploader({
        url: 'index.php?r=api/upload-file'
    });
    uploader.onWhenAddingFileFailed = function (item /*{File|FileLikeObject}*/, filter, options) {
        console.info('onWhenAddingFileFailed', item, filter, options);
    };
    uploader.onAfterAddingFile = function (fileItem) {
        console.info('onAfterAddingFile', fileItem);
    };
    uploader.onAfterAddingAll = function (addedFileItems) {
        console.info('onAfterAddingAll', addedFileItems);
    };
    uploader.onBeforeUploadItem = function (item) {
        console.info('onBeforeUploadItem', item);
    };
    uploader.onProgressItem = function (fileItem, progress) {
        console.info('onProgressItem', fileItem, progress);
    };
    uploader.onProgressAll = function (progress) {
        console.info('onProgressAll', progress);
    };
    uploader.onSuccessItem = function (fileItem, response, status, headers) {
        $scope.fileError='';
        console.info('onSuccessItem', fileItem, response, status, headers);
    };
    uploader.onErrorItem = function (fileItem, response, status, headers) {
        $scope.fileError='File Upload Error, please check your file size or change another file.';
        console.info('onErrorItem', fileItem, response, status, headers);
    };
    uploader.onCancelItem = function (fileItem, response, status, headers) {
        console.info('onCancelItem', fileItem, response, status, headers);
    };
    uploader.onCompleteItem = function (fileItem, response, status, headers) {
        console.info('onCompleteItem', fileItem, response, status, headers);
    };
    uploader.onCompleteAll = function () {
        console.info('onCompleteAll');
        getFiles();
    };

    console.info('uploader', uploader);

    $scope.fileError='';

    $scope.Url = [];
    ($http.post(urlBase, {
        type: 'url',
        action: 'getInfo'
    }).then(function (response) {
        console.log(response.data.info);
        $scope.Url = JSON.parse(response.data.info);
    }, function (response) {
        console.log(response);
    }));
    $scope.urlAddFun = function () {
        $scope.Url.push($scope.urlInput);
        $scope.urlInput = '';
        $scope.urlSubmit();
    };
    $scope.urlDelFun = function ($index) {
        $scope.Url.splice($index, 1);
        $scope.urlSubmit();
    };
    $scope.urlSubmit = function () {
        $http.post(urlBase, {
            type: 'url',
            action: 'updateInfo',
            info: JSON.stringify($scope.Url)
        }).then(function (response) {
            console.log(response);
        }, function (response) {
            console.log(response);
        });
    };

    $scope.Files=[];
    $scope.FileNames=[];
    var getFiles=function () {
        ($http.post(urlBase, {
            type: 'file',
            action: 'getInfo'
        }).then(function (response) {
            console.log(response.data.info);
            $scope.Files = JSON.parse(response.data.info);
            genFileName();
        }, function (response) {
            console.log(response);
        }));
    };
    getFiles();
    var genFileName=function(){
        for(var i in $scope.Files){
            var fileSplit=$scope.Files[i].split('$');
            var fileName=fileSplit[2];
            $scope.FileNames.push(fileName);
        }
    };
    $scope.fileDelFun=function ($index) {
        $scope.Files.splice($index, 1);
        $scope.fileSubmit();
    };
    $scope.fileSubmit=function(){
        $http.post(urlBase, {
            type: 'file',
            action: 'updateInfo',
            info: JSON.stringify($scope.Url)
        }).then(function (response) {
            console.log(response);
        }, function (response) {
            console.log(response);
        });
    };
}]);
