class AddReportComplement < ActiveRecord::Migration[4.2]
  def change
    add_column :reports, :dateBegin, :string
    add_column :reports, :dateEnd, :string
    add_column :reports, :isRangeSet, :boolean
    add_column :reports, :dayRangeFromEnd, :integer
  end
end
