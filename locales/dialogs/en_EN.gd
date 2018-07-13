extends Node

#dictionary values:
#id/npc_id:	combination of these two, makes an unique id (ie: [03]and [frontiersman_steeltrap] is the 3rd dialogue line for npc "frontiersman_steeltrap"
#
#Q:		question (also text selecion)
#A:		NPC answer if this question is picked
var dialogue = [
#		frontiersman_steeltrap lines


     {
     "id"         : 0,#internal ID for frontiersman_steeltrap dialogues
     "npc"        : "frontiersman_steeltrap",#npc who says this line
     "q"          : "Ugh. My head...",#player dialogue
     "a"          : ["Huh? Holy Horseshoes! You're not Inspector Klein!"],#npc answer (multiple lines)
     "cinematic"  : [
          {"speaker":"frontiersman_steeltrap","text":"Who are ya? Some kinda Hamster Avenger?"}],

    
     "enabled"    : true,#if the line is enabled from the beginning of a new game
     "activate"   : [1,2,3,],#picking this line will enable other lines (relative to current npc) #Klein, hamster, costume
     "disable"    : null,#other lines to be disable other lines (the picked one is always disabled)
     }
     ,{
     "id"         : 1,
     "npc"        : "frontiersman_steeltrap",
     "q"          : ["Who's Inspector Klein?"],
     "a"          : ["Ha! Ya hear that, Paul? Rodent girl here doesn't know about Klein."],
     "cinematic"  : [
          {"speaker":"frontiersman_steeltrap","text":"He's the worst! A pox on the face of wholesome family entertainment!"},
          {"speaker":"frontiersman_steeltrap","text":"Always tryin' to shut me down. It's a disgrace!"},
          {"speaker":"frontiersman_steeltrap","text":"Sure, I may have had to bend a few little health and safety laws to make ends meet."},
          {"speaker":"player","text":"A few?"},  
          {"speaker":"frontiersman_steeltrap","text":"Or a lot.  Makes no difference.  Any way..."},  
          {"speaker":"frontiersman_steeltrap","text":"Do you know what's wrong with kids these days?"},          
		  {"speaker":"player","text":"Well..."},  
          {"speaker":"frontiersman_steeltrap","text":"They're always too busy playin' with their gatherin' magic cards an' pok-e-mans"},
          {"speaker":"frontiersman_steeltrap","text":"an' YouPages. They just don’t want to get up off their lazy butts and go"},
          {"speaker":"frontiersman_steeltrap","text":"see some REAL entertainment. It’s not like anyone’s died from fallin' off"},
          {"speaker":"frontiersman_steeltrap","text":"the narrow viewin' platform above the Gopher Saloon and Terrarium."},  
          {"speaker":"frontiersman_steeltrap","text":"Why should I have to pay forty bucks to put up guard rails when I can put in a new"},  
          {"speaker":"frontiersman_steeltrap","text":"attraction, or get ta utilizin' the latest and greatest in advertisin' technology?"},
          {"speaker":"player","text":"..."},
          {"speaker":"frontiersman_steeltrap","text":"Anyway, ya better hope Klein doesn’t show his ugly mug for a while,"},
          {"speaker":"frontiersman_steeltrap","text":"'cause I only got enough room in this trap for one interloper."}],  

     "enabled"    : false,
     "disable"    : [2,3],
	"activate"	  : [4,6],#trap, safety
     }
     ,{
     "id"         : 2,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "I'm not a hamster themed hero! I'm...",
     "a"          : ["A mouse, then?"],
     "cinematic"  : [
          {"speaker":"frontiersman_steeltrap","text":"Well, Ms. Mouse, you wandered right into my trap!"},
          {"speaker":"frontiersman_steeltrap","text":"And I didn't even set it for ya!"},
          {"speaker":"frontiersman_steeltrap","text":"Ha!"}],
    
     "enabled"    : false,
     "disable"    : [1,3],
	"activate"   : 4,#trap
	} 
     ,{
     "id"         : 3,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "I'm selling these fine superhero costumes.",
     "a"          : ["Ah, a salesperson. Excellent!"],
     "cinematic"  : [
          {"speaker":"frontiersman_steeltrap","text":"There's nothing worse than a door to door salesperson."},
          {"speaker":"frontiersman_steeltrap","text":"Except for a safety inspector, of course."},
          {"speaker":"frontiersman_steeltrap","text":"But since I can't get my nemesis, Inspector Klein,"},
          {"speaker":"frontiersman_steeltrap","text":"you'll be the perfect test subject for my steel trap."},
          {"speaker":"player","text":"Steel trap?"},
          {"speaker":"frontiersman_steeltrap","text":" What did ya expect? It's a room full of steel an' a big robot!"},   
          {"speaker":"frontiersman_steeltrap","text":"I'd like to see you come up with a better name."}],   
     "enabled"    : false,
     "disable"    : [1,2],
	"activate"   : [4,5],#trap, robot
	} 
	     ,{
     "id"         : 4,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "I’ve been locked in supply closets before.",
     "a"          : ["But I betcha've never been locked in a supply closet with a state of the art"],
     "cinematic"  : [
          {"speaker":"frontiersman_steeltrap","text":"MECHA PAUL Bunyan!"},
          {"speaker":"frontiersman_steeltrap","text":"I figured I might as well let Paul here do the honors of finishing"},
          {"speaker":"frontiersman_steeltrap","text":"Klein off, on account of the good inspector deciding to close down"},
          {"speaker":"frontiersman_steeltrap","text":"Paul Bunyan’s Authentic Clear Cuttin' and Log Splittin' Show"},
          {"speaker":"frontiersman_steeltrap","text":"because of a few splinters."},
          {"speaker":"player","text":"A tree branch is not a splinter."},
          {"speaker":"frontiersman_steeltrap","text":"Details."}],   
     "enabled"    : false,
     "disable"    : [1,2,3],
	"activate"   : 5, #robot
	} 
	     ,{
     "id"         : 5,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "That's an interesting robot.",
     "a"          : ["Paul Bunyan here is only the latest and greatest in robot lumberjack technology."],
     "cinematic"  : [
          {"speaker":"frontiersman_steeltrap","text":"Cost me a fortune to build, and I had to evict a few termites"},
          {"speaker":"frontiersman_steeltrap","text":"from the old ghost town to get enough wood to finish the"},
          {"speaker":"frontiersman_steeltrap","text":"Loopy Llama Log Flume, but it was worth it."},
          {"speaker":"frontiersman_steeltrap","text":"First, he's gonna chop you into chipmunk chunks."},
          {"speaker":"frontiersman_steeltrap","text":"Then he'll move onto bigger prey when I trap that"},
          {"speaker":"frontiersman_steeltrap","text":"no good, interfering safety inspector."}],
     "enabled"    : false,
     "disable"    : [1,2,3,4],
	"activate"   : [6,7], #safety, trick villain
		 }
	     ,{
     "id"         : 6,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "Your park seems a bit, uh, dangerous.",
     "a"          : ["So?"],
     "cinematic"  : [
          {"speaker":"player","text":"''So?'' Your park is a deathtrap! There’s a log flume running through an"},
          {"speaker":"player","text":"active saw mill, the hall of giant spherical objects is dangerously"},
          {"speaker":"player","text":"unsecured and full of ramps, and the gophers are able to freely leave"},
          {"speaker":"player","text":"their enclosure to rob banks and hold people for ransom!"},
          {"speaker":"player","text":"Are you trying to kill your customers?"},
          {"speaker":"frontiersman_steeltrap","text":"If they can’t leave, they can’t spend their money elsewhere."},
          {"speaker":"frontiersman_steeltrap","text":"It’s just good business sense little lady. The only hard part"},
          {"speaker":"frontiersman_steeltrap","text":"is getting a steady supply of new customers. But I’ve got"},
          {"speaker":"frontiersman_steeltrap","text":"some new ads going that are workin' just fine on that front."}],
     "enabled"    : false,
     "disable"    : [1,2,3,4,5],
	 "activate"   : [7,8], #trick villain, death
		  }
			     ,{
     "id"         : 7,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "You're thrifty. I get that.",
     "cinematic"  : [
          {"speaker":"player","text":"You want to save all the money you can by getting great deals. I do too."},
          {"speaker":"player","text":"Like this morning, I was just on wePay looking at an auction for a dozen"},
          {"speaker":"player","text":"claw machines. Last I looked, it had no bids, and it had a minimum of "},
          {"speaker":"player","text":"only a dollar. It's a shame I can't get to a computer right now, as the "},
          {"speaker":"player","text":"auction is going to end in about thirty minutes."},
          {"speaker":"frontiersman_steeltrap","text":"Paul, you guard the prisoner."}, 
          {"speaker":"frontiersman_steeltrap","text":"I have some urgent matters I need to attend to."}],
     "enabled"    : false,
     "disable"    : [1,2,3,4,5,6,7],
	"activate"   : 41, #go to steeltrap_emptymonitor room
		 }
	     ,{
     "id"         : 7, #death path - the choice has to be crazy enough to choose that it is obvious it leads to death
     "npc"        : "frontiersman_steeltrap",
     "q"          : "You're under arrest.\nI know you're behind\nthose hypnotic ads.",
     "a"          : ["Don’t be stupid girl. Everyone knows hypnotism is bupkis."],
     "cinematic"  : [
          {"speaker":"frontiersman_steeltrap","text":"All my ads do is plant subliminal messages in folk’s subconscious,"},
          {"speaker":"frontiersman_steeltrap","text":"makin them drop what they’re doin an' bring their life savings"},
          {"speaker":"frontiersman_steeltrap","text":"down to Frontier World and Action Park for some good"},
          {"speaker":"frontiersman_steeltrap","text":"family entertainment."},
          {"speaker":"player","text":"Sounds like hypnosis to me. And unreliable hypnosis to boot."},
          {"speaker":"frontiersman_steeltrap","text":"Sure, it can take a few viewings for 'em to work, but the"},
          {"speaker":"frontiersman_steeltrap","text":"billboards work every time, thanks to the little radio transmitters"},
          {"speaker":"frontiersman_steeltrap","text":"I stuck in ‘em. Once I launch a satellite over the U S of A,"},
          {"speaker":"frontiersman_steeltrap","text":"I’ll get people comin' in from all over the country. Heck, "},
          {"speaker":"frontiersman_steeltrap","text":"I’ll probably get even get some Canadians."},
          {"speaker":"player","text":"That's insane!"},
          {"speaker":"frontiersman_steeltrap","text":"Maybe, but it's certainly profitable!"},
          {"speaker":"frontiersman_steeltrap","text":"Once I get enough money, an' dispose of that annoyin' inspector,"},
          {"speaker":"frontiersman_steeltrap","text":"I’ll finally be able to open up that miniature golf course"},
          {"speaker":"frontiersman_steeltrap","text":"my pa always talked about buildin'."},
          {"speaker":"player","text":"You won't get away with this!"},
          {"speaker":"frontiersman_steeltrap","text":"What? Oh, well, darn. Looks like ya got me to tell ya my plans."},
          {"speaker":"frontiersman_steeltrap","text":"Can’t risk lettin ya escape now."},
          {"speaker":"frontiersman_steeltrap","text":"Paul, let 'er have it."}],

     "enabled"    : false,
     "disable"    : [1,2,3,4],
	"activate"   : 40, #go to temporary bad ending
			} 	 	
	     ,{
     "id"         : 40,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "room tempending1",#	quick and dirty room change code is in dialogue_base.gd
    
     "enabled"    : false,
	}
 	     ,{
     "id"         : 41,
     "npc"        : "frontiersman_steeltrap",
     "q"          : "room pb_in_chair",#	can look around freely, but still in the chair
    
     "enabled"    : false,
	} 


#pb_in_chair lines

     ,{
     "id"         : 0,#internal ID for inchair_steeltrap dialogues
     "npc"        : "pb_in_chair",#npc who says this line
     "q"          : "Hello Paul Bunyan.",#player dialogue
     "a"          : "...",#npc dialogue

    
     "enabled"    : true,#if the line is enabled from the beginning of a new game
     "activate"   : [2,4],#picking this line will enable other lines (relative to current npc) #don't talk
     "disable"    : [1],#other lines to be disable other lines (the picked one is always disabled)
     }
     ,{
     "id"         : 1,
     "npc"        : "pb_in_chair",
     "q"          : ["How are you doing, Paul?"],
     "a"          : "...",

     "enabled"    : true,
     "disable"    : [0],
	"activate"	  : [2,4],#don't talk, insult, apologize
     }
     ,{
     "id"         : 2,
     "npc"        : "pb_in_chair",
     "q"          : ["You don't talk much do you?"],
     "a"          : "...",

     "enabled"    : false,
     "disable"    : null,
	"activate"	  : [3,5,4],#insult, apologize
     }		     
     ,{
     "id"         : 3,
     "npc"        : "pb_in_chair",
     "q"          : ["You're not so great."],
     "cinematic"  : [
         {"speaker":"player","text":"You haven't done much besides stand there."},
         {"speaker":"player","text":"The real Paul Bunyan would be ashamed."},
         {"speaker":"pb_in_chair","text":"Grr..."},
         {"speaker":"player","text":"Uh oh..."}],

     "enabled"    : false,
     "disable"    : null,
	"activate"	  : [43],#go to the temp ending 2 for now
     }	
     ,{
     "id"         : 4,
     "npc"        : "pb_in_chair",
     "q"          : ["Well, I see you don't want to talk."],
     "cinematic"  : [
         {"speaker":"player","text":"I'll leave you alone now. Sorry I disturbed you."},
         {"speaker":"pb_in_chair","text":"..."}],


     "enabled"    : false,
     "disable"    : null,
	"activate"	  : [42],#go back to talk on the chair
     }	
     ,{
     "id"         : 5,
     "npc"        : "pb_in_chair",
     "q"          : ["Home, home on the range."],
     "cinematic"  : [
         {"speaker":"pb_in_chair","text":"Where the deer and the antelope play"}],
 
     "enabled"    : false,
     "disable"    : null,
	"activate"	  : [3,6,4],#go to the steeltrap room for now
     }	
     ,{
     "id"         : 6,
     "npc"        : "pb_in_chair",
     "q"          : ["Where seldom is heard a discouraging word."],
     "cinematic"  : [
         {"speaker":"pb_in_chair","text":"And the skies are not cloudy all day."}],
 
     "enabled"    : false,
     "disable"    : null,
	"activate"	  : [3,4],#go to the steeltrap room for now
     }	

#Scene changes

	     ,{
     "id"         : 42,
     "npc"        : "pb_in_chair",
     "q"          : "room pb_in_chair",#	quick and dirty room change code is in dialogue_base.gd
    
     "enabled"    : false,
	} 
		     ,{
     "id"         : 43,
     "npc"        : "pb_in_chair",
     "q"          : "room tempending2",#	quick and dirty room change code is in dialogue_base.gd
    
     "enabled"    : false,
	}

#pb_final lines

     ,{
     "id"         : 0,#internal ID for inchair_steeltrap dialogues
     "npc"        : "pb_final",#npc who says this line
     "q"          : "Can you help me up please?",#player dialogue
     "a"          : "...",#npc dialogue

    
     "enabled"    : true,#if the line is enabled from the beginning of a new game
     "activate"   : [1],#picking this line will enable other lines (relative to current npc) #don't talk
     "disable"    : [0],#other lines to be disable other lines (the picked one is always disabled)
     }
     ,{
     "id"         : 1,
     "npc"        : "pb_final",
     "q"          : ["Fine. Be that way."],
     "a"          : "...",

     "enabled"    : false,
     "disable"    : [0],
	"activate"	  : [2],#insult
     }		     
     ,{
     "id"         : 2,
     "npc"        : "pb_final",
     "q"          : ["You're not so great."],
     "cinematic"  : [
         {"speaker":"player","text":"You haven't done much besides stand there."},
         {"speaker":"player","text":"The real Paul Bunyan would be ashamed."},
         {"speaker":"pb_final","text":"Grr..."},
         {"speaker":"player","text":"Ah ha! You freed me!"},
         {"speaker":"pb_final","text":"Crap. The Frontiersman will demote me for this! I'm outta here!"}],

     "enabled"    : true,
     "disable"    : null,
	"activate"	  : [44],#go to the temp ending 2 for now
     }	
	
#Scene change

    ,{
     "id"         : 44,
     "npc"        : "pb_final",
     "q"          : "room steeltrap",#	quick and dirty room change code is in dialogue_base.gd
    
     "enabled"    : false,
	}
]


func newgame():
	get_node().dialogue = dialogue
	queue_free()

func refreshdb():#refresh the database with this translation
	var database = get_node("/root/database")
	for i in range(dialogue.size()):
		database.dialogue[i]["q"] = dialogue[i]["q"]
		database.dialogue[i]["a"] = dialogue[i]["a"]
		database.dialogue[i]["newscene"] = dialogue[i]["newscene"]
	queue_free()
