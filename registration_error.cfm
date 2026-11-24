<p>There is an error, go back to <a href="register.cfm">registration</a></p>
<cfdump  var="#session#">

<cfif structKeyExists(SESSION, "errorMsg") AND len(trim(SESSION.errorMsg))>
    <cfoutput>
        <div class="alert alert-danger">
            #encodeForHTML(SESSION.errorMsg)#
        </div>
    </cfoutput>
    <cfset structDelete(SESSION, "errorMsg")>
</cfif>