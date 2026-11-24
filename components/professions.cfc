
<cfcomponent displayname="professions" hint="CF Component for profession">

    <cffunction  name="getAllProfessions" returntype="query">

        <cfquery name="allProfessions">
            SELECT profID, name from profession
        </cfquery>

        <cfreturn allProfessions>

    </cffunction>

</cfcomponent>