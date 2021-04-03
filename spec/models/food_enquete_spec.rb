require 'rails_helper'

RSpec.describe FoodEnquete, type: :model do
  describe '正常系の機能' do
    context '回答する' do
      it '正しく登録できること 料理:やきそば food_id: 2, 
                            満足度:良い score: 3, 
                            希望するプレゼント:ビール飲み放題 present_id: 1)' do
        # [Point.3-3-1]テストデータを作成します。
        enquete = FoodEnquete.new(
          name: '田中 太郎',
          mail: 'taro.tanaka@example.com',
          age: 25,
          food_id: 2,
          score: 3,
          request: 'おいしかったです。',
          present_id: 1
        )

        # [Point.3-3-2]「バリデーションが正常に通ること(バリデーションエラーが無いこと)」を検証します。
        expect(enquete).to be_valid

        # [Point.3-3-3]テストデータを保存します。
        enquete.save

        # [Point.3-3-4][Point.3-3-3]で保存したデータを取得します。
        answered_enquete = FoodEnquete.find(1);

        # [Point.3-3-5][Point.3-3-1]で作成したデータを同一か検証します。
        expect(answered_enquete.name).to eq('田中 太郎')
        expect(answered_enquete.mail).to eq('taro.tanaka@example.com')
        expect(answered_enquete.age).to eq(25)
        expect(answered_enquete.food_id).to eq(2)
        expect(answered_enquete.score).to eq(3)
        expect(answered_enquete.request).to eq('おいしかったです。')
        expect(answered_enquete.present_id).to eq(1)
      end
    end
  end

  describe '入力項目の有無' do
    context '必須入力であること' do
      # [Point.3-4-1]itを複数書くことができます。
      it 'お名前が必須であること' do
        new_enquete = FoodEnquete.new
        # [Point.3-4-2]バリデーションエラーが発生することを検証します。
        expect(new_enquete).not_to be_valid
        # [Point.3-4-3]必須入力のメッセージが含まれることを検証します。
        expect(new_enquete.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end

      it 'メールアドレスが必須であること' do
        new_enquete = FoodEnquete.new
        expect(new_enquete).not_to be_valid
        expect(new_enquete.errors[:mail]).to include(I18n.t('errors.messages.blank'))
      end

      # [Point.3-4-1]itを複数書くことができます。
      it '登録できないこと' do
        new_enquete = FoodEnquete.new

        # [Point.3-4-4]保存に失敗することを検証します。
        expect(new_enquete.save).to be_falsey
      end
    end
    
    context '任意入力であること' do
      it 'ご意見・ご要望が任意であること' do
        new_enquete = FoodEnquete.new
        expect(new_enquete).not_to be_valid
        # [Point.3-4-6]必須入力のメッセージが含まれないことを検証します。
        expect(new_enquete.errors[:request]).not_to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
