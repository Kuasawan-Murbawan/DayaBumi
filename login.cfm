<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login Page</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
  <div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
      <div class="col-md-5 col-lg-4">
        <div class="card shadow-sm">
          <div class="card-header bg-dark text-white font-weight-bold">
            Biodata Portal Login
          </div>
          <div class="card-body">
            <cfif structKeyExists(SESSION, "successMsg") && len(trim(SESSION.successMsg))>
              <cfoutput>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                  #encodeForHTML(SESSION.successMsg)#
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
              </cfoutput>
              <cfset structDelete(SESSION, "successMsg")>
            </cfif>

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

            <form action="login_action.cfm" method="POST">
              <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
              </div>

              <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
              </div>

              <button type="submit" class="btn btn-primary btn-block">Login</button>
            </form>
          </div>
          <div class="card-footer bg-white text-center small">
            <a href="register.cfm">Don't have an account? Click here to register</a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>