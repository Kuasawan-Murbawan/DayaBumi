Hi, From Dayabumi

<cfparam name="FORM.contactpreference" default="2,4,8">
<cfset contactMask = 0>

<cfloop list="#FORM.contactpreference#" index="bitVal">
    <cfif isNumeric(bitVal)>
        <cfset contactMask = bitOr(contactMask, val(bitVal))>
    </cfif>
</cfloop>

<cfoutput>
  #contactMask#
</cfoutput>