describe UserLeaderboardQuery do
  let(:leaderboard_query) { described_class.new }

  let(:expected_users) { [user_1, user_2, user_3] }

  let!(:user_2) { create :user, score: 100 }
  let!(:user_1) { create :user, score: 200 }
  let!(:user_3) { create :user, score: 50 }

  context "#all" do
    subject(:leaderboard_query_result) { leaderboard_query.all }

    it { is_expected.to eq(expected_users) }
  end
end