
<cfset professionDetails="">
<cfset hobbiesDetails="">
<cfset fullBiodata="">
<cfset contactPrefs= []>

<cfinvoke
	component="components.biodata"
	method="getFullBiodata"
	userID="#SESSION.userID#"
	returnvariable="fullBiodata"
>
<cfset maskVal = (isQuery(fullBiodata) && fullBiodata.recordCount GT 0) ? val(fullBiodata.contactMask) : 0>

<cfinvoke
  component="components.professions"
  method="getProfessionByID"
  userID="#SESSION.userID#"
  returnvariable="professionDetails"
>

<cfinvoke
  component="components.hobbies"
  method="getHobbyByUserID2"
  userID="#SESSION.userID#"
  returnvariable="hobbiesDetails"
  >

<cfinvoke
  component="components.biodata"
  method="getContactPreference"
  contactMask="#maskVal#"
  returnvariable="contactPrefs"
>

<html>

<head>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <title>Landing Page</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</head>

<body class="bg-light">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <cfoutput>
        <span class="navbar-brand mb-0 h1">Biodata Portal - #encodeForHTML(SESSION.userName)#</span>
      </cfoutput>
      <div class="ml-auto">
        <a href="logout.cfm" class="btn btn-outline-light btn-sm">Logout</a>
      </div>
    </div>
  </nav>

  <div class="container my-4">
    <cfif structKeyExists(SESSION, "successMsg" ) && len(trim(SESSION.successMsg))>
      <cfoutput>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
          #encodeForHTML(SESSION.successMsg)#
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
      </cfoutput>
      <cfset structDelete(SESSION, "successMsg" )>
    </cfif>
    <div class="row">
      <div class="col-lg-7 mb-4">
        <div class="card shadow-sm mb-4">
          <div class="card-header font-weight-bold">Biodata &amp; Profession</div>
          <div class="card-body">
            <cfif isQuery(fullBiodata) && fullBiodata.recordCount GT 0>
              <cfset profLabel=(isQuery(professionDetails) && professionDetails.recordCount GT 0 &&
                len(trim(professionDetails.name))) ? professionDetails.name : "Not specified">
                <cfoutput>
                  <dl class="row mb-0">
                    <dt class="col-sm-4">Name</dt>
                    <dd class="col-sm-8">#encodeForHTML(fullBiodata.name)#</dd>

                    <dt class="col-sm-4">Email</dt>
                    <dd class="col-sm-8">#encodeForHTML(fullBiodata.email)#</dd>

                    <dt class="col-sm-4">IC</dt>
                    <dd class="col-sm-8">#encodeForHTML(fullBiodata.IC)#</dd>

                    <dt class="col-sm-4">Date of Birth</dt>
                    <dd class="col-sm-8">#encodeForHTML(dateFormat(fullBiodata.dob, "yyyy-mm-dd"))#</dd>

                    <dt class="col-sm-4">Age / Gender</dt>
                    <dd class="col-sm-8">#encodeForHTML(fullBiodata.age)# / #encodeForHTML(fullBiodata.gender)#</dd>

                    <dt class="col-sm-4">Profession</dt>
                    <dd class="col-sm-8">#encodeForHTML(profLabel)#</dd>

                    <dt class="col-sm-4">About Me</dt>
                    <dd class="col-sm-8 mb-0">#encodeForHTML(fullBiodata.aboutme)#</dd>
                  </dl>
                </cfoutput>
                <cfelse>
                  <p class="text-muted mb-0">No biodata record found.</p>
            </cfif>
          </div>
        </div>

        <div class="card shadow-sm">
          <div class="card-header font-weight-bold">Contact Preferences</div>
          <div class="card-body">
            <cfif arrayLen(contactPrefs) GT 0>
              <cfoutput>
                <div class="mb-2">
                  <cfloop array="#contactPrefs#" item="prefLabel">
                    <span class="badge badge-info p-2 mr-1 mb-1">#encodeForHTML(prefLabel)#</span>
                  </cfloop>
                </div>
              </cfoutput>
              <cfelse>
                <p class="text-muted mb-2">No contact channels selected.</p>
            </cfif>

            <cfoutput>
              <div class="small text-muted">
                Mask: <code>#encodeForHTML(maskVal)#</code> |
                Binary: <code>#encodeForHTML(formatBaseN(maskVal, 2))#</code>
              </div>
            </cfoutput>
          </div>
        </div>
      </div>

      <div class="col-lg-5 mb-4">
        <div class="card shadow-sm">
          <div class="card-header font-weight-bold">Hobbies</div>
          <cfif isQuery(hobbiesDetails) && hobbiesDetails.recordCount GT 0>
            <ul class="list-group list-group-flush">
              <cfoutput query="hobbiesDetails">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                  <span>#encodeForHTML(hobbiesDetails.name)#</span>
                  <span class="badge badge-light border">#encodeForHTML(hobbiesDetails.location)#</span>
                </li>
              </cfoutput>
            </ul>
            <cfelse>
              <div class="card-body">
                <p class="text-muted mb-0">No hobbies listed.</p>
              </div>
          </cfif>
        </div>
      </div>
    </div>
  </div>


  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
    crossorigin="anonymous"></script>

</body>

</html>