import jwt from "jsonwebtoken";

export function generateJwtToken(tokenData, secretKey, jwt_expiry) {
  return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expiry });
}
