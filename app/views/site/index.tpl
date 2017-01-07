{include file='../layouts/header.tpl'}
<div class="container">
    <div class="jumbotron">
        <h1>User Directory</h1>
        <br>
        <div class="row">
            {foreach $display as $ins}
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="uploads/{$ins.img}" alt="...">
                    <div class="caption">
                        <h3>{$ins.name}</h3>
                        <p><a href="index.php?r=site/detail&id={$ins.id}" class="btn btn-primary" role="button">More detail</a></p>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
    </div>
</div>
{include file='../layouts/footer.tpl'}
