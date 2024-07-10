locals {
  users = {
    "vincent.park@onclusive.com" = {
      first_name = "Vincent"
      last_name = "Park"
      groups = [
        "aws#acc#CrawlerAdmin#310550864638",
        "aws#acc#CrawlerAdmin#357750346051",
        "aws#acc#AdministratorAccess#690763002009",
        "aws#acc#MLOPS_ADMIN_PROD#211212199399",
        "aws#acc#MLOPS_ADMIN_DEV#690763002009",
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#ML_Admin#690763002009",
        "aws#acc#AdministratorAccess#211212199399",
      ]
    }
    "rajesh.dharmalingam@onclusive.com" = {
      first_name = "Rajesh"
      last_name = "D"
      groups = [
        "aws#acc#CrawlerTeam#357750346051",
        "aws#acc#AdministratorAccess#310550864638",
        "aws#acc#AdministratorAccess#229549174149",
        "aws#acc#BillingReadOnly#211212199399",
        "aws#acc#AdministratorAccess#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
        "aws#acc#AdministratorAccess#690763002009",
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#AdministratorAccess#357750346051",
        "aws#acc#MLTeamAccess#484375727565",
        "aws#acc#AdministratorAccess#211212199399",
      ]
    }
    "gireesh.nair@onclusive.com" = {
      first_name = "Gireesh"
      last_name = "Nair"
      groups = [
        "aws#acc#AdministratorAccess#310550864638",
        "aws#acc#AdministratorAccess#229549174149",
        "aws#acc#AdministratorAccess#632083551481",
        "aws#acc#AdministratorAccess#484375727565",
        "aws#acc#AdministratorAccess#690763002009",
        "aws#acc#AdministratorAccess#357750346051",
        "aws#acc#AdministratorAccess#211212199399",
      ]
    }
    "rene-jean.corneille@onclusive.com" = {
      first_name = "Rene-jean"
      last_name = "Corneille"
      groups = [
        "aws#acc#CrawlerAdmin#310550864638",
        "aws#acc#CrawlerAdmin#357750346051",
        "aws#acc#AdministratorAccess#690763002009",
        "aws#acc#MLOPS_ADMIN_PROD#211212199399",
        "aws#acc#MLOPS_ADMIN_DEV#690763002009",
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#AdministratorAccess#211212199399",
      ]
    }
    "manal.elguerouani@onclusive.com" = {
      first_name = "manal"
      last_name = "elguerouani"
      groups = [
        "aws#acc#MLOPS_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLOPS_CONTRIBUTOR_PROD#211212199399",
      ]
    }
    "szymon.aptacy@onclusive.com" = {
      first_name = "Szymon"
      last_name = "Aptacy"
      groups = [
        "aws#acc#MLOPS_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLOPS_READER_DEV#690763002009",
        "aws#acc#MLOPS_CONTRIBUTOR_PROD#211212199399",
      ]
    }
    "syed.reza@onclusive.com" = {
      first_name = "Syed"
      last_name = "Reza"
      groups = [
        "aws#acc#MLE_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MLE_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLOPS_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MLOPS_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLTeamAccess#484375727565",
      ]
    }
    "ivan.okhotnikov@onclusive.com" = {
      first_name = "Ivan"
      last_name = "Okhotnikov"
      groups = [
        "aws#acc#MediaMonitoring#484375727565",
        "aws#acc#MLOPS_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLOPS_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MediaMonitoring#357750346051",
      ]
    }
    "vishal.singh@onclusive.com" = {
      first_name = "Vishal"
      last_name = "Singh"
      groups = [
        "aws#acc#MLOPS_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLE_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLOPS_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MLTeamAccess#484375727565",
      ]
    }
    "yuzhou.gao@onclusive.com" = {
      first_name = "Yuzhou"
      last_name = "Gao"
      groups = [
        "aws#acc#MLE_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MLE_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLTeamAccess#484375727565",
      ]
    }
    "jian.tong@onclusive.com" = {
      first_name = "Jian"
      last_name = "Tong"
      groups = [
        "aws#acc#ML_Admin#357750346051",
        "aws#acc#MLE_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MLE_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLTeamAccess#484375727565",
      ]
    }
    "amaury.deguillebon@onclusive.com" = {
      first_name = "Amaury"
      last_name = "Deguillebon"
      groups = [
        "aws#acc#MLTeamAccess#357750346051",
        "aws#acc#MLE_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MLE_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLTeamAccess#484375727565",
      ]
    }
    "zheyuan.hu@onclusive.com" = {
      first_name = "Zheyuan"
      last_name = "Hu"
      groups = [
        "aws#acc#MLE_CONTRIBUTOR_PROD#211212199399",
        "aws#acc#MLE_CONTRIBUTOR_DEV#690763002009",
        "aws#acc#MLTeamAccess#484375727565",
      ]
    }
    "nutchapol.dendumrongsup@onclusive.com" = {
      first_name = "Nutchapol"
      last_name = "Dendumrongsup"
      groups = [
        "aws#acc#MLE_ADMIN_DEV#690763002009",
        "aws#acc#MLE_ADMIN_PROD#211212199399",
      ]
    }
    "ali.elhabchi@digimind.com" = {
      first_name = "ali"
      last_name = "elhabchi"
      groups = [
        "aws#acc#MLE_READER_DEV#690763002009",
        "aws#acc#MLE_READER_PROD#211212199399",
      ]
    }
    "patrick@onclusive.com" = {
      first_name = "Patrick"
      last_name = "Liang"
      groups = [
        "aws#acc#CriticalMention#310550864638",
        "aws#acc#AdministratorAccess#310550864638",
        "aws#acc#AdministratorAccess#229549174149",
        "aws#acc#CriticalMention#229549174149",
        "aws#acc#AdministratorAccess#484375727565",
        "aws#acc#AdministratorAccess#357750346051",
        "aws#acc#AdministratorAccess#211212199399",
      ]
    }
    "warren.willis-bray@onclusive.com" = {
      first_name = "Warren"
      last_name = "Willis Bray"
      groups = [
        "aws#acc#AdministratorAccess#310550864638",
        "aws#acc#AdministratorAccess#229549174149",
        "aws#acc#AdministratorAccess#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#AdministratorAccess#357750346051",
      ]
    }
    "bhushan.bende@onclusive.com" = {
      first_name = "Bhushan"
      last_name = "Bende"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#310550864638",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "Nikhith.Kudumula@Onclusive.com" = {
      first_name = "Nikhith"
      last_name = "Kudumula"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#310550864638",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "shubham.garg@onclusive.com" = {
      first_name = "Shubham"
      last_name = "Garg"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#310550864638",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "derek@onclusive.com" = {
      first_name = "Derek"
      last_name = "Gavey"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#310550864638",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "ajay.urankar@onclusive.com" = {
      first_name = "Ajay"
      last_name = "Urankar"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Neha.Deshmukh@Onclusive.com" = {
      first_name = "Neha"
      last_name = "Deshmukh"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "sayali.mane@onclusive.com" = {
      first_name = "sayali"
      last_name = "mane"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Chetna.Pilane@Onclusive.com" = {
      first_name = "Chetna"
      last_name = "Pilane"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Pratik.Pawar@Onclusive.com" = {
      first_name = "Pratik"
      last_name = "Pawar"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Mitali.Mokal@Onclusive.com" = {
      first_name = "Mitali"
      last_name = "Mokal"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "sviola@criticalmention.com" = {
      first_name = "Steven"
      last_name = "Viola"
      groups = [
        "aws#acc#CrawlerTeam#357750346051",
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "pranit.pawar@Onclusive.com" = {
      first_name = "pranit"
      last_name = "pawar"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Lohit.Shetty@Onclusive.com" = {
      first_name = "Lohit"
      last_name = "Shetty"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Aishwarya.Keshri@Onclusive.com" = {
      first_name = "Aishwarya"
      last_name = "Keshri"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Prajakta.Mhatre@Onclusive.com" = {
      first_name = "Prajakta"
      last_name = "Mhatre"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Ganesh.Inamdar@Onclusive.com" = {
      first_name = "Ganesh"
      last_name = "Inamdar"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "Vipin.Poswal@Onclusive.com" = {
      first_name = "Vipin"
      last_name = "Poswal"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "sahil.mhatre@onclusive.com" = {
      first_name = "sahil"
      last_name = "mhatre"
      groups = [
        "aws#acc#Logs_PermissionOnly_new#310550864638",
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#ReadOnlyAccess#310550864638",
      ]
    }
    "rakesh.chand@onclusive.com" = {
      first_name = "rakesh"
      last_name = "chand"
      groups = [
        "aws#acc#CrawlerTeam#357750346051",
        "aws#acc#CrawlerTeam#310550864638",
        "aws#acc#CrawlerTeam#229549174149",
      ]
    }
    "pitchai.devarajan@onclusive.com" = {
      first_name = "Pitchai"
      last_name = "Devarajan"
      groups = [
        "aws#acc#CrawlerTeam#357750346051",
        "aws#acc#CrawlerTeam#310550864638",
        "aws#acc#CrawlerTeam#229549174149",
      ]
    }
    "ramesh.babu@onclusive.com" = {
      first_name = "Ramesh"
      last_name = "Babu"
      groups = [
        "aws#acc#AdministratorAccess#229549174149",
        "aws#acc#DevOps#357750346051",
        "aws#acc#DevOps#310550864638",
        "aws#acc#DevOps#229549174149",
      ]
    }
    "Rahul.Banakar@Onclusive.com" = {
      first_name = "Rahul"
      last_name = "Banakar"
      groups = [
        "aws#acc#AdministratorAccess#229549174149",
        "aws#acc#DevOps#357750346051",
        "aws#acc#DevOps#310550864638",
        "aws#acc#DevOps#229549174149",
      ]
    }
    "genis.barrera@onclusive.com" = {
      first_name = "Genis"
      last_name = "Barrera"
      groups = [
        "aws#acc#CriticalMention#310550864638",
        "aws#acc#CriticalMention#229549174149",
      ]
    }
    "fabrizio.ervini@onclusive.com" = {
      first_name = "Fabrizio"
      last_name = "Ervini"
      groups = [
        "aws#acc#CriticalMention#310550864638",
        "aws#acc#CriticalMention#229549174149",
      ]
    }
    "alberto.garcia@onclusive.com" = {
      first_name = "Alberto"
      last_name = "Garcia"
      groups = [
        "aws#acc#ReadOnlyAccess#357750346051",
        "aws#acc#CriticalMention#310550864638",
      ]
    }
    "isaac.diaz@onclusive.com" = {
      first_name = "Isaac"
      last_name = "Diaz"
      groups = [
        "aws#acc#CriticalMention#310550864638",
        "aws#acc#CriticalMention#229549174149",
      ]
    }
    "ferran.muray@onclusive.com" = {
      first_name = "Ferran"
      last_name = "Muray"
      groups = [
        "aws#acc#CriticalMention#310550864638",
        "aws#acc#CriticalMention#229549174149",
      ]
    }
    "eric.sanchez@onclusive.com" = {
      first_name = "eric"
      last_name = "sanchez"
      groups = [
        "aws#acc#CriticalMention#310550864638",
        "aws#acc#CriticalMention#229549174149",
      ]
    }
    "david.pujol@onclusive.com" = {
      first_name = "David"
      last_name = "Pujol"
      groups = [
        "aws#acc#ReadOnlyAccess#357750346051",
        "aws#acc#CriticalMention#310550864638",
      ]
    }
    "richard.hobson@onclusive.com" = {
      first_name = "Richard"
      last_name = "Hobson"
      groups = [
        "aws#acc#MediaMonitoring#484375727565",
        "aws#acc#MediaMonitoring#357750346051",
      ]
    }
    "aanthony@criticalmention.com" = {
      first_name = "anniya"
      last_name = "anthony"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "akarmakar@criticalmention.com" = {
      first_name = "Argha"
      last_name = "Karmakar"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "harshavardhan.juturu@onclusive.com" = {
      first_name = "Harshavardhan"
      last_name = "Juturu"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
      ]
    }
    "rippon.mangaraj@onclusive.com" = {
      first_name = "Rippon"
      last_name = "Mangaraj"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "andy.moulton@onclusive.com" = {
      first_name = "andy"
      last_name = "moulton"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "vanaja.guntaka@onclusive.com" = {
      first_name = "Vanaja"
      last_name = "Guntaka"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "pjadhav@criticalmention.com" = {
      first_name = "pooja"
      last_name = "jadhav"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "akhil.mathew@onclusive.com" = {
      first_name = "Akhil"
      last_name = "Mathew"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "szambre@criticalmention.com" = {
      first_name = "Saurabh"
      last_name = "Zambre"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "ankur@onclusive.com" = {
      first_name = "Ankur"
      last_name = "Gupta"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "dchang@criticalmention.com" = {
      first_name = "Dave"
      last_name = "Chang"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "aperezalbela@onclusive.com" = {
      first_name = "Andres"
      last_name = "Pérez-Albela Hernández"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "abdelmoughit.kinani@onclusive.com" = {
      first_name = "abdelmoughit"
      last_name = "kinani"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "rudi@porter.run" = {
      first_name = "Rudi"
      last_name = "MK"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "kdougherty@criticalmention.com" = {
      first_name = "kevin"
      last_name = "dougherty"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "mayank.mittal@Onclusive.com" = {
      first_name = "Mayank"
      last_name = "Mittal"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "katia.oravcova@onclusive.com" = {
      first_name = "katia"
      last_name = "oravcova"
      groups = [
        "aws#acc#CrawlerAdmin#484375727565",
        "aws#acc#CrawlerAdmin#357750346051",
      ]
    }
    "nuruddin_shaik@persistent.com" = {
      first_name = "nuruddin"
      last_name = "shaik"
      groups = [
        "aws#acc#ReadOnlyAccess#357750346051",
        "aws#acc#Persistent_ReadOnly#484375727565",
      ]
    }
    "rahul_yadav6@persistent.com" = {
      first_name = "rahul"
      last_name = "yadav"
      groups = [
        "aws#acc#ReadOnlyAccess#357750346051",
        "aws#acc#Persistent_ReadOnly#484375727565",
      ]
    }
    "tsingh@criticalmention.com" = {
      first_name = "tej"
      last_name = "singh"
      groups = [
        "aws#acc#ReadOnlyAccess#484375727565",
        "aws#acc#Persistent_ReadOnly#484375727565",
      ]
    }
    "paul.yen@onclusive.com" = {
      first_name = "paul"
      last_name = "yen"
      groups = [
        "aws#acc#airflow-fullaccess#484375727565",
      ]
    }
    "mukesh.barnwal@onclusive.com" = {
      first_name = "Mukesh"
      last_name = "Barnwal"
      groups = [
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerTeam#357750346051",
      ]
    }
    "swathi.vimalraj@onclusive.com" = {
      first_name = "Swathi"
      last_name = "Vimalraj"
      groups = [
        "aws#acc#CrawlerAdmin#229549174149",
        "aws#acc#CrawlerTeam#357750346051",
      ]
    }
    "swathi.chova@onclusive.com" = {
      first_name = "swathi"
      last_name = "chova"
      groups = [
        "aws#acc#CrawlerTeam#357750346051",
      ]
    }
    "dhanush.isukapalli@onclusive.com" = {
      first_name = "Dhanush"
      last_name = "Isukapalli"
      groups = [
        "aws#acc#CrawlerTeam#357750346051",
      ]
    }
    "praveen.hegde@onclusive.com" = {
      first_name = "Praveen"
      last_name = "Hegde"
      groups = [
        "aws#acc#CrawlerTeam#357750346051",
      ]
    }
    "Alexandra.Zhasminova@Onclusive.com" = {
      first_name = "Alexandra"
      last_name = "Zhasminova"
      groups = [
        "aws#acc#BillingReadOnly#211212199399",
      ]
    }
  }
}
