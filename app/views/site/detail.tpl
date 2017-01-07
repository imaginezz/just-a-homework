{include file='../layouts/header.tpl'}
<script src="vendor/bower-asset/angular/angular.js"></script>
<script src="script/detail.js"></script>
<link rel="stylesheet" href="css/profile.css">
{literal}
    <div class="container" ng-app="appDetail" ng-controller="detailController">
        <a href="index.php"><h2><span class="glyphicon glyphicon-arrow-left"></span> go back</h2></a>
        <h1>Score</h1>
        <table class="table table-condensed table-hover">
            <tr>
                <th>Index</th>
                <th>Subject</th>
                <th>Score</th>
            </tr>
            <tr ng-repeat="score in Score track by $index">
                <td>{{$index+1}}</td>
                <td>{{score.Subject}}</td>
                <td>{{score.Score}}</td>
            </tr>
        </table>
        <hr>
        <h1>Class</h1>
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
                    {{Class[$parent.$index][$index]}}
                </td>
            </tr>
        </table>
        <h1>Image</h1>
        <table class="table table-condensed table-hover" id="imageTable">
            <tr>
                <th>Index</th>
                <th>Img</th>
            </tr>
            <tr ng-repeat="img in Imgs  track by $index">
                <td>{{$index+1}}</td>
                <td><img alt="" ng-src="uploads/{{img}}"></td>
            </tr>
        </table>
        <h1>Personal</h1>
        <h3>Url list</h3>
        <table class="table table-condensed table-hover">
            <tr>
                <th>Index</th>
                <th>Url</th>
            </tr>
            <tr ng-repeat="url in Url  track by $index">
                <td>{{$index + 1}}</td>
                <td><a ng-href="{{url}}" target="_blank">{{url}}</a></td>
            </tr>
        </table>
        <h3>File list</h3>
        <table class="table table-condensed table-hover" id="personTable">
            <tr>
                <th>Index</th>
                <th>Name</th>
                <th>Download</th>
            </tr>
            <tr ng-repeat="file in Files  track by $index">
                <td>{{$index + 1}}</td>
                <td>{{FileNames[$index]}}</td>
                <td><a ng-href="uploads/{{file}}" class="glyphicon glyphicon-download" target="_blank"></a></td>
            </tr>
        </table>
    </div>
{/literal}
{include file='../layouts/footer.tpl'}