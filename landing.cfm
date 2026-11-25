
<cfset professionDetails="">
<cfset hobbiesDetails="">
<cfset fullBiodata="">
<cfset contactPrefs= []>

<cfinvoke  
    component="components.biodata"
    method="getFullBiodata"
    userID="#SESSION.userID#"
    returnvariable="fullBiodata"
>
<cfset maskVal = (isQuery(fullBiodata) && fullBiodata.recordCount GT 0) ? val(fullBiodata.contactMask) : 0>
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

<cfinvoke  
    component="components.biodata"
    method="getContactPreference"
    contactMask="#maskVal#"
    returnvariable="contactPrefs"
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

        <div id="contact-preference">
            <cfoutput>
                <div>
                    Contact preference (Mask: #encodeForHTML(maskVal)#):
                </div>
                <cfif arrayLen(contactPrefs) GT 0>
                    <ul>
                        <cfloop array="#contactPrefs#" item="item">
                            <li>#encodeForHTML(item)#</li>
                        </cfloop>
                    </ul>
                    <cfelse>
                        <div>None Selected</div>
                </cfif>
            </cfoutput>
        </div>
    </div>

<a href="logout.cfm">Logout</a>
</body>

</html>