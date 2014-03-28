# Arabic Verb Conjugator

## Description

A simple tool that allows you to create Arabic verbs and conjugate them. This project is a work in progress and currently
conjugation options are limited to only form I verbs in the perfect tense. Eventually, I hope to add all forms and tenses.

## Usage

**Create a New Verb**

The first argument is the verb form (although only form 1 is currently supported), the second, third, and fourth arguments
are the three root letters and the optional arguments refer to the middle vowel for the perfect and imperfect tenses respectively
 as these are not predictable.

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
