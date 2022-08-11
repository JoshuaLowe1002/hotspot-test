const express = require("express");
const app = express();
const { execSync } = require('child_process');
const { io } = require("socket.io-client");
const printer = require("@thiagoelg/node-printer");

app.get('/', function(req, res, next){
    res.send("WMS Hub")
});

app.use(express.json());

function getCleanValue(value){
    return value.replace(/\0.*$/g,'');
}

app.get('/info', async function(req, res, next){
    const serial = getCleanValue(execSync("cat /sys/firmware/devicetree/base/serial-number").toString());
    const name = `FC-${serial.slice(-7)}`;
    const response = {
        name,
        serial
    }
    res.send(JSON.stringify(response));
});

app.get('/printers', async function(req, res, next){
    res.send(printer.getPrinters());
});


function setupSockets() {
    const serial = getCleanValue(execSync("cat /sys/firmware/devicetree/base/serial-number").toString());
    const socket = io("https://ad15-81-110-131-243.ngrok.io");

    socket.on('connect', () => {
        console.log(`event: connect | session id: ${socket.id}`);
    });

    socket.on(serial, (arg) => {
        if (arg.action === "print"){
            printer.
            printer.printDirect({
                data: "Hello World", 
                type: "TEXT",
                success: (id) => {
                    console.log(id);
                },
                error: (err) => {
                    console.log(err);
                }
            });
        }
    });
}

setupSockets();

app.listen(3000, () => {
    console.log("Server listening on port 3000")
});