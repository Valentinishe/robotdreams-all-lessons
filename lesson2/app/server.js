var express = require('express');
var path = require('path');
var logger = require('morgan');
const mongoose = require('mongoose');

var indexRouter = require('./routes/index');
var leaderboardRouter = require('./routes/leaderboard');
var notFoundRouter = require('./routes/not-found');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/leaderboard', leaderboardRouter);
app.use('*', notFoundRouter);

app.listen(3000, async () => {
    const res = await mongoose.connect("mongodb://root:root@10.0.0.10:27017/test", { useNewUrlParser: true, useUnifiedTopology: true  });
    console.log('res', res);
    console.log('Successfully listen on port 3000');
});

module.exports = app;
