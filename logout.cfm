<cfset sessionRotate()>
<cfset SESSION.isLoggedIn = false>
<cfset SESSION.userID = 0>
<cfset SESSION.userName = "">
<cfset SESSION.successMsg = "logout successful">
<cflocation url="login.cfm" addtoken="false">