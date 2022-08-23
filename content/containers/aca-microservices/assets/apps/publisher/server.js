axios = require("axios");

const DAPR_HOST = process.env.DAPR_HOST || "http://localhost";
const DAPR_HTTP_PORT = process.env.DAPR_HTTP_PORT || "3500";
const PUBSUB_NAME = process.env.PUBSUB_NAME || "pubsub";
const PUBSUB_TOPIC = process.env.PUBSUB_TOPIC || "orders";
const sleepInMilliseconds = 1000
var i = 0

async function main() {
  while (true) { // infinite loop
    i++
    const order = { orderId: i };

    // Publish an event using Dapr pub/sub
    await axios.post(`${DAPR_HOST}:${DAPR_HTTP_PORT}/v1.0/publish/${PUBSUB_NAME}/${PUBSUB_TOPIC}`, order)
      .then(function (response) {
        console.log("Published order: " + response.config.data);
      })
      .catch(function (error) {
        // catch & print errors as JSON
        var errObj = new Object();
        errObj.message = error.message
        errObj.url = error.config.url
        errObj.method = error.config.method
        errObj.data = error.config.data
        
        console.log(JSON.stringify(errObj));
      });

    await sleep(`${sleepInMilliseconds}`);
  }
}

async function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

main().catch(e => console.error(e))