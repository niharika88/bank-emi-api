require 'csv'
class EmiController < ApplicationController
  include Response
  def create_emi_schemes
    csv_text = File.read(Rails.root.join('app', 'controllers', 'EMIRates-Sheet1.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      bank = Bank.new
      bank.name= row['Lender']
      bank.save!

      rate = row['Rate']
      month = row['Tenure']
      minimum_amount = row['Minimum']
      tenure_params = {:month => month, :rate => rate, :minimum_amount => minimum_amount}
      bank.create_tenure!(tenure_params)

      puts "#{bank}, #{bank.tenure} saved"
    end
    puts "There are now #{Bank.count} rows in the bank table"
  end

  def emi_schemes(amount=nil)
    p_amount = params[:amount].to_i
    @banks = Bank.all
    display_banks = []
    available_banks = {}
    @banks.each do |x|
      if (x.tenure.minimum_amount <= (p_amount/x.tenure.month))
        available_banks = { "bank" => x.name,
                            "tenures" => {
                              "months" => x.tenure.month,
                              "rate" => x.tenure.rate,
                              "minimum_amount" => x.tenure.minimum_amount
                            }
                        }

        display_banks << available_banks
      end
    end
    json_response(display_banks)
  end

end
