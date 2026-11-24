
<cfcomponent displayname="hobbies" hint="to fetch hobbies stuff">

    <cffunction  name="getAllHobbies" returntype="query">

        <cfquery name="hobbies">
                SELECT hobbyID, name, location from hobbies
        </cfquery>

        <cfreturn hobbies>

    </cffunction>


</cfcomponent>