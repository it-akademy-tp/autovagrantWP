########################### MAIN MENU ##############################
read -p "
 ____________________________________
| Quelle box voulez-vous utiliser ?  |
| 1 - Xenial 64                      |
 ____________________________________
" choix;

################################# XENIAL 64 ###################################"
if [[ $choix -eq 1 ]]
then
    box="ubuntu/xenial64";
#### VERIF DOSSIER DATAXENIAL ####
if [ ! -d dataX ]; then
    mkdir dataX
    doss=datax
    echo -e "
\033[44mLe dossier dataXenial a été creer !\033[0m"
else
    echo -e "
\033[45mUn dossier dataXenial existe deja !\033[0m"
fi
###### MODIF VAGRANT FILE #######

#### VERIF VAGRANTFILE ####
if [ ! -f Vagrantfile ]; then

    echo "
    Vagrant.configure("2") do |config|
    config.vm.box = \"$box\"
    config.vm.synced_folder \"$doss\", \"/var/www/html\"
    config.vm.network \"private_network\", ip: \"192.168.33.10\"
    end">Vagrantfile

    echo -e "
\033[44mLe fichier Vagrantfile a été généré !\033[0m"
else
    echo -e "
\033[45mUn Vagrantfile existe déjà dans ce dossier !\033[0m"
fi

# deplacer wp.sh dans dossier data
pwd
mv wp.sh dataX/

vagrant up;

   ####### MENU XENIAL #######
    read -p "
 _________________________________________________XENIAL 64____
| Menu :                                                        |
| 1 - Eteindre la vagrant                                       |
| 2 - Se connecter                                              |
 _______________________________________________________________
" menu;
if [[ $menu -eq 1 ]]
then
    vagrant halt;
elif [[ $menu -eq 2 ]]
then
    vagrant ssh;
else
    echo "Saisie incorrect";
fi




fi
