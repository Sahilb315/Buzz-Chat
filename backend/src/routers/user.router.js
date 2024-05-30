import express from "express";
import { upload } from "../middlewares/multer.middleware.js";
import { loginUser, registerUser } from "../controllers/user.controller.js";

const userRouter = express.Router();

userRouter.post("/signup", upload.single("profilePic"), registerUser);
userRouter.post("/login", loginUser);

export { userRouter };
