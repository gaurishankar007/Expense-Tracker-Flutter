const mongoose = require("mongoose");

mongoose.connect(
    'mongodb://127.0.0.1:27017/expense_tracker', 
    {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    },
);