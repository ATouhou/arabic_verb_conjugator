# encoding: UTF-8
class VerbConjugator
  VERB_OPTIONS = [:third_person_singular_masculine, :third_person_singular_feminine, :third_person_dual_masculine, :third_person_dual_feminine, :third_person_plural_masculine, :third_person_plural_feminine, :second_person_singular_masculine, :second_person_singular_feminine, :second_person_dual_masculine, :second_person_dual_feminine, :second_person_plural_masculine, :second_person_plural_feminine, :first_person_singular, :first_person_plural]
  DETACHED_PRONOUNS = %w(هُوَ هِيَ هُما هُما هُمْ هُنَّ أنْتَ أَنْتِ أنْتما أنْتما أنْتُمْ أَنْتُنََّ أَنا نَحْن)
  ENDINGS =  ["َ", "َتْ", "ا", "َتا", "ُوا", "نَ", "تَ", "تِ", "تُما", "تما", "تُم", "تُنَّ", "تُ", "نا"]

  [:third_person_singular_masculine, :third_person_singular_feminine, :third_person_dual_masculine,
   :third_person_dual_feminine, :third_person_plural_masculine, :third_person_plural_feminine,
   :second_person_singular_masculine, :second_person_singular_feminine, :second_person_dual_masculine,
   :second_person_dual_feminine, :second_person_plural_masculine, :second_person_plural_feminine,
   :first_person_singular, :first_person_plural]

  attr_accessor :verb, :person, :number, :gender, :tense, :conjugation_type

  def initialize(verb, opts = {})
    @verb = verb
    @person = opts[:person]
    @number = opts[:number]
    @gender = opts[:gender]
    @tense = opts[:tense]
    @conjugation_type = get_conjugation_type
  end

  def options_with_endings
    @options_with_endings ||= Hash[VERB_OPTIONS.zip(ENDINGS)]
  end

  def get_conjugation_type
    if gender.nil?
     "#{person}_#{number}".to_sym
    else
     "#{person}_#{number}_#{gender}".to_sym
    end
  end

  def conjugate
    @conjugation_type = get_conjugation_type
    # check if irregular - hollow or weak laam
    if verb.irregular?
      conjugate_irregular
    else
      # because all first and second person endings have a sukoon on the third radical
      if sukoon_on_third_radical?
        stem_with_sukoon_and_ending
      else
        stem_and_ending
      end
    end
  end

  # if it's a first person or second person verb or third person plural feminine
  # which all have a sukoon on the last radical
  def sukoon_on_third_radical?
    return true if conjugation_type.to_s == "third_person_plural_feminine" || conjugation_type.to_s =~ /first|second+/
    false
  end

  def conjugate_irregular
    if sukoon_on_third_radical? && !verb.hollow? # these are basically regular even for weak_laam and doubled verbs but not hollow
      stem_with_sukoon_and_ending
    elsif verb.weak_laam?
      conjugate_weak_laam
    elsif verb.hollow?
      conjugate_hollow
    elsif verb.doubled?
      conjugate_doubled
    end
  end

  def conjugate_weak_laam
    if verb.middle_vowel_fathah? || verb.third_radical_waw?
      conjugate_weak_laam_fathah_middle
    elsif verb.middle_vowel_kasrah?
      conjugate_weak_laam_kasrah_middle
    end
  end

  def conjugate_hollow
    # deal with exceptions such as naama, khaafa, etc but first deal with the two normal cases
    if sukoon_on_third_radical?
      hollow_first_second_person
    # third person
    else
      hollow_third_person
    end
  end

  def hollow_third_person
    verb.radical1 + 'ا' + verb.radical3 + options_with_endings[conjugation_type]
  end

  def hollow_first_second_person
    if verb.radical2 == 'و'
      short_vowel = 'ُ'
    elsif verb.radical2 == 'ي'
      short_vowel = 'ِ'
    end
    verb.radical1 + short_vowel + verb.radical3 + 'ْ' +  options_with_endings[conjugation_type]
  end

  def conjugate_doubled
    verb.radical1 + 'َ'+ verb.radical2 + 'ّ'+ options_with_endings[conjugation_type]
  end

  # like رمى for example
  # working on this!
  def conjugate_weak_laam_fathah_middle
    revised_form = stem_and_ending
    unless conjugation_type == :third_person_dual_masculine # this form behaves normally
      # for all third person verbs except third person plural feminine
      revised_form.slice!(4..5) # remove the characters which are omitted in the weak form
      revised_form = revised_form + last_letter_weak_laam_fathah_middle_infinitive if conjugation_type == :third_person_singular_masculine # this form has an alif maqsura tacked to end of it
    end
    revised_form
  end

  def last_letter_weak_laam_fathah_middle_infinitive
    verb.third_radical_waw? ? 'ا' : 'ى'
  end

  def conjugate_weak_laam_kasrah_middle
    revised_form = stem_and_ending
    if conjugation_type == :third_person_plural_masculine # this is the only one that acts in an unexpected way
      revised_form = imperfect_stem[0..2] + 'ُوا'
    end
    revised_form
  end

  def stem_and_ending
    imperfect_stem + options_with_endings[conjugation_type]
  end

  def stem_with_sukoon_and_ending
    imperfect_stem_with_sukoon + options_with_endings[conjugation_type]
  end

  def imperfect_stem
    verb.radical1 + 'َ'+ verb.radical2 + verb.perfect_middle_vowel + verb.radical3
  end

  def imperfect_stem_with_sukoon
    imperfect_stem + 'ْ'
  end

  def self.get_verb_options_array
    options_array = []
    VERB_OPTIONS.each do |verb_option|
      broken_up_option = verb_option.to_s.split("_").map(&:to_sym)
      option_hash = { person: ("#{broken_up_option[0]}_#{broken_up_option[1]}").to_sym, number: broken_up_option[2], tense: :perfect, gender: broken_up_option[3] }
      options_array << option_hash
    end
    options_array
  end

end