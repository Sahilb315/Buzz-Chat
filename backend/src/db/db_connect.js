import mongoose from "mongoose";

async function connectDB() {
  try {
    await mongoose.connect(`${process.env.MONGO_URL}/message`).then(() => {
      console.log("Connected to MongoDB");
    });
  } catch (error) {
    console.log(`Error while connecting to MongoDB: ${error.message}`);
    throw error;
  }
}

export { connectDB };
