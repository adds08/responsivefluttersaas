var data = "username=ashakya&password=7f2ababa423061c509f4923dd04b6cf1&scope=Innovator&client_id=atishplayground&database=upaystaging001&grant_type=password";

var xhr = new XMLHttpRequest();
xhr.withCredentials = true;

xhr.addEventListener("readystatechange", function() {
  if(this.readyState === 4) {
    console.log(this.responseText);
  }
});

xhr.open("POST", "http://44.202.199.120/upayeval/OAuthServer/connect/token");
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

xhr.send(data);