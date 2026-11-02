import * as jsonwebtoken from "jsonwebtoken";
import "dotenv/config";
import type { Request, Response } from "express";

export function generartoken(
    id: number,
    email: string,
    rol: string
) {
    return jsonwebtoken.sign(
        {
            id,
            email,
            rol
        },
        process.env.JWT_TOKEN_SECRET as string,
        {
            expiresIn: "1h"
        }
    );
}