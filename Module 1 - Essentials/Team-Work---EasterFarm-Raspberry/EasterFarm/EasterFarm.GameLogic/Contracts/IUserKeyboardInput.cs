﻿namespace EasterFarm.GameLogic.Contracts
{
    using System;

    public interface IUserKeyboardInput : IUserInput
    {
        event EventHandler OnLeftPressed;

        event EventHandler OnRightPressed;

        event EventHandler OnUpPressed;

        event EventHandler OnDownPressed;

        event EventHandler OnActionPressed;
    }
}
