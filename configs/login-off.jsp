<%--no whitespace before page tag and <!DOCTYPE> --%><%@ include file="include-internal.jsp"
    %><jsp:useBean id="loginDescription" beanName="loginDescription" scope="request" type="java.lang.String"
    /><jsp:useBean id="canRegisterUsers" beanName="canRegisterUsers" scope="request" type="java.lang.Boolean"
    /><jsp:useBean id="guestLoginAllowed" beanName="guestLoginAllowed" scope="request" type="java.lang.Boolean"
    /><jsp:useBean id="publicKey" scope="request" type="java.lang.String"
    /><jsp:useBean id="unauthenticatedReason" scope="request" type="java.lang.String"
    /><jsp:useBean id="superUser" scope="request" type="java.lang.Boolean"
    /><c:set var="title" value="Log in to TeamCity"
    /><c:if test="${superUser}"><c:set var="title" value="Log in as Super user"/></c:if
    ><bs:externalPage>
  <jsp:attribute name="page_title">${title}</jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/forms.css
      /css/initialPages.css
    </bs:linkCSS>
    <script>
      document.documentElement.className = 'ua-js';
    </script>
    <bs:linkScript>
      /js/crypt/rsa.js
      /js/crypt/jsbn.js
      /js/crypt/prng4.js
      /js/crypt/rng.js
      /js/aculo/effects.js
      /js/bs/forms.js
      /js/bs/encrypt.js
      /js/bs/login.js
    </bs:linkScript>
    <script type="text/javascript">
      $j(document).ready(function($) {
        var loginForm = $('.loginForm');

        $("#username").focus();

        loginForm.attr('action', '<c:url value='/loginSubmit.html'/>');
        loginForm.submit(function() {
          return BS.LoginForm.submitLogin();
        });

        if (BS.Cookie.get("__test") != "1") {
          $("#noCookiesEnabledMessage").show();
        }

        if ($('#fading').length > 0) {
          BS.Highlight('fading');
        }
      });
    </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <bs:_loginPageDecoration id="loginPage" title="${title}">
      <div id="errorMessage" <c:if test="${not empty unauthenticatedReason}">style="display: block;"</c:if>><bs:out value="${unauthenticatedReason}" multilineOnly="${true}"/></div>

      <c:if test="${!superUser && fn:length(loginDescription) > 0}">
        <p id="loginDescription"><bs:out value="${loginDescription}"/></p>
      </c:if>
      
      <c:if test="${superUser}">
        <input type="hidden" id="username" name="username" value="">
      </c:if>

      <form class="loginForm" method="post">
        <table class="loginCredentials">
          <c:if test="${!superUser}">
            <tr class="formField">
              <th><label for="username">Username:</label></th>
              <td><input class="text" id="username" type="text" name="username"></td>
            </tr>
          </c:if>
          <tr class="formField">
            <c:choose>
              <c:when test="${superUser}"><th><label for="password">Authentication token: <bs:help file="Super+User"/></label></th></c:when>
              <c:otherwise><th><label for="password">Password:</label></th></c:otherwise>
            </c:choose>
            <td><input class="text" id="password" type="password" name="password"></td>
          </tr>
          <tr>
            <th>&nbsp;</th>
            <td>
              <forms:checkbox className="checkbox" id="remember" name="remember" checked="true"/>
              <label class="rememberMe" for="remember">Remember me</label>
            </td>
          </tr>
          <tr>
            <th><forms:saving className="progressRingSubmitBlock"/></th>
            <td>
              <noscript>
                <div class="noJavaScriptEnabledMessage">
                  Please enable JavaScript in your browser to proceed with login.
                </div>
              </noscript>

              <div id="noCookiesEnabledMessage" class="noCookiesEnabledMessage" style="display: none;">
                Please enable cookies in your browser to proceed with login.
              </div>

              <input class="btn loginButton" type="submit" name="submitLogin" value="Log in">
              <c:if test="${guestLoginAllowed}">
                <span class="greyNote"><a href="<c:url value='/guestLogin.html?guest=1'/>">Log in as guest</a>&nbsp;<bs:help file="User+Account"/></span>
              </c:if>
            </td>
          </tr>
        </table>

        <input type="hidden" id="publicKey" name="publicKey" value="${publicKey}"/>
        <c:if test="${superUser}">
          <input type="hidden" name="super" value="1"/>
        </c:if>
      </form>


      <c:if test="${!superUser}">

        <jsp:include page="/loginExtensions.html"/>
      </c:if>
    </bs:_loginPageDecoration>
  </jsp:attribute>
</bs:externalPage>
