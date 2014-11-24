#Instructions

	C:\> @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
	
	$ choco install boxstarter
    $ START http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/ppallesws/Boxstarter-JSWebDev/master/windows8.txt