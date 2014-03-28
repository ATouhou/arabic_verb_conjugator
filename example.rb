# encoding: UTF-8
require_relative 'arabic_verb'
require_relative 'verb_conjugator'

# Note only perfect conjugation has been implemented. Other tenses will be added soon.

verb = ArabicVerb.new("د", "ر", "س", 1, perfect_middle_vowel: "َ", imperfect_middle_vowel: "ُ")

conjugator = VerbConjugator.new(verb, :tense => :perfect, :person => :first_person, :number => :singular)

puts conjugator.conjugate

conjugator.number = :plural
conjugator.gender = :masculine
conjugator.person = :second_person

puts conjugator.conjugate





