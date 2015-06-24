﻿namespace EasterFarm.Console
{
    using System;
    using System.Text;

    public static class HelperMethods
    {
        public static void PrintOnPosition(int x, int y, char symbol, ConsoleColor color = ConsoleColor.White)
        {
            Console.SetCursorPosition(x, y);
            Console.ForegroundColor = color;
            Console.Write(symbol);
        }

        public static void PrintOnPosition(int x, int y, string text, ConsoleColor color = ConsoleColor.White)
        {
            Console.SetCursorPosition(x, y);
            Console.ForegroundColor = color;
            Console.Write(text);
        }

        public static void ClearConsolePart(int x, int y, int width, int height)
        {
            int currentLineCursor = y;
            Console.SetCursorPosition(x, y);
            for (int i = 0; i < height; i++)
            {
                Console.SetCursorPosition(x, y + i);
                Console.Write(new string(' ', width));
            }

            Console.SetCursorPosition(x, currentLineCursor);
        }

        public static void HandleExceptions(Exception e, int x = 0, int y = 0, ConsoleColor color = ConsoleColor.White)
        {
            ClearConsolePart(x, y, 40, 5);
            PrintOnPosition(x, y, "Uh oh... Something went wrong!", color);
            PrintOnPosition(x, y, e.Message, color);
        }

        public static void PrintMatrix(char[,] matrix, int x, int y, ConsoleColor color)
        {
            StringBuilder sb = new StringBuilder();
            for (int row = 0; row < matrix.GetLength(0); row++)
            {
                for (int col = 0; col < matrix.GetLength(1); col++)
                {
                    sb.AppendFormat("{0}", matrix[row, col]);
                }

                PrintOnPosition(x, y + row, sb.ToString(), color);
                sb.Clear();
            }
        }
    }
}
