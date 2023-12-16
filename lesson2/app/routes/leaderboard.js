var express = require('express');
const leaderboardModel = require('../models/leaderboard');
var router = express.Router();

/* GET users listing. */
router.get('/', async function(req, res, next) {
    const list = await leaderboardModel.find().sort('-points').lean();
    console.log('list', list);

    console.log('list', list);
    res.render(
        'leaderboard',
        { 
            title: "Leaderboards",
            list: list,
        }
    );
});

module.exports = router;
