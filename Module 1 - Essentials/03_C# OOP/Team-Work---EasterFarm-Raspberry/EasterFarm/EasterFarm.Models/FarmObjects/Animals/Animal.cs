﻿namespace EasterFarm.Models.FarmObjects.Animals
{
    using EasterFarm.Models.Contracts;
    using EasterFarm.Models.FarmObjects.Byproducts;

    public abstract class Animal : GameObject, IMovable, IProduce
    {
        protected Animal(MatrixCoords topLeft) 
            : base(topLeft)
        {
        }

        public virtual void Move(int[,] map)
        {
            int mapHeight = map.GetLength(0);
            int mapWidth = map.GetLength(1);
            int currentRow = this.TopLeft.Row;
            int currentCol = this.TopLeft.Col;

            for (int row = (currentRow - 1 > 0 ? currentRow - 1 : 0); row <= (currentRow + 1 <= mapHeight - 1 ? currentRow + 1 : mapHeight - 1); row++)
            {
                for (int col = (currentCol - 1 > 0 ? currentCol - 1 : 0); col <= (currentCol + 1 <= mapWidth - 1 ? currentCol + 1 : mapWidth - 1); col++)
                {
                    if (map[row, col] < map[currentRow, currentCol])
                    {
                        this.TopLeft = new MatrixCoords(row, col);
                        map[row, col] = int.MaxValue;
                        return;
                    }
                }
            }

            map[currentRow, currentCol] = int.MaxValue;
        }

        public virtual Byproduct Produce(ByproductColor color)
        {
            return null;
        }
    }
}
