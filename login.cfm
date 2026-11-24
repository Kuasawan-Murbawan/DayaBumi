

<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <title>Login Page</title>
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


  <form action="login_action.cfm" method="get">
    
    <label for="email">Email:</label>
    <input type="text" id="email" name="email"/>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password"/>

    <button type="submit">Login</button>
  </form>
  
</body>
</html>