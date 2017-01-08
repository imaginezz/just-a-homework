{include file='../layouts/header.tpl'}
<div class="container">
    <div class="jumbotron">
        <h1>Error</h1>
        <p>{$errorStr}</p>
        <p>Return to the previous page 1 second later.</p>
    </div>
</div>
{include file='../layouts/footer.tpl'}
<script>
    function timer(callback){
        setTimeout(function(){
            callback();
        }, 1000);
    }

    timer(function(){
        history.go(-1);
    });
</script>