
component{

    // APPLICATION SETTINGS
    this.name = "DayaBumiPortal_v1";
    this.applicationTimeout = createTimeSpan(1,0,0,0); // 1 day
    this.sessionManagement = true; // enable session
    this.sessionTimeout = createTimespan(0, 0, 30, 0) // 30 mins timeout session
    this.datasource = "CFTrainingDSN";

    // RUNS WHEN APP STARTS
    public boolean function onApplicationStart(){

        APPLICATION.contactPrefs = [
            {bit: 1, label: "Email"},
            {bit: 2, label: "SMS / Whatsapp"},
            {bit: 4, label: "Phone Call"},
            {bit: 8, label: "Push Notification"}
        ];

        return true;
    }

    // RUNS WHEN A NEW USER SESSION BEGINS
    public void function onSessionStart(){
        SESSION.isloggedIn = false;
        SESSION.userID = "";
        SESSION.userName = "";
    }

    // RUNS BEFORE EVERY .cfm REQUEST (protected route)
    public boolean function onRequestStart(required string targetPage) {
        //  helper: can visit any page with "?reinit=1" to reload onApplicationStart() during development
        if(structKeyExists(URL, "reinit") && URL.reinit == "1"){
            onApplicationStart();
        }

        // Extract just the filename (e.g., "landing.cfm") from the full request path
        var requestedFile = listLast(arguments.targetPage, "/\");

        // Route Protection: Block unauthenticated access to landing.cfm
        if(requestedFile == "landing.cfm" && (!structKeyExists(SESSION, "isLoggedIn") || !SESSION.isLoggedIn)){
            SESSION.errorMsg = "Please log in to access your dashboard";
            location(url="login.cfm", addToken="false");
        }
        return true;
    }
}