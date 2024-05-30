import express from "express";
import dotenv from "dotenv";
import http from "http";
import { Server } from "socket.io";
import { messageRouter } from "./src/routers/message.router.js";
import { userRouter } from "./src/routers/user.router.js";
import { connectDB } from "./src/db/db_connect.js";
import { v2 as cloudinary } from "cloudinary";
import { checkUserAuthentication } from "./src/middlewares/authentication.middleware.js";

dotenv.config();

const app = express();
const server = http.createServer(app);
const io = new Server(server);
app.use(express.json());
app.use("/message", checkUserAuthentication, messageRouter);
app.use("/user", userRouter);

/// Making connection to MongoDB
connectDB();

/// Making connection to cloudinary
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_SECRET_KEY,
});

/// Map containing the users id with their socket id - {userId: socketId}
const userSocketMap = {};

function getSocketId(receiverID) {
  return userSocketMap[receiverID];
}

server.listen(3000, () => {
  console.log("Server is running on port 3000");
});

io.on("connection", (socket) => {
  console.log("User connected");
  const userID = socket.handshake.query.userID;
  console.log(`From socket connection: ${socket.id} user id: ${userID}`);
  userSocketMap[userID] = socket.id;
  socket.on("disconnect", () => {
    console.log("User disconnected with userID: ", userID);
    delete userSocketMap[userID];
  });
});

export { getSocketId, io };
