<html>
<head>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <title>Landing Page</title>
  <!-- <link rel='stylesheet' href='main.css'> -->
</head>
<body>
<cfif structKeyExists(SESSION, "successMsg") AND len(trim(SESSION.successMsg))>
    <cfoutput>
        <div class="">
            #encodeForHTML(SESSION.successMsg)#
        </div>
    </cfoutput>
    <cfset structDelete(SESSION, "successMsg")>
</cfif>

Saya di landing

<a href="logout.cfm">Logout</a>
</body>

</html>