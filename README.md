# Reload-Module
if you're developing modules, it stinks to remove and re-add them.  This function does it all, and with autocomplete.

Built off of [this blog post](http://www.poshpete.com/powershell/reloading-powershell-modules#comment-116422) by Russi Pete ([@rossipete](https://twitter.com/rossipete) on twitter), the function has been expanded to now also include Autocompletion of module names, to make it even easier when working with PowerShell modules.

#Install

If you have PsGet installed you can simply execute:

Install-Module Reload-Module
Or install it manually:

    git clone https://github.com/1RedOne/Reload-Module.git
    cd Reload-Module
    . .\Reload-Module.ps1
