const mongoose = require('mongoose');

const { Schema } = mongoose;


const Leaderboard = new Schema({
	name: { type: Schema.Types.String },
	points: { type: Schema.Types.Number },
}, { collection: "leaderboard" });


module.exports = mongoose.model('leaderboard', Leaderboard);
