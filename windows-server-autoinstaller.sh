#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows 2025"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 10
        img_file="windows10.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=a30cfbba-2930-4a78-8fd2-589f90af8006&P1=1749971598&P2=601&P3=2&P4=Ec6mu5DVC45OHsDtCoazgDt03tQPlMC9R4KDnVcRDsbBcJQD2grn%2bPZbJMg%2bS560aIHY%2blIRA%2fzq%2bTNkEKiuDuIztsEP3nj78CXkJecunKJlTot0OLMtbwNWyGrYt4baMt69BLA9Q7chZVlxveQzSSHBy%2bzsQn94v2qk%2bs5Da%2bZiNsKMKyQJjwaJNEU4xmv32c3uo%2f3wmo0v086vj%2bamqPo66T8p0OI%2bGfZR%2f2ZN8lpv2GJ0ON%2bixFwfabphl%2fc6hOe4n9Or7DuyDG%2fG%2fr99bvKhaLNPTkaSnQSrflBMPcz5bklmH5JZL%2b2Sjl3D6UgFlL49jJgPpwRhI3RiWSeuGg%3d%3d"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11
        img_file="windows11.img"
        iso_link="https://www.swiftuploads.com/download/eyJpdiI6IlhLWXJoKy9sZUdmT28vYXFMb1BxekE9PSIsInZhbHVlIjoiOTREWFprQzdSa1BpV09XRWsrSmFaYkhVYzk3MjBERG9Ebk4xaXhQUFZ3ND0iLCJtYWMiOiI1MWU2MTBhOWY0Njc5YTMxMjQ1ODUwYTRjMWNmMDQ5Yjg5MGJlYzU4NTYzMDY0ZmFiN2NhYzEwMDdiYTJmNjc1IiwidGFnIjoiIn0=/G-W11-24H2.P.U15.wpe64?expiration=1749970147&signature=7cd9e4509b65eab844703fd32aaee5a2d6bbc2823ad93b89027936590458fb89"
        iso_file="windows11.iso"
        ;;
    6)
        # Windows 1021h2
        img_file="windows2025.img"
        iso_link="http://167.172.65.19/windows2025.iso"
        iso_file="windows2025.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 40G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
