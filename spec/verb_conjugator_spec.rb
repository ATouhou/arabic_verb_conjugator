# encoding: UTF-8
require_relative '../verb_conjugator'
require_relative '../arabic_verb'

describe VerbConjugator do

  before :each do
    @verb = ArabicVerb.new("د", "ر", "س", 1, perfect_middle_vowel: "َ", imperfect_middle_vowel: "ُ")
    @weak_laam_verb = ArabicVerb.new('ر', 'م', 'ي', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ِ')
    @weak_laam_verb1 = ArabicVerb.new('ل', 'ق', 'ي', 1, perfect_middle_vowel: 'ِ', imperfect_middle_vowel: 'ِ')
    @weak_laam_verb2 = ArabicVerb.new('د', 'ع', 'و', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ُ')
    @doubled_verb = ArabicVerb.new('د', 'ل', 'ل', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ُ')
    @hollow_verb_waw = ArabicVerb.new('ق', 'و', 'ل', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ُ')
    @hollow_verb_yaa = ArabicVerb.new('ع', 'ي', 'ش', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ُ')
  end

  describe "conjugate" do
    context "first person, singular, imperfect" do
      it "should conjugate the verb according to the context" do
        verb_conjugator = VerbConjugator.new(@verb, :tense => :perfect, :person => :first_person, :number => :singular)
        verb_conjugator.conjugate.should == "دَرَسْتُ"
      end
    end

    context "third person, singular, masculine, imperfect" do
      it "should conjugate the verb according to the context" do
        verb_conjugator = VerbConjugator.new(@verb, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :masculine)
        verb_conjugator.conjugate.should == 'دَرَسَ'
      end
    end

    context "third person, plural, masculine, imperfect" do
      it "should conjugate the verb according to the context" do
        verb_conjugator = VerbConjugator.new(@verb, :tense => :perfect, :person => :third_person, :number => :plural, :gender => :masculine)
        verb_conjugator.conjugate.should == 'دَرَسُوا'
      end
    end

    context "third person, dual, feminine, imperfect" do
      it "should conjugate the verb according to the context" do
        verb_conjugator = VerbConjugator.new(@verb, :tense => :perfect, :person => :third_person, :number => :dual, :gender => :feminine)
        verb_conjugator.conjugate.should == 'دَرَسَتا'
      end
    end

    context "second person, singular, feminine, imperfect" do
      it "should conjugate the verb according to the context" do
        verb_conjugator = VerbConjugator.new(@verb, :tense => :perfect, :person => :second_person, :number => :singular, :gender => :feminine)
        verb_conjugator.conjugate.should == "دَرَسْتِ"
      end
    end

    describe "irregular verbs" do
      context "a weak laam verb which has a sukoon on the third radical" do
        it "should conjugate the verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb, :tense => :perfect, :person => :first_person, :number => :singular)
          verb_conjugator.conjugate.should == 'رَمَيْتُ'
        end

        context "a weak laam verb with a kasrah as the middle vowel" do
          it "should conjugate the verb" do
            verb_conjugator = VerbConjugator.new(@weak_laam_verb1, :tense => :perfect, :person => :first_person, :number => :singular)
            verb_conjugator.conjugate.should == 'لَقِيْتُ'
          end

          it "should conjugate the verb" do
            verb_conjugator = VerbConjugator.new(@weak_laam_verb1, :tense => :perfect, :person => :second_person, :number => :plural, :gender => :feminine)
            verb_conjugator.conjugate.should == 'لَقِيْتُنَّ'
          end
        end
      end

      context "a weak laam verb which does not have a sukoon on the third radical and the third radical is waw" do
        it "should conjugate the third person plural verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb2, :tense => :perfect, :person => :third_person, :number => :plural, :gender => :masculine)
          verb_conjugator.conjugate_weak_laam.should == 'دَعَوا'
        end

        it "should conjugate the third person singular feminine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb2, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :feminine)
          verb_conjugator.conjugate.should == 'دَعَتْ'
        end

        it "should conjugate the third person singular masculine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb2, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :masculine)
          verb_conjugator.conjugate.should == 'دَعَا'
        end
      end

      context "a weak laam verb which does not have a sukoon on the third radical with middle vowel fathah" do
        it "should conjugate the third person plural verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb, :tense => :perfect, :person => :third_person, :number => :plural, :gender => :masculine)
          verb_conjugator.conjugate_weak_laam.should == 'رَمَوا'
        end

        it "should conjugate the third person dual feminine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb, :tense => :perfect, :person => :third_person, :number => :dual, :gender => :feminine)
          verb_conjugator.conjugate.should == 'رَمَتا'
        end

        it "should conjugate the third person dual masculine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb, :tense => :perfect, :person => :third_person, :number => :dual, :gender => :masculine)
          verb_conjugator.conjugate.should == 'رَمَيا'
        end

        it "should conjugate the third person singular feminine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :feminine)
          verb_conjugator.conjugate.should == 'رَمَتْ'
        end

        it "should conjugate the third person singular masculine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :masculine)
          verb_conjugator.conjugate.should == 'رَمَى'
        end
      end

      context "a weak laam verb which does not have sukoon on the third radical with middle vowel kasrah" do
        it "should conjugate the third person plural verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb1, :tense => :perfect, :person => :third_person, :number => :plural, :gender => :masculine)
          verb_conjugator.conjugate_weak_laam.should == 'لَقُوا'
        end

        it "should conjugate the third person singular masculine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb1, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :masculine)
          verb_conjugator.conjugate.should == 'لَقِيَ'
        end

        it "should conjugate the third person singular feminine verb" do
          verb_conjugator = VerbConjugator.new(@weak_laam_verb1, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :feminine)
          verb_conjugator.conjugate.should == 'لَقِيَتْ'
        end
      end

      context "doubled verbs" do
        context "first person singular" do
          it "should conjugate the verb" do
            verb_conjugator = VerbConjugator.new(@doubled_verb, :tense => :perfect, :person => :first_person, :number => :singular)
            verb_conjugator.conjugate.should == 'دَلَلْتُ'
          end
        end

        context "a third person doubled verb" do
          it "should conjugate the verb" do
            verb_conjugator = VerbConjugator.new(@doubled_verb, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :masculine)
            verb_conjugator.conjugate.should == 'دَلَّ'
          end

          it "should conjugate the verb" do
            verb_conjugator = VerbConjugator.new(@doubled_verb, :tense => :perfect, :person => :third_person, :number => :plural, :gender => :masculine)
            verb_conjugator.conjugate.should == 'دَلُّوا'
          end

        end
      end

      context "hollow verbs" do
        context "waw as second radical" do
          it "should conjugate the verb" do
            verb_conjugator = VerbConjugator.new(@hollow_verb_waw, :tense => :perfect, :person => :first_person, :number => :singular)
            verb_conjugator.conjugate.should == 'قُلْتُ'
          end
        end

        context "yaa as second radical" do
          it "should conjugate the verb" do
            verb_conjugator = VerbConjugator.new(@hollow_verb_yaa, :tense => :perfect, :person => :first_person, :number => :singular)
            verb_conjugator.conjugate.should == 'عِشْتُ'
          end
        end

        context "second and third person verbs" do
          context "waw as second radical" do
            it "should conjugate the verb" do
              verb_conjugator = VerbConjugator.new(@hollow_verb_waw, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :masculine)
              verb_conjugator.conjugate.should == 'قالَ'
            end

            it "should conjugate the verb" do
              verb_conjugator = VerbConjugator.new(@hollow_verb_waw, :tense => :perfect, :person => :third_person, :number => :dual, :gender => :masculine)
              verb_conjugator.conjugate.should == 'قالا'
            end
          end

          context "yaa as second radical" do
            it "should conjugate the verb" do
              verb_conjugator = VerbConjugator.new(@hollow_verb_yaa, :tense => :perfect, :person => :third_person, :number => :singular, :gender => :masculine)
              verb_conjugator.conjugate.should == 'عاشَ'
            end

            it "should conjugate the verb" do
              verb_conjugator = VerbConjugator.new(@hollow_verb_yaa, :tense => :perfect, :person => :third_person, :number => :dual, :gender => :masculine)
              verb_conjugator.conjugate.should == 'عاشا'
            end
          end
        end
      end

    end

  end

  describe "#get_conjugation_type" do
    it "should return a symbol that represents the conjugation type of the verb" do
      verb_conjugator = VerbConjugator.new(@verb, :tense => :perfect, :person => :first_person, :number => :singular, :gender => :masculine)
      verb_conjugator.get_conjugation_type.should == :first_person_singular_masculine
    end
  end

  describe "#get_verb_options_array" do
    it "should take verb_options constant in order to get a further drilled down array of hashes" do
      VerbConjugator.get_verb_options_array.should == [{:person=>:third_person, :number=>:singular, :tense=>:perfect, :gender=>:masculine}, {:person=>:third_person, :number=>:singular, :tense=>:perfect, :gender=>:feminine}, {:person=>:third_person, :number=>:dual, :tense=>:perfect, :gender=>:masculine}, {:person=>:third_person, :number=>:dual, :tense=>:perfect, :gender=>:feminine}, {:person=>:third_person, :number=>:plural, :tense=>:perfect, :gender=>:masculine}, {:person=>:third_person, :number=>:plural, :tense=>:perfect, :gender=>:feminine}, {:person=>:second_person, :number=>:singular, :tense=>:perfect, :gender=>:masculine}, {:person=>:second_person, :number=>:singular, :tense=>:perfect, :gender=>:feminine}, {:person=>:second_person, :number=>:dual, :tense=>:perfect, :gender=>:masculine}, {:person=>:second_person, :number=>:dual, :tense=>:perfect, :gender=>:feminine}, {:person=>:second_person, :number=>:plural, :tense=>:perfect, :gender=>:masculine}, {:person=>:second_person, :number=>:plural, :tense=>:perfect, :gender=>:feminine}, {:person=>:first_person, :number=>:singular, :tense=>:perfect, :gender=>nil}, {:person=>:first_person, :number=>:plural, :tense=>:perfect, :gender=>nil}]
    end
  end

end