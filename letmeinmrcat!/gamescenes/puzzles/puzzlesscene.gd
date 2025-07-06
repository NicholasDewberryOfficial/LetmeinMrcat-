extends Node2D

var state: int = 0
#1 = password 2= wall 3= cieling and so forth

func _ready() -> void:
	assignvalues()
	pass
	
func assignvalues():
	if(gv.wallsolved == 1):
		$reguarLook/wallengraving.text = "Solved!"
		$reguarLook/wallengraving.disabled = true
	if(gv.ceilingsolved == 1):
		$reguarLook/ceiling.text = "Solved!"
		$reguarLook/ceiling.disabled = true
	if(gv.shadowsolved ==1 ):
		$reguarLook/shadowbehindpillar.text = "Solved!"
		$reguarLook/shadowbehindpillar.disabled = true
	if(gv.papersolved ==1):
		$reguarLook/paperonground.text = "Solved!"
		$reguarLook/paperonground.disabled = true
	if(gv.closetsolved ==1):
		$reguarLook/closetinside.text = "Solved!"
		$reguarLook/closetinside.disabled = true
	
	
func _process(delta: float) -> void:
	assignvalues()
	controlPanels()



func controlPanels():
	if(state == 0):
		$reguarLook.show() 
		$detailedlook.hide()
		$detailedlook/choiceholder/op1.show()
		$detailedlook/choiceholder/op2.show()
		$detailedlook/choiceholder/op3.show()
		$detailedlook/choiceholder/customopt.show()
	else:
		$reguarLook.hide()
		$detailedlook.show()

func hidem():
	$detailedlook/choiceholder/op1.hide()
	$detailedlook/choiceholder/op2.hide()
	$detailedlook/choiceholder/op3.hide()
	$detailedlook/choiceholder/customopt.hide()

func _on_passwordplaque_pressed() -> void:
	state = 1
	$detailedlook/custompuzzletext.text = "The password plaque is extremely low to the ground, requiring you to bend down onto your knees to properly read it. 
	\n You can see an uncovered paragraph and a deep gray-blue cloud of ink underneath it. You read:  
	\n 'Ye brave hero. Speak the password, and be rewarded. I guess. The password is one word, with no spaces. Case matters.'	
	\n"
	
	$detailedlook/choiceholder/op1.hide()
	$detailedlook/choiceholder/op2.hide()
	$detailedlook/choiceholder/op3.hide()
	$detailedlook/choiceholder/customopt.hide()
	
	if(gv.wallsolved ==1):
		$detailedlook/custompuzzletext.text += "\n The first character is: *"
	if(gv.ceilingsolved == 1):
		$detailedlook/custompuzzletext.text += "\n The second character is: b"
	if(gv.shadowsolved ==1):
		$detailedlook/custompuzzletext.text += "\n The third character is 9"
	if(gv.papersolved ==1):
		$detailedlook/custompuzzletext.text += "\n Once you get all of the characters - reverse them. The password is backwards."
	if(gv.closetsolved == 1):
		$detailedlook/custompuzzletext.text += "\n The fourth character is G"
	
	


func _on_wallengraving_pressed() -> void:
	$detailedlook/custompuzzletext.text = "The engravings on the wall are numerous and strange. You see some crude drawings, a lot of graffiti, and a lot more crude insults.
	\n It reminds you of a bathroom stall in a middle school bathroom - or a dirty dive bar.
	\n However, you also see a strange indentation - far too subtle to read at range.
	\n As you get closer, it starts to glow. Soon enough, a question is posed to you.
	[b]'What gets larger the more you remove from it?' [/b]
	"
	state = 2
	hidem()
	$detailedlook/choiceholder/customopt.show()


func _on_ceiling_pressed() -> void:
	$detailedlook/custompuzzletext.text = "The ceiling has a question painted on top.
	\n 'A lily pad doubles in size every second. 
	After 1 minute, it fills the pond. 
	[b] How long would it take to fill one fourth of the pond? [/b] Answer in a fraction of a minute.
	Hint: Use 60 as the denominator, and simplify.
	Hint: I'm asking how to go from start to 1/4th full.' 
	"
	state = 3
	hidem()
	$detailedlook/choiceholder/customopt.show()

