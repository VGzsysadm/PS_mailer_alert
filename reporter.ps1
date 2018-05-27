##### AN EMAIL WILL SENT ONLY IF A HOST IS NOT RESPONDING TO PING ######
##### TESTED ON POWERSHELL version 5.1.16299.98 ######
##### host list ######    
$servername = "192.168.1.1","192.168.1.4" 

##### SMTP Configuration ######
##### BE SURE YOUR https://myaccount.google.com/lesssecureapps IS ACTIVE ######
$smtpserver = "smtp.gmail.com"
$port = "587"
$from = "YOURMAIL@gmail.com"
$pass = "YOURPASSWORDHERE"
$to = "YOURDESTINATION@here.com"
$subject = "::::::#### ATTENTION HOST DOWN ###::::::"

##### Function ######  
foreach ($server in $servername) { 
                    if (test-Connection -ComputerName $server -Count 3 -Quiet ) {  
                        $body += write-output "$server host responding to ping `n"  
 
                            } else { $body += Write-output "$server ::::::#### HOST NOT RESPONDING TO PING ###:::::: `n"
                            
                            $message = New-Object System.Net.Mail.MailMessage
                            $message.subject = $subject
                            $message.body = $body
                            $message.to.add($to)
                            $message.from = $from
                            $smtp = New-Object System.Net.Mail.SmtpClient($smtpserver, $port);
                            $smtp.EnableSSL = $true
                            $smtp.Credentials = New-Object System.Net.NetworkCredential($from, $pass);
                            $smtp.send($message)
                            write-host "Mail Sent"  
                            }     
         
} 
 
 