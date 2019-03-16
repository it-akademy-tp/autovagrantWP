
## affichage information des commandes
echo -e "
Mise a jour...";
sudo apt-get update
echo -e "
Installation du paquet Apache2";
sudo apt-get install apache2
echo -e "
Installation du paquet mysql-server";
sudo apt-get install mysql-server
echo -e "
Installation du paquet php7.0";
sudo apt-get install php7.0
echo -e "
Installation du paquet php7.0-mysql";
sudo apt-get install php7.0-mysql
echo -e "
Installation du paquet libapache2-mod-php7.0";
sudo apt-get install libapache2-mod-php7.0
sudo service apache2 restart
mysql -uroot -p0000



echo -e "
L'installation de WP-CLI va debuter...";

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
# FIN Installation
# Choix creation de dossier

read -p "
 _______________________________________________________
| Quel sera le nom du dossier d'installation ?           |
 ________________________________________________________
" nameDoss;

mkdir $nameDoss
cd $nameDoss

# fin creation dossier

read -p "
 ____________________________________________WORDPRESS___
| Quelle langue voulez-vous installer?                   |
| 1 - Francais                                           |
| 2 - Anglais                                            |
 ________________________________________________________
" choix;

if [[ $choix -eq 1 ]] ; then
lang="fr_FR";
elif [[ $choix -eq 2 ]]; then
lang="en_EN"
fi

wp core download --locale=$lang ;

echo -e "
Telechargement de wordpress : ok ! ";

#creation et edition du fichier wpconfig

echo -e "
 ______________________________WORDPRESS__
| creation et edition du fichier wpconfig |
 _________________________________________";
 echo -e "
 Veuillez renseigner les informations suivant : ";



read -p " Le nom de votre base de données :
" bdd;
read -p " votre identifiant :
" usr;
read -p " Votre mot de passe  :
" pass;

wp config create --dbname=$nameDoss --dbuser=$usr --dbpass=$pass;

echo -e "
votre fichier wponfig est bien configuré ";

## FIN WP config

# CREATIION bdd
echo -e "
 ___________________________WORDPRESS__
| Creation de votre base de données... |
 _____________________________________";

wp db create;

echo -e "
bdd : ok ";
#fin Creation bdd

# INSTALL WP

echo -e "
 __________________WORDPRESS___
| Installation de wordpress... |
 ______________________________";


echo -e "
Veuillez renseigner les informations suivantes : ";

read -p "Quel est le titre de votre site wordpress :
" title;
read -p " Quel sera votre identifiant de connexion :
" login;
read -p " Quel sera votre mot de passe :
" password;
read -p " Quel est votre adresse e-mail :
" email;
read -p " Quel est l'adresse de votre site (ex : 192.168.33.10) :
" url;


wp core install --url=$url --title="'$title'" --admin_user=$login --admin_password=$password  --admin_email=$email --skip-email;
    # modification du fichier envars
    sudo sed -i -e "s=export APACHE_RUN_USER=www-dtata=export APACHE_RUN_USER=ubuntu=g" /etc/apache2/envvars;
    sudo sed -i -e "s=export APACHE_RUN_GROUP=www-dtata=export APACHE_RUN_GROUP=ubuntu=g" /etc/apache2/envvars;

    # MODIFICATION DU FICHIER sites-availbles.confaut
    sudo sed -i -e "s=DocumentRoot /var/www/html=DocumentRoot /var/www/html/$nameDoss=g" /etc/apache2/sites-available/000-default.conf;

# RESTART Apache2
sudo service apache2 restart;


# FIN INSTALL WP

echo -e "
 =====================================================
| Votre wordpress est desormais configué et installé   |
| Vous pouvez y acceder a l'adresse suivante : " $url" |
 ====================================================== ";
