:: safely clean DriverStore File Repository folder in Windows 11/10 (create a restore point first before deleting)

@echo off
cd C:\Windows\System32\DriverStore\FileRepository

@echo off
for /L %%N in (1,1,600) do (
echo Deleting driver OEM%%N.INF
pnputil /d OEM%%N.INF
)