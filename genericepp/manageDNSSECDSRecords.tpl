<div class="alert alert-block alert-info">
    <p>{$LANG.domainname}: <strong>{$domain}</strong></p>
</div>

{if $error}
<div class="alert alert-error textcenter">
    {$error}
</div>
{else}
    {if $DSRecords eq 'YES'}
        <p style="font-size: 110%; text-align: center"><b>DS records:</b><br /></p>
        {foreach $DSRecordslist as $item}
            <div class="textcenter">
            <form method="post" action="clientarea.php">
            <input type="hidden" name="action" value="domaindetails" />
            <input type="hidden" name="id" value="{$domainid}" />
            <input type="hidden" name="modop" value="custom" />
            <input type="hidden" name="a" value="manageDNSSECDSRecords" />
            <input type="hidden" name="command" value="secDNSrem" />

            <div>
            Key tag: <input name="keyTag" type="text" maxlength="65535" data-supported="True" data-required="True" value="{$item.keyTag}" />
            Algorithm: <input name="alg" data-supported="True" data-required="True" value="{$item.alg}">
            Digest type: <input name="digestType" data-supported="True" data-required="True" value="{$item.digestType}">
            Digest: <input name="digest" data-supported="True" data-required="True" value="{$item.digest}">
            </div>

            <p class="text-center">
            <input type="submit" class="btn btn-primary" value="Remove DS Record" />
            </p>
            </form>
            </div>
            <br />
        {/foreach}
    {else}
        <p style="font-size: 200%; text-align: center; background: #EEE; padding: 5px">{$DSRecords}</p>
    {/if}
{/if}

<hr>
<div class="textcenter">
<form method="post" action="clientarea.php">
<input type="hidden" name="action" value="domaindetails" />
<input type="hidden" name="id" value="{$domainid}" />
<input type="hidden" name="modop" value="custom" />
<input type="hidden" name="a" value="manageDNSSECDSRecords" />
<input type="hidden" name="command" value="secDNSadd" />

<div>
Key tag: <input name="keyTag" type="text" maxlength="65535" data-supported="True" data-required="True" data-previousvalue="" />

Algorithm: <select name="alg" data-supported="True" data-required="True" data-previousvalue="">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="10">10</option>
        <option value="12">12</option>
        <option value="13">13</option>
        <option value="253">253</option>
        <option value="254">254</option>
    </select>

Digest type: <select name="digestType" data-supported="True" data-required="True" data-previousvalue="">
        <option value="1">1</option>
        <option value="2">2</option>
    </select>
</div>

<div>Digest: <textarea name="digest" rows="2" data-supported="True" data-required="True" data-previousvalue=""></textarea>
</div>

<p class="text-center">
<input type="submit" class="btn btn-primary" value="Create DS Record" />
</p>
</form>
</div>