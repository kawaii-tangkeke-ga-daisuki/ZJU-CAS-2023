@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.2.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Mon Oct 30 18:25:00 +0800 2023
REM SW Build 3118627 on Tue Feb  9 05:14:06 MST 2021
REM
REM Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim core_sim_behav -key {Behavioral:sim_1:Functional:core_sim} -tclbatch core_sim.tcl -view D:/45951/Desktop/minnanotangkeke/CAS/Computer-Arch/Lab2/Exp2/Exp2/code/sim/core_sim_behav.wcfg -log simulate.log"
call xsim  core_sim_behav -key {Behavioral:sim_1:Functional:core_sim} -tclbatch core_sim.tcl -view D:/45951/Desktop/minnanotangkeke/CAS/Computer-Arch/Lab2/Exp2/Exp2/code/sim/core_sim_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
