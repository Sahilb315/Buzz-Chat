import multer from "multer";

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    return cb(null, "./public/temp/");
  },
  filename: function (req, file, cb) {
    return cb(null, file.originalname + "-" + Date.now());
  },
});

const upload = multer({ storage });

export { upload };
