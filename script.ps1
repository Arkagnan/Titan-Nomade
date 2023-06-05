#######################################################################
# Script création utilisateurs Titan Nomade - Projet Microsoft Intune #
#######################################################################


#/------------------------------\


# Auteur : DEBOVE Esteban
# Date de création : 26/04/2023
# Date de révision : 03/05/2023


#\------------------------------/


# Initialisation des variables d'entrées
$GivenName = "Titan Nomade"
$SamAccountName = "nomade"
$Password = "xxxxxxxx"
$microsoft_domain = "@xxxxxxxxxxxxxxx.xxx"


Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

Clear-Host


########################
# ETABLISSEMENTS ACPPA #
########################


Write-Host ""
Write-Host "============== ETABLISSEMENTS ACPPA ==============" -ForegroundColor Yellow
Write-Host ""

# Récupérer tous les OU établissements ACPPA dans l'AD
$OUenfants = Get-ADOrganizationalUnit -Filter {Name -notlike "Users"} -SearchBase "OU=xxxxxx,OU=xxxx,OU=xxxxxx,DC=xxxx,DC=xxx" -SearchScope OneLevel

# Parcourir et traitement sur tous les établissements 
foreach ($OU in $OUenfants)
{
    
    # Initialisation des variables d'entrées pour l'utilisateur
    $OUName = $OU.Name
    $OU_minuscule = $OUName.ToLower()
    $Path = $OU.DistinguishedName
    $local_domain = "@xxxxx.xxx"
 
    # Si l'utilisateur est déjà créé, affiche un message d'erreur et passe au suivant
    $Test = "$SamAccountName.$OU_minuscule"
    
    if (Get-ADUser -Filter { SamAccountName -eq $Test } -ErrorAction SilentlyContinue) 
    {
    
        Write-Warning "Utilisateur déjà créé !!"

    }

    # Création de l'utilisateur
    New-ADUser `
        -SamAccountName         "$SamAccountName.$OU_minuscule"  `
        -UserPrincipalName      "$SamAccountName.$OU_minuscule$local_domain" `
        -Name                   "$OUName $GivenName" `
        -GivenName              "$GivenName" `
        -SurName                "$OUName" `
        -ChangePasswordAtLogon  $false `
        -DisplayName            "$OUName $GivenName" `
        -Path                   "$Path" `
        -AccountPassword        (convertto-securestring  $Password -AsPlainText -Force) `
        -Enabled                $true `
        -CannotChangePassword   $true `
        -PasswordNeverExpires   $true `
        -ErrorAction SilentlyContinue `
        -EmailAddress           "$SamAccountName.$OU_minuscule$microsoft_domain" `


    if ($? -eq $false) 
    {
            
        Write-Warning "Erreur création utilisateur !"
        pause

        
    } else { 
            
        Write-Host "$OUName $GivenName : Ok"

    }
 
 }

############################
# ETABLISSEMENTS SINOPLIES #
############################


Write-Host ""
Write-Host "============== ETABLISSEMENTS SINOPLIES ==============" -ForegroundColor Yellow
Write-Host ""

# Récupérer tous les OU établissements SINOPLIES dans l'AD
$OUenfants = Get-ADOrganizationalUnit -Filter {Name -notlike "Users"} -SearchBase "OU=xxxxxx,OU=xxxx,OU=xxxxxx,DC=xxxx,DC=xxx" -SearchScope OneLevel

# Parcourir et traitement sur tous les établissements 
foreach ($OU in $OUenfants)
{
    
    # Initialisation des variables d'entrées pour l'utilisateur
    $OUName = $OU.Name
    $OU_minuscule = $OUName.ToLower()
    $Path = $OU.DistinguishedName
    $local_domain = "@xxxxx.xxx"
    
    # Si l'utilisateur est déjà créé, affiche un message d'erreur et passe au suivant
    $Test = "$SamAccountName.$OU_minuscule"
    
    if (Get-ADUser -Filter { SamAccountName -eq $Test } -ErrorAction SilentlyContinue) 
    {
    
        Write-Warning "Utilisateur déjà créé !!"

    }

    # Création de l'utilisateur
    New-ADUser `
        -SamAccountName         "$SamAccountName.$OU_minuscule"  `
        -UserPrincipalName      "$SamAccountName.$OU_minuscule$local_domain" `
        -Name                   "$OUName $GivenName" `
        -GivenName              "$GivenName" `
        -SurName                "$OUName" `
        -ChangePasswordAtLogon  $false `
        -DisplayName            "$OUName $GivenName" `
        -Path                   "$Path" `
        -AccountPassword        (convertto-securestring  $Password -AsPlainText -Force) `
        -Enabled                $true `
        -CannotChangePassword   $true `
        -PasswordNeverExpires   $true `
        -ErrorAction SilentlyContinue `
        -EmailAddress           "$SamAccountName.$OU_minuscule$microsoft_domain" `


    if ($? -eq $false) 
    {
            
        Write-Warning "Erreur création utilisateur !"
        pause

        
    } else { 
            
        Write-Host "$OUName $GivenName : Ok"

    }   
    
    #################
    #################

}
