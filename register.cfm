<cfparam  name="professions" default="">

<cfinvoke component="components.professions" method="getAllProfessions" returntype="query" returnvariable="professions">

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

  <title>Training</title>
</head>

<!-- TODO: fill required -->

<body>
  <h1>Training</h1>

  <p>Fill in the form below:</p>

  <div class="container">
    <form action="" method="get">

      <div class="form-row">
        <div class="form-group col-md-6">
          <label for="name">Name:</label> <input type="text" class="form-control" id="name" name="name" />
        </div>
        <div class="form-group col-md-6">
          <label for="email">Email:</label> <input type="email" class="form-control" id="email" name="email" />
        </div>
        <div class="form-group col-md-6">
          <label for="password">Password:</label> <input type="password" class="form-control" id="password" name="password" />
        </div>
        <div class="form-group col-md-6">
          <label for="confirm-password">Confirm Password:</label> <input type="password" class="form-control" id="confirm-password" name="confirm-password" />
        </div>
      </div>

      <div class="form-group"> <label for="dob">Date of Birth:</label>
        <input type="date" class="form-control" id="dob" name="dob" />
      </div>

      <div class="form-group"> <label for="aboutme">About me:</label>
        <textarea class="form-control" id="aboutme" name="aboutme"></textarea>
      </div>
      <div class="form-group">

        <label for="profession">Profession:</label>
        <select class="form-control" id="profession" name="profession">
          <option value="">--- Select ---</option>

          <cfoutput query="professions">
            <option value="#professions.profID#">#professions.name#</option>

          </cfoutput> 
                   </select>
      </div>

      <div class="form-group">
        <label>Hobbies:</label>

        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="badminton" name="hobby" value="badminton" />
          <label class="form-check-label" for="badminton">Badminton</label>
        </div>

        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="freelance" name="hobby" value="freelance" />
          <label class="form-check-label" for="freelance">Freelance</label>
        </div>

        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="swimming" name="hobby" value="swimming" />
          <label class="form-check-label" for="swimming">Swimming</label>
        </div>
      </div>
      <div class="form-group">
        <label for="ic">IC:</label>
        <input type="text" class="form-control" id="ic" name="ic" maxlength="12" pattern="[0-9]{12}" required
          data-toggle="popover" data-placement="bottom" data-content="IC does not corresponds to Date of Birth">
      </div>

      <div class="form-group">
        <label for="age">Age:</label>
        <input type="number" class="form-control" id="age" name="age" readonly>
      </div>

      <div class="form-group">
        <fieldset>
          <legend>Gender</legend>

          <div class="form-check">
            <input type="radio" class="form-check-input" id="gender-male" name="gender" value="M" disabled>
            <label class="form-check-label" for="gender-male">Male</label>
          </div>

          <div class="form-check">
            <input type="radio" class="form-check-input" id="gender-female" name="gender" value="F" disabled>
            <label class="form-check-label" for="gender-female">Female</label>
          </div>
        </fieldset>
      </div>
      <div class="form-group"> <button type="submit">Submit</button>
      </div>

    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
    crossorigin="anonymous"></script>

  <script>
    // Grab the element
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
      const today = new Date()
      let currentAge = today.getFullYear() - dob.getFullYear();
      // check month
      if (today.getMonth() <= dob.getMonth()) {
        //check day
        if (today.getDate() < dob.getDate()) {
          currentAge--
        }
      }
      return currentAge;
    }

    dobInput.addEventListener("change", function () {
      const convertedDOB = new Date(this.value)
      dob = convertedDOB;
      ageInput.value = calculateAge(convertedDOB);
    })

    // Check IC validation
    function validateIC(ic, dob) {
      // compare year
      let dobYear = dob.getFullYear() % 100;
      const icYear = "" + ic[0] + ic[1];

      if (dobYear !== parseInt(icYear)) {
        return false;
      }

      // compare month
      const icMonth = "" + ic[2] + ic[3];
      let dobMonth = dob.getMonth() + 1;

      if (parseInt(icMonth) !== dobMonth) { return false; }

      // compare day
      const icDate = "" + ic[4] + ic[5];
      let dobDate = dob.getDate();

      if (parseInt(icDate) !== dobDate) { return false; }

      return true
    }

    icInput.addEventListener("change", function () {

      const convertedIC = parseInt(this.value)
      if (!validateIC(this.value, dob)) {
        $('#ic').popover('show');
        console.warn("IC n DOB is different")
      } else {
        $('#ic').popover('hide');

      }

      // Automatically Populate gender
      const lastDigit = convertedIC % 10;
      const gender = lastDigit % 2 === 0 ? 'F' : 'M';

      document.querySelector('input[name="gender"][value=' + gender + ']').checked = true;
    })


  </script>
</body>

</html>