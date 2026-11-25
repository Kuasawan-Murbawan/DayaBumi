
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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
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

    <div name="biodata details">

        <div id="name">
            Name:
            <cfoutput>
                #encodeForHTML(fullBiodata.name)#
            </cfoutput>
        </div>

        <div id="age">
            Age:
            <cfoutput>
                #encodeForHTML(fullBiodata.age)#
            </cfoutput>
        </div>

        <div id="dob">
            Date Of Birth:
            <cfoutput>
                #encodeForHTML(fullBiodata.dob)#
            </cfoutput>
        </div>

        <div id="ic">
            IC:
            <cfoutput>
                #encodeForHTML(fullBiodata.ic)#
            </cfoutput>
        </div>

        <div id="gender">
            Gender:
            <cfoutput>
                <cfif fullBiodata.gender eq 'M'>
                    Male
                    <cfelse>
                        Female
                </cfif>
            </cfoutput>
        </div>

        <div id="about-me">
        About Me:
            <cfoutput query="fullBiodata">
                #encodeForHTML(fullBiodata.aboutme)#
            </cfoutput>
        </div>

        <div id="profession">
            <cfoutput query="professionDetails">
                Profession: #encodeForHTML(professionDetails.name)#
            </cfoutput>
        </div>

        <div id="hobbies">
            Hobbies: 
            <cfoutput query="hobbiesDetails">
                #encodeForHTML(hobbiesDetails.name)#: #encodeForHTML(hobbiesDetails.location)# <br>
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

</a href="logout.cfm">Logout</a>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

</body>

</html>