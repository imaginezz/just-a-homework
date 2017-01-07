<!doctype html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="vendor/bower/bootstrap/dist/css/bootstrap.min.css">
    <script src="vendor/bower/jquery/dist/jquery.min.js"></script>
    <script src="vendor/bower/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="script/app.js"></script>
    <title>Yet Another Site</title>
</head>
<body>
<nav class="navbar navbar-default navbar-inverse" role="navigation">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.php">Yet Another Site</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                {if ! isset($isProfile)}
                    <li class="active"><a href="index.php">Explore</a></li>
                {else}
                    <li><a href="index.php">Explore</a></li>
                {/if}
                {if $isLogin==1}
                    {if ! isset($isProfile)}
                        <li><a href="index.php?r=site/profile">Profile</a></li>
                    {else}
                        <li class="active"><a href="index.php?r=site/profile">Profile</a></li>
                    {/if}
                {/if}
            </ul>
            {if $isLogin==0}
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="index.php?r=site/login">Login</a></li>
                    <li><a href="index.php?r=site/register">Register</a></li>
                </ul>
            {else}
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">{$userName}<span
                                    class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" id="exitButton">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            {/if}

        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<form action="index.php" method="post" id="exitForm">
    <input type="hidden" name="action" id="action" value="Logout">
    <input name="_csrf" type="hidden" id="_csrf" value="{$token}">
    <input type="hidden" name="next" id="next" value="index">
</form>
