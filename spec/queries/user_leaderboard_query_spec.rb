describe UserLeaderboardQuery do
  subject(:leaderboard_query_result) { leaderboard_query.all }

  let(:leaderboard_query) { described_class.new(relation) }
  let(:expected_users) { [user_4, user_1, user_2, user_3] }
  let(:relation) { User.all }
  let!(:user_2) { create :user, score: 100, university: kfu }
  let!(:user_1) { create :user, score: 200, university: kai }
  let!(:user_3) { create :user, score: 50, university: kfu }
  let!(:user_4) { create :user, score: 300, university: kai }
  let(:kfu) { create :university }
  let(:kai) { create :university, name: "KAI" }

  describe "#all" do
    it { is_expected.to eq(expected_users) }

    context "when filtered by university" do
      let(:relation) { User.where(university: kfu) }
      let(:expected_users) { [user_2, user_3] }

      it { is_expected.to eq(expected_users) }
    end

    context "when relation has no records" do
      let(:relation) { User.where(id: -1) }

      it { is_expected.to eq([]) }
    end
  end
end
