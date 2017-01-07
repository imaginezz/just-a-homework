{include file='../layouts/header.tpl'}
<div class="container">
    <div class="jumbotron">
        <h1>{$model}</h1>
        <br>
        <form role="form" action="index.php" method="post">
            <input name="_csrf" type="hidden" id="_csrf" value="{$token}">
            <input type="hidden" name="action" id="action" value="{$model}">
            <input type="hidden" name="next" id="next" value="{$next}">
            <div class="form-group">
                <label for="inputUser">User</label>
                <input type="text" class="form-control" id="imputUser" name="username" placeholder="Enter UserName" required>
            </div>
            <div class="form-group">
                <label for="inputPassword">Password</label>
                <input type="password" class="form-control" id="inputPassword" name="passwd" placeholder="Password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-lg btn-block">{$model} !</button>
        </form>
    </div>
</div>
{include file='../layouts/footer.tpl'}