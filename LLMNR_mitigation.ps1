# Disable LLMNR
Get-NetAdapter | Where-Object { $_.LinkLayerTopologyDescription -eq "Link-Local Multicast Name Resolution" } | Set-NetAdapter -LLMNREnabled $false

# Set DNS
Set-DnsClientServerAddress -ServerAddresses '1.1.1.1', '8.8.8.8'

# Set secure DHCP
Set-DnsClientLeaseObtainTimeout -TimeoutInMinutes 1
Set-DnsClientLeaseRenewTimeout -TimeoutInMinutes 1
Set-DnsClientLeaseReleaseTimeout -TimeoutInMinutes 1

# Set firewall
New-NetFirewallRule -Name "Block LLMNR" -DisplayName "Block LLMNR" -Direction Inbound -Protocol UDP -LocalPort 5355 -Action Block
New-NetFirewallRule -Name "Block LLMNR" -DisplayName "Block LLMNR" -Direction Outbound -Protocol UDP -LocalPort 5355 -Action Block


# Questo script eseguirà le seguenti azioni:
# - Disabiliterà LLMNR su tutti gli adattatori di rete che supportano il protocollo.
# - Imposterà i server DNS su 1.1.1.1 e 8.8.8.8.
# - Imposterà i timeout di acquisizione, rinnovo e rilascio del lease DHCP su 1 minuto.
# - Creerà due regole di firewall per bloccare il traffico LLMNR in ingresso e in uscita.
# È importante notare che questo script è solo una guida. Potrebbe essere necessario modificarlo per soddisfare le specifiche esigenze della tua rete.


# La prima parte dello script utilizza il cmdlet Get-NetAdapter per ottenere una lista di tutti gli adattatori di rete. Quindi, utilizza il cmdlet Where-Object per filtrare la lista in base alla proprietà LinkLayerTopologyDescription. Questa proprietà indica se l'adattatore supporta il protocollo LLMNR. Se l'adattatore supporta LLMNR, il cmdlet Set-NetAdapter lo disabiliterà.
# La seconda parte dello script utilizza il cmdlet Set-DnsClientServerAddress per impostare i server DNS. In questo caso, i server DNS sono impostati su 1.1.1.1 e 8.8.8.8.
# La terza parte dello script utilizza i cmdlet Set-DnsClientLeaseObtainTimeout, Set-DnsClientLeaseRenewTimeout e Set-DnsClientLeaseReleaseTimeout per impostare i timeout di acquisizione, rinnovo e rilascio del lease DHCP. Questi timeout sono impostati su 1 minuto per rendere più difficile per gli aggressori utilizzare indirizzi IP autoassegnati per gli attacchi LLMNR Poisoning.
# L'ultima parte dello script utilizza il cmdlet New-NetFirewallRule per creare due regole di firewall che bloccano il traffico LLMNR in ingresso e in uscita.
