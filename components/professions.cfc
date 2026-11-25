
<cfcomponent displayname="professions" hint="CF Component for profession">

    <cffunction  name="getAllProfessions" returntype="query">

        <cfquery name="allProfessions">
            SELECT profID, name from profession
        </cfquery>

        <cfreturn allProfessions>

    </cffunction>

    <cffunction  name="getProfessionByID" returntype="query">

        <cfargument  name="userID" required="yes">
        <cfquery name="qUser">
            SELECT profID 
            FROM biodata 
            WHERE userID=<cfqueryparam value="#val(userID)#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfset profID = trim(qUser.profID)>

        <cfquery name="professionDetails" >
            SELECT profID, name 
            FROM profession 
            WHERE profID=<cfqueryparam value="#profID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn professionDetails>

    </cffunction>

</cfcomponent>