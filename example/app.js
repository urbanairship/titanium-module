// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

// TODO: write your module tests here
var urbanairship = require('com.urbanairship');
Ti.API.info("module is => " + urbanairship);

label.text = urbanairship.example();

Ti.API.info("module exampleProp is => " + urbanairship.exampleProp);
urbanairship.exampleProp = "This is a test value";



