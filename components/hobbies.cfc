
<cfcomponent displayname="hobbies" hint="to fetch hobbies stuff">

    <cffunction  name="getAllHobbies" returntype="query">

        <cfquery name="hobbies">
                SELECT hobbyID, name, location from hobbies
        </cfquery>

        <cfreturn hobbies>

    </cffunction>

    <cffunction  name="getHobbyByUserID" returntype="query">
        <cfargument  name="userID" required="yes">

        <cfquery name="qUserHobbies">
            SELECT hobbyID
            FROM UserHobbies
            WHERE userID=<cfqueryparam value="#val(userID)#" cfsqltype="cf_sql_integer">
        </cfquery>

        <!--- this will return hobbyID only, not the name or details, so need to fetch hobbies table --->

        <cfset hobbyIdList = valueList(qUserHobbies.hobbyID)>

        <cfquery name="hobbiesDetails">
            SELECT hobbyID, name, location
            FROM hobbies
            WHERE hobbyID in (<cfqueryparam value="#hobbyIDList#" cfsqltype="CF_SQL_INTEGER" list="true">)
        </cfquery>

        <cfreturn hobbiesDetails>

    </cffunction>

    <cffunction  name="getHobbyByUserID2" returntype="query">
        <cfargument  name="userID" required="yes">

        <cfquery name="hobbiesDetails">
            SELECT userHobbies.hobbyid, hobbies.name, hobbies.location
            FROM hobbies
            JOIN userHobbies
            ON hobbies.hobbyID = userHobbies.hobbyID
            WHERE userHobbies.userID = <cfqueryparam value="#userID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn hobbiesDetails>
    </cffunction>


</cfcomponent>