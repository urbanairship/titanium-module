// Sample code

var UrbanAirship = require('com.urbanairship');

var window = Ti.UI.createWindow({backgroundColor:'white', layout:'vertical'});

var osname = Ti.Platform.osname;
var isAndroid = (osname=='android') ? true : false;

// Title
window.add(Ti.UI.createLabel({
    text:'Urban Airship Titanium Sample',
    top:20,
    left:10,
    right:10,
    textAlign:'center',
    color:'white',
    font:{fontSize:18, fontStyle:'bold'},
    height:Ti.UI.SIZE || 'auto',
    width:Ti.UI.FILL,
    backgroundColor:'gray'
}));

// Enable push
var view = Ti.UI.createView({
    backgroundColor:'white',
    top:20,
    width:Ti.UI.FILL,
    height:50,
    left:10,
    horizontalWrap:true,
    layout:'horizontal'
});

view.add(Ti.UI.createLabel({
    text:'Enable Push',
    textAlign:'left',
    color:'black',
    font:{fontSize:18, fontStyle:'bold'},
}));

var notificationsEnabledSwitch = Ti.UI.createSwitch({
    value:false,
    isSwitch:true,
    height:Ti.UI.SIZE || 'auto',
    width:200,
});
view.add(notificationsEnabledSwitch);

window.add(view);

// Channel
window.add(Ti.UI.createLabel({
    text:'Channel:',
    left:10,
    textAlign:'left',
    color:'black',
    font:{fontSize:18, fontStyle:'bold'},
    height:Ti.UI.SIZE || 'auto'
}));

var channelIdLabel = Ti.UI.createLabel({
    text:'',
    top:10,
    left:10,
    textAlign:'left',
    color:'black',
    height:Ti.UI.SIZE || 'auto'
});
window.add(channelIdLabel);

// NamedUser
window.add(Ti.UI.createLabel({
    text:'Named User:',
    top:20,
    left:10,
    textAlign:'left',
    color:'black',
    font:{fontSize:18, fontStyle:'bold'},
    height:Ti.UI.SIZE || 'auto'
}));

var namedUserLabel = Ti.UI.createLabel({
    text:'',
    top:10,
    left:10,
    textAlign:'left',
    color:'black',
    height:Ti.UI.SIZE || 'auto'
});
window.add(namedUserLabel);

// Tags
window.add(Ti.UI.createLabel({
    text:'Tags:',
    top:20,
    left:10,
    textAlign:'left',
    color:'black',
    font:{fontSize:18, fontStyle:'bold'},
    height:Ti.UI.SIZE || 'auto'
}));

var tagsLabel = Ti.UI.createLabel({
    text:'',
    top:10,
    left:10,
    textAlign:'left',
    color:'black',
    height:Ti.UI.SIZE || 'auto'
});

window.add(tagsLabel);

// Last message
window.add(Ti.UI.createLabel({
    text:'Last Message:',
    top:20,
    left:10,
    textAlign:'left',
    color:'black',
    font:{fontSize:18, fontStyle:'bold'},
    height:Ti.UI.SIZE || 'auto'
}));

var labelMessage = Ti.UI.createLabel({
    text:'',
    top:10,
    left:10,
    textAlign:'left',
    color:'black',
    height:Ti.UI.SIZE || 'auto'
});
window.add(labelMessage);

// Display message center
var mesgCtrButton = Ti.UI.createButton({
    title : 'Display Message Center',
    height:Ti.UI.FILL,
    width:Ti.UI.FILL
});

if(isAndroid) {
    var view = Ti.UI.createView({
        top:10,
        width:Ti.UI.FILL,
        height:50,
        left:10,
        right:10
    });
} else {
    var view = Ti.UI.createView({
        top:10,
        borderRadius:10,
        borderColor:'gray',
        width:Ti.UI.FILL,
        height:50,
        left:10,
        right:10
    });
}

view.add(mesgCtrButton);

window.add(view);

// Listen for click events.
mesgCtrButton.addEventListener('click', function() {
    UrbanAirship.displayMessageCenter();
});

window.open();

channelIdLabel.text = UrbanAirship.channelId;

// Associate channel to a Named User
UrbanAirship.namedUser = "namedUser";
Ti.API.info("namedUser: " + UrbanAirship.namedUser);
namedUserLabel.text = UrbanAirship.namedUser;

// Add a custom identifier
UrbanAirship.associateIdentifier("customKey", "customIdentifier");

// Add a custom event
var customEvent = {
    event_name: 'customEventName',
    event_value: 2016,
    transaction_id: 'customTransactionId',
    interaction_id: 'customInteractionId',
    interaction_type: 'customInteractionType',
    properties: {
        someBoolean: true,
        someDouble: 124.49,
        someString: "customString",
        someInt: 5,
        someLong: 1234567890,
        someArray: ["tangerine", "pineapple", "kiwi"]
    }
};

var customEventPayload = JSON.stringify(customEvent);
UrbanAirship.addCustomEvent(customEventPayload);

// Set Tags
UrbanAirship.tags = [ osname, 'titanium-test' ];
var data = UrbanAirship.tags;
var tags = '';
data.forEach( function ( val, i ) {
    Ti.API.info("Tag: " + val);
    if(tags=='') {
        tags = val;
    } else {
        tags = tags + ', ' + val;
    }
    Ti.API.info("tags: " + tags);
});
tagsLabel.text = tags;

// Set switch to current state of push
notificationsEnabledSwitch.value = UrbanAirship.userNotificationsEnabled;

// Toggle push state on switch change
notificationsEnabledSwitch.addEventListener('change', function (e) {
    UrbanAirship.userNotificationsEnabled = e.value;
});

Ti.API.info("Launch: " + UrbanAirship.getLaunchNotification(true).message);
Ti.API.info("Launch Deep Link: " + UrbanAirship.getDeepLink(true));

if(isAndroid) {
    window.addEventListener("open", function(e) {
        window.activity.addEventListener("resume", function() {
            Ti.App.fireEvent('resume');
        });
        //Notice the pause event
        window.activity.addEventListener("pause", function() {
            Ti.App.fireEvent('paused');
        });
    });

    Ti.App.addEventListener('resume', function() {
        Ti.API.info("Launch: " + UrbanAirship.getLaunchNotification(true).message);
    });
} else {
    Ti.App.addEventListener('resumed', function() {
        Ti.API.info("Launch iOS resumed: " + UrbanAirship.getLaunchNotification(true).message);
    });
}

UrbanAirship.addEventListener(UrbanAirship.EVENT_DEEP_LINK_RECEIVED, function (e) {
    alert("Received deepLink: " + e.deepLink);
});

UrbanAirship.addEventListener(UrbanAirship.EVENT_CHANNEL_UPDATED, function(e) {
        Ti.API.info('Channel Updated: ' + UrbanAirship.channelId);
        channelIdLabel.text = UrbanAirship.channelId;
});

UrbanAirship.addEventListener(UrbanAirship.EVENT_PUSH_RECEIVED, function(e) {
        Ti.API.info('Push received: ' + e.message);
        Ti.API.info('Extras: ' + JSON.stringify(e.extras));
        labelMessage.text = e.message;
});
