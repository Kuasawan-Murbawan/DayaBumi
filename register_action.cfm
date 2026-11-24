
<cfparam  name="FORM.name" default="">
<cfparam  name="FORM.email" default="">
<cfparam  name="FORM.password" default="">
<cfparam  name="FORM.confirmpassword" default="">
<cfparam  name="FORM.dob" default="">
<cfparam  name="FORM.aboutme" default="">
<cfparam  name="FORM.profession" default="">
<cfparam name="FORM.hobby" default="">
<cfparam  name="FORM.ic" default="">
<cfparam  name="FORM.age" default="">
<cfparam  name="FORM.gender" default="">
<cfparam  name="FORM.contactpreference" default="0">

<!---  avoid users from accessing the url directly without submitting form --->
<cfif CGI.REQUEST_METHOD eq "GET" || structIsEmpty(FORM)>
  <cflocation  url="register.cfm" addtoken="false">
</cfif>

<!--- server-side validation --->
<cfif NOT structKeyExists(FORM, "name") OR NOT len(trim(FORM.name))
   OR NOT structKeyExists(FORM, "email") OR NOT len(trim(FORM.email))
   OR NOT structKeyExists(FORM, "password") OR NOT len(trim(FORM.password))
   OR NOT structKeyExists(FORM, "confirmpassword") OR NOT len(trim(FORM.confirmpassword))
   OR NOT structKeyExists(FORM, "ic") OR NOT len(trim(FORM.ic))
   OR NOT structKeyExists(FORM, "dob") OR NOT len(trim(FORM.dob))
   OR NOT structKeyExists(FORM, "gender") OR NOT len(trim(FORM.gender))>

    <cfset SESSION.errorMsg="All field must be filled">
    <cflocation  url="register.cfm" addtoken="false">

</cfif>

<!--- CHECKING DUPLICATE EMAIL --->
<cfquery name="queryResult">
  SELECT userID FROM biodata WHERE email = <cfqueryparam value="#trim(FORM.email)#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif queryResult.recordCount gt 0>
  <cfset SESSION.errorMsg = "Email is already registered">
  <cflocation  url="register.cfm" addtoken="false">
</cfif>

<!--- CHECKING IF PASSWORD MATCHES --->
<cfif compare(FORM.password, FORM.confirmpassword) NEQ 0>
    <cfset SESSION.errorMsg = "Passwords do not match.">
    <cflocation url="register.cfm" addtoken="false">
</cfif>

<!--- HASHING PASSWORD --->
<cfset hashedPassword = lCase(hash(trim(FORM.password), "SHA-256"))>

<!--- Contact MASKING BIT OR --->
<cfset contactMask = 0>

<cfloop list="#FORM.contactpreference#" index="bitVal">
  <cfif isNumeric(bitVal)>
    <cfset contactMask = bitOr(contactMask, val(bitVal))>
  </cfif>
</cfloop>

<!--- INSERT INTO DATABASE --->
<cftransaction>
  <cfquery name="qInsertUser" result="insertResult">
    INSERT INTO biodata (
          name, email, passwordHash, dob, aboutme, profID, IC, age, gender, contactMask
      )
      VALUES (
        <cfqueryparam value="#trim(FORM.name)#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#trim(FORM.email)#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#FORM.dob#" cfsqltype="cf_sql_date">,
          <cfqueryparam value="#trim(FORM.aboutme)#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#val(FORM.profession)#" cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#trim(FORM.IC)#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#val(FORM.age)#" cfsqltype="cf_sql_integer">,
          <cfqueryparam value="#trim(FORM.gender)#" cfsqltype="cf_sql_char">,
          <cfqueryparam value="#contactMask#" cfsqltype="cf_sql_integer">
      )
  </cfquery>

  <!---   INSERT hobby into UserHobbies table --->
  <cfset newUserID = insertResult.generatedKey>

  <cfif len(trim(FORM.hobby))>

    <cfloop list="#FORM.hobby#" index="item">

      <cfif isNumeric(item)>

          <cfquery>
          INSERT INTO UserHobbies (UserID, HobbyID)
          VALUES (
            <cfqueryparam value="#newUserID#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#val(item)#" cfsqltype="cf_sql_integer">
          )
        </cfquery>

      </cfif>
    </cfloop>
  </cfif>

</cftransaction>


<cfset SESSION.successMsg = "Registration successful, please log in">
<cflocation url="login.cfm" addtoken="false">
