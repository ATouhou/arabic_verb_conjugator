# encoding: UTF-8
require_relative 'arabic_letters'

class ArabicVerb
  include ArabicLetters
  attr_accessor :radical1, :radical2, :radical3, :form, :perfect_middle_vowel, :imperfect_middle_vowel

  def initialize(radical1, radical2, radical3, form, opts = {})
    @radical1 = radical1
    @radical2 = radical2
    @radical3 = radical3
    @form = form
    @perfect_middle_vowel = opts[:perfect_middle_vowel]
    @imperfect_middle_vowel = opts[:imperfect_middle_vowel]
  end

  def irregular?
    return true if weak_laam? || hollow? || doubled?
    false
  end

  def weak_laam?
    return true if irregular_letters.include?(radical3)
    false
  end

  def hollow?
    return true if irregular_letters.include?(radical2)
    false
  end

  def middle_vowel_fathah?
    return true if perfect_middle_vowel == fathah
    false
  end

  def middle_vowel_kasrah?
    return true if perfect_middle_vowel == kasrah
    false
  end

  def third_radical_waw?
    return true if radical3 == 'و'
    false
  end

  def doubled?
    return true if radical2 == radical3
    false
  end

end