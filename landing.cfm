
<cfset professionDetails="">

<cfinvoke 
    component="components.professions" 
    method="getProfessionByID"
    userID="#SESSION.userID#"
    returnvariable="professionDetails"
>

<cfinvoke 
    component="components.hobbies" 
    method="getHobbyByUserID2"
    userID="#SESSION.userID#"
    returnvariable="hobbiesDetails"
    >

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

Saya di landing branch

    <div name="biodata details">

        <div name="profession">
        <cfoutput query="professionDetails">
            Profession: #professionDetails.name#
        </cfoutput>
        </div>

        <div name="hobbies">
            Hobbies: 
            <cfoutput query="hobbiesDetails">
                #hobbiesDetails.name#: #hobbiesDetails.location# <br>
            </cfoutput>
        </div>
    </div>

<a href="logout.cfm">Logout</a>
</body>

</html>