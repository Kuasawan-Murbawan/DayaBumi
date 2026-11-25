
<cfparam  name="FORM.email" default="">
<cfparam  name="FORM.password" default="">

<!--- PREVENT DIRECT ACCESS --->
<cfif CGI.REQUEST_METHOD eq "GET" OR structIsEmpty(FORM)>
  <cfset SESSION.errorMsg="Please do not access the page directly, login lu">
  <cflocation  url="login.cfm" addtoken="false">
</cfif>

<!--- CHECK FOR MISSING FIELD --->
<cfif not structKeyExists(FORM, "email") OR NOT len(trim(FORM.email))
      OR NOT structKeyExists(FORM, "password") OR NOT len(trim(FORM.password))>

  <cfset SESSION.errorMsg="Please fill in all the field">
  <cflocation url="login.cfm" addtoken="false">
</cfif>

<!--- FETCH USER USING EMAIL --->

<cfquery name="qUser">
  SELECT userID, email, name, passwordHash  
  FROM biodata 
  WHERE email=<cfqueryparam value="#trim(FORM.email)#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<cfset hashPw = lcase(hash(trim(FORM.password), "SHA-256"))>

<cfif qUser.recordCount EQ 1 AND compare(qUser.passwordHash, hashPw) eq 0>

    <!--- TELL APPLICATION THAT THE USER IS LOGGED IN --->
    <cfset sessionRotate()>
    <cfset SESSION.isLoggedIn = true>
    <cfset SESSION.userID = qUser.userID>
    <cfset SESSION.userName = qUser.name>
    <cfset SESSION.successMsg = "login successful, welcome #qUser.name#">
    <cflocation url="landing.cfm" addtoken="false">

    <cfelse>
      <cfset SESSION.errorMsg="Email or Password is incorrect.">
      <cflocation  url="login.cfm" addtoken="false">
</cfif>
