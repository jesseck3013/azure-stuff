function Encrypt {
    param(
        $message,    
        $certPath
    )
    
    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath)
    $rsa = $cert.PublicKey.Key
    
    # Convert the string to bytes 
    $bytesToEncrypt = [System.Text.Encoding]::UTF8.GetBytes($message)
    
    # Encrypt the bytes 
    $encryptedBytes = $rsa.Encrypt($bytesToEncrypt, [System.Security.Cryptography.RSAEncryptionPadding]::Pkcs1)
    
    # Convert encrypted bytes to Base64 for easy display/storage 
    $encryptedString = [System.Convert]::ToBase64String($encryptedBytes)
    
    Write-Output $encryptedString
}

function Decrypt {
    [CmdletBinding()]
    param ( 
        [Parameter( Mandatory = $true, ValueFromPipeline = $true )] 
        [string]$encryptedMessage,
        $certPath
    )
    

    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath)
    $rsa = $cert.PrivateKey
    
    $bytesToDecrypt = [System.Convert]::FromBase64String($encryptedMessage)
    
    # Encrypt the bytes 
    $decryptedBytes = $rsa.Decrypt($bytesToDecrypt, [System.Security.Cryptography.RSAEncryptionPadding]::Pkcs1)
    $decryptedMessage = [System.Text.Encoding]::UTF8.GetString($decryptedBytes)
    Write-Output $decryptedMessage
}