Function StartRun
{

    $MinAvailMem = 0;    
    while(1)
    {   
        Start-Sleep -Seconds 1
        $ops = Get-WmiObject -Class Win32_OperatingSystem
        #"机器名      : {0}" -f $ops.csname
        #"可用内存(MB): {0}" -f ([math]::round($ops.FreePhysicalMemory / 1kb, 2))
        $AvailableMemory = [math]::round(($ops.FreePhysicalMemory / (1mb)), 2)
        if($MinAvailMem -eq 0)
        {
            $MinAvailMem = $AvailableMemory
        }
        if($AvailableMemory -le $MinAvailMem)
        {
            $MinAvailMem = $AvailableMemory
        }
        #Write-Host "Available memory(GB): $AvailableMemory GB"
        Write-Host "Minimum memory(GB): $MinAvailMem GB" 
        Out-File -Append -FilePath .\Memory.txt -InputObject $MinAvailMem
        
    }
}

StartRun
