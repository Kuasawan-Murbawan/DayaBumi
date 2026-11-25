
<cfcomponent>

  <cffunction  name="getFullBiodata" returntype="query">
    <cfargument  name="userID" required="yes">

    <cfquery name="userDetails">
      SELECT * 
      FROM biodata
      WHERE userID = <cfqueryparam value="#val(userID)#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfreturn userDetails>
  </cffunction>

  <cffunction name="getContactPreference" returntype="array">
    <cfargument  name="contactMask" required="yes">

    <cfscript>
      var contactsMatched = [];
      var mask = val(arguments.contactMask);

      for (var pref in APPLICATION.contactPrefs){
        if(bitAnd(mask, pref.bit) gt 0){
          contactsMatched.append(pref.label)
        }
      }

      return contactsMatched;

    </cfscript>
  </cffunction>

</cfcomponent>