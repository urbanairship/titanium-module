// Sample code

var Airship = require('ti.airship');
Airship.takeOff({
    "default": {
        "appKey": "APP KEY HERE",
        "appSecret": "APP SECRET HERE"
    },
    "urlAllowList": ["*"],
    "site": "us"
})

var window = Ti.UI.createWindow({backgroundColor:'white', layout:'vertical'});

var osname = Ti.Platform.osname;
var isAndroid = (osname=='android') ? true : false;

// Title
window.add(Ti.UI.createLabel({
    text:'Airship Titanium Sample',
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
    Airship.messageCenter.open();
});

window.open();

channelIdLabel.text = Airship.channelId;

// Associate channel to a Named User
Airship.contact.identify("titanium person");
Ti.API.info("namedUser: " + Airship.contact.namedUserId);
namedUserLabel.text = Airship.contact.namedUserId;

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

Airship.analytics.addEvent(customEvent);
Airship.analytics.trackScreen("woot");

// Set Tags
Airship.tags = [ osname, 'titanium-test' ];
var data = Airship.tags;
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
notificationsEnabledSwitch.value = Airship.push.userNotificationsEnabled;

// Toggle push state on switch change
notificationsEnabledSwitch.addEventListener('change', function (e) {
    Airship.push.userNotificationsEnabled = e.value;
});

Airship.addEventListener(Airship.pushReceivedEvent, function (e) {
    alert("pushReceivedEvent: " + JSON.stringify(e));
});

Airship.addEventListener(Airship.notificationResponseReceivedEvent, function (e) {
    alert("notificationResponseReceivedEvent: " + JSON.stringify(e));
});

Airship.addEventListener(Airship.notificationOptInStatusChangedEvent, function (e) {
    alert("notificationOptInStatusChangedEvent: " + JSON.stringify(e));
});

Airship.addEventListener(Airship.channelCreatedEvent, function (e) {
    alert("channelCreatedEvent: " + JSON.stringify(e));
});

Airship.addEventListener(Airship.deepLinkReceivedEvent, function (e) {
    alert("deepLinkReceivedEvent: " + JSON.stringify(e));
});

Airship.addEventListener(Airship.inboxUpdatedEvent, function (e) {
    alert("inboxUpdatedEvent: " + JSON.stringify(e));
});

Airship.addEventListener(Airship.openPreferenceCenterEvent, function (e) {
    alert("openPreferenceCenterEvent: " + JSON.stringify(e));
});