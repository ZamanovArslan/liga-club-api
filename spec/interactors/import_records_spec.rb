require 'csv'

describe ImportRecords do
  subject(:import_records) { described_class.new(data: data, model: Phone, find_by_columns: ["value"]) }

  context "when file is csv" do
    let(:data) { CSV.parse("value\n+7241124125\n+7241124126\n+7241124127", headers: true) }

    it { expect { import_records.call }.to change { Phone.count }.from(0).to(3) }
    it do
      import_records.call

      expect(import_records.successful_imports).to eq 3
    end
  end
end
