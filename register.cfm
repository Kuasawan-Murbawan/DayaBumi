<cfparam name="professions" default="">
<cfparam name="hobbies" default="">

<cfinvoke component="components.professions" method="getAllProfessions" returntype="query" returnvariable="professions">
<cfinvoke component="components.hobbies" method="getAllHobbies" returntype="query" returnvariable="hobbies">

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Registration Page</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</head>
<body class="bg-light">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <div class="card shadow-sm">
          <div class="card-header bg-dark text-white">
            <h1 class="h4 mb-0">Register Your Account</h1>
            <small class="text-light">Fill in the form below to create your profile</small>
          </div>

          <div class="card-body">
            <cfif structKeyExists(SESSION, "errorMsg") && len(trim(SESSION.errorMsg))>
              <cfoutput>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                  #encodeForHTML(SESSION.errorMsg)#
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
              </cfoutput>
              <cfset structDelete(SESSION, "errorMsg")>
            </cfif>

            <form action="register_action.cfm" method="POST">
              <h2 class="h6 text-uppercase text-muted mb-3">Account Details</h2>
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="name">Name</label>
                  <input type="text" class="form-control" id="name" name="name" placeholder="Full name" required>
                </div>
                <div class="form-group col-md-6">
                  <label for="email">Email</label>
                  <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                </div>
              </div>

              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="password">Password</label>
                  <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
                </div>
                <div class="form-group col-md-6">
                  <label for="confirm-password">Confirm Password</label>
                  <input type="password" class="form-control" id="confirm-password" name="confirmpassword" placeholder="Re-enter password" required>
                </div>
              </div>

              <hr class="my-4">
              <h2 class="h6 text-uppercase text-muted mb-3">Profile &amp; Identification</h2>

              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="dob">Date of Birth</label>
                  <input type="date" class="form-control" id="dob" name="dob" required>
                </div>
                <div class="form-group col-md-6">
                  <label for="age">Age</label>
                  <input type="number" class="form-control bg-light" id="age" name="age" readonly>
                </div>
              </div>

              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="ic">IC Number</label>
                  <input type="text" class="form-control" id="ic" name="ic" maxlength="12" pattern="[0-9]{12}"
                    placeholder="12-digit IC without dashes" required
                    data-toggle="popover" data-placement="bottom" data-content="IC does not corresponds to Date of Birth">
                </div>
                <div class="form-group col-md-6">
                  <label for="profession">Profession</label>
                  <select class="form-control" id="profession" name="profession" required>
                    <option value="">--- Select ---</option>
                    <cfoutput query="professions">
                      <option value="#encodeForHTML(professions.profID)#">#encodeForHTML(professions.name)#</option>
                    </cfoutput>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <fieldset>
                  <legend class="col-form-label pt-0">Gender (Auto-detected from IC)</legend>
                  <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" id="gender-male" name="gender" value="M" disabled>
                    <label class="form-check-label" for="gender-male">Male</label>
                  </div>
                  <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" id="gender-female" name="gender" value="F" disabled>
                    <label class="form-check-label" for="gender-female">Female</label>
                  </div>
                  <input type="hidden" id="gender-hidden" name="gender" value="">
                </fieldset>
              </div>

              <div class="form-group">
                <label for="aboutme">About Me</label>
                <textarea class="form-control" id="aboutme" name="aboutme" rows="3" placeholder="Tell us a bit about yourself"></textarea>
              </div>

              <hr class="my-4">
              <h2 class="h6 text-uppercase text-muted mb-3">Hobbies &amp; Contact Preferences</h2>

              <div class="form-row">
                <div class="form-group col-md-6">
                  <label class="d-block">Hobbies</label>
                  <cfoutput query="hobbies">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="hobby_#encodeForHTML(hobbies.hobbyID)#" name="hobby" value="#encodeForHTML(hobbies.hobbyID)#">
                      <label class="form-check-label" for="hobby_#encodeForHTML(hobbies.hobbyID)#">#encodeForHTML(hobbies.name)#</label>
                    </div>
                  </cfoutput>
                </div>

                <div class="form-group col-md-6">
                  <label class="d-block">Contact Preference</label>
                  <cfloop array="#APPLICATION.contactprefs#" item="pref">
                    <cfoutput>
                      <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="pref_#encodeForHTML(pref.bit)#" name="contactpreference" value="#encodeForHTML(pref.bit)#">
                        <label class="form-check-label" for="pref_#encodeForHTML(pref.bit)#">#encodeForHTML(pref.label)#</label>
                      </div>
                    </cfoutput>
                  </cfloop>
                </div>
              </div>

              <button type="submit" class="btn btn-primary btn-block mt-4">Register</button>
            </form>
          </div>

          <div class="card-footer bg-white text-center small">
            <a href="login.cfm">Already have an account? Click here to login</a>
          </div>
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

  <script>
    const dobInput = document.getElementById('dob');
    const ageInput = document.getElementById('age');
    const icInput = document.getElementById('ic');

    $(document).ready(function () {
      $('#ic').popover({
        trigger: 'manual'
      });
    });

    var dob;

    function calculateAge(dob) {
      const today = new Date();
      let currentAge = today.getFullYear() - dob.getFullYear();
      if (today.getMonth() <= dob.getMonth()) {
        if (today.getDate() < dob.getDate()) {
          currentAge--;
        }
      }
      return currentAge;
    }

    dobInput.addEventListener("change", function () {
      const convertedDOB = new Date(this.value);
      dob = convertedDOB;
      ageInput.value = calculateAge(convertedDOB);
    });

    function validateIC(ic, dob) {
      if (!dob) return true;

      let dobYear = dob.getFullYear() % 100;
      const icYear = "" + ic[0] + ic[1];
      if (dobYear !== parseInt(icYear)) {
        return false;
      }

      const icMonth = "" + ic[2] + ic[3];
      let dobMonth = dob.getMonth() + 1;
      if (parseInt(icMonth) !== dobMonth) {
        return false;
      }

      const icDate = "" + ic[4] + ic[5];
      let dobDate = dob.getDate();
      if (parseInt(icDate) !== dobDate) {
        return false;
      }

      return true;
    }

    icInput.addEventListener("change", function () {
      const convertedIC = parseInt(this.value);
      if (!validateIC(this.value, dob)) {
        $('#ic').popover('show');
        console.warn("IC n DOB is different");
      } else {
        $('#ic').popover('hide');
      }

      const lastDigit = convertedIC % 10;
      const gender = lastDigit % 2 === 0 ? 'F' : 'M';

      document.querySelector('input[name="gender"][value=' + gender + ']').checked = true;
      document.getElementById('gender-hidden').value = gender;
    });
  </script>
</body>
</html>