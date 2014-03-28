# Arabic Verb Conjugator

## Description

A simple tool that allows you to create Arabic verbs and conjugate them. This project is a work in progress and currently
conjugation options are limited to only form I verbs in the perfect tense. Eventually, I hope to add all forms and tenses.

## Usage

**Create a New Verb**

The first, second, and third arguments are the three root letters respectively, the fourth argument is
the verb form (although only form 1 is currently supported), and
the optional arguments refer to the middle vowel for the perfect and
imperfect tenses respectively as these are not predictable.

*Note, that the order of the arguments appears to be incorrect in markdown I'm not sure how to fix that. Also, the fathah and dammah
 don't show up very well so to clarify:*

argument 1: 'د'

argument 2: 'ر'

argument 3: 'س'

argument 4: 1

argument 5: 'َ' known as fathah

arugment 6: 'ُ' known as dammah

verb = ArabicVerb.new("د", "ر", "س", 1, perfect_middle_vowel: "َ", imperfect_middle_vowel: "ُ")

**Create a Conjugator Object**

Here, you are specifying all the details about the specific conjugation you want

    conjugator = VerbConjugator.new(verb, :tense => :perfect, :person => :first_person, :number => :singular)

**Conjugate the Verb**

    puts conjugator.conjugate

**Change the conjugation options**

Here, you're changing the conjuation options and printing the new result

    conjugator.number = :plural
    conjugator.gender = :masculine
    conjugator.person = :second_person

    puts conjugator.conjugate
