extends Node

@export var texts: Array[String] = [
	"Allo papa ? Je suis completement cuite a Preverenge. J'ai du dormir chez Julie et il me manque une chaussure. Tu peux venir me chercher stp ?",
	"Allo oui c'est Cedric l'ami de Victor ? Ecoutez je crois que votre fils ne va pas tres bien, il ne repond plus. Je crois que les joints dans la flute c'etait la goutte d'eau... Vous pouvez venir le chercher ?",
]

var texts_copy: Array[String] = [
	"Allo papa ? Je suis completement cuite a Preverenge. J'ai du dormir chez Julie et il me manque une chaussure. Tu peux venir me chercher stp ?",
	"Allo oui c'est Cedric l'ami de Victor ? Ecoutez je crois que votre fils ne va pas tres bien, il ne repond plus. Je crois que les joints dans la flute c'etait la goutte d'eau... Vous pouvez venir le chercher ?",
]

func get_random_text() -> String:
	if texts.size() == 0:
		texts = texts_copy
	var random_text: String = texts[randi_range(0, texts.size() - 1)]
	texts.erase(random_text)
	return random_text
