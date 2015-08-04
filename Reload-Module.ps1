<#
.Synopsis
    Use this funtion to speed up the reloading of modules, while in development
.DESCRIPTION
    Based off of the excellent Reload-Module cmdlet written by PoshPete, this version now features dynamic autocompletion of module names, to make it even easier
.EXAMPLE
    Reload-Module Gma[<Hit Tab>]

    Module name autocompletes
.Link
    http://www.poshpete.com/powershell/reloading-powershell-modules
#>
Function Reload-Module{
    [CmdletBinding()]
    Param()
 
    DynamicParam {
            # Set the dynamic parameters' name
            $ParameterName = 'ModuleName'
            
            # Create the dictionary 
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

            # Create the collection of attributes
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            
            # Create and set the parameters' attributes
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Mandatory = $true
            $ParameterAttribute.Position = 1

            # Add the attributes to the attributes collection
            $AttributeCollection.Add($ParameterAttribute)

            # Generate and set the ValidateSet 
            $arrSet = get-module -ListAvailable | select -ExpandProperty Name
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

            # Add the ValidateSet to the attributes collection
            $AttributeCollection.Add($ValidateSetAttribute)

            # Create and return the dynamic parameter
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
            $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
            return $RuntimeParameterDictionary
    }

    begin {
        # Bind the parameter to a friendly variable
        $ModuleName = $PsBoundParameters[$ParameterName]
    }

    process {
      if((get-module -list | where{$_.name -eq "$ModuleName"} | measure-object).count -gt 0)
    {
 
	
	        Write-Host "Module $ModuleName Unloading"	
            rmo $ModuleName
		
	
        Write-Host "Module $ModuleName Loaded"
	    ipmo $ModuleName
	
    }
    Else
    {
	    Write-Host "Module $ModuleName Doesn't Exist"
    }
    }

}