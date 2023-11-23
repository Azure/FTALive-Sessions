express=require('express');
bodyParser=require('body-parser');

const APP_PORT = process.env.APP_PORT || '3000';
const PUBSUB_NAME = process.env.PUBSUB_NAME || 'pubsub';
const PUBSUB_TOPIC = process.env.PUBSUB_TOPIC || 'orders';

const app = express();
app.use(bodyParser.json({ type: 'application/*+json' }));

app.get('/dapr/subscribe', (_req, res) => {
    res.json([
        {
            pubsubname: `${PUBSUB_NAME}`,
            topic: `${PUBSUB_TOPIC}`,
            route: "orders"
        }
    ]);
});

// Dapr subscription routes 'orders' topic to this route
app.post('/orders', (req, res) => {
    console.log("Subscriber received:", req.body.data);
    res.sendStatus(200);
});

app.listen(APP_PORT);