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


# This script will perform the following actions:
# - Will disable LLMNR on all network adapters that support the protocol.
# - Will set DNS servers to 1.1.1.1 and 8.8.8.8.
# - Will set the DHCP lease acquisition, renewal, and release timeouts to 1 minute.
# - Will create two firewall rules to block incoming and outgoing LLMNR traffic.
# It is important to note that this script is only a guide. You may need to modify this to meet the specific needs of your network.


# The first part of the script uses the Get-NetAdapter cmdlet to get a list of all network adapters. Then, use the Where-Object cmdlet to filter the list based on the LinkLayerTopologyDescription property. This property indicates whether the adapter supports the LLMNR protocol. If the adapter supports LLMNR, the Set-NetAdapter cmdlet will disable it.
# The second part of the script uses the Set-DnsClientServerAddress cmdlet to set DNS servers. In this case, the DNS servers are set to 1.1.1.1 and 8.8.8.8.
# The third part of the script uses the Set-DnsClientLeaseObtainTimeout, Set-DnsClientLeaseRenewTimeout, and Set-DnsClientLeaseReleaseTimeout cmdlets to set the DHCP lease acquisition, renewal, and release timeouts. These timeouts are set to 1 minute to make it more difficult for attackers to use self-assigned IP addresses for LLMNR Poisoning attacks.
# The last part of the script uses the New-NetFirewallRule cmdlet to create two firewall rules that block incoming and outgoing LLMNR traffic.
