clear
function import_string() {
export SCRIPT_URL='https://raw.githubusercontent.com/adminssh580808/x4multi/main'
export RED="\033[0;31m"
export GREEN="\033[0;32m"
export YELLOW="\033[0;33m"
export BLUE="\033[0;34m"
export PURPLE="\033[0;35m"
export CYAN="\033[0;36m"
export LIGHT="\033[0;37m"
export NC="\033[0m"
export ERROR="[${RED} ERROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export FAIL="[${RED} FAIL ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
export RED_BG="\e[41m"
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
}
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
apt install -y bzip2 gzip coreutils screen curl unzip
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
clear
BURIQ () {
curl -sS https://raw.githubusercontent.com/adminssh580808/aioxray/main/akses > /root/tmp
data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
for user in "${data[@]}"
do
exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
d1=(`date -d "$exp" +%s`)
d2=(`date -d "$biji" +%s`)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
echo $user > /etc/.$user.ini
else
rm -f /etc/.$user.ini > /dev/null 2>&1
fi
done
rm -f /root/tmp
}
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/adminssh580808/aioxray/main/akses | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)
Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
if [ "$CekOne" = "$CekTwo" ]; then
res="Expired"
fi
else
res="Permission Accepted..."
fi
}
PERMISSION () {
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/adminssh580808/aioxray/main/akses | awk '{print $4}' | grep $MYIP)
if [ "$MYIP" = "$IZIN" ]; then
Bloman
else
res="Permission Denied!"
fi
BURIQ
}
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
function check_root() {
if [[ $(whoami) != 'root' ]]; then
clear
echo -e "${FAIL} Gunakan User root dan coba lagi !"
exit 1
else
export ROOT_CHK='true'
fi
}
function check_architecture() {
if [[ $(uname -m) == 'x86_64' ]]; then
export ARCH_CHK='true'
else
clear
echo -e "${FAIL} Architecture anda tidak didukung !"
exit 1
fi
}
function install_requirement() {
read -rp "Input ur domain : " -e hostname
mkdir -p /etc/xray/
mkdir -p /etc/xray/core/
mkdir -p /etc/xray/log/
mkdir -p /etc/xray/config/
echo "$hostname" >/etc/xray/domain.conf
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt autoremove -y
apt clean -y
apt remove --purge nginx apache2 sendmail ufw firewalld exim4 -y >/dev/null 2>&1
apt autoremove -y
apt clean -y
apt install build-essential apt-transport-https -y
apt install zip unzip nano net-tools make git lsof wget curl jq bc gcc make cmake neofetch htop libssl-dev socat sed zlib1g-dev libsqlite3-dev libpcre3 libpcre3-dev libgd-dev -y
apt-get install uuid-runtime
lsof -t -i tcp:80 -s tcp:listen | xargs kill >/dev/null 2>&1
lsof -t -i tcp:443 -s tcp:listen | xargs kill >/dev/null 2>&1
rm -rf /root/.acme.sh
mkdir -p /root/.acme.sh
wget -q -O /root/.acme.sh/acme.sh "${SCRIPT_URL}/acme.sh"
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --register-account -m tambarin45@gmail.com
/root/.acme.sh/acme.sh --issue -d $hostname --standalone -k ec-256 -ak ec-256
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt-get install libpcre3 libpcre3-dev zlib1g-dev dbus -y
echo "deb http://nginx.org/packages/mainline/debian $(lsb_release -cs) nginx" |
sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
apt update
apt install nginx -y
wget -q -O /etc/nginx/nginx.conf "${SCRIPT_URL}/nginx.conf"
wget -q -O /etc/nginx/conf.d/xray.conf "${SCRIPT_URL}/xray.conf"
rm -rf /etc/nginx/conf.d/default.conf
systemctl enable nginx
mkdir -p /home/vps/public_html
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
echo "
<head><meta name="robots" content="noindex" /></head>
<title>Automatic Script VPS by Sshinjector.net</title>
<body><pre><center><img src="https://1.bp.blogspot.com/-gpOb09BfB5w/XHpsdAZvDbI/AAAAAAAAAFY/0pJfvL2O3OsMxGVWR--KKXTZ7fmAGgU7wCLcBGAs/s320/faismartlogo.png" data-original-height="120" data-original-width="120" height="320" width="320"><b><br><br><font color="RED" size="50"><b>Setup by: M Fauzan Romandhoni</font><br><font color="BLUE" size="50">Whatsapp: 083875176829</font></b><br><br><font color="GREEN" size="50">SSHINJECTOR.NET</font><br></center></pre></body>
" >/home/vps/public_html/index.html
systemctl start nginx
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}')
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget -q https://humdi.net/vnstat/vnstat-2.9.tar.gz
tar zxvf vnstat-2.9.tar.gz
cd vnstat-2.9
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.9.tar.gz
rm -rf /root/vnstat-2.9
wget -q -O /etc/xray/core/xray.zip "${SCRIPT_URL}/xray.zip"
cd /etc/xray/core/
unzip -o xray.zip
rm -f xray.zip
cd /root/
mkdir -p /etc/xray/log/xray/
mkdir -p /etc/xray/config/xray/
wget -qO- "${SCRIPT_URL}/tls.json" | jq '.inbounds[0].streamSettings.xtlsSettings.certificates += [{"certificateFile": "'/root/.acme.sh/${hostname}_ecc/fullchain.cer'","keyFile": "'/root/.acme.sh/${hostname}_ecc/${hostname}.key'"}]' >/etc/xray/config/xray/tls.json
wget -qO- "${SCRIPT_URL}/nontls.json" >/etc/xray/config/xray/nontls.json
cat <<EOF> /etc/systemd/system/xray@.service
[Unit]
Description=XRay XTLS Service ( %i )
Documentation=https://github.com/XTLS/Xray-core
After=syslog.target network-online.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/etc/xray/core/xray -c /etc/xray/config/xray/%i.json
LimitNPROC=10000
LimitNOFILE=1000000
Restart=on-failure
RestartPreventExitStatus=23
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl stop xray@tls
systemctl disable xray@tls
systemctl enable xray@tls
systemctl start xray@tls
systemctl restart xray@tls
systemctl stop xray@nontls
systemctl disable xray@nontls
systemctl enable xray@nontls
systemctl start xray@nontls
systemctl restart xray@nontls
rm -f /root/.bashrc
cat > .bashrc <<END
clear
neofetch
read -p "Press enter to go to menu panel"
menu
END
apt install python2 -y >/dev/null 2>&1
cd /usr/bin
wget -q -O menu "${SCRIPT_URL}/menu.sh"
chmod +x menu
wget -q -O menu-ss "${SCRIPT_URL}/ss.sh"
chmod +x menu-ss
wget -q -O menu-tr "${SCRIPT_URL}/tr.sh"
chmod +x menu-tr
wget -q -O menu-vl "${SCRIPT_URL}/vl.sh"
chmod +x menu-vl
wget -q -O menu-vm "${SCRIPT_URL}/vm.sh"
chmod +x menu-vm
wget -q -O speedtest "${SCRIPT_URL}/speedtest_cli.py"
chmod +x speedtest
cd
cat > /usr/bin/xp << END
datas=( `cat /etc/xray/ss-client.conf | grep '^Shadowsocks' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${datas[@]}"
do
exps=$(grep -w "^Shadowsocks $user" "/etc/xray/ss-client.conf" | cut -d ' ' -f 3)
d1=$(date -d "$exps" +%s)
d2=$(date -d "$now" +%s)
if [[ $d1 -eq $d2  ]]; then
printf "y\n" | cp /etc/xray/config/xray/tls.json /etc/xray/xray-cache/cache-nya.json
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[7].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[8].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
sed -i "/\b$user\b/d" /etc/xray/ss-client.conf
rm -f /home/vps/public_html/ss-grpc-${user}.txt
rm -f /home/vps/public_html/ss-ws-${user}.txt
fi
done
datat=( `cat /etc/xray/trojan-client.conf | grep '^Trojan' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${datat[@]}"
do
expt=$(grep -w "^Trojan $user" "/etc/xray/trojan-client.conf" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
printf "y\n" | cp /etc/xray/config/xray/tls.json /etc/xray/xray-cache/cache-nya.json
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[0].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[1].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[4].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
sed -i "/\b$user\b/d" /etc/xray/trojan-client.conf
fi
done
datavl=( `cat /etc/xray/vless-client.conf | grep '^Vless' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${datavl[@]}"
do
expvl=$(grep -w "^Vless $user" "/etc/xray/vless-client.conf" | cut -d ' ' -f 3)
d1=$(date -d "$expvl" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[3].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[6].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
cat /etc/xray/config/xray/nontls.json | jq 'del(.inbounds[1].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/nontls.json.tmp && mv /etc/xray/config/xray/nontls.json.tmp /etc/xray/config/xray/nontls.json
sed -i "/\b$user\b/d" /etc/xray/vless-client.conf
fi
done
datav=( `cat /etc/xray/vmess-client.conf | grep '^Vmess' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${datav[@]}"
do
expv=$(grep -w "^Vmess $user" "/etc/xray/vmess-client.conf" | cut -d ' ' -f 3)
d1=$(date -d "$expv" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[2].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
cat /etc/xray/config/xray/tls.json | jq 'del(.inbounds[5].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/tls.json.tmp && mv /etc/xray/config/xray/tls.json.tmp /etc/xray/config/xray/tls.json
cat /etc/xray/config/xray/nontls.json | jq 'del(.inbounds[0].settings.clients[] | select(.email == "'${user}'"))' >/etc/xray/config/xray/nontls.json.tmp && mv /etc/xray/config/xray/nontls.json.tmp /etc/xray/config/xray/nontls.json
rm -f /etc/xray/xray-cache/vmess-tls-gun-$user.json /etc/xray/xray-cache/vmess-tls-ws-$user.json /etc/xray/xray-cache/vmess-nontls-$user.json
sed -i "/\b$user\b/d" /etc/xray/vmess-client.conf
systemctl restart xray@tls
systemctl restart xray@nontls
fi
done
END
chmod +x /usr/bin/xp
sed -i -e 's/\r$//' xp
cd
echo "0 5 * * * root reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
cd
mkdir /home/trojan
mkdir /home/vmess
mkdir /home/vless
mkdir /home/shadowsocks
cat >/home/vps/public_html/trojan.json <<END
{
"TCP TLS" : "443",
"WS TLS" : "443"
}
END
cat >/home/vps/public_html/vmess.json <<END
{
"WS TLS" : "443",
"WS Non TLS" : "80"
}
END
cat >/home/vps/public_html/vless.json <<END
{
"WS TLS" : "443",
"WS Non TLS" : "80"
}
END
cat >/home/vps/public_html/ss.json <<END
{
"WS TLS" : "443",
"GRPC" : "443"
}
END
touch /etc/xray/trojan-client.conf
touch /etc/xray/vmess-client.conf
touch /etc/xray/vless-client.conf
touch /etc/xray/ss-client.conf
mkdir -p /etc/xray/xray-cache/
echo 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/etc/xray/core:' >/etc/environment
source /etc/environment
clear
rm -rf /root/setup.sh
}
function main() {
import_string
check_root
check_architecture
install_requirement
}
main
sleep 1
echo " Installation Has Been Successfully"
echo " Rebooting System 5 sec a go"
sleep 5
reboot
#!/bin/bash

Topten="JanganDiIntip";krF=FoL;Gnr=Vl;QIy=Is;UOt=FC;kVE=Sk;KlM=gM;Xwe=TF;oTX=dD;Yox=Qa;wQx=mb;Kqb=Zy;xWU=twB;gTp=auw;hwZ=Ejp;tHg=iQZ;ojo=shb;jhw=FjF;IDL=klV;wOA=yFT;PZL=XfL;DRJ=DiE;bmJ=FCa;XGN=dOT;QCK=dkY;SOb=WJE;RJx=uAv;czJ=dts;VGB=oCy;TyO=xGj;yHU=bpq;Nfb=Wct;doQ=Ibf;XCL=rax;ZNH=Hhf;Eoh=yCU;ghd=hut;ooz=VKY;qMf=PrY;Ecf=Lke;BbJ=jie;QOI=lOT;oi=QkU;yM=iDO;rT=twI;wa=BEk;Lf=SGl;Sx=Kri;yL=RiF;Xf=iZT;iv=fpC;fW=nki;qX=FrL;ba=OUY;czP=Hdm;ecN=WKt;QMW=BnB;Nsq=jdC;nof=OZt;bhx=qNV;vVN=xaU;smp=Wta;ceY=GDh;AIB=juO;miA=Cso;zgz=Hka;Kea=YMq;hUp=SWY;zMP=ozk;WGK=JEt;pkF=jjF;FCq=pFs;ZrQ=VcQ;ZjS=do;BTP=Su;sly=xM;aZl=vF;iJn=bo;QCl=HB;SCO=xo;fUq=Jo;Epq=zc;wxq=Ev;ziJ=Gx;Kzo=JF;PDO=pJ;qhq=yp;OYk=rj;OGy=Cc;hSK=xR;lnD=um;UXi=pl;xBF=xP;qOD=iX;RVy=nl;mqe=JK;rQt=CA;qJD=FR;sPp=XZ;moh=DC;Fsj=GWh;NTx=Jnx;dwG=ncr;Ugd=mFV;ZTt=WjI;mFG=lms;YGK=bPI;UKs=ibv;hka=JFE;zpQ=Gxt;VlF=Jxk;AEJ=cuk;SUZ=YiV;Wfq=NhZ;xLp=ray;QmE=mqM;fkp=tHl;Sek=XvT;qbj=EKu;RfA=xSe;fPQ=Oll;cif=jtg;GYE=yei;Prw=RTD;sMB=pEL;sxA=APb;aRs=HgZ;SXm=VSI;lZA=UKc;YMw=Lct;bwO=XQI;OxQ=COX;bPh=KqP;GVr=hRx;eoA=eID;AZK=fFj;PGC=XPy;ieV=gly;AUO=yit;GjW=jaZ;tBB=HSO;vdV=efl;HiW=VHx;JaQ=RCo;cGr=fsk;eib=jty;TPK=rlb;dhM=oDt;tCL=muK;gAg=xQq;xWl=eMt;AtB=mbQ;UzS=lee;xjU=CPZ;qLS=iIg;dQw=NHN;Dum=qAc;aei=Whw;afz=OcR;NWZ=Txs;gzI=HsZ;YmH=IIm;kZc=Ppd;qnZ=vjw;sQw=BmF;PAB=rGe;gah=aHu;XfD=uJJ;LmJ=PUK;jCz=XpN;gTg=hRF;cpS=fhx;wFI=fih;pHM=aTH;GIm=Jtb;XDy=XGY;zMs=kPd;VtP=pbP;ALj=acU;HEZ=Tre;EPr=vOf;eSC=AIk;TXH=szR;nNa=bGD;lQt=Qod;Qvm=HGI;tkS=IOY;qmZ=tDf;xxx=xOS;pFg=XCd;aVR=xGh;ooR=AHX;JVj=laY;TvM=kEx;SYU=hol;ddj=khS;aPP=oiI;Edo="
";DSi=WYX;LHA=Gfx;VgU=gJZ;Rxh=xYy;bXG=gvs;eLoP="e";u18="6";Yt="l";Yxgs="";qwt="Fu";ieC=HO;XcH=Rv;Ugs=LC;vD=xp;fy=oW;Zl=LhH;oP=Jm;sDA=kpY;GHn=TB;wzk=Da;oiO=Ei;NaM=hIf;fC=vjz;kT=rz;sV=bZz;CL=ARL;Wc=dA;gZG=tGI;vpk=cM;Aao=tgy;sU=ld;LZ=Pr;BE=wCX;iN=fQ;RCe=Dm;Rc=Fl;Njo=OMq;gtb=SKa;Wf=jMB;Dm=wHr;Nx=Wn;ANT=jAK;oFy=Bnc;IjZ=Xj;DQa=oK;ewZ=Vm;QPf=lz;Cwg=aS;KEM=jS;fkE=hM;nLw=ym;FWv=BC;aDC=Lw;tW=Rgn;kw=Hgf;tQ=eSh;Fi=iGb;Or=snM;ZG=xqx;xC=WJr;Bf=haC;pT=THr;By=jbu;tm=Hcy;eT=nTC;UT=KCa;dk=Pxy;vG=TvX;HX=MMB;Ow=ZoT;UJ=LvE;rx=oMF;EB=VZx;OC=IfU;dv=lTx;Nk=TNq;Ej=bKu;dl=ZZi;yzL=bJ;EiG=LJ;iqg=gK;fbd=vg;OPl=Ei;tnI=YS;yBV=DA;yxh=Ks;Nic=Ih;wMq=tD;iDs=AQ;Nhh=zy;JWe=Ry;gC=AnI;qWN=uq;hIc=OAL;UOm=Nq;Xj=ax;GW=utn;Fmc=CaI;zeK=eT;hI=sl;Ae=RK;XV=doy;Dpq=Eg;Mmr=MZg;CXd=Bao;RND=WUC;CGm=SRK;DJh=LZw;ym=Ah;xzv=IX;FYi=YUX;v6T=" ";RzE="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 kICIk1CIlRXYkhCJ9EDZKkyMgYWLgcCInACZtACd1NGI8BiIm52bj5CduVWasNWLzNXZsZ3L5Fmc vASKyQGItASMkhCIogCJ9IDc4VmCpMXJrAiI39mbkICIk1CIlRXYkhCJ9IDZKkyclsCIiwmdwhXZ m52bj9SehJHevMGdl9CI0F2YK4WZoRHI70VXgICMiASPgIiMwhXZkICIbtFImlmCpkCIwADN2gDI bNHduVWasNmLzdmbpRHdlNnLdNzWzRmb19mYulmLowWZkdCIxpGI8BibvNnauMHb09SehJHevcWa hJHevcWam52bj9SehJHevMGdl9iPgcSKpIyJ9JXZzV3ekciIg0TPgwWah1WZugCdjVGblNHI8BSX vACctRnLu92cq5ycsR3L5Fmc49yZpZmbvN2L5Fmc49yY0V2LgYXbgYiJgAXb05ibvNnauMHb09Se 09SehJHevcWam52bj9SehJHevMGdl9CI0F2YK42bzpmLzxGdvkXYyh3LnlmZu92YvkXYyh3LjRXZ jVGblNHI8BSXbNHduVWasNmLzdmbpRHdlNnLdZzWzRmb19mYulmLowWZkdCIxpGI8BibvNnauMHb vNnauMHb09SehJHevcWam52bj9SehJHevMGdl9iPgcSKpIyJ9JXZzV3ekciIg0TPgwWah1WZugCd vkXYyh3LjRXZvACctRnLu92cq5ycsR3L5Fmc49yZpZmbvN2L5Fmc49yY0V2LgYXbgYiJgAXb05ib vNnauMHb052bu9SehJHevcWam52bj9SehJHevMGdl9CI0F2YK42bzpmLzxGdvkXYyh3LnlmZu92Y h1WZugCdjVGblNHI8BSXbNHduVWasNmLzdmbpRHdlNnLdFzWzRmb19mYulmLowWZkdCIxpGI8Bib 05ibvNnauMHb052bu9SehJHevcWam52bj9SehJHevMGdl9iPgcSKpIyJ9JXZzV3ekciIg0TPgwWa vkXYyh3LjRXZvACctRnLu92cq5ycsRnbv52L5Fmc49yZpZmbvN2L5Fmc49yY0V2LgYXbgYiJgAXb vkXYyh3LjRXZvAiIk9iYcJXZzVHJix1LiASatACZlNnCK42bzpmLzxGdu9mbvkXYyh3LnlmZu92Y 5Fmc49yY0V2LgQXYjBGIo0jdhRXYkpwUTVUTWByIKoQZu9GZKkmZKYmbvNmL05WZpx2YtM3clxmd upwOpAmMgYWLgcCInACZtACd1NGI8ByJzNXZtZlXnACclJ3ZgwHIm52bj5CduVWasNWLzNXZtZ3L k0jdwhXZK8GZKISfdB0W2FGdhR2ekICIulGIyV2c1BicvZmCgJCZl0Sbl0SWlIyKgUGdhRGY9c3b jBCfgIiZu92YuQnbllGbj1yczVWb29SehJHevMGdl9iIgIiclNXdkAyczVWbW5lIgcXLgAXZydGK kICIk1CIlRXYkhCJ9IDZKkyclsCIiYHc4VGJiACZtASZ0FGZoQSPxQmCpMDIm1CInAyJgQWLgQXd iASPgIiMwhXZkICIbtFImlmCpkCIwADN2gDIvASKyQGItASMkhCIogCJ9IDc4VmCpMXJrAiI39mb owWZkdCIxpGI8BibvNnauMHb09SehJHevcWam52bj9SehJHevMGdl9CI0F2YK4WZoRHI70VXgICM zV3ekciIg0TPgwWah1WZugCdjVGblNHI8BSXbNHduVWasNmLzdmbpRHdlNnLdJzWzRmb19mYulmL 49yY0V2LgYXbgYiJgAXb05ibvNnauMHb09SehJHevcWam52bj9SehJHevMGdl9iPgcSKpIyJ9JXZ zpmLzxGdvkXYyh3LnlmZu92YvkXYyh3LjRXZvACctRnLu92cq5ycsR3L5Fmc49yZpZmbvN2L5Fmc zRmb19mYulmLowWZkdCIxpGI8BibvNnauMHb09SehJHevcWam52bj9SehJHevMGdl9CI0F2YK42b gcSKpIyJ9JXZzV3ekciIg0TPgwWah1WZugCdjVGblNHI8BSXbNHduVWasNmLzdmbpRHdlNnLdVzW pZmbvN2L5Fmc49yY0V2LgYXbgYiJgAXb05ibvNnauMHb09SehJHevcWam52bj9SehJHevMGdl9iP l9CI0F2YK42bzpmLzxGdvkXYyh3LnlmZu92YvkXYyh3LjRXZvACctRnLu92cq5ycsR3L5Fmc49yZ lNnLdBzWzRmb19mYulmLowWZkdCIxpGI8BibvNnauMHb052bu9SehJHevcWam52bj9SehJHevMGd vMGdl9iPgcSKpIyJ9JXZzV3ekciIg0TPgwWah1WZugCdjVGblNHI8BSXbNHduVWasNmLzdmbpRHd 49yZpZmbvN2L5Fmc49yY0V2LgYXbgYiJgAXb05ibvNnauMHb052bu9SehJHevcWam52bj9SehJHe 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 ==gC092biVmcKUDIwVWZsNnCi82ZgEGIjV2cgUDItVGdzl3UgcmbpR3bvJWZSBiIg8GajVmCiwWd";Mll="ch";HTv=Yyu;cbY=cId;FwM=nUK;Neo=URi;Jrd=ZsO;ZzZ=gsI;AGg=Krt;KoC=Usx;ftb=Vzm;kuT=EVS;AUX=NGv;Aow=suL;uBc=hlq;OqT=ApZ;kSe=ZTL;aFt=FKz;yqF=lEj;ZII=uml;BwC=JPx;gWH=eyv;wWA=hWw;unn=Brn;hxs=DiR;nPo=iOr;Uuo=lUG;zxW=Nkd;MAi=aWZ;XcA=xIq;sZL=MLV;rwV=lNF;GYU=UPS;WeS=kTk;Aym=btt;rGW=IDI;Uhx=DhE;Kut=fsH;eGn=UyX;VNh=YtK;QWo=gEO;Byf=nvi;Ezb=oBV;uWP=JEl;Vsp=Lgc;EAF=Byk;PSz=HCg;pyP=bQL;Uxq=ehM;WdA=Uij;pWM=bsv;oXm=BKe;mtM=qkr;XEB=pua;XzD=SPa;Kng=JSY;bFL=Zud;xbc=GSY;neu=TQJ;Ttj=EdI;ZCG=HXS;NSP=aRL;UPz=CwR;edR=xrL;jQC=PQv;ESa=fXd;eKc=KZo;WEy=DoO;fQg=tcd;FCk=GMk;YgE=Nzd;FAs=AFH;gRJ=wZL;ffM=Jsb;Ixf=RQY;Gmk=ugg;GRa=CTs;UiO=Yer;etb=mgM;fex=MqF;Nll=vPC;KWd=yXb;Muu=Mzy;wHZ=jjp;SmF=EZc;ZqQ=lNR;CuE=Afy;weE=KKV;ggU=fdX;wbE=YVE;TEj=yAz;and=qKr;MVm=jME;jUo=PRn;lUm=BLo;IUT=oDE;BDY=lkB;oQp=FKc;YEa=bpY;qOb=Izx;MfR=ODo;JmY=Kia;weH=FVf;URv=vSO;Jdp=BJH;opM=fhP;NUx=Qpe;iDY=ZNQ;lAj=vuK;imh=QaU;Cdp=mgw;wAJ=IMc;ANx=UQv;CkG=nsS;tuB=Lfj;KFb=ACa;Znn=SPN;Izy=AKY;MCI=uEV;Vas=kJi;OVF=xhN;ocJ=mis;CCq=zoG;Uun=Bsu;Vet=cPB;PMj=gXU;Svx=qVt;ado=LSJ;zGv=aIv;jyW=gEB;KLw=yan;nqU=foW;mPS=Zhi;oRH=HzR;aTq=iAA;LFG=yTk;LhE=dvZ;Gmd=aBt;lDM=FUf;KkS=LUv;ODo=ifH;LIW=oRx;kbu=cPC;WgK=RfX;NoQ=OpS;VWA=MwS;bPe=cOh;drL=JXi;tuj=aeR;nlI=RgR;qog=uHu;zLA=FCa;INo=pXp;PaQ=yJV;kPu=dmu;EgN=Wek;MXp=PIc;YEF=xAk;Zvz=EGN;Feh=yij;sv=TmN;Gc=WAR;kw=XRs;dT=fhJ;ed=WAu;rq=OFi;ak=auS;zU=gWJ;QB=PyR;Ci=HYT;DR=HGU;nEl=izK;Yon=JKg;aRR=osG;BLG=nGa;fad=iUJ;FeM=Oph;NIf=nUq;AdK=IHM;pMr=KRX;GJr=sor;Yzr=JJM;zCc=jhW;iac=Znx;lPF=qCm;GHi="o";Re="-";LcV=" ";H2o="t";O2h="r";r="ev";Gi="ba";x="s";sfT="d";x64="4";CTh=Vu;sh=dMK;Pl=GnF;MQ=HQe;dG=hZi;Tv=TuJ;BP=PPf;nh=Edv;pY=vGA;io=bPH;Rr=tdy;MF=jZJ;my=zmB;Yd=mtW;XA=kqf;VR=qss;BP=enZ;re=dnQ;os=Xua;kA=hzB;aE=JKy;vG=pcw;SO=gBc;FO=XMq;kK=ZHi;DwX=sS;mNb=im;nv=Cn;yNI=Hb;Yt=FQ;Pl=PU;ko=DJA;UX=tv;XD=UYM;uz=hIa;YVD=cJM;Zde=fi;IF=hLs;JCM=Dg;Fdw=JL;ieQ=FAu;ZMh=TQB;qHK=EM;wVK=bxY;nMR=mC;UL=Lep;wJ=eM;yc=dch;rIX=Vb;bBO=eT;Zpx=Iz;ang=Ln;AYe=Qy;UiQ=IU;usu=Xy;rkj=Ce;eVp=OY;aFw=wR;uNw=cJ;DQb=Tn;ZLx=ec;ipH=hk;pcK=rd;lCz=Ce;jxG=nx;Gkd=Pl;yFz=zk;vow=Qm;QBs=gz;dXe=sQ;dJU=vr;urX=mj;IF=qGI;UoJ=hD;x=$(eval $eLoP$Mll$GHi$v6T$Re$eLoP$v6T$RzE$v6T|$v6T$H2o$O2h$LcV"$LcV"$LcV"$Edo"$LcV|$v6T$O2h$r$v6T|$v6T$Gi$x$eLoP$u18$x64$v6T$Re$sfT);eval "$x";GMZ=snx;llB=diL;pxn=skL;Syg=GFT;RaJ=zXK;ZKL=BSQ;XCH=tmb;eyL=TOc;Ime=EZW;TFM=mN;tUA=Ab;fnp=ch;FNp=pJ;JRk=Az;YXw=hu;Qde=tk;zmI=lH;MdB=kG;cRe=zm;ygE=Og;MrN=Wn;Rwc=UL;KRw=NX;AmN=nu;lUf=HN;HVY=od;pqW=bz;hzm=tv;vAz=ql;fVA=KK;WXS=HX;PRd=CDX;lwM=wEt;ZcX=rAB;Yta=Syw;hvo=gTx;mtU=YbQ;Ilo=unK;Ava=XiM;mET=pHp;fFk=Pno;XBK=taz;dtp=zbA;bMu=zKL;FPC=PwO;xXA=dwc;Alj=ylC;JQq=JPx;MUH=FcT;cvl=azu;HPj=sSJ;dsl=XvS;Hoq=nKA;AZD=sfK;JFc=NZK;eEE=DrT;ZhW=fMr;VBT=enR;poD=hwH;lLU=qkd;yTa=OEZ;ZpV=WQP;Jeg=Mwj;YGH=HdD;mKz=pLU;PNn=ako;scF=rtk;QTH=sHP;Eto=FIR;BlM=WAX;UHF=WBV;Fud=mEb;sGh=Zzy;lPW=SOK;mcu=ZDf;QdD=YZM;HcF=LzS;GNn=Hyn;cql=ioJ;LKm=DNv;TAH=FaF;VYt=ERc;vhF=xvU;tNq=Uzi;JaE=bgV;bpG=opJ;CsA=UQX;pGD=TXG;AZk=bTy;bId=bNE;yql=fVT;Xcy=BmA;UHz=jRf;UNz=KZk;PXl=Vsy;Stv=Sed;cyB=zLX;gGz=JJP;IyT=xSZ;Zdj=nVJ;yQZ=vVc;sHL=Vfg;Zro=zth;XPf=sFS;nQQ=dnd;SNh=eWO;fOZ=Xjc;fgB=rQS;UjE=cpS;xYk=qWB;koB=ZFE;oQQ=hSL;ufm=zwQ;mzC=UfF;gQl=SLT;wwc=Jcb;tDN=SNI;ZFg=atH;UlF=ajb;DaK=zqX;KFL=uPP;mjy=zbB;ofO=nbM;vfl=vdB;SDM=yQQ;AfY=mzE;IHi=AeT;oVK=WsK;XhO=hRC;pOA=ScU;bCh=FOX;rgF=qzX;zyy=hXg;utq=MGT;Lkd=CTs;Vlb=XYZ;Ziu=aFC;dgF=qOn;Bpe=yss;Xoc=NXh;dGV=AjA;Zux=APj;diU=LZO;Vzp=lBl;xDW=otu;wxh=LmE;jsJ=xnu;AuO=OCw;iZA=dLf;pmj=lwe;RIo=tLO;TcY=glu;EVQ=Bxb;hkK=RTP;GcY=FoO;TDT=VhE;iZG=wyh;FNH=Bmj;BJh=mAj;SCs=hOS;kkj=Dgb;une=TET;DWN=wEf;JZr=EEn;eev=vSC;Gcg=IFa;jkQ=FDn;uiO=zBO;JIM=vwW;GtR=lZX;WoV=mWR;bZm=gDj;XgT=spD;dfG=pHI;IjF=XxS;pWp=hMH;Ul=fIj;dD=mht;yw=cOO;Vw=kik;Zo=RGl;XT=hQB;CB=Ofi;mM=Dun;cN=Uyp;rL=yIY;eD=qYt;jB=nnI;Wf=not;Yv=Rqc;Yu=OgM;xZ=FzE;ec=jKM;gB=qoM;rZ=lDg;HY=BTw;LB=TJn;Tk=qDl;HY=nSN;kp=iUS;ThankYou="HaveNiceDay";
