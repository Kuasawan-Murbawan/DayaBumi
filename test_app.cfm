<!--- 1. Verify Application & Session Scopes --->
<h3>Application & Session Check</h3>
<cfdump var="#APPLICATION#" label="APPLICATION Scope">
<cfdump var="#SESSION#" label="SESSION Scope">

<!--- 2. Verify Default Datasource Connection --->
<h3>Datasource Check</h3>
<cfquery name="qTest">
    SELECT COUNT(*) AS totalProfessions FROM dbo.profession
</cfquery>
<cfdump var="#qTest#" label="DB Query Result">