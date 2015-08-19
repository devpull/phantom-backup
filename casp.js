// config
var fs = require('fs'), configFile = fs.read('./local/config.json'), config = JSON.parse(configFile);
// casper create
var casper = require("casper").create({
    verbose: true,
    logLevel: 'debug',
    pageSettings: {
        loadImages: false,
        loadPlugins: false,
        userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4'
    }
});

// log
function log(msg) {
    var date = new Date();

    var hour = ('0' + (date.getHours()+1)).slice(-2);
    var min = ('0' + (date.getMinutes()+1)).slice(-2);
    var time = '[' + hour + ':' + min + ']  ';

    var day = ('0' + date.getDate()).slice(-2), month = ('0' + (date.getMonth()+1)).slice(-2), year = date.getFullYear();
    var logFileName = day + "" + month + "" + year + '.log';
    var filePath = fs.workingDirectory + '/logs/' + logFileName;
    // creating log file
    if(!fs.exists(filePath)) {
        fs.write(filePath, time + msg + '\n', 'w');
    } else {
        fs.write(filePath, time + msg + '\n', 'a');
    }
}

// print out all the messages in the headless browser context
casper.on('remote.message', function(msg) {
    log(msg);
    this.echo('remote message caught: ' + msg);
});

// print out all the messages in the headless browser context
casper.on("page.error", function(msg, trace) {
    log(msg);
    this.echo("Page Error: " + msg, "ERROR");
});

// print out all the messages in the headless browser context
casper.on("resource.error", function(resourceError){
    log('Unable to load resource (#' + resourceError.id + 'URL:' + resourceError.url + ')');
    log('Error code: ' + resourceError.errorCode + '. Description: ' + resourceError.errorString);
    console.log('Unable to load resource (#' + resourceError.id + 'URL:' + resourceError.url + ')');
    console.log('Error code: ' + resourceError.errorCode + '. Description: ' + resourceError.errorString);
});

// url is set in config
casper.start(config.url, function() {
    this.echo('Starting.');
    log('Starting');
    log('Some more here.');
});

// wait for page to load
casper.waitForResource(config.url, function() {
    this.echo('trying fill form');

    // fill selectors not working with phantomjs v1.9.8 & casperjs v1.1.0-beta3
    this.fillXPath('form', {
        '//input[@name="username"]': config.username,
        '//input[@name="password"]': config.password
    }, true);

    this.capture('screen/fill.png');
}).then(function() {
    this.wait(5000, function () {
        this.capture('screen/done.png');
    });
}).run();