const multer = require("multer");

const storageNavigation = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, "../expense_tracker_api/upload");
    },
    filename: function(req, file, cb) {
        cb(null, Date.now()+"_"+file.originalname);
    }
});


const filter = function(req, file, cb) {
    if(file.mimetype == "image/png" || file.mimetype=="image/jpeg" || file.mimetype=="application/octet-stream") {
        cb(null, true);
    }
    else {
        cb(null, false);
    }
}

const profileUpload = multer({
    storage: storageNavigation,
    fileFilter: filter
});

module.exports = profileUpload;