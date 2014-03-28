# encoding: UTF-8
require_relative '../arabic_verb'

describe ArabicVerb do
  before :each do
    @sound_verb = ArabicVerb.new('ك', 'ت', 'ب', 1)
    @weak_laam_verb = ArabicVerb.new('ر', 'م', 'ي', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ِ')
    @weak_laam_verb1 = ArabicVerb.new('ل', 'ق', 'ي', 1, perfect_middle_vowel: 'ِ', imperfect_middle_vowel: 'ِ')
    @weak_laam_verb2 = ArabicVerb.new('د', 'ع', 'و', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ُ')
    @hollow_verb = ArabicVerb.new('ق', 'و', 'ل', 1)
    @doubled_verb = ArabicVerb.new('د', 'ل', 'ل', 1, perfect_middle_vowel: 'َ', imperfect_middle_vowel: 'ُ')
  end

  describe "#initialize" do
    it "should initialize the ArabicVerb objects's radicls, form, and middle vowels if provided" do
      verb = ArabicVerb.new("د", "ر", "س", 1, perfect_middle_vowel: "َ", imperfect_middle_vowel: "ُ")
      verb.radical1.should == "د"
    end
  end

  describe "#irregular?" do
    context "when the verb is weak laam" do
      it "should return true" do
        @hollow_verb.irregular?.should == true
      end
    end

    context "when the verb is hollow" do
      it "should return true" do
        @weak_laam_verb.irregular?.should == true
      end
    end

    context "when the verb is sound" do
      it "should return false" do
        @sound_verb.irregular?.should == false
      end
    end
  end

  describe "#weak_laam?" do
    context "when the verb is not weak_laam" do
      it "should return false" do
        @sound_verb.weak_laam?.should == false
      end
    end

    context "when the verb is hollow" do
      it "should return true" do
        @weak_laam_verb.weak_laam?.should == true
      end
    end
  end

  describe "#hollow?" do
    context "when the verb is hollow" do
      it "should return true" do
        @hollow_verb.hollow?.should == true
      end
    end

    context "when the verb is not hollow" do
      it "should return false" do
        @weak_laam_verb.hollow?.should == false
      end
    end
  end

  describe "#middle_vowel_fathah" do
    context "the middle vowel is a fathah" do
      it "should return true" do
        @weak_laam_verb.middle_vowel_fathah?.should == true
      end
    end
  end

  describe "#middle_vowel_kasrah" do
    context "the middle vowel is a kasrah" do
      it "should return true" do
        @weak_laam_verb1.middle_vowel_kasrah?.should == true
      end
    end
  end

  describe "#third_radical_waw?" do
    context "when the third radical is waw" do
      it "should return true" do
        @weak_laam_verb2.third_radical_waw?.should == true
      end
    end

    context "when the third radical is not waw" do
      it "should return false" do
        @weak_laam_verb1.third_radical_waw?.should == false
      end
    end
  end

  describe "#doubled?" do
    context "when the verb is doubled" do
      it "should return true" do
        @doubled_verb.doubled?.should == true
      end
    end

    context "when the verb is not doubled" do
      it "should return false" do
        @sound_verb.doubled?.should == false
      end
    end
  end


end