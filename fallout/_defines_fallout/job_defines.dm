/// SEE fallout_jobs.dm FOR JOB DATUMS ///

//Faction and job category defines, since it is the same value for all intents and purposes
#define WASTELAND "Wasteland"
#define TOWN "Maravillo"
#define BROTHERHOOD "Brotherhood of Steel"
#define ENCLAVE "Enclave"
#define RAIDERs "Raiders"
#define TALON_COMPANY "Talon Company"
#define REGULATORS "Regulators"
#define NCR "NCR"
#define LEGION "Legion"

//Job title defines
#define WASTELANDER "Wastelander"

//Town
#define TOWN_CITIZEN "Settler"
#define TOWN_GUARD "Peacekeeper"
#define TOWN_MERCHANT "Merchant"
#define TOWN_LEADER "Mayor"

//Brotherhood
#define BOS_KNIGHT "Brotherhood Knight"
#define BOS_SCRIBE "Brotherhood Scribe"
#define BOS_PALADIN "Brotherhood Paladin"
#define BOS_LEADER "Brotherhood Elder"

//Enclave
#define ENCLAVE_SOLDIER "Enclave Soldier"
#define ENCLAVE_SCIENTIST "Enclave Scientist"
#define ENCLAVE_CAPTAIN "Enclave Captain"
#define ENCLAVE_LEADER "Enclave General"

//Raider
#define RAIDER "Raider"
#define RAIDER_LEADER "Raider Boss"

//Talon Company
#define TALON "Talon Company Mercenary"
#define TALON_LEADER "Talon Company Commander"

//Regulators
#define REGULATOR "Regulator"
#define REGULATOR_LEADER "Chief Regulator"

//NCR
#define NCR_PRIVATE "NCR Private"
#define NCR_HEAVY "NCR Heavy Trooper"
#define NCR_MEDIC "NCR Field Medic"
#define NCR_ENGINEER "NCR Field Engineer"
#define NCR_CAPTAIN "NCR Captain"
#define NCR_LEADER "NCR Major"
#define NCR_SUPPORT "NCR Operations Staff"

//Legion
#define LEGION_RECRUIT "Recruit Legionary"
#define LEGION_PRIME "Prime Legionary"
#define LEGION_VETERAN "Veteran Legionary"
#define LEGION_DECANUS "Recruit Decanus"
#define LEGION_DECANUS_PRIME "Prime Decanus"
#define LEGION_DECANUS_VETERAN "Veteran Decanus"
#define LEGION_VEXILLARIUS "Legion Vexillarius"
#define LEGION_LEADER "Legion Centurion"
#define LEGION_SUPPORT "Legion Medicus"

GLOBAL_LIST_INIT(jobs_ncr, list(NCR_PRIVATE, NCR_HEAVY, NCR_MEDIC, NCR_ENGINEER, NCR_CAPTAIN, NCR_LEADER, NCR_SUPPORT))
GLOBAL_LIST_INIT(jobs_legion, list(LEGION_RECRUIT, LEGION_PRIME, LEGION_VETERAN, \
LEGION_DECANUS, LEGION_DECANUS_PRIME, LEGION_DECANUS_VETERAN, LEGION_VEXILLARIUS, LEGION_LEADER, LEGION_SUPPORT))