func _on_shadowbehindpillar_pressed() -> void:
	$detailedlook/custompuzzletext.text = "The shadow behind the pillar takes on a humanoid form as you approach - and then disperses into the shadow behind you. You hear a laugh from the mist.
	'Dear Traveler - I shall give you a riddle within a riddle. Solve it, and you shall be rewarded.' 
	He gives a throaty chuckle before telling his story:
	'George Washington is visiting a bar after a hard day's work. 

He buys, and drinks a lot. Once it's time to pay his tab - disaster strikes! He left his wallet at home.

The bartender laughs, and puts his hand under the table. His aged, chubby yet brotherly face is one of pure warm mirth. He will forgive the tab if George can answer a small riddle.

'I am grabbing something below the table. It's full of holes, yet still holds water. What is it?'	
	"
	state = 4
	hidem()
	$detailedlook/choiceholder/customopt.show()
	
	pass # Replace with function body.


func _on_paperonground_pressed() -> void:
	$detailedlook/custompuzzletext.text = "The paper on the ground is of a strange reciept. 
	The reciept is an itemized bill of A LOT of different foods. It's strange, because you see food from dozens of cultures and countries all on one bill.
	There's no way all of these different cuisines can be done at a singular resturant - and there's even less chance that it can be done well.
	To add to your confusion, it comes from a 'cheesecake factory.' Why is a dessert shop making italian flatbread and avacado eggrolls. 
	The ink on the reciept swirls, and a purple glow highlights a riddle for you.
	
	[b] I'm a three-digit number. My tens digit is three times as much as my hundreds digit, and my ones digit is half of my tens digit. If you reverse my digits, you'll get a number 198 greater than me. What number am I? [/b]
	"
	state = 5
	hidem()
	$detailedlook/choiceholder/customopt.show()
	pass # Replace with function body.


func _on_closetinside_pressed() -> void:
	$detailedlook/custompuzzletext.text = "As you approach the closet to the side, you see a very well dressed man in a suit and lincoln hat playing Dota 2 on a computer. 
	You clear your throat to grab his attention, and he panics and covers his monitor with his hands. 'Hey man, haven't you heard of knocking.' He begins nodding. 'Yeah. YEAH.'
	After a moment of starting at you, he calms down and gives you a riddle.
	
	[b] You see me once in June, twice in November, and not at all in May. What am I? [/b]
	
	(He gives you a thousand years stare as you prepare to answer.)
	'And uh. Here's a hint. 
	1. You can answer in the form of a single character, or in a short sentence.
	"
	state = 6
	hidem()
	$detailedlook/choiceholder/customopt.show()
	pass # Replace with function body.


func _on_help_pressed() -> void:
	pass # Replace with function body.


func _on_leave_pressed() -> void:
	get_tree().change_scene_to_file("res://gamescenes/mainlobby.tscn")
	pass # Replace with function body.


func _on_confirmcustom_pressed() -> void:
	match state:
		0:
			pass
		1:
			pass
		2:
			runwalllogic()
		3:
			runceilinglogic()
		4:
			runshadowlogic()
		5:
			runpaperlogic()
		6:
			runclosetlogic()
	pass # Replace with function body.
	state=0
	$detailedlook/choiceholder/customopt.text = ""

func runwalllogic():
	if ($detailedlook/choiceholder/customopt.text == "hole" or $detailedlook/choiceholder/customopt.text == "a hole"):
		gv.wallsolved = 1
		print("it's correct")
	print($detailedlook/choiceholder/customopt.text)
	
func runceilinglogic():
	if ($detailedlook/choiceholder/customopt.text == "29/30"):
		gv.ceilingsolved = 1
		print("it's correct")
	print($detailedlook/choiceholder/customopt.text)

func runshadowlogic():
	if($detailedlook/choiceholder/customopt.text == "sponge" or $detailedlook/choiceholder/customopt.text == "a sponge"):
		gv.shadowsolved =1 
		
	
func runpaperlogic():
	if($detailedlook/choiceholder/customopt.text == "286"):
		gv.papersolved = 1
	pass

func runclosetlogic():
	if($detailedlook/choiceholder/customopt.text == "E" or $detailedlook/choiceholder/customopt.text == "The letter E" or $detailedlook/choiceholder/customopt.text == "e" or $detailedlook/choiceholder/customopt.text == "The letter e"):
		gv.closetsolved = 1
	print($detailedlook/choiceholder/customopt.text)
	
