// This is a closure function https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-closure-b2f0d2152b36

var departments = { EEE: 0, MECH: 1, CSE: 2, CIVIL: 3 };
var department1, department2, form;
var primarydepartment = 'EEE';
var seconddepartment = 'MECH';
var re = new RegExp('^[A-Za-z0-9-\\+]+(\\.[A-Za-z0-9-]+)*@college.edu');
(function() {
  var initialize = function() {
    department1 = document.getElementsByName('department1')[0];
    department2 = document.getElementsByName('department2')[0];
    form = document.forms[0];
    department1.addEventListener('change', disableDuplicateSecondaryDepartment);
    form.addEventListener('submit', onSubmit, false);
  };

  var disableDuplicateSecondaryDepartment = function(event) {
    console.log('Started Function : disableDuplicateSecondaryDepartment');

    temp = department1[department1.options.selectedIndex].value;
    department2.options[departments[primarydepartment]].disabled = false;
    primarydepartment = temp;
    department2.options[departments[primarydepartment]].disabled = true;
  };

  var constructData = function() {
    var data = {};
    var formData = new FormData(form);
    for (var key of formData.keys()) {
      data[key] = formData.get(key);
    }
    return data;
  };

  var validateResults = function(data) {
    var isValid = true;

    if (data['phno'].trim().length > 10) {
      isValid = false;
      //phno.innerHTML="afhdfh";
      console.log('Invalid phone no');
    }

    if (data['name'].trim().length > 100 || data['name'].trim().length == 0) {
      isValid = false;
      console.log('Invalid name');
    }

    if (!re.test(data['emailaddress'])) {
      console.log('Invlaid email');
      isValid = false;
    }

    if (!data['department2']) {
      console.log('department issue');
      isValid = false;
    }
    return isValid;
  };

  var onSubmit = function(event) {
    event.preventDefault();
    var data = constructData();
    //console.log(data);
    if (validateResults(data)) {
      printResults(data);
    } else {
      var resultsDiv = document.getElementById('results');
      resultsDiv.innerHTML = '';
      resultsDiv.classList.add('hide');
    }
  };

  var printResults = function(data) {
    var constructElement = function([key, value]) {
      return `<p class='result-item'>${key}: ${value}</p>`;
    };

    var resultHtml = (Object.entries(data) || []).reduce(function(
      innerHtml,
      keyValuePair
    ) {
      return innerHtml + constructElement(keyValuePair);
    },
    '');
    var resultsDiv = document.getElementById('results');
    resultsDiv.innerHTML = resultHtml;
    resultsDiv.classList.remove('hide');
  };


  document.addEventListener('DOMContentLoaded', initialize);
})();
