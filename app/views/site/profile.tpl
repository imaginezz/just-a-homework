{include file='../layouts/header.tpl'}
<script src="vendor/bower-asset/angular/angular.js"></script>
<script src="vendor/bower-asset/angular-file-upload/dist/angular-file-upload.min.js"></script>
<script src="script/profile.js"></script>
<link rel="stylesheet" href="css/profile.css">
{literal}
    <div class="container" ng-app="appProfile">
        <div id="scoreCtrl" ng-controller="scoreCtrl">
            <h1>Score</h1>
            <div class="input-group">
                <input class="form-control" type="text" placeholder="Enter the Subject you want to add"
                       ng-model="subjectAdd" required>
                <input class="form-control" type="text" placeholder="Enter the Score you want to add"
                       ng-model="scoreAdd" required>
                <div class="input-group-addon btn-primary" ng-click="scoreAddFun();" ng-show="subjectAdd&&scoreAdd">
                    Add
                </div>
                <div class="input-group-addon disabled curNot" ng-show="!(subjectAdd&&scoreAdd)">Add</div>
            </div>
            <br>
            <table class="table table-condensed table-hover">
                <tr>
                    <th>Index</th>
                    <th>Subject</th>
                    <th>Score</th>
                    <th>Delete</th>
                </tr>
                <tr ng-repeat="score in Score track by $index">
                    <td>{{$index+1}}</td>
                    <td>{{score.Subject}}</td>
                    <td>{{score.Score}}</td>
                    <td><p class="glyphicon glyphicon-remove curPointer" ng-click="scoreDelFun($index);"></p></td>
                </tr>
            </table>
        </div>
        <hr>
        <div id="classCtrl" ng-controller="classCtrl">
            <h1>Class</h1>
            <br>
            <table class="table table-condensed table-hover">
                <tr>
                    <th>No.</th>
                    <th>Mon.</th>
                    <th>Tue.</th>
                    <th>Wed.</th>
                    <th>Thu.</th>
                    <th>Fri.</th>
                    <th>Sat.</th>
                    <th>Sun.</th>
                </tr>
                <tr ng-repeat="cls in Class track by $index">
                    <td>{{$index+1}}</td>
                    <td ng-repeat="oneCls in cls track by $index">
                        <input class="form-control" type="text" ng-model="Class[$parent.$index][$index]">
                    </td>
                </tr>
            </table>
            <button type="button" class="btn btn-danger" ng-click="classSubmit()">Submit !</button>
        </div>
        <hr>
        <div id="imgCtrl" ng-controller="imgCtrl">
            <h1>Image</h1>
            <table class="table table-condensed table-hover" id="imageTable">
                <tr>
                    <th>Index</th>
                    <th>Img</th>
                    <th>Delete</th>
                </tr>
                <tr ng-repeat="img in Imgs  track by $index">
                    <td>{{$index+1}}</td>
                    <td><img alt="" ng-src="uploads/{{img}}"></td>
                    <td><p class="glyphicon glyphicon-remove curPointer" ng-click="imgDelFun($index);"></p></td>
                </tr>
            </table>
            <br>
            <h3><label for="imgPicker">Please select the pictures you want to upload.(Might be slow)</label></h3>
            <input id="imgPicker" class="btn btn-default" type="file" accept="image/*" nv-file-select=""
                   uploader="uploader" multiple/><br/>
            <div>
                <h3>Upload queue</h3>
                <p>Queue length: {{ uploader.queue.length }}</p>
                <table class="table">
                    <thead>
                    <tr>
                        <th width="50%">Name</th>
                        <th ng-show="uploader.isHTML5">Size</th>
                        <th ng-show="uploader.isHTML5">Progress</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="item in uploader.queue">
                        <td><strong>{{ item.file.name }}</strong></td>
                        <td ng-show="uploader.isHTML5" nowrap>{{ item.file.size/1024/1024|number:2 }} MB</td>
                        <td ng-show="uploader.isHTML5">
                            <div class="progress">
                                <div class="progress-bar" role="progressbar"
                                     ng-style="{ 'width': item.progress + '%' }"></div>
                            </div>
                        </td>
                        <td class="text-center">
                            <span ng-show="item.isSuccess"><i class="glyphicon glyphicon-ok"></i></span>
                            <span ng-show="item.isCancel"><i class="glyphicon glyphicon-ban-circle"></i></span>
                            <span ng-show="item.isError"><i class="glyphicon glyphicon-remove"></i></span>
                        </td>
                        <td nowrap>
                            <button type="button" class="btn btn-success btn-xs" ng-click="item.upload()"
                                    ng-disabled="item.isReady || item.isUploading || item.isSuccess">
                                <span class="glyphicon glyphicon-upload"></span> Upload
                            </button>
                            <button type="button" class="btn btn-warning btn-xs" ng-click="item.cancel()"
                                    ng-disabled="!item.isUploading">
                                <span class="glyphicon glyphicon-ban-circle"></span> Cancel
                            </button>
                            <button type="button" class="btn btn-danger btn-xs" ng-click="item.remove()">
                                <span class="glyphicon glyphicon-trash"></span> Remove
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <div>
                    <div>
                        Queue progress:
                        <div class="progress">
                            <div class="progress-bar" role="progressbar"
                                 ng-style="{ 'width': uploader.progress + '%' }"></div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-success btn-s" ng-click="uploader.uploadAll()"
                            ng-disabled="!uploader.getNotUploadedItems().length">
                        <span class="glyphicon glyphicon-upload"></span> Upload all
                    </button>
                    <button type="button" class="btn btn-warning btn-s" ng-click="uploader.cancelAll()"
                            ng-disabled="!uploader.isUploading">
                        <span class="glyphicon glyphicon-ban-circle"></span> Cancel all
                    </button>
                    <button type="button" class="btn btn-danger btn-s" ng-click="uploader.clearQueue()"
                            ng-disabled="!uploader.queue.length">
                        <span class="glyphicon glyphicon-trash"></span> Remove all
                    </button>
                    <h4>{{fileError}}</h4>
                </div>

            </div>
        </div>
        <hr>
        <div id="personCtrl" ng-controller="personCtrl">
            <h1>Personal</h1>
            <h3>Url list</h3>
            <div class="input-group">
                <input class="form-control" ng-model="urlInput" type="text" placeholder="Enter your Url to add">
                <div class="input-group-addon" ng-click="urlAddFun();">Add Url</div>
            </div>
            <br>
            <table class="table table-condensed table-hover">
                <tr>
                    <th>Index</th>
                    <th>Url</th>
                </tr>
                <tr ng-repeat="url in Url  track by $index">
                    <td>{{$index + 1}}</td>
                    <td><a ng-href="{{url}}" target="_blank">{{url}}</a></td>
                    <td><p class="glyphicon glyphicon-remove curPointer" ng-click="urlDelFun($index);"></p></td>
                </tr>
            </table>

            <h3>File list</h3>
            <table class="table table-condensed table-hover">
                <tr>
                    <th>Index</th>
                    <th>Name</th>
                    <th>Download</th>
                    <th>Delete</th>
                </tr>
                <tr ng-repeat="file in Files  track by $index">
                    <td>{{$index + 1}}</td>
                    <td>{{FileNames[$index]}}</td>
                    <td><a ng-href="uploads/{{file}}" class="glyphicon glyphicon-download" target="_blank"></a></td>
                    <td><p class="glyphicon glyphicon-remove curPointer" ng-click="fileDelFun($index);"></p></td>
                </tr>
            </table>
            <h3><label for="filePicker">Please select your file to upload.</label></h3>
            <input id="filePicker" class="btn btn-default" type="file" nv-file-select="" uploader="uploader"
                   multiple/><br>
            <div>
                <h3>Upload queue</h3>
                <p>Queue length: {{ uploader.queue.length }}</p>
                <table class="table">
                    <thead>
                    <tr>
                        <th width="50%">Name</th>
                        <th ng-show="uploader.isHTML5">Size</th>
                        <th ng-show="uploader.isHTML5">Progress</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="item in uploader.queue">
                        <td><strong>{{ item.file.name }}</strong></td>
                        <td ng-show="uploader.isHTML5" nowrap>{{ item.file.size/1024/1024|number:2 }} MB</td>
                        <td ng-show="uploader.isHTML5">
                            <div class="progress">
                                <div class="progress-bar" role="progressbar"
                                     ng-style="{ 'width': item.progress + '%' }"></div>
                            </div>
                        </td>
                        <td class="text-center">
                            <span ng-show="item.isSuccess"><i class="glyphicon glyphicon-ok"></i></span>
                            <span ng-show="item.isCancel"><i class="glyphicon glyphicon-ban-circle"></i></span>
                            <span ng-show="item.isError"><i class="glyphicon glyphicon-remove"></i></span>
                        </td>
                        <td nowrap>
                            <button type="button" class="btn btn-success btn-xs" ng-click="item.upload()"
                                    ng-disabled="item.isReady || item.isUploading || item.isSuccess">
                                <span class="glyphicon glyphicon-upload"></span> Upload
                            </button>
                            <button type="button" class="btn btn-warning btn-xs" ng-click="item.cancel()"
                                    ng-disabled="!item.isUploading">
                                <span class="glyphicon glyphicon-ban-circle"></span> Cancel
                            </button>
                            <button type="button" class="btn btn-danger btn-xs" ng-click="item.remove()">
                                <span class="glyphicon glyphicon-trash"></span> Remove
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <div>
                    <div>
                        Queue progress:
                        <div class="progress">
                            <div class="progress-bar" role="progressbar"
                                 ng-style="{ 'width': uploader.progress + '%' }"></div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-success btn-s" ng-click="uploader.uploadAll()"
                            ng-disabled="!uploader.getNotUploadedItems().length">
                        <span class="glyphicon glyphicon-upload"></span> Upload all
                    </button>
                    <button type="button" class="btn btn-warning btn-s" ng-click="uploader.cancelAll()"
                            ng-disabled="!uploader.isUploading">
                        <span class="glyphicon glyphicon-ban-circle"></span> Cancel all
                    </button>
                    <button type="button" class="btn btn-danger btn-s" ng-click="uploader.clearQueue()"
                            ng-disabled="!uploader.queue.length">
                        <span class="glyphicon glyphicon-trash"></span> Remove all
                    </button>
                    <h4>{{fileError}}</h4>
                </div>
            </div>
        </div>
    </div>
{/literal}
{include file='../layouts/footer.tpl'}
